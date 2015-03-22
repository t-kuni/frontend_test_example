g = require 'gulp'
wp = require 'webpack'
gwp = require 'gulp-webpack'
named = require 'vinyl-named'

g.task 'webpack', ->
  g.src([
    'src/index.coffee',
    'src/second.coffee'
  ]).pipe(named())
    .pipe(gwp(
      watch: true
      module:
        loaders:
          [{ test: /\.coffee$/, loader: "coffee-loader" }]
      resolve:
        modulesDirectories: [
          'src',
          'bower_components'
        ]
      output:
        filename: "[name].js"
      plugins: [
        new wp.ResolverPlugin(
          new wp.ResolverPlugin.DirectoryDescriptionFilePlugin("bower.json", ["main"])
        )
      ]
    ))
    .pipe(g.dest('build'))

g.task 'default', ['webpack']
