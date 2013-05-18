from fabric.api import task, cd, local

PROJECT_DIR = '/home/tyler/src/win/javascript/slim_text/'

@task
def coffee():
    """start coffeescript daemon to compile dynamically"""
    with cd(PROJECT_DIR):
        local('coffee --watch --output js/ --compile coffee/')

@task
def dist():
    """generate distribution package inside the dist/ folder"""
    import json
    folder = ''
    with open('manifest.json', 'r') as file:
        data = json.loads(file.read())
        folder = '../slimtext.org/dist/{0}'.format(data['version'])
    with cd(PROJECT_DIR):
        local('mkdir -p {0}/'.format(folder))
        local('rm -rf {0}/*'.format(folder))

        local('cp -r _locales {0}/'.format(folder))

        local('mkdir -p {0}/ace/src-min-noconflict/'.format(folder))
        local('cp -r ace/src-min-noconflict/* {0}/ace/src-min-noconflict/'.format(folder))

        local('mkdir -p {0}/css/'.format(folder))
        local('scss -t compressed css/bootstrap.css {0}/css/bootstrap.css'.format(folder))
        local('scss -t compressed css/editor.css {0}/css/editor.css'.format(folder))
        local('scss -t compressed css/jquery.layout.css {0}/css/jquery.layout.css'.format(folder))
        local('scss -t compressed css/jqueryui.css {0}/css/jqueryui.css'.format(folder))
        local('scss -t compressed css/options.css {0}/css/options.css'.format(folder))
        local('cp -r -n css/* {0}/css/'.format(folder))

        local('mkdir -p {0}/font/'.format(folder))
        local('scss -t compressed font/fonts.css {0}/font/fonts.css'.format(folder))
        local('cp -r -n font/* {0}/font/'.format(folder))

        local('cp -r html/ {0}/'.format(folder))

        local('mkdir -p {0}/image/'.format(folder))
        local('cp -r image/* {0}/image/'.format(folder))

        local('mkdir -p {0}/js/'.format(folder))
        local('uglifyjs js/application.js -c -m -o {0}/js/application.js'.format(folder))
        local('uglifyjs js/background.js -c -m -o {0}/js/background.js'.format(folder))
        local('uglifyjs js/editor.js -c -m -o {0}/js/editor.js'.format(folder))
        local('uglifyjs js/event.js -c -m -o {0}/js/event.js'.format(folder))
        local('uglifyjs js/file_manager.js -c -m -o {0}/js/file_manager.js'.format(folder))
        local('uglifyjs js/main.js -c -m -o {0}/js/main.js'.format(folder))
        local('uglifyjs js/mode.js -c -m -o {0}/js/mode.js'.format(folder))
        local('uglifyjs js/option.js -c -m -o {0}/js/option.js'.format(folder))
        local('uglifyjs js/util.js -c -m -o {0}/js/util.js'.format(folder))
        local('cp -r -n js/* {0}/js/'.format(folder))

        local('cp manifest.json {0}/'.format(folder))
        local('cp -r plugin/ {0}/'.format(folder))
