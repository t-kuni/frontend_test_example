gulp = require 'gulp'
webpack = require 'webpack'
gulpWebpack = require 'gulp-webpack'
named = require 'vinyl-named'
karma = require 'gulp-karma'

webpackConfig =
  watch: true
  module:
    preLoaders: [
      test: /\.coffee$/
      exclude: /node_modules/
      loader: "coffeelint-loader"
    ]
    loaders:
      [{ test: /\.coffee$/, loader: "coffee-loader" }]
  resolve:
    modulesDirectories: [
      'src',
      'bower_components'
    ]
  output:
    filename: "[name].js"
  coffeelint:
    camel_case_classes: 'error'            # クラス名にキャメルケースを禁止
    empty_constructor_needs_parens: 'warn' # 括弧なしのインスタンス化を警告
    line_endings: 'warn'                   # 改行コードを統一
    # reporter: require('coffeelint-stylish').reporter # レポーターの指定
  plugins: [
    new webpack.ResolverPlugin(
      new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin("bower.json", ["main"])
    )
  ]

gulp.task 'webpack:src', ->
  gulp.src(['src/*.coffee'])
    .pipe(named())
    .pipe(gulpWebpack(webpackConfig))
    .pipe(gulp.dest('build'))

gulp.task 'webpack:test', ->
  gulp.src(['test/*.coffee'])
    .pipe(named())
    .pipe(gulpWebpack(webpackConfig))
    .pipe(gulp.dest('test'))

gulp.task 'karma', ->
  gulp.src('test/*.js')
    .pipe(karma(
      configFile: 'karma.conf.js',
      action: 'watch'
    ))

gulp.task 'default', ['webpack:src', 'webpack:test']
