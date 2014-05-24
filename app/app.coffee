_passport = () ->
  config = require './config'
  passport = require 'passport'
  TwitterStrategy = require('passport-twitter').Strategy
  
  passport.serializeUser (user, done) -> done(null, user)
  passport.deserializeUser (user, done) -> done(null, user)
  
  passport.use new TwitterStrategy(
    config.twitter,
    (token, tokenSecret, profile, done) -> done(null, profile))
  
  return passport

express = () ->
  config = require './config'
  
  express = require 'express'
  bodyParser = require 'body-parser'
  cookieParser = require 'cookie-parser'
  logger = require 'morgan'
  session = require 'express-session'
  
  passport = _passport()
  app = express()
  
  app.set 'view engine', 'jade'
  app.set 'views', "#{__dirname}/views"
  
  app.use logger('dev')
  app.use bodyParser()
  app.use cookieParser()
  app.use session(config.session)
  app.use passport.initialize()
  app.use passport.session()
  app.use express.static("#{__dirname}/public")
  
  app.use '/', (req, res, next) ->
    res.locals.user = req.session.passport.user
    next()
    
  for route, router of require './routes'
    path = if route == 'index' then '/' else "/#{route}"
    app.use path, router(express.Router())
  
  app.listen process.env.PORT || 8080

mongo = () ->
  config = require './config'
  mongoose = require 'mongoose'
  db = mongoose.connection
  
  connect = () -> mongoose.connect config.mongodb
  
  db.on 'error', console.error.bind('connection error:')
  db.on 'error', () -> setTimeout(connect, 10000)
  
  connect()

express()
mongo()