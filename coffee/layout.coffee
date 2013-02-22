$ ->
    layout = $('body').layout
        livePaneResizing: true
        spacing_open: 8
        onresize: ->
            editor.resize()
        north:
            spacing_closed: 8
            size: 32
            resizable: false
            togglerLength_closed: 128
            togglerLength_open: 128
            togglerTip_open: "Hide"
            togglerTip_closed: "Show"
            onopen_start: ->
                layout.open 'west'
            onclose_start: ->
                layout.close 'west'
        west:
            size: 192
            spacing_closed: 0
            togglerLength_open: 0
