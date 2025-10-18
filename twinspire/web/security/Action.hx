package twinspire.web.security;

typedef Action = {
    var name:String; // Name of the action
    var description:String; // Description of the action
    var ?roles:Array<String>; // Optional roles that can perform this action
    var ?permissions:Array<String>; // Optional permissions required to perform this action
    var ?httpMethod:String; // Optional HTTP method (GET, POST, etc.) for web actions
    var ?path:String; // Optional path for web actions
}