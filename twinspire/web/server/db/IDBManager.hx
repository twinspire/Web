package twinspire.web.server.db;

#if macro
import haxe.macro.Expr;
#end

typedef SortOptions = {
    /**
    * Limits the number of results.
    **/
    var ?limit:Int;
    /**
    * Order by any number of table columns. Use `-` prefix to denote
    * DESC by that column.
    **/
    var ?orderBy:Array<String>;
    /**
    * Offset by a certain number of results.
    **/
    var ?offset:Int;
}

interface IDBManager {
    function search<T>(filters:#if macro Expr #else Dynamic #end, ?sort:SortOptions):Array<T>;
    function searchBy(table:String, filters:#if macro Expr #else Dynamic #end, ?sort:SortOptions):Array<IDBResult>;
    function join2<T1, T2>(filters:#if macro Expr #else Dynamic #end, ?sort:SortOptions):Array<JoinedResult2<T1, T2>>;
    function joinAny(tables:Array<String>, filters:#if macro Expr #else Dynamic #end, ?sort:SortOptions):JoinedResult2<IDBResult, Array<IDBResult>>;
    function delete<T>(filters:#if macro Expr #else Dynamic #end):Int;
    function deleteBy(table:String, filters:#if macro Expr #else Dynamic #end):Int;
}