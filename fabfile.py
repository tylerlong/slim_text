from fabric.api import *
from contextlib import contextmanager as _contextmanager

env.user = 'tyler'
env.directory = '/home/tyler/src/win/javascript/slim_text/'
env.hosts = ['localhost']

@_contextmanager
def workspace():
    with cd(env.directory):
        yield

def coffee():
    """start coffeescript daemon to compile dynamically"""
    with workspace():
        run('coffee --watch --output js/ --compile coffee/')

def dist():
    """generate distribution package inside the dist/ folder"""
    import json
    folder = ''
    with open('manifest.json', 'r') as file:
        data = json.loads(file.read())
        folder = '../slimtext.org/dist/{0}'.format(data['version'])
    with workspace():
        run('mkdir -p {0}/'.format(folder))
        run('rm -rf {0}/*'.format(folder))
        run('cp -r _locales/ {0}/'.format(folder))
        run('mkdir -p {0}/ace/src-min-noconflict/'.format(folder))
        run('cp -r ace/src-min-noconflict/* {0}/ace/src-min-noconflict/'.format(folder))
        
        run('mkdir -p {0}/css/'.format(folder))
        run('scss -t compressed css/bootstrap.css {0}/css/bootstrap.css'.format(folder))
        run('scss -t compressed css/editor.css {0}/css/editor.css'.format(folder))
        run('scss -t compressed css/jquery.layout.css {0}/css/jquery.layout.css'.format(folder))
        run('scss -t compressed css/options.css {0}/css/options.css'.format(folder))
        
        run('cp -r font/ {0}/'.format(folder))
        run('cp -r html/ {0}/'.format(folder))
        run('cp -r image/ {0}/'.format(folder))
        run('cp -r js/ {0}/'.format(folder))
        run('cp manifest.json {0}/'.format(folder))
        run('cp -r plugin/ {0}/'.format(folder))
