package twinspire.web.services;

import twinspire.web.services.RestRoute;

typedef RestServiceInfo = {
    var name:String;
    var baseUrl:String;
    var ?routes:Array<RestRoute>;
}