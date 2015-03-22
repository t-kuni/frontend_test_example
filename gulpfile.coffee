gulp = require 'gulp'
wp = require 'webpack'
gwp = require 'gulp-webpack'
named = require 'vinyl-named'

gulp.task 'webpack', ->
  gulp.src([
    'src/index.coffee',
    'src/second.coffee'
  ]).pipe(named())
    .pipe(gwp(
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
        new wp.ResolverPlugin(
          new wp.ResolverPlugin.DirectoryDescriptionFilePlugin("bower.json", ["main"])
        )
      ]
    ))
    .pipe(gulp.dest('build'))

gulp.task 'default', ['webpack']
