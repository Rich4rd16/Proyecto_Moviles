const JwtStrategy = require('passport-jwt').Strategy;
const ExtractJwt = require('passport-jwt').ExtractJwt;
const User = require('../models/user');
const keys = require('./keys');

module.exports = function(passport){

    let opts = {};
    opts.jwtFromRequest = ExtractJwt.fromAuthHeaderWithScheme('jwt');
    opts.secretOrKey = keys.secretOrKey;
    passport.use(new JwtStrategy(opts, (jwt_parload, done) => {
        User.findById(jwt_parload.id, (err, user) =>{
            if (err){
                return done(err, false);
            }
            if(user){
                return done(null, user);
            }
            else{
                return done (null, false);
            }
        })
    }))

}