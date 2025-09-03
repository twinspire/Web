package twinspire.web.server.db;

@:autoBuild(twinspire.web.server.db.macros.DBBuilder.build())
abstract class DBObject implements IDBObject {
    
    public function new() {
        
    }

    public abstract function insert():Void;

    public abstract function update(filters:#if macro Expr #else Dynamic #end):Int;

    public abstract function delete():Void;

}