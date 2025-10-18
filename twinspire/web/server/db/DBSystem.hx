package twinspire.web.server.db;

import haxe.macro.Expr;

class DBSystem {
    
    /**
    * Callback function that is called by the `@:autoBuild` macro when a `DBObject` is created.
    **/
    public var onDBObject:(Array<Field>) -> Array<Field>;

}