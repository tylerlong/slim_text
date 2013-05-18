class @Editor
    constructor: (@path) ->
        @uid = _.uniqueId()
        @tabs = $('#tabs').tabs()
        @create_tab()
        @create_editor()
        @load_content()
        @bind_event()

    create_tab: ->
        panel = $("""<div id="tab-#{@uid}"><div id="editor-#{@uid}"></div></div>""")
        panel.data 'path', @path
        panel.data 'uid', @uid
        $('#tabs').append panel
        @filename = file_manager.filename(@path)
        tab = $("""<li id="li-#{@uid}" title="#{@path}"><a id="link-#{@uid}" href="#tab-#{@uid}">#{@filename}</a> <span class="ui-icon ui-icon-close">x</span></li>""")
        tab.appendTo('#tabs .ui-tabs-nav')
        @tabs.tabs 'refresh'
        @tabs.tabs 'option', 'active', -1

    create_editor: ->
        @editor = ace.edit "editor-#{@uid}"
        editor = @editor
        chrome.storage.sync.get ['theme', 'font_size', 'key_binding', 'tab_size', 'trim_trailing_space', 'ensure_newline_at_eof'], (items) ->
            if not items.theme
                items.theme = 'monokai'
            if not items.font_size
                items.font_size = '13'
            if not items.key_binding
                items.key_binding = 'ace'
            if not items.tab_size
                items.tab_size = 4
            if items.trim_trailing_space == undefined
                items.trim_trailing_space = true
            if items.ensure_newline_at_eof == undefined
                items.ensure_newline_at_eof = true
            editor.setTheme "ace/theme/#{items.theme}"
            editor.setFontSize "#{items.font_size}px"
            editor.getSession().setTabSize(parseInt(items.tab_size))
            if items.key_binding == 'vim'
                editor.setKeyboardHandler(ace.require("ace/keyboard/vim").handler)
            else if items.key_binding == 'emacs'
                editor.setKeyboardHandler(ace.require("ace/keyboard/emacs").handler)
            @trim_trailing_space = items.trim_trailing_space
            @ensure_newline_at_eof = items.ensure_newline_at_eof

    load_content: ->
        content = file_manager.read @path
        @editor.session.setValue content, -1
        extension = file_manager.extension(@filename)
        if extension
            extension = extension.toLowerCase().substr(1, extension.length - 1)
            @editor.getSession().setMode mode.guess_mode_by_extension(extension)
        else
            @editor.getSession().setMode mode.guess_mode_by_name(@filename)

    bind_event: ->
        uid = @uid
        lazy_change = _.debounce (->
            if $("#link-#{uid}").text().indexOf('* ') != 0
                $("#link-#{uid}").text '* ' + $("#link-#{uid}").text()
            ), 500, true
        @editor.getSession().on 'change', ->
            lazy_change()

    trim_trailing_space: ->
        ace.require("ace/ext/whitespace").trimTrailingSpace(@editor.getSession())

    ensure_newline_at_eof: ->
        doc = @editor.session.getDocument()
        lines = doc.getAllLines()
        if lines[lines.length - 1].search(/^\s*$/) == -1
            doc.insert({row: lines.length, column: 0}, doc.getNewLineCharacter())
        else
            for i in [(lines.length - 1) ... 0]
                if lines[i].search(/^\s*$/) != -1 and lines[i - 1].search(/^\s*$/) != -1
                    doc.removeLines i, i
                else
                    break

    save_file: ->
        result = file_manager.write @path, @editor.getValue()
        if result
            link = $("""a#link-#{@uid}""")
            if link.text().indexOf('* ') == 0
                link.text link.text().substr(2)
        else
            util.notice chrome.i18n.getMessage('unable_to_save'), @path

    dispose: ->
        filename = $("#link-#{@uid}").text()
        return if filename.indexOf('* ') == 0 and not confirm """"#{filename.substr(2)}" #{chrome.i18n.getMessage('save_before_leaving')}"""
        @editor.destroy()
        $("li[aria-controls='tab-#{@uid}']").remove()
        $("#tab-#{@uid}").remove()
        @tabs.tabs("refresh")
        delete editors[@uid]
        application.refresh_sidebar()
