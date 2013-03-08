window.full_window = ->
    if window.layout.state.north.isVisible
        window.layout.close 'north'

window.exit_full_window = ->
    if window.layout.state.north.isClosed
        window.layout.open 'north'

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
        window.exit_full_window()

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
    window.full_window()

$('body').on 'click', '.save_btn', ->
    window.save_file()

$('body').on 'click', '.mode-link', ->
    window.editor.getSession().setMode "ace/mode/#{$(this).data('mode')}"

$('body').on 'click', '.options_btn', ->
    chrome.tabs.create { url: chrome.extension.getURL('html/options.html') }

$('body').on 'click', '.about_btn', ->
    window.notice "Slim Text #{chrome.app.getDetails().version}", "Copyright © 2012 - 2013 slimtext.org", 5000

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

$('body').on 'click', '.toggle_invisibles_btn', ->
    window.editor.setShowInvisibles(!window.editor.getShowInvisibles())

$('body').on 'click', '.toggle_word_wrap_btn', ->
    window.editor.getSession().setUseWrapMode(!window.editor.getSession().getUseWrapMode())

$('body').on 'click', '.find_btn', ->
    alert "unimplemented, press ctrl + f instead"

$('body').on 'click', '.replace_btn', ->
    alert "unimplemented, press ctrl + h instead"

$('body').on 'click', '.check_for_updates_btn', ->
    $.get('https://raw.github.com/tylerlong/slimtext.org/gh-pages/__version__', (data) ->
        newest = data.trim()
        current = chrome.app.getDetails().version
        if newest > current
            window.notice "#{chrome.i18n.getMessage('new_version')}: #{newest}", chrome.i18n.getMessage('fetch_and_install'), 8000
        else
            window.notice chrome.i18n.getMessage('no_update'), "#{chrome.i18n.getMessage('newest_version')}: #{current}", 5000
            
    ).fail ->
        window.notice chrome.i18n.getMessage('network_error'), chrome.i18n.getMessage('check_manually'), 5000

window.onbeforeunload = () ->
    chrome.storage.local.set { 'path': window.storage.path, 'file': window.storage.file }
    if document.title.indexOf('* ') == 0
        return """"#{window.storage.file}" #{chrome.i18n.getMessage('save_before_leaving')}"""

chrome.omnibox.onInputEntered.addListener (text) ->
    chrome.tabs.getCurrent (tab) ->
        chrome.tabs.query { currentWindow: true, active: true }, (tabs) ->
            if tabs[0].id == tab.id
                text = text.replace /\s{2,}/g, ' '
                tokens = text.split(' ')
                command = tokens[0]
                params = _.rest(tokens).join(' ')
                switch command
                    when 'save'
                        window.save_file()
                    when 'open', 'cd'
                        if params.indexOf('/') == 0 || params.indexOf(':/') == 1
                            window.open_path params
                        else 
                            absolute_path = window.combine_path(window.storage.path, params)
                            if absolute_path != ''
                                window.open_path absolute_path
                            else 
                                window.notice chrome.i18n.getMessage('does_not_exist'), params
                    else
                        window.notice chrome.i18n.getMessage('command_not_found'), command
