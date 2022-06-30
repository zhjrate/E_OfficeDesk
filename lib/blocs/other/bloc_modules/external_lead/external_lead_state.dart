part of 'external_lead_bloc.dart';


abstract class ExternalLeadStates extends BaseStates {
  const ExternalLeadStates();
}

///all states of AuthenticationStates
class ExternalLeadInitialState extends ExternalLeadStates {}

class ExternalLeadListCallResponseState extends ExternalLeadStates {
  final ExternalLeadListResponse response;
  final int newPage;
  ExternalLeadListCallResponseState(this.response,this.newPage);
}
class CountryListEventResponseState extends ExternalLeadStates{
  final CountryListResponse countrylistresponse;
  CountryListEventResponseState(this.countrylistresponse);
}
class StateListEventResponseState extends ExternalLeadStates{
  final StateListResponse statelistresponse;
  StateListEventResponseState(this.statelistresponse);
}


class CityListEventResponseState extends ExternalLeadStates{
  final CityApiRespose cityApiRespose;
  CityListEventResponseState(this.cityApiRespose);
}

class CustomerSourceCallEventResponseState extends ExternalLeadStates{
  final CustomerSourceResponse sourceResponse;
  CustomerSourceCallEventResponseState(this.sourceResponse);
}

class ExternalLeadDeleteCallResponseState extends ExternalLeadStates {
  final CustomerDeleteResponse customerDeleteResponse;

  ExternalLeadDeleteCallResponseState(this.customerDeleteResponse);
}

class  ExternalLeadSearchByNameResponseState extends ExternalLeadStates{
  final ExternalLeadSearchResponseByName sourceResponse;
  ExternalLeadSearchByNameResponseState(this.sourceResponse);
}



class ExternalLeadSearchByIDResponseState extends ExternalLeadStates {
  final ExternalLeadListResponse response;
  ExternalLeadSearchByIDResponseState(this.response);
}
class ExternalLeadSaveResponseState extends ExternalLeadStates {
  final ExternalLeadSaveResponse response;
  ExternalLeadSaveResponseState(this.response);
}