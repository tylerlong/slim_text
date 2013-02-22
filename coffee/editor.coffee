editor = ace.edit "editor"

editor.commands.addCommand
    name: 'saveCommand'
    bindKey: { win: 'Ctrl-S',  mac: 'Command-S' }
    exec: (editor) ->
        alert 'fake save'
    readOnly: false

$('body').on 'click', 'a.resource-link', ->
    link = $(this)
    if $(this).data('dir')
        # list the content of folder
    else
        editor.setValue('content', -1)
        mode = guess_mode(link.text().file_exteniosn())
        editor.getSession().setMode mode
        breadcrumb(link.data('path'))

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
    xml = $('')
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
        $('#editor').css('font-size', items.font_size)

        if items.mode
            editor.getSession().setMode "ace/mode/#{items.mode}"

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
