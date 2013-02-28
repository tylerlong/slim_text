window.editor = ace.edit "editor"
file_manager = document.getElementById('file_manager')


window.save_file = ->
    if window.storage.file
        result = file_manager.write window.storage.file, editor.getValue()
        if result
            window.notice 'File Saved', window.storage.file
            document.title = "#{file_manager.filename(window.storage.file)} - Slim Text"
        else
            alert "Unable to save #{window.storage.file}"


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
            drives.val(first.name + '/')
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


window.show_sidebar = (path) ->
    $('#sidebar').empty()
    items = file_manager.list(path)
    items = _.filter items, (item) ->
        if item.type == 'folder'
            return true
        if item.type == 'file'
            extension = file_manager.extension(item.name)
            if extension == ''
                return true
            if extension == item.name
                return true
            extension = extension.toLowerCase().substr(1, extension.length - 1)
            if window.known_extension(extension)
                return true
        return false
    items = _.sortBy items, (item) ->
        item.name.toLowerCase()
    for item in items
        if item.path == window.storage.file
            $('#sidebar').append item.name
        else
            link = $("""<a class="file-link">#{item.name}</a>""")
            link.data("path", item.path)
            $('#sidebar').append link
            if item.type == 'folder'
                $('#sidebar').append '/'
        $('#sidebar').append "<br/>"


window.add_topbar = ->
    $('.ui-layout-resizer-north').append """<div id="navbar">
    <span class="dropdown">
      <a class="dropdown-toggle" data-toggle="dropdown">
        #{chrome.i18n.getMessage('file')}
        <b class="caret"></b>
      </a>
      <ul class="dropdown-menu">
          <li><a class="save_btn">#{chrome.i18n.getMessage('save')}</a></li>
      </ul>
    </span>
    <span class="dropdown">
      <a class="dropdown-toggle" data-toggle="dropdown">
        #{chrome.i18n.getMessage('edit')}
        <b class="caret"></b>
      </a>
      <ul class="dropdown-menu">
          <li><a class="lower_case_btn">#{chrome.i18n.getMessage('lower_case')}</a></li>
          <li><a class="upper_case_btn">#{chrome.i18n.getMessage('upper_case')}</a></li>
          <li><a class="remove_lines_btn">#{chrome.i18n.getMessage('remove_lines')}</a></li>
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
          <li><a class="about_btn">#{chrome.i18n.getMessage('about')} Slim Text</a></li>
      </ul>
    </span>
</div>
<div id="toolbar">
  <a class="save_btn" title="Save"><img src="../image/save.png" width="14px" height="14px"/></a>
  <a class="full_window_btn" title="Full Window"><img src="../image/expand.png" width="12px" height="12px"/></a>
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
        window.notice 'Does not exist', path
        route = file_manager.route path
        for item in _.rest(route)
            if file_manager.exists item.path
                window.open_path item.path
                return
        return
    window.storage.path = path
    type = file_manager.type path
    if type == 'file'
        if document.title.indexOf('* ') == 0
            if confirm("#{chrome.i18n.getMessage('save_before_open')} #{window.storage.path}")
                window.save_file()
        window.storage.file = path
        content = file_manager.read(path)
        editor.session.setValue content, -1
        extension = file_manager.extension(path)
        if extension
            extension = extension.toLowerCase().substr(1, extension.length - 1)
        editor.getSession().setMode window.guess_mode(extension)
        document.title = "#{file_manager.filename(path)} - Slim Text"
        path = file_manager.container(path)
    while not file_manager.can_list path
        window.notice 'Permission denied', path
        path = file_manager.container(path)
    show_breadcrumb path
    show_sidebar path


$ ->
    chrome.storage.local.get ['path', 'file'], (items) ->
        path = items.file or items.path or file_manager.home_folder() or file_manager.temp_folder()
        window.storage = { file: items.file, path: path }
        open_path path
        path = items.path or file_manager.home_folder() or file_manager.temp_folder()
        open_path path

    chrome.storage.sync.get ['theme', 'font_size'], (items) ->
        if not items.theme
            items.theme = 'monokai'
        if not items.font_size
            items.font_size = '12'
        editor.setTheme "ace/theme/#{items.theme}"
        editor.setFontSize "#{items.font_size}px"

    window.layout = $('body').layout
        spacing_closed: 5
        stateManagement__enabled: true
        north:
            slidable: false
            spacing_open: 14
            size: 18
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

    window.add_topbar()
