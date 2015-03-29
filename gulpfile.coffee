gulp          = require 'gulp'
webpack       = require 'webpack'
webpackConfig = require './webpack.config.coffee'
spawn         = require('child_process').spawn
gulpWebpack   = require 'gulp-webpack'
named         = require 'vinyl-named'
karma         = require 'gulp-karma'
webserver     = require 'gulp-webserver'

gulp.task 'webpack:src', ->
  gulp.src ['src/coffee/*.coffee']
    .pipe named()
    .pipe gulpWebpack webpackConfig
    .pipe gulp.dest 'build'

gulp.task 'webpack:test', ->
  gulp.src ['test/*.coffee']
    .pipe named()
    .pipe gulpWebpack webpackConfig
    .pipe gulp.dest 'test/build'

gulp.task 'karma', ->
  gulp.src 'test/build/*.js'
    .pipe karma
      configFile: 'karma.conf.js',
      action: 'watch'

gulp.task 'server', ->
  gulp.src 'stub'
    .pipe webserver
      port: 9875
      livereload: true
      directoryListing:
        enable: true
        path: 'stub'
      host: '0.0.0.0'

gulp.task 'watch', ->
  spawn 'gulp', ['webpack:src'], stdio: 'inherit'
  spawn 'gulp', ['webpack:test'], stdio: 'inherit'
  spawn 'gulp', ['karma'], stdio: 'inherit'

gulp.task 'default', ['watch']
