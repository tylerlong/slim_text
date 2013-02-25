window.modes =
    'abap': 'ABAP'
    'asciidoc': 'AsciiDoc'
    'c_cpp': 'C/C++'
    'clojure': 'Clojure'
    'coffee': 'CoffeeScript'
    'coldfusion': 'Coldfusion'
    'csharp': 'C#'
    'css': 'CSS'
    'curly': 'Curly'
    'dart': 'Dart'
    'diff': 'Diff'
    'dot': 'Dot'
    'glsl': 'Glsl'
    'golang': 'Golang'
    'groovy': 'Groovy'
    'haml': 'HAML'
    'haxe': 'haXe'
    'html': 'HTML'
    'jade': 'Jade'
    'java': 'Java'
    'javascript': 'Javascript'
    'json': 'JSON'
    'jsp': 'JSP'
    'jsx': 'JSX'
    'latex': 'LaTex'
    'less': 'LESS'
    'liquid': 'Liquid'
    'lisp': 'Lisp'
    'lua': 'Lua'
    'luapage': 'LuaPage'
    'lucene': 'Lucene'
    'makefile': 'Makefile'
    'markdown': 'Markdown'
    'objectivec': 'Objective-C'
    'ocaml': 'Ocaml'
    'perl': 'Perl'
    'pgsql': 'pgSQL'
    'php': 'PHP'
    'powershell': 'Powershell'
    'python': 'Python'
    'r': 'R'
    'rdoc': 'RDoc'
    'rhtml': 'RHTML'
    'ruby': 'Ruby'
    'scad': 'OpenSCAD'
    'scala': 'Scala'
    'scss': 'SCSS'
    'sh': 'SH'
    'sql': 'SQL'
    'stylus': 'Stylus'
    'svg': 'SVG'
    'tcl': 'Tcl'
    'tex': 'Tex'
    'text': 'Text'
    'textible': 'Textile'
    'typescript': 'Typescript'
    'vbscript': 'VBScript'
    'xml': 'XML'
    'xquery': 'XQuery'
    'yaml': 'YAML'


extensions =
    'abap': 'abap'

    'asciidoc': 'asciidoc'

    'c9search': 'c9search'

    'cpp': 'c_cpp'
    'h': 'c_cpp'
    'c': 'c_cpp'
    'hpp': 'c_cpp'
    'cc': 'c_cpp'
    'hxx': 'c_cpp'
    'cxx': 'c_cpp'
    'c++': 'c_cpp'

    'clj': 'clojure'
    'clojure': 'clojure'

    'coffee': 'coffee'

    'cfm': 'coldfusion'
    'cfml': 'coldfusion'
    'coldfusion': 'coldfusion'

    'cs': 'csharp'
    'csharp': 'csharp'

    'css': 'css'

    'curly': 'curly'

    'dart': 'dart'

    'diff': 'diff'

    'dot': 'dot'

    'glsl': 'glsl'
    'vert': 'glsl'
    'frag': 'glsl'

    'go': 'golang'
    'golang': 'golang'

    'groovy': 'groovy'
    'gvy': 'groovy'
    'gy': 'groovy'
    'gsh': 'groovy'

    'haml': 'haml'

    'hx': 'haxe'
    'haxe': 'haxe'

    'htm': 'html'
    'html': 'html'

    'jade': 'jade'

    'java': 'java'

    'js': 'javascript'
    'javascript': 'javascript'

    'json': 'json'

    'jsp': 'jsp'

    'jsx': 'jsx'

    'latex': 'latex'
    'tex': 'latex'

    'less': 'less'

    'liquid': 'liquid'

    'lisp': 'lisp'

    'lua': 'lua'

    'luapage': 'luapage'

    'lucene': 'lucene'

    'cmake': 'makefile'
    'make': 'makefile'
    'makefile': 'makefile'

    'md': 'markdown'
    'markdown': 'markdown'

    'm': 'objectivec'
    'mm': 'objectivec'
    'objectivec': 'objectivec'

    'ml': 'ocaml'
    'ocaml': 'ocaml'

    'pl': 'perl'
    'perl': 'perl'

    'pgsql': 'pgsql'

    'php': 'php'

    'ps1': 'powershell'
    'ps1xml': 'powershell'
    'psc1': 'powershell'
    'psd1': 'powershell'
    'psm1': 'powershell'
    'powershell': 'powershell'

    'py': 'python'
    'python': 'python'

    'r': 'r'

    'rdoc': 'rdoc'

    'rhtml': 'rhtml'

    'ruby': 'ruby'

    'scad': 'scad'

    'scala': 'scala'

    'scss': 'scss'

    'sh': 'sh'

    'sql': 'sql'

    'stylus': 'stylus'
    'styl': 'stylus'

    'svg': 'svg'

    'tcl': 'tcl'

    'tex': 'tex'

    'txt': 'text'
    'text': 'text'

    'textile': 'textile'

    'typescript': 'typescript'
    'ts': 'typescript'

    'vbscript': 'vbscript'
    'vbs': 'vbscript'

    'xml': 'xml'

    'xquery': 'xquery'

    'yaml': 'yaml'
    'yml': 'yaml'


window.guess_mode = (file_extension) ->
    mode = extensions[file_extension]
    if not mode
        mode = 'text'
    return "ace/mode/#{mode}"
