import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tourpoint/helpers/components.dart';

import '../../view_models/places_view_model_cubit.dart';
import 'map_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getAllPlaces(context);
    Future.delayed(Duration(seconds: 7), () {
      pushToStack(context, MapScreen());
    });
  }

  Future<void> getAllPlaces(BuildContext context) async {
    PlacesViewModelCubit inst = PlacesViewModelCubit.get(context);
    await inst.getPlacesResponse();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 15.h,
              ),
              Container(
                width: 100.w,
                height: 40.h,
                child: Image.asset("assets/images/splash.gif"),
              ),
              TextLiquidFill(
                waveDuration: Duration(seconds: 1),
                text: 'Tour Point',
                waveColor: Colors.black,
                boxBackgroundColor: Colors.white,
                textStyle: TextStyle(
                  fontSize: 40.sp,
                  fontFamily: "Lob",
                  wordSpacing: 1.5,
                ),
                boxHeight: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
