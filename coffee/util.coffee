window.notice = (title, content) ->
    notification = window.webkitNotifications.createNotification '../icon/icon48.png', title, content
    notification.show()
    setTimeout (-> notification.cancel()), 3600
