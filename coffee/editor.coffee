window.tabs = $('#tabs').tabs()

window.add_tab = () ->
    uid = _.uniqueId()
    $('#tabs').append """<div id="tab-#{uid}"><div id="editor-#{uid}"></div></div>"""
    $("""<li><a href="#tab-#{uid}">New tab</a> <span class="ui-icon ui-icon-close">Remove tab</span></li>""").appendTo('#tabs .ui-tabs-nav')
    $('#tabs').tabs 'refresh'
    $('#tabs').tabs 'option', 'active', -1
    window.editor = ace.edit "editor-#{uid}"
    window.init_editor window.editor
    
    lazy_change = _.debounce (->
        if document.title.indexOf('* ') != 0
            document.title = '* ' + document.title
        ), 500, true
    window.editor.getSession().on 'change', ->
        lazy_change()

window.init_editor = (editor) ->
    chrome.storage.sync.get ['theme', 'font_size', 'key_binding', 'tab_size'], (items) ->
        if not items.theme
            items.theme = 'monokai'
        if not items.font_size
            items.font_size = '12'
        if not items.key_binding
            items.key_binding = 'ace'
        if not items.tab_size
            items.tab_size = 4
        editor.setTheme "ace/theme/#{items.theme}"
        editor.setFontSize "#{items.font_size}px"
        editor.getSession().setTabSize(items.tab_size)
        if items.key_binding == 'vim'
            editor.setKeyboardHandler(ace.require("ace/keyboard/vim").handler)
        else if items.key_binding == 'emacs'
            editor.setKeyboardHandler(ace.require("ace/keyboard/emacs").handler)

file_manager = document.getElementById('file_manager')


window.combine_path = (path1, path2) ->
    file_manager.combine path1, path2


window.prompt_file_name = ->
    file_name = prompt "#{chrome.i18n.getMessage('create_file')} #{window.storage.path}/"
    if not file_name or file_name.trim() == ''
        return false
    if not file_manager.valid_name file_name
        window.notice chrome.i18n.getMessage('invalid_path_name'), file_name
        return false
    file_path = "#{window.storage.path}/#{file_name}"
    if file_manager.exists file_path
        window.notice chrome.i18n.getMessage('already_exists'), file_path
        return false
    return file_path


window.save_file = ->
    if window.storage.file
        result = file_manager.write window.storage.file, editor.getValue()
        if result
            window.notice chrome.i18n.getMessage('saved'), window.storage.file
            document.title = "#{file_manager.filename(window.storage.file)} - Slim Text"
        else
            alert "#{chrome.i18n.getMessage('unable_to_save')} #{window.storage.file}"
    else
        window.storage.file = window.prompt_file_name()
        return if not window.storage.file
        window.save_file()
        window.show_sidebar window.storage.path


window.create_file = ->
    file_path = window.prompt_file_name()
    return if not file_path
    file_manager.write file_path, ''
    window.open_path file_path


window.create_folder = ->
    folder_name = prompt "#{chrome.i18n.getMessage('create_folder')} #{window.storage.path}/"
    if not folder_name or folder_name.trim() == ''
        return
    if not file_manager.valid_name folder_name
        return window.notice chrome.i18n.getMessage('invalid_path_name'), folder_name
    folder_path = "#{window.storage.path}/#{folder_name}"
    if file_manager.exists folder_path
        return window.notice chrome.i18n.getMessage('already_exists'), folder_path
    file_manager.create_folder folder_path
    window.show_sidebar window.storage.path


window.show_breadcrumb = (path) ->
    $('#route').empty()
    route = file_manager.route(path)
    route.reverse()
    if navigator.appVersion.indexOf('Windows') != -1
        first = _.first route
        route = _.rest route
        second = _.first route
        if second
            second.name = first.name
        if route.length == 0
            drives = $('<select id="drives_select"></select>')
            for drive in file_manager.drives()
                drives.append """<option value="#{drive}">#{drive.substr(0, drive.length - 1)}</option>"""
            drives.val(first.name.toUpperCase() + '/')
            $('#route').append drives
    else
        if route.length ==0
            $('#route').append('/')
    for item in _.initial(route)
        link = $("""<a class="file-link">#{item.name}</a>""")
        link.data("path", item.path)
        $('#route').append(link)
        if item.name == '/'
            $('#route').append(' ')
        else
            $('#route').append(' / ')
    item = _.last(route)
    if item
        $('#route').append("#{item.name}")


clickable = (item) ->
    if item.type == 'file'
        extension = file_manager.extension(item.name)
        if extension.length > 0
            extension = extension.toLowerCase().substr(1, extension.length - 1)
            return false if window.is_binary(extension)
    return true
window.show_sidebar = (path) ->
    $('#sidebar').empty()
    items = file_manager.list(path)
    items = _.sortBy items, (item) ->
        item.name.toLowerCase()
    for item in items
        if item.path == window.storage.file
            $('#sidebar').append """<span class="current">#{item.name}</span>"""
        else if clickable(item)
            link = $("""<a class="file-link">#{item.name}</a>""")
            link.data("path", item.path)
            $('#sidebar').append link
            if item.type == 'folder'
                $('#sidebar').append '/'
        else 
            $('#sidebar').append "<span>#{item.name}</span>"
        $('#sidebar').append "<br/>"


window.add_topbar = ->
    $('.ui-layout-resizer-north').append """<div id="navbar">
    <span class="dropdown">
      <a class="dropdown-toggle" data-toggle="dropdown">
        #{chrome.i18n.getMessage('file')}
        <b class="caret"></b>
      </a>
      <ul class="dropdown-menu">
          <li><a class="new_file_btn">#{chrome.i18n.getMessage('new_file')}</a></li>
          <li><a class="new_folder_btn">#{chrome.i18n.getMessage('new_folder')}</a></li>
          <li><a class="save_btn">#{chrome.i18n.getMessage('save')}</a></li>
      </ul>
    </span>
    <span class="dropdown">
      <a class="dropdown-toggle" data-toggle="dropdown">
        #{chrome.i18n.getMessage('edit')}
        <b class="caret"></b>
      </a>
      <ul class="dropdown-menu">
        <li><a class="indent_btn">#{chrome.i18n.getMessage('indent')}</a></li>
        <li><a class="outdent_btn">#{chrome.i18n.getMessage('outdent')}</a></li>
        <li><a class="lower_case_btn">#{chrome.i18n.getMessage('lower_case')}</a></li>
        <li><a class="upper_case_btn">#{chrome.i18n.getMessage('upper_case')}</a></li>
        <li><a class="remove_lines_btn">#{chrome.i18n.getMessage('remove_lines')}</a></li>
        <li><a class="toggle_comment_btn">#{chrome.i18n.getMessage('toggle_comment')}</a></li>
      </ul>
    </span>
    <span class="dropdown">
      <a class="dropdown-toggle" data-toggle="dropdown">
        #{chrome.i18n.getMessage('search')}
        <b class="caret"></b>
      </a>
      <ul class="dropdown-menu">
        <li><a class="find_btn">#{chrome.i18n.getMessage('find')}</a></li>
        <li><a class="replace_btn">#{chrome.i18n.getMessage('replace')}</a></li>
      </ul>
    </span>
    <span class="dropdown">
      <a class="dropdown-toggle" data-toggle="dropdown">
        #{chrome.i18n.getMessage('view')}
        <b class="caret"></b>
      </a>
      <ul class="dropdown-menu">
          <li class="dropdown-submenu">
              <a>#{chrome.i18n.getMessage('syntax')}</a>
              <ul class="dropdown-menu" id="mode_list"></ul>
          </li>
          <li><a class="toggle_word_wrap_btn">#{chrome.i18n.getMessage('toggle_word_wrap')}</a></li>
          <li><a class="toggle_invisibles_btn">#{chrome.i18n.getMessage('toggle_invisibles')}</a></li>
          <li><a class="full_window_btn">#{chrome.i18n.getMessage('full_window')}</a></li>
      </ul>
    </span>
    <span class="dropdown">
      <a class="dropdown-toggle" data-toggle="dropdown">
        #{chrome.i18n.getMessage('preferences')}
        <b class="caret"></b>
      </a>
      <ul class="dropdown-menu">
          <li><a class="options_btn">#{chrome.i18n.getMessage('options')}</a></li>
      </ul>
    </span>
    <span class="dropdown">
      <a class="dropdown-toggle" data-toggle="dropdown">
        #{chrome.i18n.getMessage('help')}
        <b class="caret"></b>
      </a>
      <ul class="dropdown-menu">
          <li><a href="https://github.com/ajaxorg/ace/wiki/Default-Keyboard-Shortcuts" target="_blank">#{chrome.i18n.getMessage('keyboard_shortcuts')}</a></li>
          <li><a href="http://slimtext.org" target="_blank">#{chrome.i18n.getMessage('website')}</a></li>
          <li><a href="https://github.com/tylerlong/slimtext.org/issues" target="_blank">#{chrome.i18n.getMessage('report_issue')}</a></li>
          <li><a class="check_for_updates_btn">#{chrome.i18n.getMessage('check_for_updates')}</a></li>
          <li><a class="about_btn">#{chrome.i18n.getMessage('about')} Slim Text</a></li>
      </ul>
    </span>
</div>
<div id="toolbar">
  <a class="new_file_btn" title="#{chrome.i18n.getMessage('new_file')}"><i class="icon-file"></i></a>
  <a class="new_folder_btn" title="#{chrome.i18n.getMessage('new_folder')}"><i class="icon-folder-close-alt"></i></a>
  <a class="save_btn" title="#{chrome.i18n.getMessage('save')}"><i class="icon-save"></i></a>
  <a class="find_btn" title="#{chrome.i18n.getMessage('find')}"><i class="icon-search"></i></a>
  <a class="toggle_invisibles_btn" title="#{chrome.i18n.getMessage('toggle_invisibles')}"><i class="icon-eye-open"></i></a>
  <a class="indent_btn" title="#{chrome.i18n.getMessage('indent')}"><i class="icon-indent-right"></i></a>
  <a class="outdent_btn" title="#{chrome.i18n.getMessage('outdent')}"><i class="icon-indent-left"></i></a>
  <a class="full_window_btn" title="#{chrome.i18n.getMessage('full_window')}"><i class="icon-fullscreen"></i></a>
  <a class="options_btn" title="#{chrome.i18n.getMessage('options')}"><i class="icon-cog"></i></a>
  <a class="check_for_updates_btn" title="#{chrome.i18n.getMessage('check_for_updates')}"><i class="icon-cloud-download"></i></a>
  <a title="#{chrome.i18n.getMessage('report_issue')}" href="https://github.com/tylerlong/slimtext.org/issues" target="_blank"><i class="icon-github-alt"></i></a>
  <a class="about_btn" title="#{chrome.i18n.getMessage('about')} Slim Text"><i class="icon-info-sign"></i></a>
  <i class="icon-fullscreen" id="hidden_btn"></i>
</div>"""
    ranges = [['a', 'd'], ['e', 'j'], ['k', 'o'], ['p', 's'], ['t', 'z']]
    pairs = []
    for range in ranges
        $('#mode_list').append """
<li class="dropdown-submenu">
    <a>#{range[0].toUpperCase()} - #{range[1].toUpperCase()}</a>
    <ul class="dropdown-menu" id="#{range[0]}_to_#{range[1]}"></ul>
</li>
"""
        pairs.push [RegExp("^[#{range[0]}-#{range[1]}]", 'i'), "##{range[0]}_to_#{range[1]}"]
    for mode, name of window.modes
        item = """<li><a data-mode="#{mode}" class="mode-link">#{name}</a></li>"""
        for pair in pairs
            if name.match pair[0]
                $(pair[1]).append item
                break
    window.layout.allowOverflow($('.ui-layout-resizer-north'))
    if window.layout.state.north.isClosed
        $('#navbar').hide()
        $('#toolbar').hide()


window.open_path = (path) ->
    if not file_manager.exists(path)
        window.notice chrome.i18n.getMessage('does_not_exist'), path
        route = file_manager.route path
        for item in _.rest(route)
            if file_manager.exists item.path
                window.open_path item.path
                return
        return
    type = file_manager.type path
    if type == 'file'
        window.storage.file = path
        content = file_manager.read(path)
        window.add_tab()
        editor.session.setValue content, -1
        filename = file_manager.filename(path)
        document.title = "#{filename} - Slim Text"
        extension = file_manager.extension(filename)
        if extension
            extension = extension.toLowerCase().substr(1, extension.length - 1)
            editor.getSession().setMode window.guess_mode_by_extension(extension)
        else 
            editor.getSession().setMode window.guess_mode_by_name(filename)
        path = file_manager.container(path)
    if not file_manager.can_list path
        window.notice chrome.i18n.getMessage('permission_denied'), path
        path = file_manager.home_folder() or file_manager.temp_folder()
    window.storage.path = path
    show_breadcrumb path
    show_sidebar path


$ ->
    chrome.storage.local.get ['path', 'file'], (items) ->
        path = items.file or items.path or file_manager.home_folder() or file_manager.temp_folder()
        window.storage = { file: items.file, path: path }
        open_path path
        path = items.path or file_manager.home_folder() or file_manager.temp_folder()
        open_path path

    window.layout = $('body').layout
        spacing_closed: 5
        stateManagement__enabled: true
        north:
            slidable: false
            spacing_open: 15
            size: 18
            resizable: false
            togglerLength_open: 0
            togglerTip_closed: chrome.i18n.getMessage('exit_full_window')
            onopen_start: ->
                window.layout.open 'west'
                $('#navbar').show()
                $('#toolbar').show()
                window.editor.focus()
            onclose_start: ->
                window.layout.close 'west'
                $('#navbar').hide()
                $('#toolbar').hide()
                window.editor.focus()
        west:
            spacing_open: 5
            livePaneResizing: true
            size: 192
            togglerLength_open: 0
            togglerLength_closed: 0
            slideTrigger_open: 'mouseover'
            resizerTip: chrome.i18n.getMessage('resize')
        center:
            onresize_end: ->
                editor.resize()

    window.add_topbar()
