@editors = {}
@event = new Event()
@action = new Action()
@file_manager = new FileManager()
@mode = new Mode()
@util = new Util()
@showdown = new Showdown.converter()

$ ->
    util.last_folder (path) ->
        window.application = new Application(path)

    util.last_files (paths) ->
        for path in paths
            if file_manager.exists path
                application.open_file path
