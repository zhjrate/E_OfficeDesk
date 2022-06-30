part of 'telecaller_bloc.dart';


abstract class TeleCallerStates extends BaseStates {
  const TeleCallerStates();
}

///all states of AuthenticationStates
class TeleCallerInitialState extends TeleCallerStates {}

class TeleCallerListCallResponseState extends TeleCallerStates {
  final TeleCallerListResponse response;
  final int newPage;
  TeleCallerListCallResponseState(this.response,this.newPage);
}
class CountryListEventResponseState extends TeleCallerStates{
  final CountryListResponse countrylistresponse;
  CountryListEventResponseState(this.countrylistresponse);
}
class StateListEventResponseState extends TeleCallerStates{
  final StateListResponse statelistresponse;
  StateListEventResponseState(this.statelistresponse);
}


class CityListEventResponseState extends TeleCallerStates{
  final CityApiRespose cityApiRespose;
  CityListEventResponseState(this.cityApiRespose);
}

class CustomerSourceCallEventResponseState extends TeleCallerStates{
  final CustomerSourceResponse sourceResponse;
  CustomerSourceCallEventResponseState(this.sourceResponse);
}

class TeleCallerDeleteCallResponseState extends TeleCallerStates {
  final CustomerDeleteResponse customerDeleteResponse;

  TeleCallerDeleteCallResponseState(this.customerDeleteResponse);
}

class  TeleCallerSearchByNameResponseState extends TeleCallerStates{
  final TeleCallerSearchResponseByName sourceResponse;
  TeleCallerSearchByNameResponseState(this.sourceResponse);
}



class TeleCallerSearchByIDResponseState extends TeleCallerStates {
  final TeleCallerListResponse response;
  TeleCallerSearchByIDResponseState(this.response);
}
class ExternalLeadSaveResponseState extends TeleCallerStates {
  final ExternalLeadSaveResponse response;
  ExternalLeadSaveResponseState(this.response);
}

class CustomerListByNameCallResponseState extends TeleCallerStates {
  final CustomerLabelvalueRsponse response;

  CustomerListByNameCallResponseState(this.response);
}
class TeleCallerUploadImgApiResponseState extends TeleCallerStates {
  final Telecaller_image_upload_response response;

  TeleCallerUploadImgApiResponseState(this.response);
}
class TeleCallerImageDeleteResponseState extends TeleCallerStates {
  final TeleCallerImageDeleteResponse response;

  TeleCallerImageDeleteResponseState(this.response);
}

