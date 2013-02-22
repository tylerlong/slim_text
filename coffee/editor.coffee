editor = ace.edit "editor"

$ ->
    chrome.storage.sync.get ['theme', 'font_size'], (items) ->
        if not items.theme
            items.theme = 'monokai'
        if not items.font_size
            items.font_size = '16'

        editor.setTheme "ace/theme/#{items.theme}"
        editor.setFontSize "#{items.font_size}px"

    editor.setValue 'good to know', -1
