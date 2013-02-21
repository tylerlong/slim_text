editor = ace.edit "editor"
webdav_service_url = "http://localhost:8484"

editor.commands.addCommand
    name: 'saveCommand'
    bindKey: { win: 'Ctrl-S',  mac: 'Command-S' }
    exec: (editor) ->
        alert 'fake save'
    readOnly: false

setMode = (file) ->
    extension = file.substr (file.lastIndexOf('.') + 1)
    switch extension
        when 'html', 'htm'
            editor.getSession().setMode "ace/mode/html"
        when 'css'
            editor.getSession().setMode "ace/mode/css"
        when 'js'
            editor.getSession().setMode "ace/mode/javascript"
        when 'coffee'
            editor.getSession().setMode "ace/mode/coffee"
        when 'txt'
            editor.getSession().setMode "ace/mode/text"
        when 'py'
            editor.getSession().setMode "ace/mode/python"
        when 'rb'
            editor.getSession().setMode "ace/mode/ruby"
        else
            editor.getSession().setMode "ace/mode/text"

$('body').on 'click', 'a.resource-link', ->
    link = $(this)
    if $(this).data('dir')
        openFolder($(this).data('path'))
    else
        $.ajax
            type: "GET"
            url: webdav_service_url + $(this).data('path')
            dataType: "text"
            success: (data) ->
                editor.setValue(data, -1)
                setMode link.text()
                breadcrumb(link.data('path'))

parentFolder = (folder) ->
    tokens = _.filter folder.split(/\//), (item) ->
        item != ''
    if tokens.length == 0
        return ''
    else
        return '/' + _.initial(tokens).join('/')

lastToken = (path) ->
    tokens = _.filter path.split(/\//), (item) ->
        item != ''
    return _.last(tokens)

breadcrumb = (path) ->
    $('#current_path').html('')
    tokens = _.filter path.split(/\//), (token) ->
        token != ''

    if tokens.length > 0
        link = $("""<a href="#" class="resource-link">~</a>""")
        link.data('dir', true)
        link.data('path', '/')
        $('#current_path').append link
    else
        $('#current_path').append $("<span>~</span>")

    counter = 0
    _.each _.initial(tokens), (item) ->
        link = $("""<a href="#" class="resource-link">#{item}</a>""")
        link.data('dir', 'true')
        link.data('path', '/' + _.first(tokens, counter + 1).join('/'))
        $('#current_path').append ' / '
        $('#current_path').append link
        counter += 1

    item = _.last(tokens)
    if item
        $('#current_path').append ' / '
        $('#current_path').append $("""<span>#{item}</span>""")

openFolder = (folder) ->
    $.ajax
        type: "PROPFIND"
        url: webdav_service_url + folder
        dataType: "text"
        success: (data) ->
            xml = $(data)
            $('#sidebar').html('')
            if folder != '/'
                link = $("""<a href="#" class="resource-link">..</a><br/>""")
                link.data('dir', true)
                link.data('path', parentFolder(folder))
                $('#sidebar').append link
            xml.find('D\\:response').next().each (i) ->
                href = $(this).find('D\\:href').text()
                dir = $(this).find('D\\:collection').length > 0
                link = $("""<a href="#" class="resource-link">#{lastToken(href)}</a><br/>""")
                link.data('dir', dir)
                link.data('path', href)
                $('#sidebar').append link

            breadcrumb(folder)

$ ->
    chrome.storage.sync.get ['theme', 'mode', 'font_size'], (items) ->
        if not items.theme
            items.theme = 'monokai'
        if not items.font_size
            items.font_size = '16px'

        editor.setTheme "ace/theme/#{items.theme}"
        editor.getSession().setMode "ace/mode/#{items.mode}"
        $('#editor').css('font-size', items.font_size)

        openFolder('/')

    layout = $('body').layout
        livePaneResizing: true
        spacing_open: 15
        initClosed: true
        onresize: ->
            editor.resize()
        north:
            spacing_closed: 15
            size: 32
            resizable: false
            togglerLength_closed: 128
            togglerLength_open: 128
            togglerContent_open: "Hide"
            togglerTip_open: "Hide"
            togglerContent_closed: "Show"
            togglerTip_closed: "Show"
            onopen_start: ->
                layout.open 'west'
            onclose_start: ->
                layout.close 'west'
        west:
            size: 192
            spacing_closed: 0
            togglerLength_open: 0
