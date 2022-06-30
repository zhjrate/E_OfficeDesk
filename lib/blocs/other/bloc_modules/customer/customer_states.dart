part of 'customer_bloc.dart';

abstract class CustomerStates extends BaseStates {
  const CustomerStates();
}

///all states of AuthenticationStates
class CustomerInitialState extends CustomerStates {}

class CustomerListCallResponseState extends CustomerStates {
  final CustomerDetailsResponse response;
  final int newPage;
  CustomerListCallResponseState(this.response,this.newPage);
}

class CustomerListByNameCallResponseState extends CustomerStates {
  final CustomerLabelvalueRsponse response;

  CustomerListByNameCallResponseState(this.response);
}

class SearchCustomerListByNumberCallResponseState extends CustomerStates {
  final CustomerDetailsResponse response;

  SearchCustomerListByNumberCallResponseState(this.response);
}



class CountryListEventResponseState extends CustomerStates{
  final CountryListResponse countrylistresponse;
  CountryListEventResponseState(this.countrylistresponse);
}
class StateListEventResponseState extends CustomerStates{
  final StateListResponse statelistresponse;
  StateListEventResponseState(this.statelistresponse);
}

class DistrictListEventResponseState extends CustomerStates{
  final DistrictApiResponse districtApiResponseList;
  DistrictListEventResponseState(this.districtApiResponseList);
}
class TalukaListEventResponseState extends CustomerStates{
  final TalukaApiRespose talukaApiRespose;
  TalukaListEventResponseState(this.talukaApiRespose);
}

class CityListEventResponseState extends CustomerStates{
  final CityApiRespose cityApiRespose;
  CityListEventResponseState(this.cityApiRespose);
}



class CustomerAddEditEventResponseState extends CustomerStates{
  final CustomerAddEditApiResponse customerAddEditApiResponse;
  CustomerAddEditEventResponseState(this.customerAddEditApiResponse);
}
class CustomerDeleteCallResponseState extends CustomerStates {
  final CustomerDeleteResponse customerDeleteResponse;

  CustomerDeleteCallResponseState(this.customerDeleteResponse);
}
class CustomerContactSaveResponseState extends CustomerStates {
  final CustomerContactSaveResponse contactSaveResponse;
  CustomerContactSaveResponseState(this.contactSaveResponse);
}
class CustomerIdToCustomerListResponseState extends CustomerStates {
  final CustomerIdToContactListResponse customerIdToContactListResponse;
  CustomerIdToCustomerListResponseState(this.customerIdToContactListResponse);
}

class CustomerIdToDeleteAllContactResponseState extends CustomerStates {
  final CustomerIdToDeleteAllContactResponse response;

  CustomerIdToDeleteAllContactResponseState(this.response);
}


class CustomerCategoryCallEventResponseState extends CustomerStates{
  final CustomerCategoryResponse categoryResponse;
  CustomerCategoryCallEventResponseState(this.categoryResponse);
}
class CustomerSourceCallEventResponseState extends CustomerStates{
  final CustomerSourceResponse sourceResponse;
  CustomerSourceCallEventResponseState(this.sourceResponse);
}

class DesignationListEventResponseState extends CustomerStates{
  final DesignationApiResponse designationApiResponse;
  DesignationListEventResponseState(this.designationApiResponse);
}

