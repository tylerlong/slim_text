editor = ace.edit "editor"
file_manager = document.getElementById('file_manager')


show_breadcrumb = (path) ->
    $('#route').html('')
    route = file_manager.route(path)
    route.reverse()
    for item in _.initial(route)
        link = $("""<a href="#" class="file-link">#{item.name}</a>""")
        link.data("name", item.name)
        link.data("path", item.path)
        link.data("type", item.type)
        $('#route').append(link)
        if item.name == '/'
            $('#route').append(' ')
        else
            $('#route').append(' / ')
    last_token = _.last(route)
    if last_token
        $('#route').append("#{last_token.name}")


open_folder = (path) ->
    $('#sidebar').html('')
    items = file_manager.list(path)
    items = _.sortBy items, (item) ->
        item.name.toLowerCase()
    for item in items
        if item.type == 'file' || item.type == 'folder'
            link = $("""<a href="#" class="file-link">#{item.name}</a>""")
            link.data("name", item.name)
            link.data("path", item.path)
            link.data("type", item.type)
            $('#sidebar').append link
            $('#sidebar').append "<br/>"

    show_breadcrumb path


open_file = (path) ->
    content = file_manager.read(path)
    editor.setValue content, -1

    show_breadcrumb path


$ ->
    chrome.storage.sync.get ['theme', 'font_size'], (items) ->
        if not items.theme
            items.theme = 'monokai'
        if not items.font_size
            items.font_size = '16'

        editor.setTheme "ace/theme/#{items.theme}"
        editor.setFontSize "#{items.font_size}px"

    chrome.storage.local.get ['path'], (items) ->
        path = items.path
        if not path
            path = file_manager.temp_folder()
            chrome.storage.local.set { 'path': path }

        type = file_manager.type(path)
        if type == 'folder'
            open_folder path
        else if type == 'file'
            open_folder file_manager.container(path)
            open_file path



$('body').on 'click', 'a.file-link', ->
    path = $(this).data('path')
    type = $(this).data('type')
    if type == 'file'
        open_file path
    else if type == 'folder'
        open_folder path
