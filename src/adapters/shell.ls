require! {
  child_process: {execSync}
}

exports.run = (note)->
  execSync note.body
