part of 'places_view_model_cubit.dart';

@immutable
abstract class PlacesViewModelState {}

class PlacesViewModelInitial extends PlacesViewModelState {}

class PlacesResponseLoaded extends PlacesViewModelState {
  final PlacesResponse placesRes;

  PlacesResponseLoaded({required this.placesRes}) {
    print(
        "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    for (int i = 0; i < placesRes.placesList!.length; i++) {
      print(placesRes.placesList![i].placeName.toString());
    }
  }
}
