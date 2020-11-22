process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

// Load Webpack config
// const eslint = require('eslint-webpack-plugin')

// Add Webpack plugins
// environment.plugins.append('eslint', new eslint({'files': 'app/frontend', 'extensions': ['coffee']}))

// Export configured environment
module.exports = environment.toWebpackConfig()
