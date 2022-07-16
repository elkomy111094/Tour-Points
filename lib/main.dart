import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:tourpoint/view_models/places_view_model_cubit.dart';
import 'package:tourpoint/views/screens/splash_screen.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<PlacesViewModelCubit>(create: (ctx) => PlacesViewModelCubit()),
  ], child: TourPoint()));
}

class TourPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}
