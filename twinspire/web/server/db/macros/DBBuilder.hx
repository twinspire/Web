package twinspire.web.server.db.macros;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr.Field;

class DBBuilder {
    
    public static function build():Array<Field> {
        var fields = Context.getBuildFields();

        return fields;
    }

}
#end