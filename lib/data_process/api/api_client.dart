import 'package:food_app/utilities/constant_data.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService {
  // when talking to teh server token is used to communicate with server...
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;
  late SharedPreferences sharedPreferences;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = appBaseUrl;
    // how long the data should take to check
    timeout = Duration(seconds: 30);
    token = sharedPreferences.getString(ConstantData.TOKEN) ?? '';
    allowAutoSignedCert = true;
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers': 'Origin, Content-Type, X-Auth-Token',
    };

    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Accept'] = 'application/json';
      if (token.isNotEmpty) {
        // Only add auth header if token exists
        request.headers['Authorization'] = 'Bearer $token';
      }
      return request;
    });

    _mainHeaders = {
      //The header is needed in other to get  response and post request from the server and it should be in json format
      'Content-type': 'application/json; charset=UTF-8',
      // This is use for authentication.. the type of the token is bearer...
      'Authorization': 'Bearer $token',
    };
  }

  // the get request method that is will help us to get the data from the server and the link to get the data is being specified...
  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    // a data need to be return after sending the request to the server... either successful or not ...
    try {
      // This get the response gotten from the server and save it in the response variable of Response type
      Response response = await get(uri, headers: headers ?? _mainHeaders);
      // print("⚡ Status Code: ${response.statusCode}");
      // print("⚡ Response Body: ${response.body}");
      return response;
    } catch (e) {
      // Return the error in case the data is failed to get...
      return Response(
        // this return the error type
        statusCode: 1,
        statusText: e.toString(),
      );
    }
  }

  Future<Response> postData(
    String uri,
    dynamic body, {
    bool isAuthRequest = false,
  }) async {
    print('Sending to $uri with body: $body');

    try {
      final headers =
          isAuthRequest
              ? {'Content-type': 'application/json; charset=UTF-8'}
              : _mainHeaders;

      Response response = await post(uri, body, headers: headers);
      print('Response: ${response.statusCode} - ${response.body}');
      return response;
    } catch (e) {
      print('Error: $e');
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  // This help us to update the header automatically after the user register for authentication purpose
  void updateHeader(String token) {
    _mainHeaders = {
      //The header is needed in other to get  response and post request from the server and it should be in json format
      'Content-type': 'application/json; charset=UTF-8',
      // This is use for authentication.. the type of the token is bearer...
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getMapLink(String uri) async {
    Response response = (uri) as Response;
    return response;
  }
}
