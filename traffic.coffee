QS = require 'querystring'
# Configures the plugin
module.exports = (robot) ->
    # waits for the string "hubot traffic" to occur
    robot.respond /traffic/i, (msg) ->
      msg.send 'use traffic <departure> <destination>'
      msg.send ''
      msg.send 'example: traffic ann anz'
      msg.send 'ann = antwerp nord'

    robot.respond /traffic (.+)/i, (msg) ->
        url = 'http://www.filebeeld.be/mobiel/reistijden/R1R2'

        data = QS.stringify({'from': msg.match[1], 'to': msg.match[2]})
        msg.http(url)
          .post(data) (err, res, body) ->
                msg.send body
