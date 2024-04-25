import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mausam/mausam_model.dart';

class WeatherService{
  //WeatherService(this.data);
  getWeather(String? city) async{
    var url="https://api.openweathermap.org/data/2.5/weather?q=$city&appid=f1202fb2957d78b850112e0b8b105902";
    final res=await http.get(Uri.parse(url));
    var resBody=res.body;

    try{
    if(res.statusCode==200){
       return MausamModel.fromJson(json.decode(resBody));
    }
    }
    catch(e){
      throw Exception();
  }}

} 