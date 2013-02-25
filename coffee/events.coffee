window.editor.commands.addCommand
    name: 'saveCommand'
    bindKey: { win: 'Ctrl-S',  mac: 'Command-S' }
    exec: (editor) ->
        window.save_file()
    readOnly: false

lazy_change = _.debounce (->
    if document.title.indexOf('* ') != 0
        document.title = '* ' + document.title
    ), 500, true
window.editor.getSession().on 'change', (e)->
    lazy_change()

$('body').on 'click', 'a.file-link', ->
    window.open_path $(this).data('path')

$('body').on 'click', '.full_window_btn', ->
    window.layout.close 'north'
    window.layout.close 'west'

$('body').on 'click', '.save_btn', ->
    window.save_file()

$('body').on 'click', 'a.mode-link', ->
    window.editor.getSession().setMode "ace/mode/#{$(this).data('mode')}"
