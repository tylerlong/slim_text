class @FileManager
    constructor:  ->
        @file_manager = document.getElementById('file_manager')

    container: (path) ->
        @file_manager.container path

    filename: (path) ->
        @file_manager.filename path

    read: (path) ->
        @file_manager.read path

    extension: (filename) ->
        @file_manager.extension filename

    write: (path, content) ->
        @file_manager.write path, content

    valid_name: (filename) ->
        @file_manager.valid_name filename

    exists: (path) ->
        @file_manager.exists path

    type: (path) ->
        @file_manager.type path

    create_file: (path) ->
        @write path, ''

    create_folder: (path) ->
        @file_manager.create_folder path

    route: (path) ->
        @file_manager.route path

    can_list: (path) ->
        @file_manager.can_list path

    home_folder: ->
        @file_manager.home_folder()

    temp_folder: ->
        folder = @file_manager.temp_folder()
        folder = folder.slice(0, -1) if folder.slice(-1) == '/'
        folder

    drives: ->
        @file_manager.drives()

    list: (path) ->
        @file_manager.list path
