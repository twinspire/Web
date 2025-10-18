package twinspire.web.security;

typedef AuthenticatedUser = {
    var userInfo:UserInfo; // Information about the user
    var token:Token; // Authentication token for the user
    var roles:Array<String>; // Roles assigned to the user
    var permissions:Array<String>; // Permissions granted to the user
}