import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tourpoint/models/places_response.dart';
import 'package:tourpoint/services/allplaces_service.dart';

part 'places_view_model_state.dart';

class PlacesViewModelCubit extends Cubit<PlacesViewModelState> {
  PlacesViewModelCubit() : super(PlacesViewModelInitial()) {}

  static PlacesViewModelCubit get(context) => BlocProvider.of(context);

  PlacesResponse placesRes = PlacesResponse();

  Future getPlacesResponse() async {
    placesServices().getAllPlacesRespons().then((apiPlacesResponse) {
      placesRes = apiPlacesResponse;
      emit(PlacesResponseLoaded(placesRes: placesRes));
    });
  }
}
