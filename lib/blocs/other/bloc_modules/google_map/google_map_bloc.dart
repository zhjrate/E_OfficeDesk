import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/models/api_requests/distance_matrix_api_request.dart';
import 'package:soleoserp/models/api_requests/google_place_api_request.dart';
import 'package:soleoserp/models/api_responses/distance_matrix_api_response.dart';
import 'package:soleoserp/models/api_responses/google_place_search_response.dart';
import 'package:soleoserp/repositories/repository.dart';

part 'google_map_event.dart';
part 'google_map_state.dart';

class GoogleMapScreenBloc
    extends Bloc<GoogleMapScreenEvents, GoogleMapScreenStates> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;

  GoogleMapScreenBloc(this.baseBloc) : super(GoogleMapScreenInitialState());

  @override
  Stream<GoogleMapScreenStates> mapEventToState(
      GoogleMapScreenEvents event) async* {
    /// sets state based on events
    /* if (event is CompanyDetailsCallEvent) {
      yield* _mapCompanyDetailsCallEventToState(event);
    }
    if(event is LoginUserDetailsCallEvent)
    {
      yield* _mapLoginUserDetailsCallEventToState(event);

    }*/

    if (event is PlaceSearchRequestCallEvent) {
      yield* _mapCompanyDetailsCallEventToState(event);
    }
    if (event is DistanceMatrixCallEvent) {
      yield* _mapDistanceMatrixCallEventToState(event);
    }
  }

  ///event functions to states implementation
  Stream<GoogleMapScreenStates> _mapCompanyDetailsCallEventToState(
      PlaceSearchRequestCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      PlacesSearchResponse placesSearchResponse = await userRepository
          .googelePlaceSearch(event.MapAPIKey, event.placeSearchRequest);
      yield PlaceSearchResponseState(placesSearchResponse);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<GoogleMapScreenStates> _mapDistanceMatrixCallEventToState(
      DistanceMatrixCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      DistanceMatrixResponse distanceMatrixResponse = await userRepository
          .distanceMatrixDetails(event.MapAPIKey, event.distanceMatrix_Request);
      yield DistanceMatrixState(distanceMatrixResponse);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
}
