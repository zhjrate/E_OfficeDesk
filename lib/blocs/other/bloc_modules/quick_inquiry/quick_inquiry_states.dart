part of 'quick_inquiry_bloc.dart';

abstract class QuickInquiryStates extends BaseStates {
  const QuickInquiryStates();
}

///all states of AuthenticationStates
class QuickInquiryInitialState extends QuickInquiryStates {}



class CountryListEventResponseState extends QuickInquiryStates{
  final CountryListResponse countrylistresponse;
  CountryListEventResponseState(this.countrylistresponse);
}
class StateListEventResponseState extends QuickInquiryStates{
  final StateListResponse statelistresponse;
  StateListEventResponseState(this.statelistresponse);
}

class DistrictListEventResponseState extends QuickInquiryStates{
  final DistrictApiResponse districtApiResponseList;
  DistrictListEventResponseState(this.districtApiResponseList);
}
class TalukaListEventResponseState extends QuickInquiryStates{
  final TalukaApiRespose talukaApiRespose;
  TalukaListEventResponseState(this.talukaApiRespose);
}

class CityListEventResponseState extends QuickInquiryStates{
  final CityApiRespose cityApiRespose;
  CityListEventResponseState(this.cityApiRespose);
}



class CustomerAddEditEventResponseState extends QuickInquiryStates{
  final CustomerAddEditApiResponse customerAddEditApiResponse;
  CustomerAddEditEventResponseState(this.customerAddEditApiResponse);
}





class CustomerCategoryCallEventResponseState extends QuickInquiryStates{
  final CustomerCategoryResponse categoryResponse;
  CustomerCategoryCallEventResponseState(this.categoryResponse);
}
class CustomerSourceCallEventResponseState extends QuickInquiryStates{
  final CustomerSourceResponse sourceResponse;
  CustomerSourceCallEventResponseState(this.sourceResponse);
}

class DesignationListEventResponseState extends QuickInquiryStates{
  final DesignationApiResponse designationApiResponse;
  DesignationListEventResponseState(this.designationApiResponse);
}



class InquiryLeadStatusListCallResponseState extends QuickInquiryStates {
  final InquiryStatusListResponse inquiryStatusListResponse;

  InquiryLeadStatusListCallResponseState(this.inquiryStatusListResponse);
}
class InquiryHeaderSaveResponseState extends QuickInquiryStates{
  final InquiryHeaderSaveResponse inquiryHeaderSaveResponse;
  InquiryHeaderSaveResponseState(this.inquiryHeaderSaveResponse);
}
class InquiryProductSaveResponseState extends QuickInquiryStates{
  final InquiryProductSaveResponse inquiryProductSaveResponse;
  InquiryProductSaveResponseState(this.inquiryProductSaveResponse);
}

class FollowupTypeListCallResponseState extends QuickInquiryStates {
  final FollowupTypeListResponse followupTypeListResponse;

  FollowupTypeListCallResponseState(this.followupTypeListResponse);
}

class CustomerListByNameCallResponseState extends QuickInquiryStates {
  final CustomerLabelvalueRsponse response;

  CustomerListByNameCallResponseState(this.response);
}

class SearchCustomerListByNumberCallResponseState extends QuickInquiryStates {
  final CustomerDetailsResponse response;

  SearchCustomerListByNumberCallResponseState(this.response);
}