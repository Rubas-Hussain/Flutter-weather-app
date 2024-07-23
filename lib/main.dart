import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weather_app/utils/appColors.dart';
import 'package:weather_app/ui/home_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/ui/home_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherHomeViewController controller = Get.put(WeatherHomeViewController());

    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          // Listen to the switchValue to determine the themeMode
          return Obx(() {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData.light().copyWith(
                scaffoldBackgroundColor: AppColors.whiteColor,
                canvasColor: Colors.green,
                appBarTheme: const AppBarTheme(
                  backgroundColor: AppColors.whiteColor,
                  elevation: 0.0,
                ),
                useMaterial3: false
              ),
              darkTheme: ThemeData.dark().copyWith(
                  scaffoldBackgroundColor: AppColors.blackColor,
                  canvasColor: Colors.green,
                  appBarTheme: const AppBarTheme(
                      backgroundColor: AppColors.blackColor,
                      elevation: 0.0
                  )
              ),
              themeMode: controller.switchValue.value ? ThemeMode.dark : ThemeMode.light,
              home: const WeatherHomeView(),
            );
          });
        }
    );
  }
}

