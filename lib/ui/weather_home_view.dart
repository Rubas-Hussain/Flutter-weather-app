import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/ui/weather_home_view_controller.dart';

class WeatherHomeView extends StatelessWidget {
  const WeatherHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    WeatherHomeViewController weatherHomeViewController = Get.put(WeatherHomeViewController());
    weatherHomeViewController.fetchWeather();

    return Scaffold(
      backgroundColor:(weatherHomeViewController.switchValue.value==false) ?
      const Color(0xffE0DFE1)
          :
      const Color(0xff252425),
      appBar: AppBar(
        backgroundColor: (weatherHomeViewController.switchValue.value==false) ?
        const Color(0xffE0DFE1)
            :
        const Color(0xff252425),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child:
            Obx(()=>InkWell(
              onTap: (){
                weatherHomeViewController.toggleSwitch();
                // weatherHomeViewController.changeTheme();
                // if(weatherHomeViewController.switchValue.value==false){
                //   Get.changeTheme(ThemeData.light());
                // }else{
                //   Get.changeTheme(ThemeData.dark());
                // }
              },
              child: (weatherHomeViewController.switchValue.value==false) ?
              Icon(Icons.toggle_off,size: 40.r,color: const Color(0xff3A393A) ,)
                  :
              Icon(Icons.toggle_on,size: 40.r,color: const Color(0xffffffff)),
            )),
          )
        ],
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 60.0.h,top: 30.h),
              child: Column(
                children: [
                  const Icon(
                    Icons.location_on_rounded,
                    color: Color(0xff9F9E9F),
                  ),
                  Obx(() {
                    if (weatherHomeViewController.weather.value != null) {
                      return Text(
                        weatherHomeViewController.weather.value!.cityName,
                        style: TextStyle(
                            color: const Color(0xff3A393A),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500),
                      );
                    } else {
                      return Text('Loading...',
                          style: TextStyle(
                              color: const Color(0xff3A393A),
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500));
                    }
                  }),
                ],
              ),
            ),

            // Lottie.asset('assets/cloud.json'),
            Obx(()=>(weatherHomeViewController.weather.value!=null) ?
            Lottie.asset(weatherHomeViewController.getWeatherConditions())
            :
            Container()),

            SizedBox(height: 80.h,),

            Obx(() {
              if (weatherHomeViewController.weather.value != null) {
                return Text(
                    '${weatherHomeViewController.weather.value!.temperature.toString()} \u2103',
                    style: TextStyle(
                        color: const Color(0xff3A393A),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500));
              } else {
                return Text('',
                    style: TextStyle(
                        color: const Color(0xff3A393A),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500));
              }
            }),
            SizedBox(height: 10.h,),
            Obx((){
              if(weatherHomeViewController.weather.value!=null){
                return Text(weatherHomeViewController.weather.value!.mainCondition,
                    style: TextStyle(
                        color: const Color(0xff3A393A),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500));
              }else{
                return const Text('');
              }
            })
          ],
        ),
      ),
    );
  }
}
