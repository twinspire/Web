package twinspire.web.services;

typedef RestRoute = {
    var method:String; // HTTP method (GET, POST, etc.)
    var path:String; // Path for the route
    var ?params:Array<String>; // Optional parameters for the route
}