@application = new Application()
@editors = {}
@event = new Event()
@action = new Action()
@file_manager = new FileManager()
@mode = new Mode()
@util = new Util()

$ ->
    application.show_breadcrumb('/home/tyler/src/win/test/')
    application.show_sidebar('/home/tyler/src/win/test/')
    editor = new Editor('/home/tyler/src/win/test/111.py')
    editors[editor.uid] = editor
