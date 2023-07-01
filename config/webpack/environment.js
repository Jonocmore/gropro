const { environment } = require('@rails/webpacker');

environment.config.merge({
  entry: {
    application: './app/javascript/application.js',
  },
});

module.exports = environment;
