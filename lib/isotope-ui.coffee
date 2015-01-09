module.exports =

  config:
    fontFamily:
      description: 'Use one of the fonts available in this package.
        View the README for descriptions of each.'
      type: 'string'
      default: 'Open Sans'
      enum: [
        'Cantarell',
        'Clear Sans',
        'Fira Sans',
        'Open Sans',
        'Oxygen',
        'Roboto',
        'Source Sans Pro',
        'Ubuntu'
      ]
    fontWeight:
      description: 'Not all fonts come in all weights: Canterell and Oxygen
        only have regular, Ubuntu and Open Sans don\'t have thin.'
      type: 'string'
      default: 'Extra light / Thin'
      enum: [
        'Extra light / Thin',
        'Light',
        'Regular'
      ]
    compactLayout:
      description: 'Make UI chrome take up less space vertically
        (useful on small screens).'
      type: 'boolean'
      default: false
    colorTreeSelection:
      description: 'Make the selected file stand out in tree-view.'
      type: 'boolean'
      default: true
    backgroundGradient:
      description: 'Experimental: apply a subtle gradient to the background.'
      type: 'boolean'
      default: false
    backgroundImage:
      description: 'Experimental: use an image as a background.'
      type: 'boolean'
      default: false
    backgroundImageUrl:
      description: 'Experimental: the url for an image from te internets.'
      type: 'string'
      default: 'atom://isotope-ui/resources/images/hubble.jpg'


  activate: (state) ->

    applyFont = (font) ->
      atom.workspaceView.attr('isotope-ui-font', font)

    applyFontWeight = (weight) ->
      atom.workspaceView.attr('isotope-ui-fontweight', weight)

    applyCompactness = () ->
      if atom.config.get('isotope-ui.compactLayout')
        atom.workspaceView.addClass('isotope-ui-compact')
      else
        atom.workspaceView.removeClass('isotope-ui-compact')

    applyTreeColor = () ->
      if atom.config.get('isotope-ui.colorTreeSelection')
        atom.workspaceView.addClass('isotope-ui-treecolor')
      else
        atom.workspaceView.removeClass('isotope-ui-treecolor')

    applyBackgroundGradient = () ->
      if atom.config.get('isotope-ui.backgroundGradient')
        atom.workspaceView.addClass('isotope-ui-bg-gradient')
        atom.config.set('isotope-ui.backgroundImage', 'false')
      else
        atom.workspaceView.removeClass('isotope-ui-bg-gradient')

    applyBackgroundImage = () ->
      if atom.config.get('isotope-ui.backgroundImage')
        atom.workspaceView.addClass('isotope-ui-bg-image')
        atom.config.set('isotope-ui.backgroundGradient', 'false')
        atom.workspaceView.css(
          'backgroundImage',
          'url(' + atom.config.get('isotope-ui.backgroundImageUrl') + ')'
        )
      else
        atom.workspaceView.removeClass('isotope-ui-bg-image')
        atom.workspaceView.css(
          'backgroundImage',
          ''
        )

    atom.workspaceView.ready ->
      applyFont(atom.config.get('isotope-ui.fontFamily'))
      applyFontWeight(atom.config.get('isotope-ui.fontWeight'))
      applyCompactness()
      applyTreeColor()
      applyBackgroundGradient()
      applyBackgroundImage()

    atom.config.onDidChange 'isotope-ui.fontFamily', ->
      applyFont(atom.config.get('isotope-ui.fontFamily'))

    atom.config.onDidChange 'isotope-ui.fontWeight', ->
      applyFontWeight(atom.config.get('isotope-ui.fontWeight'))

    atom.config.onDidChange 'isotope-ui.compactLayout', ->
      applyCompactness()

    atom.config.onDidChange 'isotope-ui.colorTreeSelection', ->
      applyTreeColor()

    atom.config.onDidChange 'isotope-ui.backgroundGradient', ->
      applyBackgroundGradient()

    atom.config.onDidChange 'isotope-ui.backgroundImage', ->
      applyBackgroundImage()

    atom.config.onDidChange 'isotope-ui.backgroundImageUrl', ->
      applyBackgroundImage()
