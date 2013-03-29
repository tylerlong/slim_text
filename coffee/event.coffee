class @Event
    constructor: ->
        $('body').on 'click', '.path_link', ->
            action.open_path $(this).data('path')

        $('body').on 'click', '.options_btn', ->
            chrome.tabs.create { url: chrome.extension.getURL('html/options.html') }

        $('body').on 'click', "span.ui-icon-close", ->
            uid = $(this).closest("li").attr('aria-controls').substr(4)
            editors[uid].dispose()

class @Action
    open_path: (path) ->
        if not file_manager.exists(path)
            util.notice chrome.i18n.getMessage('does_not_exist'), path
            route = file_manager.route path
            for item in _.rest(route)
                if file_manager.exists item.path
                    action.open_folder item.path
                    return
            return
        type = file_manager.type path
        if type == 'file'
            action.open_file path
            path = file_manager.container(path)
        action.open_folder path

    open_file: (path) ->
        for key, editor of editors
            if path == editor.path
                uid = editor.uid
                index = $('#tabs ul li').index $("#link-#{uid}")
                $('#tabs').tabs 'option', "active", index
                return
        editor = new Editor path
        editors[editor.uid] = editor

    open_folder: (path) ->
        if not file_manager.can_list path
            util.notice chrome.i18n.getMessage('permission_denied'), path
            path = file_manager.home_folder() or file_manager.temp_folder()
        document.title = path
        application.show_breadcrumb path
        application.show_sidebar path

#window.full_window = ->
    #if window.layout.state.north.isVisible
        #window.layout.close 'north'
#
#window.exit_full_window = ->
    #if window.layout.state.north.isClosed
        #window.layout.open 'north'
#
#$(document).keydown (event) ->
    #if (String.fromCharCode(event.which).toLowerCase() == 's' and event.ctrlKey) or event.which == 19
        #window.save_file()
        #event.preventDefault()
        #return false
    #else if event.which == 27
        #window.exit_full_window()
    #return true
#
#$('body').on 'click', '.file-link', ->
    #window.open_path $(this).data('path')
#
#$('body').on 'click', '.full_window_btn', ->
    #window.full_window()
#
#$('body').on 'click', '.save_btn', ->
    #window.save_file()
#
#$('body').on 'click', '.mode-link', ->
    #window.editor.getSession().setMode "ace/mode/#{$(this).data('mode')}"

#
#$('body').on 'click', '.about_btn', ->
    #util.notice "Slim Text #{chrome.app.getDetails().version}", "Copyright © 2012 - 2013 slimtext.org", 5000
#
#$('body').on 'change', '#drives_select', ->
    #window.open_path $(this).val()
#
#$('body').on 'click', '.remove_lines_btn', ->
    #window.editor.removeLines()
#
#$('body').on 'click', '.lower_case_btn', ->
    #window.editor.toLowerCase()
#
#$('body').on 'click', '.upper_case_btn', ->
    #window.editor.toUpperCase()
#
#$('body').on 'click', '.toggle_comment_btn', ->
    #window.editor.toggleCommentLines()
#
#$('body').on 'click', '.indent_btn', ->
    #window.editor.indent()
#
#$('body').on 'click', '.outdent_btn', ->
    #window.editor.blockOutdent()
#
#$('body').on 'click', '.toggle_invisibles_btn', ->
    #window.editor.setShowInvisibles(!window.editor.getShowInvisibles())
#
#$('body').on 'click', '.toggle_word_wrap_btn', ->
    #window.editor.getSession().setUseWrapMode(!window.editor.getSession().getUseWrapMode())
#
#$('body').on 'click', '.find_btn', ->
    #ace.require('ace/ext/searchbox').Search(window.editor)
#
#$('body').on 'click', '.replace_btn', ->
    #ace.require('ace/ext/searchbox').Search(window.editor, true)
    #
#$('body').on 'click', '.new_file_btn', ->
    #setTimeout((-> window.create_file()), 50)
#
#$('body').on 'click', '.new_folder_btn', ->
    #setTimeout((-> window.create_folder()), 50)
#
#$('body').on 'click', '.check_for_updates_btn', ->
    #$.get('https://raw.github.com/tylerlong/slimtext.org/gh-pages/__version__', (data) ->
        #newest = data.trim()
        #current = chrome.app.getDetails().version
        #if newest > current
            #util.notice "#{chrome.i18n.getMessage('new_version')}: #{newest}", chrome.i18n.getMessage('fetch_and_install'), 8000
        #else
            #util.notice chrome.i18n.getMessage('no_update'), "#{chrome.i18n.getMessage('newest_version')}: #{current}", 5000
            #
    #).fail ->
        #util.notice chrome.i18n.getMessage('network_error'), chrome.i18n.getMessage('check_manually'), 5000

#window.onbeforeunload = () ->
    #chrome.storage.local.set { 'path': window.storage.path, 'file': window.storage.file }
    #if document.title.indexOf('* ') == 0
        #return """"#{window.storage.file}" #{chrome.i18n.getMessage('save_before_leaving')}"""
