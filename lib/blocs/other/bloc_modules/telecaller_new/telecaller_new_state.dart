part of 'telecaller_new_bloc.dart';


abstract class TeleCallerNewStates extends BaseStates {
  const TeleCallerNewStates();
}

///all states of AuthenticationStates
class TeleCallerNewInitialState extends TeleCallerNewStates {}

class TeleCallerNewListCallResponseState extends TeleCallerNewStates {
  final TelecallerNewpaginationResponse response;
  final int newPage;
  TeleCallerNewListCallResponseState(this.response,this.newPage);
}
class CountryListEventResponseState extends TeleCallerNewStates{
  final CountryListResponse countrylistresponse;
  CountryListEventResponseState(this.countrylistresponse);
}
class StateListEventResponseState extends TeleCallerNewStates{
  final StateListResponse statelistresponse;
  StateListEventResponseState(this.statelistresponse);
}


class CityListEventResponseState extends TeleCallerNewStates{
  final CityApiRespose cityApiRespose;
  CityListEventResponseState(this.cityApiRespose);
}

class CustomerSourceCallEventResponseState extends TeleCallerNewStates{
  final CustomerSourceResponse sourceResponse;
  CustomerSourceCallEventResponseState(this.sourceResponse);
}

class TeleCallerDeleteCallResponseState extends TeleCallerNewStates {
  final CustomerDeleteResponse customerDeleteResponse;

  TeleCallerDeleteCallResponseState(this.customerDeleteResponse);
}

class  TeleCallerSearchByNameResponseState extends TeleCallerNewStates{
  final TeleCallerSearchResponseByName sourceResponse;
  TeleCallerSearchByNameResponseState(this.sourceResponse);
}



class TeleCallerSearchByIDResponseState extends TeleCallerNewStates {
  final TeleCallerListResponse response;
  TeleCallerSearchByIDResponseState(this.response);
}
class ExternalLeadSaveResponseState extends TeleCallerNewStates {
  final ExternalLeadSaveResponse response;
  ExternalLeadSaveResponseState(this.response);
}

class CustomerListByNameCallResponseState extends TeleCallerNewStates {
  final CustomerLabelvalueRsponse response;

  CustomerListByNameCallResponseState(this.response);
}