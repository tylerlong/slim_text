from fabric.api import *
from contextlib import contextmanager as _contextmanager

env.user = 'root'
env.directory = '/home/tyler/src/win/javascript/slim_text'
env.hosts = ['localhost']

@_contextmanager
def workspace():
    with cd(env.directory):
        yield

def coffee():
    """start coffeescript daemon to compile dynamically"""
    with workspace():
        run('coffee --watch --output js/ --compile coffee/')
