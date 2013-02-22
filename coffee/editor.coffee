editor = ace.edit "editor"

$ ->
    chrome.storage.sync.get ['theme', 'font_size'], (items) ->
        if not items.theme
            items.theme = 'monokai'
        if not items.font_size
            items.font_size = '16'

        editor.setTheme "ace/theme/#{items.theme}"
        editor.setFontSize "#{items.font_size}px"

    file_manager = document.getElementById('file_manager')
    chrome.storage.local.get ['path'], (items) ->
        path = items.path
        if not path
            path = file_manager.temp_folder()
            chrome.storage.local.set { 'path': path }
        items = file_manager.list(path)
        for item in items
            link = $("""<a href="#" class="file-link">#{item}</a>""")
            link.data("path", item)
            $('#sidebar').append link
            $('#sidebar').append "<br/>"


$('body').on 'click', 'a.file-link', ->
    console.log $(this).data('path')
