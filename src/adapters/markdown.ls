require! {
  marked
}

exports.run = (note)-> marked note.body
