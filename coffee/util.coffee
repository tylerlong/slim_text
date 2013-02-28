window.notice = (title, content, timeout = 3000) ->
    window.notification = window.webkitNotifications.createNotification '../image/icon48.png', title, content
    window.notification.show()
    setTimeout (-> window.notification.cancel()), timeout
