import 'package:food_app/utilities/constant_data.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  // when talking to teh server token is used to communicate with server...
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    // how long the data should take to check
    timeout = Duration(seconds: 30);
    token = ConstantData.TOKEN;
    _mainHeaders = {
      //The header is needed in other to get  response and post request from the server and it should be in json format
      'Content-type': 'application/json; charset=UTF-8',
      // This is use for authentication.. the type of the token is bearer...
      'Authorization': 'Bearer $token',
    };
  }

  // the get request method that is will help us to get the data from the server and the link to get the data is being specified...
  Future<Response> getData(String uri) async {
    // a data need to be return after sending the request to the server... either successful or not ...
    try {
      // This get the response gotten from the server and save it in the response variable of Response type
      Response response = await get(uri);
      return response;
    } catch (e) {
      // Return the error incase the data is failed to get...
      return Response(
        // this return the error type
        statusCode: 1,
        statusText: e.toString(),
      );
    }
  }
}
