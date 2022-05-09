const { webpackConfig, merge, config } = require('shakapacker')
const { join }                         = require('path')
const WebpackAssetsManifest            = require('webpack-assets-manifest')

// Load Webpack config
const jquery             = require('./rules/jquery')
const datatables         = require('./rules/datatables')
const webpack            = require('webpack')

const isProduction  = process.env.NODE_ENV === 'production'
const isDevelopment = process.env.NODE_ENV === 'development'

// Disable Webpack splitChunks
webpackConfig['optimization'] = { 'splitChunks': false }

webpackConfig.module.rules.map(module => {

  // load resolve-url-loader before sass
  // this plugin resolve relative path for images
  // in css files
  if (module.test && module.test.toString().includes('scss')) {
    module.use.splice(-1, 0, {
      loader: require.resolve('resolve-url-loader')
    })
  }

  // restore webpacker old behavior for assets
  // path in manifest.json
  if (module.type === 'asset/resource') {
    delete module.type
    delete module.generator
    const hash = isProduction ? '-[hash:8]' : ''
    module.type = 'javascript/auto'
    module.use = [
      {
        loader: 'file-loader',
        options: {
          esModule: false,
          name(resourcePath, resourceQuery) {
            // NEVER add [hash:8] to this file since we're generating it every night
            // to update references count.
            // See: app/concepts/system/operation/refresh_french_site_logo.rb
            if (resourcePath.includes('vendor/images/jalis/concerto-logo.png')) {
              return `media/[path][name].[ext]`
            } else {
              if (resourcePath.includes(config.source_path)) {
                return `media/[path][name]${hash}.[ext]`
              } else {
                return `media/[folder]/[name]${hash}.[ext]`
              }
            }
          },
          context: join(config.source_path)
        }
      }
    ]
  }

  return module
})

// Add Webpack plugins
webpackConfig.plugins.unshift(
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

// Fix for https://github.com/rails/webpacker/issues/2864
webpackConfig.plugins.splice(2, 1)

const assets_manifest = {
  plugins: [
    new WebpackAssetsManifest({
      enabled: true,
      entrypoints: true,
      writeToDisk: true,
      output: 'manifest.json',
      entrypointsUseAssets: true,
      space: 2,
      publicPath: true
    }),
  ],
}

finalConfig = merge(webpackConfig, jquery, datatables, assets_manifest)

entry_map = {}
Object.keys(finalConfig['entry']).forEach(key => {
  value   = finalConfig['entry'][key]
  new_key = key.substring(3)
  entry_map[new_key] = value
})
finalConfig['entry'] = entry_map

// Export final webpack config
module.exports = finalConfig
