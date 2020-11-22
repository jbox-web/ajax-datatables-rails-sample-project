module.exports = {
  test: require.resolve('jquery'),
  loader: require.resolve('expose-loader'),
  options: {
    exposes: ['$', 'jQuery', 'jquery'],
  },
}
