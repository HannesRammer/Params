library params.client;
import "dart:mirrors";
import "dart:html";

Map params = {};

void initParams(){
  if(window.location.search != "") {
    List list = window.location.search.replaceFirst("?", "").split("&");
    list.forEach((pair){ 
      List pairList = pair.split("=");
      params[pairList[0]] = pairList[1]; 
    });  
  }
  addlocationToParams(window.location);
  print("Client params: ${params.toString()}");
}

void addlocationToParams(var object) { 
  InstanceMirror im = reflect(object);
  ClassMirror cm = im.type;
  var decls = cm.declarations.values.where((dm) => dm is MethodMirror && dm.isSetter == false && dm.isRegularMethod == false);
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