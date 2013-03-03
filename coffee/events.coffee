window.editor.commands.addCommand
    name: 'saveCommand'
    bindKey: { win: 'Ctrl-S',  mac: 'Command-S' }
    exec: ->
        window.save_file()
    readOnly: false
    
window.editor.commands.addCommand
    name: 'exitFullWindowCommand'
    bindKey: { win: 'Esc',  mac: 'Esc' }
    exec: ->
        if window.layout.state.north.isClosed
            window.layout.open 'north'

lazy_change = _.debounce (->
    if document.title.indexOf('* ') != 0
        document.title = '* ' + document.title
    ), 500, true
window.editor.getSession().on 'change', ->
    lazy_change()
    window.editor.focus()

$('body').on 'click', '.file-link', ->
    window.open_path $(this).data('path')

$('body').on 'click', '.full_window_btn', ->
    window.layout.close 'north'
    window.layout.close 'west'
    window.editor.focus()

$('body').on 'click', '.save_btn', ->
    window.save_file()

$('body').on 'click', '.mode-link', ->
    window.editor.getSession().setMode "ace/mode/#{$(this).data('mode')}"

$('body').on 'click', '.options_btn', ->
    chrome.tabs.create { url: chrome.extension.getURL('html/options.html') }

$('body').on 'click', '.about_btn', ->
    window.notice "Slim Text #{chrome.app.getDetails().version}", "Copyright @ 2012 - 2013 slimtext.org", 5000

$('body').on 'change', '#drives_select', ->
    window.open_path $(this).val()

$('body').on 'click', '.remove_lines_btn', ->
    window.editor.removeLines()

$('body').on 'click', '.lower_case_btn', ->
    window.editor.toLowerCase()

$('body').on 'click', '.upper_case_btn', ->
    window.editor.toUpperCase()

$('body').on 'click', '.toggle_comment_btn', ->
    window.editor.toggleCommentLines()

$('body').on 'click', '.indent_btn', ->
    window.editor.indent()

$('body').on 'click', '.outdent_btn', ->
    window.editor.blockOutdent()

window.onbeforeunload = () ->
    chrome.storage.local.set { 'path': window.storage.path, 'file': window.storage.file }
    if document.title.indexOf('* ') == 0
        return """"#{window.storage.file}" #{chrome.i18n.getMessage('save_before_leaving')}"""
