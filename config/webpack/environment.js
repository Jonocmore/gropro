const { environment } = require('@rails/webpacker')
// Add an additional rule that tells Webpack to use babel-loader for .js files
environment.loaders.prepend('babel', {
  test: /\.js$/,
  exclude: /node_modules/,
  use: {
    loader: 'babel-loader',
  },
})

module.exports = {
  entry: {
    main: './path/to/main/file.js',
    vendor: './path/to/vendor/file.js'
  },
  environment
};
