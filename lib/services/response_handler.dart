
class AppResponseModel{

  final bool isSuccess;
  final String message;
  final dynamic data;
  final int? statusCode;

  AppResponseModel({required this.isSuccess,required this.data,required this.message,this.statusCode});
}


AppResponseModel appResponse({required bool isSuccess,required dynamic data,required String message,int? statusCode}){
  return AppResponseModel(isSuccess: isSuccess, data: data, message: message, statusCode: statusCode);
}