part of 'google_map_bloc.dart';



abstract class GoogleMapScreenStates extends BaseStates {
  const GoogleMapScreenStates();
}

///all states of AuthenticationStates

class GoogleMapScreenInitialState extends GoogleMapScreenStates {}

class MapDetialsCallEventResponseState extends GoogleMapScreenStates {

}


class PlaceSearchResponseState extends GoogleMapScreenStates {
  PlacesSearchResponse placesSearchResponse;

  PlaceSearchResponseState(this.placesSearchResponse);
}

class DistanceMatrixState extends GoogleMapScreenStates {
  DistanceMatrixResponse distanceMatrixResponse;

  DistanceMatrixState(this.distanceMatrixResponse);
}



/*class LoginUserDetialsCallEventResponseState extends FirstScreenStates {
  LoginUserDetialsResponse response;

  LoginUserDetialsCallEventResponseState(this.response);
}

class ComapnyDetailsEventResponseState extends FirstScreenStates{
  final CompanyDetailsResponse companyDetailsResponse;

  ComapnyDetailsEventResponseState(this.companyDetailsResponse);

}*/
