// import 'package:http/http.dart' as http;
//
// // const String baseUrl = 'http://0.0.0.0:8080/v1/produtosList3';
// const String baseUrl = 'https://sixbackend-70ed1c73ebec.herokuapp.com';
// // const String baseUrl = 'http://0.0.0.0:8080/v1/';
// // const String baseUrl = 'https://jsonplaceholder.typicode.com/todos/1';
//
// class BaseClient {
//   var client = http.Client();
//
//   //GET
//   Future<dynamic> get(String api) async {
//     var url = Uri.parse(api);
//     print('url.: ' + baseUrl + api);
//
//     // var _headers = {
//     //   'id_cliente' : '12345',
//     //   'Content-Type' : 'application/json'
//     // };
//
//     try {
//       var response = await client.get(url);
//       return response.body;
//     } catch (e) {
//       print("Ocorreu uma exceção: $e");
//     }
//
//     // if(response.statusCode == 200){
//     //   print(json.decode(response.body));
//     //   return response.body;
//     // }
//     // else{
//     //   // throw exception
//     // }
//   }
//
//   Future<dynamic> post(String api) async {}
//
//   Future<dynamic> put(String api) async {}
//
//   Future<dynamic> delete(String api) async {}
// }
