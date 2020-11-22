module.exports = {
  test: /datatables\.net.*/,
  use: [
    {
      loader: require.resolve('imports-loader'),
      options: {
        additionalCode: 'var define = false;',
      },
    },
  ],
}
