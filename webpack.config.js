var webpack = require("webpack");
var merge = require("webpack-merge");
var CopyWebpackPlugin = require("copy-webpack-plugin");
var ExtractTextPlugin = require("extract-text-webpack-plugin");

var common = {
  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: [/node_modules/, /semantic/],
        loader: "babel",
        query: {
          presets: ["es2015"]
        }
      },
      {
        test: [/\.sass$/, /\.css$/],
        loader: ExtractTextPlugin.extract("style", "css!sass")
      },
      {
        test: /\.(png|jpg|gif|svg)$/,
        loader: "file?name=/images/[name].[ext]"
      },
      {
        test: /\.(ttf|eot|svg|woff2?)$/,
        loader: "file?name=/fonts/[name].[ext]"
      }
    ]
  }
};

module.exports = [
  merge(common, {
    entry: [
      "./web/static/app/app.sass",
      "./web/static/app/app.js"
    ],
    output: {
      path: "./priv/static",
      filename: "js/app.js"
    },
    resolve: {
      moduleDirectories: ["node_modules", __dirname + "/web/static/app"]
    },
    plugins: [
      new CopyWebpackPlugin([{ from: "./web/static/assets" }]),
      new ExtractTextPlugin("css/app.css")
    ]
  }),
  merge(common, {
    entry: [
      "./web/static/semantic/semantic.js",
      "./web/static/semantic/semantic.css",
      "./web/static/admin/admin.css",
      "./web/static/admin/admin.js"
    ],
    output: {
      path: "./priv/static",
      filename: "js/admin.js"
    },
    resolve: {
      moduleDirectories: ["node_modules", __dirname + "/web/static/admin"]
    },
    plugins: [
      new webpack.ProvidePlugin({$: "jquery", jQuery: "jquery"}),
      new ExtractTextPlugin("css/admin.css")
    ]
  })
];
