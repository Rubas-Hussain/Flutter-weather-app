import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/weather_services.dart';

class WeatherHomeViewController extends GetxController{

  RxBool switchValue=false.obs;

  void toggleSwitch(){
    switchValue.toggle();
  }

  // Changing theme
  Rx themeMode= ThemeMode.light.obs;
  void changeTheme(newTheme){
    themeMode.value=newTheme;
  }


  // inserting api key here from website
  final weatherServices=WeatherServices(apiKey: 'f7f3f7373767f9255f81b7846914bceb');
  var weather=Rxn<Weather>();

  fetchWeather()async{
    // getting current city to be displayed in ui
    String cityName=await weatherServices.getCurrentCity();

    try{
      final fetchedweather=await weatherServices.getWeather(cityName);
      weather.value=fetchedweather;
    }catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }


  List<String> lottieAnimations=[
    'assets/cloud.json',
    'assets/sunny.json',
    'assets/thunderstorm.json',
  ];

  getWeatherConditions(){
    if(weather.value!.mainCondition.toLowerCase()=='clouds'){
      return lottieAnimations[0];
    }else if(weather.value!.mainCondition.toLowerCase()=='sunny'){
      return lottieAnimations[1];
    }else if(weather.value!.mainCondition.toLowerCase()=='thunderstorm'){
      return lottieAnimations[2];
    }else if(weather.value!.mainCondition.toLowerCase()=='fog'){
      return lottieAnimations[0];
    }else{
      return lottieAnimations[1];
    }

  }

}