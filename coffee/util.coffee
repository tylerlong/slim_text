class @Util
    notice: (title, content, timeout = 3000) ->
        notification = webkitNotifications.createNotification '../image/icon48.png', title, content
        notification.show()
        setTimeout (-> notification.cancel()), timeout
    
    clickable: (item) ->
        if item.type == 'file'
            extension = file_manager.extension(item.name)
            if extension.length > 0
                extension = extension.toLowerCase().substr(1, extension.length - 1)
                return false if mode.is_binary(extension)
        return true
    
    prompt_file_name: ->
        file_name = prompt "#{chrome.i18n.getMessage('create_file')} #{window.current_folder()}/"
        if not file_name or file_name.trim() == ''
            return false
        if not file_manager.valid_name file_name
            window.notice chrome.i18n.getMessage('invalid_path_name'), file_name
            return false
        file_path = "#{window.current_folder()}/#{file_name}"
        if file_manager.exists file_path
            window.notice chrome.i18n.getMessage('already_exists'), file_path
            return false
        return file_path
    
    current_editor: ->
        current_panel = $("#tabs div.ui-tabs-panel[aria-hidden='false']")
        if not current_panel
            return null
        uid = current_panel.data 'uid'
        return editors[uid]
