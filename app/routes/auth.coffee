passport = require 'passport'

index = (req, res) ->
  forwardTarget = '/auth/twitter'
  if (req.query.logout)
    req.logout()
    forwardTarget = req.cookies.last || '/'
  res.redirect forwardTarget

failed = (req, res) -> res.render 'failed-login', { flash: req.flash }

module.exports = (router) ->
  router.get '/', index
  router.get '/failed', failed
  router.get '/twitter', passport.authenticate('twitter')
  router.get '/twitter/callback', passport.authenticate('twitter',
      successRedirect: '/blog'
      failureRedirect: '/auth/failed'
      failureFlash: true)
  return router