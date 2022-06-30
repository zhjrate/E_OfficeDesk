part of 'google_map_bloc.dart';

@immutable
abstract class GoogleMapScreenEvents {}

///all events of AuthenticationEvents
class MapDetailsCallEvent extends GoogleMapScreenEvents {
  //final LoginUserDetialsAPIRequest request;

  // LoginUserDetailsCallEvent(this.request);
}

class PlaceSearchRequestCallEvent extends GoogleMapScreenEvents {
  final PlaceSearchRequest placeSearchRequest;
  final String MapAPIKey;
  PlaceSearchRequestCallEvent(this.MapAPIKey, this.placeSearchRequest);
}

class DistanceMatrixCallEvent extends GoogleMapScreenEvents {
  final DistanceMatrix_Request distanceMatrix_Request;
  final String MapAPIKey;
  DistanceMatrixCallEvent(this.MapAPIKey, this.distanceMatrix_Request);
}

/*class LoginUserDetailsCallEvent extends FirstScreenEvents {
  final LoginUserDetialsAPIRequest request;

  LoginUserDetailsCallEvent(this.request);
}

class CompanyDetailsCallEvent extends FirstScreenEvents {
  final CompanyDetailsApiRequest companyDetailsApiRequest;

  CompanyDetailsCallEvent(this.companyDetailsApiRequest);
}*/
