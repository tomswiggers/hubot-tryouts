# Description
#   This script will show tasks from vimwiki
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot wikitasks - show usage of vimwiki
#
# Author:
#   tomswiggers

fs = require 'fs'
stream = require 'stream'

liner = new stream.Transform {objectMode: true}
 
liner._transform = (chunk, encoding, done) ->
     data = chunk.toString()
     
     if (this._lastLineData) 
      data = this._lastLineData + data
 
     lines = data.split('\n')
     this._lastLineData = lines.splice(lines.length-1,1)[0]
 
     lines.forEach(this.push.bind(this))
     done

liner._flush = (done) ->

  if this._lastLineData
    this.push(this._lastLineData)
    this._lastLineData = null
    done

module.exports = liner

parseFile = (path) ->
  source = fs.createReadStream(path)
  source.pipe(liner)

  console.log 'step1'


  liner.on 'readable', () =>
    console.log 'step2'
    parseLine line while line = liner.read()

parseLine = (line) ->
      console.log line

module.exports = (robot) ->
    robot.respond /test/i, (msg) ->
        line = parseFile('/home/tomswiggers/projects/wiki-projects/Symfony.wiki')
        msg.send 'Here is a list of tasks'
