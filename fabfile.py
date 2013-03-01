from fabric.api import *
from contextlib import contextmanager as _contextmanager

env.user = 'root'
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
        folder = 'dist/{0}/'.format(data['version'])
    with workspace():
        run('mkdir -p {0}'.format(folder))
        run('rm -rf {0}*'.format(folder))
        run('cp -r _locales/ {0}'.format(folder))
        run('cp -r ace/ {0}'.format(folder))
        run('cp -r css/ {0}'.format(folder))
        run('cp -r font/ {0}'.format(folder))
        run('cp -r html/ {0}'.format(folder))
        run('cp -r image/ {0}'.format(folder))
        run('cp -r js/ {0}'.format(folder))
        run('cp manifest.json {0}'.format(folder))
        run('cp -r plugin/ {0}'.format(folder))
