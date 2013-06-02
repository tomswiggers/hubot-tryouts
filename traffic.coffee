QS = require 'querystring'
# Configures the plugin
module.exports = (robot) ->
    # waits for the string "hubot deep" to occur
    robot.respond /traffic/i, (msg) ->
      msg.send 'usage'
    robot.respond /traffic (.+)/i, (msg) ->
        # Configures the url of a remote server
        url = 'http://www.filebeeld.be/mobiel/reistijden/R1R2'
        data = QS.stringify({'from': msg.match[1], 'to': msg.match[2]})
        msg.http(url)
          .post(data) (err, res, body) ->
                msg.send body
