index = (req, res) -> res.render 'index'
about = (req, res) -> res.render 'about'

module.exports = require('requireindex') __dirname
module.exports.index = (router) ->
  router.get '/', index
  router.get '/about', about
  return router