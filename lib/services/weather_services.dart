import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';

class WeatherServices{
  static const baseUrl='http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherServices({required this.apiKey});

  Future<Weather>getWeather(String cityName)async{
    final url = Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric');
    final response=await http.get(url);
    var data=jsonDecode(response.body.toString());

    if(response.statusCode==200){
      return Weather.fromJson(data);
    }else{
      throw Exception('Error');
    }
  }

  Future<String>getCurrentCity()async{
    // checking for permission
    LocationPermission permission=await Geolocator.checkPermission();
    if (permission==LocationPermission.denied){
      permission=await Geolocator.requestPermission();
    }

    // fetching the current location
    Position position= await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );

    //converting the location into list of placement objects
    List<Placemark> placemarks=await placemarkFromCoordinates(position.latitude,position.longitude);

    // Now extract the city name from first placemark
    String? city=placemarks[0].locality;

    return city ?? '';
  }



}