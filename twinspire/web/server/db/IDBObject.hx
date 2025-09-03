package twinspire.web.server.db;

#if macro
import haxe.macro.Expr;
#end

interface IDBObject {
    function insert():Void;
    function update(filters:#if macro Expr #else Dynamic #end):Int;
    function delete():Void;
}