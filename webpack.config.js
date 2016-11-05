var webpack = require("webpack");
var merge = require("webpack-merge");
var CopyWebpackPlugin = require("copy-webpack-plugin");

var common = {
  module: {
    loaders: [
      {
        test: /\..js$/,
        exclude: [/node_modules/, /vendor/],
        loader: "babel",
        query: {
          presets: ["es2015"]
        }
      }
    ]
  },

  resolve: {
    moduleDirectories: ["node_modules", __dirname + "/web/static/js"]
  }
};

module.exports = [
  merge(common, {
    entry: "./web/static/js/app.js",
    output: {
      path: "./priv/static/js",
      filename: "app.js"
    },
    plugins: [
      new CopyWebpackPlugin([{ from: "./web/static/assets" }])
    ]
  }),
  merge(common, {
    entry: [
      "./web/static/vendor/semantic/semantic.js",
      "./web/static/js/admin.js"
    ],
    output: {
      path: "./priv/static/js",
      filename: "admin.js"
    },
    plugins: [
      new webpack.ProvidePlugin({$: "jquery", jQuery: "jquery"})
    ]
  })
];
