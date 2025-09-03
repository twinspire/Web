package twinspire.web.server.db;

typedef IDBResult = {
    var ?count:Int;
    var ?fields:Map<String, Dynamic>;
}