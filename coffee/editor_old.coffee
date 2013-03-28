




window.current_folder = ->
    $('#route').data 'path'

window.create_file = ->
    file_path = window.prompt_file_name()
    return if not file_path
    file_manager.write file_path, ''
    window.open_path file_path


window.create_folder = ->
    folder_name = prompt "#{chrome.i18n.getMessage('create_folder')} #{window.current_folder()}/"
    if not folder_name or folder_name.trim() == ''
        return
    if not file_manager.valid_name folder_name
        return window.notice chrome.i18n.getMessage('invalid_path_name'), folder_name
    folder_path = "#{window.current_folder()}/#{folder_name}"
    if file_manager.exists folder_path
        return window.notice chrome.i18n.getMessage('already_exists'), folder_path
    file_manager.create_folder folder_path
    window.show_sidebar window.current_folder()




window.open_path = (path) ->
    if not file_manager.exists(path)
        window.notice chrome.i18n.getMessage('does_not_exist'), path
        route = file_manager.route path
        for item in _.rest(route)
            if file_manager.exists item.path
                window.open_path item.path
                return
        return
    type = file_manager.type path
    if type == 'file'
        window.open_file path
        path = file_manager.container(path)
    if not file_manager.can_list path
        window.notice chrome.i18n.getMessage('permission_denied'), path
        path = file_manager.home_folder() or file_manager.temp_folder()
    document.title = path
    show_breadcrumb path
    show_sidebar path


$ ->
    chrome.storage.local.get ['path', 'file'], (items) ->
        path = items.file or items.path or file_manager.home_folder() or file_manager.temp_folder()
        open_path path
        path = items.path or file_manager.home_folder() or file_manager.temp_folder()
        open_path path

    window.add_topbar()
