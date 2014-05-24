index = (req, res) -> res.render 'blog'

module.exports = (router) ->
  router.get '/', index
  return router