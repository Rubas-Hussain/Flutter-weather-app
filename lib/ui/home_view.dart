import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/utils/appColors.dart';
import 'package:weather_app/ui/home_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherHomeView extends StatelessWidget {
  const WeatherHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    WeatherHomeViewController controller = Get.put(WeatherHomeViewController());
    controller.fetchWeather();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child:
                  GestureDetector(
                    onTap: (){
                      controller.toggleSwitch();
                    },
                    child: Obx(()=>(controller.switchValue.value==false) ?
                    Icon(Icons.toggle_off_outlined,size: 40.r,color: const Color(0xff3A393A) ,)
                        :
                    Icon(Icons.toggle_on,size: 42.r,color: const Color(0xffffffff)),
                  )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 60.0.h,top: 30.h),
                child: Column(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      color: Color(0xff9F9E9F),
                    ),
                    Obx(() {
                      if (controller.weatherModel.value != null) {
                        return Text(
                          controller.weatherModel.value!.cityName,
                          style: (controller.switchValue.value==false) ?
                          GoogleFonts.poppins().copyWith(
                              color: const Color(0xff3A393A),
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500)
                              :
                          GoogleFonts.poppins().copyWith(
                              color: AppColors.whiteColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500)

                          ,
                        );
                      } else {
                        return Center(
                          child: Container(
                              margin:const EdgeInsets.only(top:  250),
                              child:  const CircularProgressIndicator(
                                color:AppColors.blackColor,)),
                        );
                      }
                    }),
                  ],
                ),
              ),
        
              // Lottie.asset('assets/cloud.json'),
              Obx(()=>(controller.weatherModel.value!=null) ?
              Lottie.asset(controller.getWeatherConditions())
              :
              Container()),
        
              SizedBox(height: 80.h,),
        
              Obx(() {
                if (controller.weatherModel.value != null) {
                  return Text(
                      '${controller.weatherModel.value!.temperature.toString()} \u2103',
                      style: (controller.switchValue.value==false) ?
                          GoogleFonts.poppins(
                              color: const Color(0xff3A393A),
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500
                          )
                          :
                      GoogleFonts.poppins(
                          color: AppColors.whiteColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500
                      ));
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
                if(controller.weatherModel.value!=null){
                  return Text(controller.weatherModel.value!.mainCondition,
                      style: (controller.switchValue.value==false) ?
                          GoogleFonts.poppins().copyWith(
                              color: const Color(0xff3A393A),
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500
                          )
                          :
                      GoogleFonts.poppins().copyWith(
                          color: AppColors.whiteColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500
                      )
                      );
                }else{
                  return const Text('');
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
