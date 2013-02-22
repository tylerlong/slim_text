editor = ace.edit "editor"
file_manager = document.getElementById('file_manager')


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
        items = file_manager.list(path)
        items = _.sortBy items, (item) ->
            return item.name.toLowerCase()
        for item in items
            if item.type == 'file' || item.type == 'folder'
                link = $("""<a href="#" class="file-link">#{item.name}</a>""")
                link.data("name", item.name)
                link.data("path", item.path)
                link.data("type", item.type)
                $('#sidebar').append link
                $('#sidebar').append "<br/>"


$('body').on 'click', 'a.file-link', ->
    path = $(this).data('path')
    type = $(this).data('type')
    if type == 'file'
        console.log "open file: #{path}"
    else if type == 'folder'
        console.log "open folder #{path}"
