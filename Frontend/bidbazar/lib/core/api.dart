//configuration of Api like header and where to send req
//we don't have decode json data because dio explicitly do that for you.
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

//  const  String BASE_URL = "http://192.168.0.164:4000/api";

const Map<String, dynamic> DEFAULT_HEARDERS = {
  'content-Type': 'application/json'
}; //headers are metadata of api req/res.

const Map<String, dynamic> form_urlenconded = {
  'content-Type': 'application/x-www-form-urlencoded'
};
const Map<String, dynamic> form = {'content-Type': 'multipart/form-data'};

class Api {
  final Dio dio = Dio();
  static const  String BASE_URL = "http://192.168.43.172:4000/api";
  
  Api() {
    dio.options.baseUrl = BASE_URL;
    dio.options.headers = DEFAULT_HEARDERS;
    dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    )); //runs middle of req/res. we add dio log,
  } //constructor  when we create object first thing is constructor were created
  Dio get sendRequest => dio; //dio send response as js object
}

class ApiResponse {
  //dio return json object as response we handle response in this class
  bool success;
  dynamic data;
  String? message;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
  });

  factory ApiResponse.fromResponse(Response response) {
    //directly access using .
    //factory method returns object without new keyword
    //from means get
    final data = response.data as Map<String, dynamic>;
    return ApiResponse(
      //we return object instance of ApiResponse to factory method
      success: data["success"] ?? false,
      data: data["data"],
      message: data["message"] ?? "No message found",
    );
  }
}
