import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/home_services.dart';

class WeatherHomeViewController extends GetxController{

  RxBool switchValue=false.obs;

  void toggleSwitch() {
    switchValue.toggle();
    if (switchValue.value) {
      Get.changeTheme(ThemeData.dark());
    } else {
      Get.changeTheme(ThemeData.light());
    }
  }

  // inserting api key here from website
  final weatherServices=WeatherServices(apiKey: 'f7f3f7373767f9255f81b7846914bceb');
  var weatherModel=Rxn<WeatherModel>();

  fetchWeather()async{
    // getting current city to be displayed in ui
    String cityName=await weatherServices.getCurrentCity();

    try{
      final fetchedWeather=await weatherServices.getWeather(cityName);
      weatherModel.value=fetchedWeather;
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
    if(weatherModel.value!.mainCondition.toLowerCase()=='clouds'){
      return lottieAnimations[0];
    }else if(weatherModel.value!.mainCondition.toLowerCase()=='sunny'){
      return lottieAnimations[1];
    }else if(weatherModel.value!.mainCondition.toLowerCase()=='thunderstorm'){
      return lottieAnimations[2];
    }else if(weatherModel.value!.mainCondition.toLowerCase()=='fog'){
      return lottieAnimations[0];
    }else if(weatherModel.value!.mainCondition.toLowerCase()=='smoke'){
      return lottieAnimations[0];
    }else{
      return lottieAnimations[1];
    }

  }

}