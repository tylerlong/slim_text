$ ->
    layout = $('body').layout
        livePaneResizing: true
        spacing_open: 15
        initClosed: true
        onresize: ->
            editor.resize()
        north:
            spacing_closed: 15
            size: 32
            resizable: false
            togglerLength_closed: 128
            togglerLength_open: 128
            togglerContent_open: "Hide"
            togglerTip_open: "Hide"
            togglerContent_closed: "Show"
            togglerTip_closed: "Show"
            onopen_start: ->
                layout.open 'west'
            onclose_start: ->
                layout.close 'west'
        west:
            size: 192
            spacing_closed: 0
            togglerLength_open: 0
