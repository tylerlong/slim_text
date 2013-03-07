$ ->
    _.each _.range(8, 33), (i) ->
        $('#font_size').append $("""<option value="#{i}">#{i}px</option>""")
    
    chrome.storage.sync.get ['theme', 'font_size', 'key_binding', 'tab_size'], (items) ->
        if not items.theme
            items.theme = 'monokai'
        if not items.font_size
            items.font_size = '12'
        if not items.key_binding
            items.key_binding = 'ace'
        if not items.tab_size
            items.tab_size = 4

        $('select#theme').val items.theme
        $('select#font_size').val items.font_size
        $('select#key_binding').val items.key_binding
        $('input#tab_size').val items.tab_size
        $('span#tab_size_label').text items.tab_size
        
        $('input#tab_size').change ->
            $('span#tab_size_label').text $(this).val()

        $('button#btn').click ->
            options = 
                'theme': $('select#theme').val()
                'font_size': $('select#font_size').val() 
                'key_binding': $('select#key_binding').val()
                'tab_size': $('input#tab_size').val()
            chrome.storage.sync.set options, ->
                window.notice chrome.i18n.getMessage('saved'), ''
