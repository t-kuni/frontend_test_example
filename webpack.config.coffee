webpack = require 'webpack'

module.exports =
  watch: true
  module:
    preLoaders: [
      test: /\.coffee$/
      exclude: /node_modules/
      loader: 'coffeelint-loader'
    ]
    loaders: [
      { test: /\.coffee$/, loader: 'coffee' },
      { test: /\.sass$/, loader: 'style!css!autoprefixer?browsers=last 2 version!sass?indentedSyntax' },
      { test: /\.html$/, loader: 'html' }
      { test: /\.png$|\.jpg$|/i, loader: 'url?limit=1' }
    ]
  resolve:
    modulesDirectories: [
      'src/coffee',
      'src/coffee/lib',
      'src/sass',
      'src/html',
      'bower_components'
    ]
  output:
    filename: '[name].js'
    sourceMapFilename: '[file].map'
    publicPath: ''
  coffeelint:
    camel_case_classes: 'error'            # クラス名にキャメルケースを禁止
    empty_constructor_needs_parens: 'warn' # 括弧なしのインスタンス化を警告
    line_endings: 'warn'                   # 改行コードを統一
    # reporter: require('coffeelint-stylish').reporter # レポーターの指定
  devtool: '#source-map'
  plugins: [
    new webpack.ResolverPlugin(
      new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin('bower.json', ['main'])
    )
  ]
