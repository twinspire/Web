package twinspire.web.security;

class Authorisation {

    public var actions:Array<Action>; // List of actions that can be authorised
    
    public function new() {
        // Constructor logic if needed
    }

    /**
     * Checks if the user has the required permission.
     * @param user The authenticated user.
     * @param permission The permission to check.
     * @return True if the user has the permission, false otherwise.
     */
    public function hasPermission(user:AuthenticatedUser, permission:String):Bool {
        return user.permissions.indexOf(permission) >= 0;
    }

    /**
     * Checks if the user has the required role.
     * @param user The authenticated user.
     * @param role The role to check.
     * @return True if the user has the role, false otherwise.
     */
    public function hasRole(user:AuthenticatedUser, role:String):Bool {
        return user.roles.indexOf(role) >= 0;
    }

    /**
     * Checks if the user is authorised to perform an action.
     * @param user The authenticated user.
     * @param requiredRoles The roles required for the action.
     * @param requiredPermissions The permissions required for the action.
     * @return True if the user is authorised, false otherwise.
     */
    public function isAuthorised(user:AuthenticatedUser, requiredRoles:Array<String>, requiredPermissions:Array<String>):Bool {
        for (role in requiredRoles) {
            if (!hasRole(user, role)) {
                return false;
            }
        }
        for (permission in requiredPermissions) {
            if (!hasPermission(user, permission)) {
                return false;
            }
        }
        return true;
    }

    /**
     * Authorises the user for a specific action.
     * @param user The authenticated user.
     * @param action The action to authorise.
     * @return True if the user is authorised for the action, false otherwise.
     */
    public function authorise(user:AuthenticatedUser, action:String):Bool {
        // Define the required roles and permissions for the action
        var requiredRoles:Array<String> = []; // Populate with actual roles needed for the action
        var requiredPermissions:Array<String> = []; // Populate with actual permissions needed for the action
        
        return isAuthorised(user, requiredRoles, requiredPermissions);
    }

    

}