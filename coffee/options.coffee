$ ->
    _.each _.range(8, 33), (i) ->
        $('#font_size').append $("""<option value="#{i}px">#{i}px</option>""")

    chrome.storage.sync.get ['theme', 'font_size'], (items) ->
        if not items.theme
            items.theme = 'monokai'
        if not items.font_size
            items.font_size = '16px'

        $('select#theme').val items.theme
        $('select#font_size').val items.font_size

        $('button#btn').click ->
            chrome.storage.sync.set {'theme': $('select#theme').val(), 'font_size': $('select#font_size').val()}, ->
                alert "options saved"

    $('#close_btn').click ->
        if confirm('Close window?')
            chrome.tabs.getCurrent (tab) ->
                chrome.tabs.remove tab.id
