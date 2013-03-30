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

    prompt_path_name: (type) ->
        message = chrome.i18n.getMessage("create_#{type}")
        path_name = prompt "#{message} #{document.title}"
        if not path_name or path_name.trim() == ''
            return false
        if not file_manager.valid_name path_name
            util.notice chrome.i18n.getMessage('invalid_path_name'), path_name
            return false
        path = "#{document.title}#{path_name}"
        if file_manager.exists path
            util.notice chrome.i18n.getMessage('already_exists'), path
            return false
        return path

    current_editor: ->
        current_panel = $("#tabs div.ui-tabs-panel[aria-hidden='false']")
        if not current_panel
            return null
        uid = current_panel.data 'uid'
        return editors[uid]

    last_folder: (callback) ->
        chrome.storage.local.get ['path'], (items) ->
            if items.path and file_manager.exists(items.path)
                path = items.path
            else
                path = file_manager.home_folder() or file_manager.temp_folder()
            callback path
    
    last_files: (callback) ->
        chrome.storage.local.get ['paths'], (items) ->
            if items.paths
                callback items.paths
