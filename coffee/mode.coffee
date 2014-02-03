class @Mode
    constructor: ->
        @modes =
            'abap': 'Abap'
            'actionscript': 'ActionScript'
            'ada': 'Ada'
            'apache_conf': 'Apache Conf'
            'asciidoc': 'AsciiDoc'
            'assembly_x86': 'Assembly x86'
            'autohotkey': 'AutoHotKey'
            'batchfile': 'BatchFile'
            'c9search': 'C9Search'
            'c_cpp': 'C/C++'
            'clojure': 'Clojure'
            'cobol': 'Cobol'
            'coffee': 'CoffeeScript'
            'coldfusion': 'Coldfusion'
            'csharp': 'C#'
            'css': 'CSS'
            'curly': 'Curly'
            'd': 'D'
            'dart': 'Dart'
            'diff': 'Diff'
            'django': 'Django'
            'dot': 'Dot'
            'erlang': 'Erlang'
            'ejs': 'EJS'
            'forth': 'Forth'
            'ftl': 'FreeMarker'
            'glsl': 'Glsl'
            'golang': 'Golang'
            'groovy': 'Groovy'
            'haml': 'Haml'
            'handlebars': 'Handlebars'
            'haskell': 'Haskell'
            'haxe': 'haXe'
            'html': 'HTML'
            'html_ruby': 'HTML (Ruby)'
            'ini': 'INI'
            'jack': 'Jack'
            'jade': 'Jade'
            'java': 'Java'
            'javascript': 'Javascript'
            'json': 'JSON'
            'jsoniq': 'JSONiq'
            'jsp': 'JSP'
            'jsx': 'JSX'
            'julia': 'Julia'
            'latex': 'LaTex'
            'less': 'Less'
            'liquid': 'Liquid'
            'lisp': 'Lisp'
            'livescript': 'LiveScript'
            'logiql': 'LogiQL'
            'lsl': 'LSL'
            'lua': 'Lua'
            'luapage': 'LuaPage'
            'lucene': 'Lucene'
            'makefile': 'Makefile'
            'matlab': 'Matlab'
            'markdown': 'Markdown'
            'mel': 'MEL'
            'mysql': 'MySQL'
            'mushcode': 'MUSHCode'
            'nix': 'Nix'
            'objectivec': 'Objective-C'
            'ocaml': 'Ocaml'
            'pascal': 'Pascal'
            'perl': 'Perl'
            'pgsql': 'pgSQL'
            'php': 'PHP'
            'powershell': 'Powershell'
            'prolog': 'Prolog'
            'properties': 'Properties'
            'protobuf': 'Protobuf'
            'python': 'Python'
            'r': 'R'
            'rdoc': 'RDoc'
            'rhtml': 'RHTML'
            'ruby': 'Ruby'
            'rust': 'Rust'
            'sass': 'SASS'
            'scad': 'OpenSCAD'
            'scala': 'Scala'
            'scheme': 'Scheme'
            'scss': 'SCSS'
            'sh': 'Shell'
            'sjs': 'SJS'
            'space': 'Space'
            'snippets': 'Snippets'
            'soy_template': 'Soy template'
            'sql': 'SQL'
            'stylus': 'Stylus'
            'svg': 'SVG'
            'tcl': 'Tcl'
            'tex': 'Tex'
            'text': 'Text'
            'textile': 'Textile'
            'toml': 'Toml'
            'twig': 'Twig'
            'typescript': 'Typescript'
            'vbscript': 'VBScript'
            'velocity': 'Velocity'
            'verilog': 'Verilog'
            'xml': 'XML'
            'xquery': 'XQuery'
            'yaml': 'YAML'


        @extensions =
            'abap': 'abap'
            
            'as': 'actionscript'
            'actionscript': 'actionscript'
            
            'adb': 'ada'
            'ads': 'ada'
            'ada': 'ada'
        
            'asciidoc': 'asciidoc'
            
            'bat': 'batchfile'
            'batchfile': 'batchfile'
            
            'cpp': 'c_cpp'
            'h': 'c_cpp'
            'hh': 'c_cpp'
            'c': 'c_cpp'
            'hpp': 'c_cpp'
            'cc': 'c_cpp'
            'hxx': 'c_cpp'
            'cxx': 'c_cpp'
            'c++': 'c_cpp'
        
            'clj': 'clojure'
            'clojure': 'clojure'
            
            'cbl': 'cobol'
            'cobol': 'cobol'
        
            'coffee': 'coffee'
            'cf': 'coffee'
            'cson': 'coffee'
        
            'cfm': 'coldfusion'
            'cfml': 'coldfusion'
            'coldfusion': 'coldfusion'
        
            'cs': 'csharp'
            'csharp': 'csharp'
        
            'css': 'css'
        
            'curly': 'curly'
            
            'd': 'd'
        
            'dart': 'dart'
        
            'diff': 'diff'
            'patch': 'diff'
        
            'dot': 'dot'
            
            'erl': 'erlang'
            'erlang': 'erlang'
            
            'ejs': 'ejs'
            
            'fth': 'forth'
            'forth': 'forth'
            
            'ftl': 'ftl'
            'freemarker': 'ftl'
        
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
            
            'hbs': 'handlebars'
            'handlebars': 'handlebars'
            
            'hs': 'haskell'
            'haskell': 'haskell'
        
            'hx': 'haxe'
            'haxe': 'haxe'
        
            'htm': 'html'
            'html': 'html'
            'xhtml': 'html'
            'cow': 'html'
            
            'erb': 'html_ruby'
            'html_ruby': 'html_ruby'
            
            'ini': 'ini'
            
            'jack': 'jack'
        
            'jade': 'jade'
        
            'java': 'java'
        
            'js': 'javascript'
            'javascript': 'javascript'
        
            'json': 'json'
        
            'jsp': 'jsp'
        
            'jsx': 'jsx'
            
            'jl': 'julia'
            'julia': 'julia'
        
            'latex': 'latex'
            'tex': 'latex'
            'ltx': 'latex'
            'bib': 'latex'
        
            'less': 'less'
        
            'liquid': 'liquid'
        
            'lisp': 'lisp'
        
            'lua': 'lua'
        
            'luapage': 'luapage'
            'lp': 'luapage'
        
            'lucene': 'lucene'
            
            'livescript': 'livescript'
            'ls': 'livescript'
            
            'logiql': 'logiql'
            'lql': 'logiql'
            'logic': 'logiql'
            
            'lsl': 'lsl'
        
            'cmake': 'makefile'
            'make': 'makefile'
            'makefile': 'makefile'
            
            'matlab': 'matlab'
        
            'md': 'markdown'
            'markdown': 'markdown'
            
            'mel': 'mel'
            
            'mysql': 'mysql'
            
            'mc': 'mushcode'
            'mush': 'mushcode'
            'mushcode': 'mushcode'
            
            'nix': 'nix'
        
            'm': 'objectivec'
            'mm': 'objectivec'
            'objectivec': 'objectivec'
        
            'ml': 'ocaml'
            'mli': 'ocaml'
            'ocaml': 'ocaml'
            
            'pascal': 'pascal'
            'p': 'pascal'
            'pas': 'pascal'
        
            'pl': 'perl'
            'pm': 'perl'
            'perl': 'perl'
        
            'pgsql': 'pgsql'
        
            'php': 'php'
            'phtml': 'php'
        
            'ps1': 'powershell'
            'ps1xml': 'powershell'
            'psc1': 'powershell'
            'psd1': 'powershell'
            'psm1': 'powershell'
            'powershell': 'powershell'
            
            'prolog': 'prolog'
            
            'properties': 'properties'
            
            'protobuf': 'protobuf'
        
            'py': 'python'
            'python': 'python'
        
            'r': 'r'
        
            'rdoc': 'rdoc'
            'rd': 'rdoc'
        
            'rhtml': 'rhtml'
        
            'rb': 'ruby'
            'ru': 'ruby'
            'gemspec': 'ruby'
            'rake': 'ruby'
            'ruby': 'ruby'
            
            'rs': 'rust'
            'rust': 'rust'
        
            'scad': 'scad'
        
            'scala': 'scala'
            
            'scm': 'scheme'
            'rkt': 'scheme'
            'scheme': 'scheme'
        
            'sass': 'sass'
            
            'scss': 'scss'
        
            'sh': 'sh'
            'bash': 'sh'
            
            'sjs': 'sjs'
            
            'space': 'space'
            
            'snippets': 'snippets'
            
            'soy_template': 'soy_template'
        
            'sql': 'sql'
        
            'stylus': 'stylus'
            'styl': 'stylus'
        
            'svg': 'svg'
        
            'tcl': 'tcl'
        
            'tex': 'tex'
        
            'txt': 'text'
            'text': 'text'
            'log': 'text'
            'conf': 'text'
        
            'textile': 'textile'
            
            'toml': 'toml'
            
            'twig': 'twig'
        
            'typescript': 'typescript'
            'ts': 'typescript'
            'str': 'typescript'
        
            'vbscript': 'vbscript'
            'vbs': 'vbscript'
            
            'vm': 'velocity'
            'velocity': 'velocity'
            
            'v': 'verilog'
            'verilog': 'verilog'
        
            'xml': 'xml'
            'rdf': 'xml'
            'rss': 'xml'
            'wsdl': 'xml'
            'xslt': 'xml'
            'atom': 'xml'
            'mathml': 'xml'
            'mml': 'xml'
            'xul': 'xml'
            'xbl': 'xml'
        
            'xquery': 'xquery'
            'xq': 'xquery'
        
            'yaml': 'yaml'
            'yml': 'yaml'


        @names =
            'Cakefile': 'coffee'
            'Gemfile': 'ruby'
            'GNUmakefile': 'makefile'
            'makefile': 'makefile'
            'Makefile': 'makefile'
            'OCamlMakefile': 'makefile'
    

        @binaries =
            'gif': true
            'png': true
            'jpg': true
            'jpeg': true
            'ico': true
            'bmp': true
            'psd': true
            'tiff': true
            
            'iso': true
            'zip': true
            'rar': true
            'tar': true
            'jar': true
            '7z': true
            'war': true
            'gzip': true
            'bz2': true
            'cab': true
            'uue': true
            'gz': true
            'bzip2': true
            'dmg': true
            'deb': true
            'rpm': true
            'tgz': true
            'z': true
            
            'mp3': true
            'mp4': true
            'avi': true
            'mov': true
            'rm': true
            'rmvb': true
            'asf': true
            'mtv': true
            'amv': true
            'swf': true
            'divx': true
            'wmv': true
            'smv': true
            '3gp': true
            'mkv': true
            'flv': true
            'f4v': true
            'webm': true
            'wav': true
            
            'pyc': true
            'swp': true
            
            'dll': true
            'so': true
            
            'woff': true
            'eot': true
            'ttf': true
            'otf': true
            
            'rsrc': true
            
            'exe': true
            'msi': true
            
            'doc': true
            'docx': true
            'ppt': true
            'xls': true
            'wk4': true
            'shw': true
            'wb2': true
            'wpd': true
            'wpg': true
            'pdf': true
            
            'vdi': true

    guess_mode_by_extension: (file_extension) ->
        mode = @extensions[file_extension]
        if not mode
            mode = 'text'
        return "ace/mode/#{mode}"

    guess_mode_by_name: (name) ->
        mode = @names[name]
        if not mode
            mode = 'text'
        return "ace/mode/#{mode}"

    is_binary: (file_extension) ->
        return true if @binaries[file_extension]
        return false
