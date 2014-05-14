library params.server;
import "dart:mirrors";

Map params = {};

void initParams(request){
  if(request.requestedUri.query != "") {
    List list = request.requestedUri.query.split("&");
    list.forEach((pair){ 
      List pairList = pair.split("=");
      params[pairList[0]] = pairList[1]; 
    });  
  }
  addRequestToMap(request.requestedUri);
  print("Server params: ${params.toString()}");
}
  
void addRequestToMap(var object) { 
  InstanceMirror im = reflect(object);
  ClassMirror cm = im.type;

  var decls = cm.declarations.values.where((value) => value.simpleName == new Symbol("query") || (value is MethodMirror && value.isGetter == true && value.isStatic == false) );
  decls.forEach((dm) {
    var key = MirrorSystem.getName(dm.simpleName);
    var val = im.getField(dm.simpleName).reflectee;
    if(val.runtimeType==DateTime){
      val = val.millisecondsSinceEpoch;
    }
    //print("val.runtimeType: ${val.runtimeType}");
    params["_$key"] = val;
  });
}


