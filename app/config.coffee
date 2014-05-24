module.exports =
  mongodb: MONGODB_URL
  
  twitter:
    consumerKey: TWITTER_CONSUMER_KEY
    consumerSecret: TWITTER_CONSUMER_SECRET,
    callbackURL: '/auth/twitter/callback'
    
  session:
    secret: SESSION_SECRET