##Params

Params is a package that provides window.location.search on client and request.requestedUrl.query on server as a Map

1. install via pub

*************************
##On the client
*************************

1. Import the package inside your client like this 

        import 'package:params/client.dart';
    
2. At the beginning of your main function call add 

        await initParams();

3. If the window location is http://127.0.0.1:3030/Rainbow/web/rainbow.html?id=1&language=dart the Standart client params map looks like this 

        {
          id: 1, 
          language: dart, 
          _ancestorOrigins: [], 
          _hash: , 
          _host: 127.0.0.1:3030, 
          _hostname: 127.0.0.1, 
          _href: http://127.0.0.1:3030/Rainbow/web/rainbow.html?id=1&language=dart,
          _origin: http://127.0.0.1:3030, 
          _pathname: /Rainbow/web/rainbow.html, 
          _port: 3030, 
          _protocol: http:, 
          _search: ?id=1&language=dart
        }
       
 Now you can access the search values using **params['key']** like below
 
       Future main() async{
         await initParams();
         if(params['id'] != null){
           String id = params['id'];
           String language = params['language'];
           var url = http://127.0.0.1:8090/loadItem?id=$id&language=$language;
           var request = HttpRequest.getString(url).then(displayUserAccount);
         }else{
           content.text="no UserAccount id available";
         }
       };


*************************
##On the server 
*************************

1. Import the package inside your server like this 

        import 'package:params/server.dart';
    
2. At the beginning of your server.listen function add 

        await initParams();

3. If a HTTP request is made to http://127.0.0.1:8090/loadItem?id=1&language=dart

 the standart server params map looks like this:

        {
          id: 1,
          language: dart,
          _query: id=1&language=dart, 
          _authority: 127.0.0.1:8090, 
          _host: 127.0.0.1, 
          _port: 8090, 
          _path: /loadItem, 
          _pathSegments: [loadItem], 
          _queryParameters: {
            id: 1,
            language: dart
          }, 
          _isAbsolute: true, 
          _hasAuthority: true, 
          _origin: http://127.0.0.1:8090, 
          __isPathAbsolute: true, 
          _hashCode: 277712556
        }

 Now you can access the query values using **params['key']** like below
   
       server.listen((HttpRequest request) async {
         await initParams(request);
         //if request.requestedUrl.query is "id=1&language=dart"
         String id = params['id'];
         String language = params['language'];
         switch (request.method) {
           case "GET": 
             handleGet(request);
             break;
           case "POST": 
             handlePost(request);
             break;
           case "OPTIONS": 
             handleOptions(request);
             break;
           default: defaultHandler(request);
         }
       } 
 

###changelog 

v 0.0.4 - adopted to await async 