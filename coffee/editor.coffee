editor = ace.edit "editor"
file_manager = document.getElementById('file_manager')

save_file = ->
    chrome.storage.local.get ['file'], (items) ->
        if items.file
            file_manager.write items.file, editor.getValue()
            window.notice 'File Saved', items.file
            document.title = items.file


editor.commands.addCommand
    name: 'saveCommand'
    bindKey: { win: 'Ctrl-S',  mac: 'Command-S' }
    exec: (editor) ->
        save_file()
    readOnly: false

lazy_change = _.debounce (->
    if document.title.indexOf('* ') != 0
        document.title = '* ' + document.title
    ), 300, true
editor.getSession().on 'change', (e)->
    lazy_change()


show_breadcrumb = (path) ->
    $('#route').html('')
    route = file_manager.route(path)
    if route.length == 0
        $('#route').append("&nbsp;")
        return

    route.reverse()
    for item in _.initial(route)
        link = $("""<a href="#" class="file-link">#{item.name}</a>""")
        link.data("path", item.path)
        $('#route').append(link)
        if item.name == '/'
            $('#route').append(' ')
        else
            $('#route').append(' / ')
    last_token = _.last(route)
    if last_token
        $('#route').append("#{last_token.name}")


show_sidebar = (path) ->
    $('#sidebar').html('')
    chrome.storage.local.get ['file'], (items) ->
        file = items.file
        items = file_manager.list(path)
        items = _.filter items, (item) ->
            item.type == 'file' || item.type == 'folder'
        items = _.sortBy items, (item) ->
            item.name.toLowerCase()
        for item in items
            if item.path == file
                $('#sidebar').append item.name
            else
                link = $("""<a href="#" class="file-link">#{item.name}</a>""")
                link.data("path", item.path)
                $('#sidebar').append link
            $('#sidebar').append "<br/>"


open_path = (path) ->
    chrome.storage.local.set { 'path': path }

    type = file_manager.type path
    if type == 'file'
        chrome.storage.local.set { 'file': path }
        content = file_manager.read(path)
        editor.setValue content, -1
        extension = file_manager.extension(path)
        if extension
            extension = extension.toLowerCase().substr(1, extension.length - 1)
        editor.getSession().setMode window.guess_mode(extension)
        document.title = path

        path = file_manager.container(path)
    show_breadcrumb path
    show_sidebar path


$ ->
    chrome.storage.local.get ['path', 'file'], (items) ->
        path = items.file or items.path or file_manager.home_folder() or file_manager.temp_folder()
        open_path path

    chrome.storage.sync.get ['theme', 'font_size'], (items) ->
        if not items.theme
            items.theme = 'monokai'
        if not items.font_size
            items.font_size = '15'
        editor.setTheme "ace/theme/#{items.theme}"
        editor.setFontSize "#{items.font_size}px"

    window.layout = $('body').layout
        spacing_closed: 3
        north:
            slidable: false
            spacing_open: 14
            size: 21
            resizable: false
            togglerLength_open: 0
            togglerTip_closed: 'Exit full window'
            onopen_end: ->
                window.layout.open 'west'
                $('#navbar').show()
                $('#toolbar').show()
            onclose_start: ->
                $('#navbar').hide()
                $('#toolbar').hide()
        west:
            spacing_open: 3
            livePaneResizing: true
            size: 128
            togglerLength_open: 0
            togglerLength_closed: 0
            slideTrigger_open: 'mouseover'

        center:
            onresize_end: ->
                editor.resize()

    $('.ui-layout-resizer-north').append """<div id="navbar">
    <span class="dropdown">
      <a class="dropdown-toggle" data-toggle="dropdown" href="#">
        File
        <b class="caret"></b>
      </a>
      <ul class="dropdown-menu" role="menu">
          <li role="presentation"><a role="menuitem" href="#" class="save_btn">Save</a></li>
      </ul>
    </span>
    <span class="dropdown">
      <a class="dropdown-toggle" data-toggle="dropdown" href="#">
        View
        <b class="caret"></b>
      </a>
      <ul class="dropdown-menu" role="menu">
          <li role="presentation"><a role="menuitem" href="#" class="full_window_btn">Full Window</a></li>
      </ul>
    </span>
    <span id="options_link"><a href="options.html" target="_blank">Options</a></span>
</div>
<div id="toolbar">
  <a href="#" class="save_btn" title="Save"><img src="../icon/save.png" width="14px" height="14px"/></a>
  <a href="#" class="full_window_btn" title="Full Window"><img src="../icon/expand.png" width="12px" height="12px"/></a>
</div>"""
    window.layout.allowOverflow($('.ui-layout-resizer-north'))

$('body').on 'click', 'a.file-link', ->
    open_path $(this).data('path')

$('body').on 'click', '.full_window_btn', ->
    window.layout.close 'north'
    window.layout.close 'west'

$('body').on 'click', '.save_btn', ->
    save_file()
