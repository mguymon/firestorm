const webpack = require("webpack")
const path = require("path")
const MiniCssExtractPlugin = require("mini-css-extract-plugin")
const CopyWebpackPlugin = require("copy-webpack-plugin")

const nodeEnv = process.env.NODE_ENV || "development"
const assetDir = path.resolve(__dirname, 'assets')
const staticDir = path.resolve(__dirname, 'priv', 'static')
const buildPath = path.resolve(staticDir, 'js')

const config = {
  entry: [assetDir + "/js/app.js", assetDir + "/css/app.scss"],
  output: { path: buildPath, filename: 'bundle.js' },
  resolve: {
    alias: {
      config: path.resolve(__dirname, `./config/${nodeEnv}.js`),
    },
    modules: ['/firestorm-node_modules']
  },
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        query: { cacheDirectory: true }
      },
      {
        test: /\.s?css$/,
        use: [
          MiniCssExtractPlugin.loader,
          { loader: "css-loader" },
          { loader: "sass-loader" },
          { loader: 'import-glob-loader' }
        ]
      },
      {
        test: /\.(png)$/,
        loader: "file-loader?name=images/[name].[ext]"
      },
      {
        test: /\.(woff|woff2)$/,
        loader: "url-loader?limit=10000&mimetype=application/font-woff"
      },
      {
        test: [/\.ttf$/, /\.eot$/, /\.svg$/],
        loader: "file-loader"
      }
    ]
  },
  resolveLoader: {
    modules: ['/firestorm-node_modules']
  },
  plugins:  [
    new CopyWebpackPlugin([{ from: path.resolve(assetDir, "images"), to: path.resolve(staticDir, "images") }]),
    new MiniCssExtractPlugin({
      filename: "[name].css",
      chunkFilename: "[id].css"
    })
  ]
}
module.exports = config
