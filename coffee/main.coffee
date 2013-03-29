@editors = {}
@event = new Event()
@action = new Action()
@file_manager = new FileManager()
@mode = new Mode()
@util = new Util()

$ ->
    util.last_folder (path) ->
        window.application = new Application(path)
