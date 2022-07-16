import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:tourpoint/helpers/components.dart';
import 'package:tourpoint/models/places_response.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../view_models/places_view_model_cubit.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int tabbed = 0;
  double? long;
  double? lat;
  String url = '';
  double zoomVal = 5;
  var markers = HashSet<Marker>();
  Place place = Place();
  bool markerTapped = false;
  GoogleMapController? myMapController;

  var cameraPosition;

  Future floatingGetCurrentLoc() async {
    Position currentLoc = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    String position =
        currentLoc.latitude.toString() + "," + currentLoc.longitude.toString();

    print(position);

    setState(() {
      long = currentLoc.longitude;
      lat = currentLoc.latitude;
      zoomVal = 20;
      cameraPosition = CameraPosition(
        target: LatLng(lat!, long!),
        zoom: 20,
      );
      myMapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat!, long!), zoom: 17)
          //17 is new zoom level
          ));
      url =
          "https://www.google.com/maps/dir/?api=1&origin=$position&destination=$lat,$long&waypoints";
    });
  }

  getMarkersList(BuildContext context) {
    PlacesViewModelCubit inst = PlacesViewModelCubit.get(context);
    for (int i = 0; i < inst.placesRes.placesList!.length; i++) {
      markers.add(Marker(
        markerId: MarkerId(i.toString()),
        onTap: () {
          showModalBottomSheet(
              context: context,
              backgroundColor: Colors.black.withOpacity(.7),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25)),
              ),
              builder: (context) {
                return Column(
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      height: 21.h,
                      width: 21.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Center(
                            child: Container(
                              height: 5.h,
                              width: 5.h,
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            height: 20.h,
                            width: 20.h,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(place.photo!),
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          place.placeName!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Lob",
                              fontSize: 20.sp),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          height: 5,
                          width: 10.w,
                          color: Colors.white,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      place.description!,
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          goBack(context);
                          String position = place.lat.toString() +
                              "," +
                              place.longt.toString();
                          if (!await launchUrl(
                            Uri.parse(
                                "https://www.google.com/maps/@${double.parse(place.lat!)},${double.parse(place.longt!)},15z" /* "https://www.google.com/maps/dir/?api=1&origin=$position&destination=${double.parse(place.lat!)},${double.parse(place.longt!)}&waypoints"*/),
                            mode: LaunchMode.externalApplication,
                          )) {
                            throw 'Could not launch url';
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 1.h, horizontal: 5.w),
                          child: Text(
                            "GO",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.sp),
                          ),
                        )),
                  ],
                );
              });
          setState(() {
            lat = double.parse(inst.placesRes.placesList![i].lat!);
            long = double.parse(inst.placesRes.placesList![i].longt!);
            myMapController?.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(target: LatLng(lat!, long!), zoom: 17)
                //17 is new zoom level
                ));
            zoomVal = 50;
            place = inst.placesRes.placesList![i];
            markerTapped = true;
          });
        },
        position: LatLng(double.parse(inst.placesRes.placesList![i].lat!),
            double.parse(inst.placesRes.placesList![i].longt!)),
        infoWindow: InfoWindow(
          //popup info
          title: inst.placesRes.placesList![i].placeName,

          snippet: "",
        ),
      ));
    }
  }

  Future getlocation() async {
    LocationPermission per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied ||
        per == LocationPermission.deniedForever) {
      print("permission denied");
      LocationPermission per1 = await Geolocator.requestPermission();
    } else {
      Position currentLoc = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      String position = currentLoc.latitude.toString() +
          "," +
          currentLoc.longitude.toString();

      print(position);

      setState(() {
        long = currentLoc.longitude;
        lat = currentLoc.latitude;
        zoomVal = 20;
        cameraPosition = CameraPosition(
          target: LatLng(lat!, long!),
          zoom: 20,
        );
        myMapController?.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(lat!, long!), zoom: 17)
            //17 is new zoom level
            ));
        url =
            "https://www.google.com/maps/dir/?api=1&origin=$position&destination=$lat,$long&waypoints";
      });
    }
  }

  @override
  void initState() {
    getlocation().then((value) {
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    PlacesViewModelCubit inst = PlacesViewModelCubit.get(context);
    if (inst.placesRes.placesList == null) {
      inst.getPlacesResponse().then((value) {
        setState(() {});
      });
    } else {
      getMarkersList(context);
    }
    return inst.placesRes.placesList == null
        ? Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            )),
          )
        : SafeArea(
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  await floatingGetCurrentLoc();
                },
                backgroundColor: Colors.black,
                child: Padding(
                  padding: EdgeInsets.all(2.h),
                  child: SvgPicture.asset(
                    "assets/images/myloc.svg",
                    color: Colors.white,
                  ),
                ),
              ),
              body: Stack(
                alignment: Alignment.topCenter,
                children: [
                  GoogleMap(
                    /*   onTap: (position) async {
                      await ChangeCurrentLoc(position).then((value) {
                        markers.clear();
                        markers.add(
                          Marker(
                            markerId: MarkerId(markerLatestId.toString()),
                            position: position,
                            infoWindow: InfoWindow(
                              title: "موقعك الحالي",
                            ),
                          ),
                        );
                      });
                    },*/
                    onMapCreated: (mapController) {
                      setState(() {
                        myMapController = mapController;
                        getlocation().then((value) {
                          myMapController?.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                      target: LatLng(lat!, long!), zoom: 17)
                                  //17 is new zoom level
                                  ));
                          markers.add(
                            Marker(
                              markerId: MarkerId("100"),
                              position: LatLng(lat!, long!),
                              infoWindow: InfoWindow(
                                title: "موقعك الحالي",
                              ),
                            ),
                          );
                        });
                      });
                    },
                    markers: markers,
                    mapType: MapType.normal,
                    mapToolbarEnabled: false,
                    tiltGesturesEnabled: false,
                    /*myLocationButtonEnabled: true,*/
                    /*myLocationEnabled: true,*/
                    zoomControlsEnabled: false,
                    onCameraMove: (position) {
                      setState(() {
                        zoomVal = 15;
                      });
                    },
                    initialCameraPosition: cameraPosition == null
                        ? CameraPosition(
                            target: lat == null && long == null
                                ? LatLng(markers.first.position.latitude,
                                    markers.first.position.longitude)
                                : LatLng(lat!, long!),
                            zoom: 5,
                          )
                        : cameraPosition,
                  ),
                  Container(
                    height: 8.h,
                    /* color: Colors.black.withOpacity(.5),*/
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(1.h),
                            child: MaterialButton(
                              onPressed: () {
                                setState(() {
                                  tabbed = index;
                                  myMapController?.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                              target: LatLng(
                                                  double.parse(inst.placesRes
                                                      .placesList![index].lat!),
                                                  double.parse(inst
                                                      .placesRes
                                                      .placesList![index]
                                                      .longt!)),
                                              zoom: 17)
                                          //17 is new zoom level
                                          ));
                                });
                              },
                              color:
                                  tabbed == index ? Colors.red : Colors.white,
                              child: Text(
                                inst.placesRes.placesList![index].placeName!
                                    .toString(),
                                style: TextStyle(
                                  color: tabbed == index
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.h)),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 2.w,
                          );
                        },
                        itemCount: inst.placesRes.placesList!.length),
                  ),
                ],
              ),
            ),
          );
  }
}
