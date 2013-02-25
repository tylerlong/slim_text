window.editor = ace.edit "editor"
file_manager = document.getElementById('file_manager')


window.save_file = ->
    chrome.storage.local.get ['file'], (items) ->
        if items.file
            file_manager.write items.file, editor.getValue()
            window.notice 'File Saved', items.file
            document.title = items.file


window.show_breadcrumb = (path) ->
    $('#route').html('')
    route = file_manager.route(path)
    route.reverse()
    for item in _.initial(route)
        link = $("""<a class="file-link">#{item.name}</a>""")
        link.data("path", item.path)
        $('#route').append(link)
        if item.name == '/'
            $('#route').append(' ')
        else
            $('#route').append(' / ')
    last_token = _.last(route)
    if last_token
        $('#route').append("#{last_token.name}")


window.show_sidebar = (path) ->
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
                link = $("""<a class="file-link">#{item.name}</a>""")
                link.data("path", item.path)
                $('#sidebar').append link
                if item.type == 'folder'
                    $('#sidebar').append '/'
            $('#sidebar').append "<br/>"


window.show_topbar = ->
    $('.ui-layout-resizer-north').append """<div id="navbar">
    <span class="dropdown">
      <a class="dropdown-toggle" data-toggle="dropdown">
        File
        <b class="caret"></b>
      </a>
      <ul class="dropdown-menu" role="menu">
          <li role="presentation"><a role="menuitem" class="save_btn">Save</a></li>
      </ul>
    </span>
    <span class="dropdown">
      <a class="dropdown-toggle" data-toggle="dropdown">
        View
        <b class="caret"></b>
      </a>
      <ul class="dropdown-menu" role="menu">
          <li class="dropdown-submenu">
              <a>Syntax</a>
              <ul class="dropdown-menu" id="mode_list"></ul>
          </li>
          <li><a class="full_window_btn">Full Window</a></li>
      </ul>
    </span>
    <span id="options_link"><a href="options.html" target="_blank">Options</a></span>
</div>
<div id="toolbar">
  <a class="save_btn" title="Save"><img src="../icon/save.png" width="14px" height="14px"/></a>
  <a class="full_window_btn" title="Full Window"><img src="../icon/expand.png" width="12px" height="12px"/></a>
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


window.open_path = (path) ->
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
        spacing_closed: 5
        north:
            slidable: false
            spacing_open: 14
            size: 21
            resizable: false
            togglerLength_open: 0
            togglerTip_closed: 'Exit full window'
            onopen_start: ->
                window.layout.open 'west'
                $('#navbar').show()
                $('#toolbar').show()
            onclose_start: ->
                $('#navbar').hide()
                $('#toolbar').hide()
        west:
            spacing_open: 5
            livePaneResizing: true
            size: 128
            togglerLength_open: 0
            togglerLength_closed: 0
            slideTrigger_open: 'mouseover'

        center:
            onresize_end: ->
                editor.resize()

    window.show_topbar()
