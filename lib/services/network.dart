import 'dart:io';

class Network {
  Future<dynamic> getData(url, {latlng}) async {
    var responseJson;
    try {
      // 71318e996c0dc1afbc62f3e104ecc9e8
      // latlng = latlng ?? '93.2548,23.5987';
      // var headers = {
      //   "latLng": "$latlng",
      //   "Content-Type": "application/json",
      //   'Authorization': 'Bearer ${CtsSharedPreferences.getString('token')}'
      // };
      print("GET:::::::::url:${url}");
      // final response = await get(url, headers: headers);
      // responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      // throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
}
