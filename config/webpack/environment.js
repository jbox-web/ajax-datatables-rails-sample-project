const { environment } = require('@rails/webpacker')

// Load Webpack config
const datatables         = require('./loaders/datatables')
const jquery             = require('./loaders/jquery')
const webpack            = require('webpack')

// Load resolve-url-loader
environment.loaders.get('sass').use.splice(-1, 0, {
  loader: 'resolve-url-loader'
})

// Replace existing coffee loader with CS2 version
const babel_loader = environment.loaders.get('babel')
environment.loaders.insert('coffee', {
  test: /\.coffee(\.erb)?$/,
  use:  babel_loader.use.concat(['coffee-loader'])
})

// Add Webpack loaders
environment.loaders.append('datatables', datatables)
environment.loaders.append('jquery', jquery)

// Add Webpack plugins
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $:         'jquery',
    jQuery:    'jquery',
    jquery:    'jquery',
    Popper:    ['popper.js', 'default'],
    Alert:     'exports-loader?Alert!bootstrap/js/dist/alert',
    Button:    'exports-loader?Button!bootstrap/js/dist/button',
    Carousel:  'exports-loader?Carousel!bootstrap/js/dist/carousel',
    Collapse:  'exports-loader?Collapse!bootstrap/js/dist/collapse',
    Dropdown:  'exports-loader?Dropdown!bootstrap/js/dist/dropdown',
    Modal:     'exports-loader?Modal!bootstrap/js/dist/modal',
    Popover:   'exports-loader?Popover!bootstrap/js/dist/popover',
    Scrollspy: 'exports-loader?Scrollspy!bootstrap/js/dist/scrollspy',
    Tab:       'exports-loader?Tab!bootstrap/js/dist/tab',
    Tooltip:   'exports-loader?Tooltip!bootstrap/js/dist/tooltip',
    Util:      'exports-loader?Util!bootstrap/js/dist/util',
  })
)

module.exports = environment
