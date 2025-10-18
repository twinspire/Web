package twinspire.web.security;

typedef Token = {
    var token:String; // The actual token string
    var expires:Float; // Expiration date of the token
}