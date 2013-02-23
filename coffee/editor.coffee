editor = ace.edit "editor"
file_manager = document.getElementById('file_manager')


show_breadcrumb = (path) ->
    $('#route').html('')
    route = file_manager.route(path)
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

        path = file_manager.container(path)
    show_breadcrumb path
    show_sidebar path


$ ->
    chrome.storage.local.get ['path', 'file'], (items) ->
        path = items.file or items.path or file_manager.temp_folder()
        open_path path

    chrome.storage.sync.get ['theme', 'font_size'], (items) ->
        if not items.theme
            items.theme = 'monokai'
        if not items.font_size
            items.font_size = '16'
        editor.setTheme "ace/theme/#{items.theme}"
        editor.setFontSize "#{items.font_size}px"

    window.layout = $('body').layout
        spacing_open: 8
        onresize: editor.resize
        north:
            spacing_closed: 8
            size: 32
            resizable: false
            togglerLength_closed: 128
            togglerLength_open: 128
            togglerTip_open: "Hide"
            togglerTip_closed: "Show"
            onopen_start: ->
                layout.open 'west'
            onclose_start: ->
                layout.close 'west'
        west:
            livePaneResizing: true
            size: 192
            spacing_closed: 0
            togglerLength_open: 0


$('body').on 'click', 'a.file-link', ->
    open_path $(this).data('path')
