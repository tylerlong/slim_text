window.editor = ace.edit "editor"
file_manager = document.getElementById('file_manager')


window.combine_path = (path1, path2) ->
    file_manager.combine path1, path2
    

window.save_file = ->
    if window.storage.file
        result = file_manager.write window.storage.file, editor.getValue()
        if result
            window.notice chrome.i18n.getMessage('saved'), window.storage.file
            document.title = "#{file_manager.filename(window.storage.file)} - Slim Text"
        else
            alert "#{chrome.i18n.getMessage('unable_to_save')} #{window.storage.file}"


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
          <li><a class="about_btn">#{chrome.i18n.getMessage('about')} Slim Text</a></li>
      </ul>
    </span>
</div>
<div id="toolbar">
  <a class="save_btn" title="#{chrome.i18n.getMessage('save')}"><i class="icon-save"></i></a>
  <a class="indent_btn" title="#{chrome.i18n.getMessage('indent')}"><i class="icon-indent-right"></i></a>
  <a class="outdent_btn" title="#{chrome.i18n.getMessage('outdent')}"><i class="icon-indent-left"></i></a>
  <a class="full_window_btn" title="#{chrome.i18n.getMessage('full_window')}"><i class="icon-fullscreen"></i></a>
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
        if document.title.indexOf('* ') == 0
            if not confirm(""""#{window.storage.file}" #{chrome.i18n.getMessage('save_before_leaving')}""")
                return
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
        window.notice chrome.i18n.getMessage('permission_denied'), path
        path = file_manager.container(path)
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

    chrome.storage.sync.get ['theme', 'font_size', 'key_binding'], (items) ->
        if not items.theme
            items.theme = 'monokai'
        if not items.font_size
            items.font_size = '12'
        if not items.key_binding
            items.key_binding = 'ace'
        editor.setTheme "ace/theme/#{items.theme}"
        editor.setFontSize "#{items.font_size}px"
        if items.key_binding == 'vim'
            editor.setKeyboardHandler(ace.require("ace/keyboard/vim").handler)

    window.layout = $('body').layout
        spacing_closed: 5
        stateManagement__enabled: true
        north:
            slidable: false
            spacing_open: 14
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
            size: 128
            togglerLength_open: 0
            togglerLength_closed: 0
            slideTrigger_open: 'mouseover'
        center:
            onresize_end: ->
                editor.resize()

    window.add_topbar()
