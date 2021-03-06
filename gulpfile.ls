require! {
  gulp
  \gulp-webpack : webpack
  \child_process : {spawn, execSync}
}

child = null

gulp.task \webpack, ->
  gulp.src \src/index.ls
    .pipe webpack do
      resolve:
        extensions: [
          ''
          \.ls
          \.js
        ]
      module:
        loaders: [
          test: /\.ls$/
          loader: \livescript-loader
        ]
      output:
        filename: \index.js
    .pipe gulp.dest \build

gulp.task \start, ->
  start = ->
    child = spawn \./node_modules/.bin/lsc, [\index.ls],
      stdio: \inherit
    child.on \error, ->
      child.kill!
      child = null

  if child isnt null
    child.on \exit, -> start!
    child.kill!
  else start!

gulp.task \assets, ->
  gulp.src \node_modules/github-markdown-css/github-markdown.css
    .pipe gulp.dest \build

gulp.task \default, [\webpack, \assets]
gulp.task \watch, [\webpack, \assets, \start], ->
  gulp.watch \src/**/*.coffee, [\webpack]
  gulp.watch [\index.coffee, \src/components/*.coffee], [\start]
