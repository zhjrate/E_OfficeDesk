part of 'inquiry_bloc.dart';

abstract class InquiryStates extends BaseStates {
  const InquiryStates();
}

///all states of AuthenticationStates
class InquiryInitialState extends InquiryStates {}

class InquiryListCallResponseState extends InquiryStates {
  final InquiryListResponse response;
  final int newPage;
  InquiryListCallResponseState(this.response, this.newPage);
}

class SearchInquiryListByNameCallResponseState extends InquiryStates {
  final SearchInquiryListResponse response;

  SearchInquiryListByNameCallResponseState(this.response);
}

class SearchInquiryListByNumberCallResponseState extends InquiryStates {
  final InquiryListResponse response;

  SearchInquiryListByNumberCallResponseState(this.response);
}
/*class InquirySaveCallResponseState extends InquiryStates {
  final CustomerContactSaveResponse inquirysaveResponse;
  InquirySaveCallResponseState(this.inquirysaveResponse);
}*/

/*class InquirySourceCallEventResponseState extends InquiryStates{
  final CustomerSourceResponse sourceResponse;
  InquirySourceCallEventResponseState(this.sourceResponse);
}*/

class InquiryDeleteCallResponseState extends InquiryStates {
  final InquiryDeleteResponse inquiryDeleteResponse;

  InquiryDeleteCallResponseState(this.inquiryDeleteResponse);
}

class InquiryProductSearchResponseState extends InquiryStates {
  final InquiryProductSearchResponse inquiryProductSearchResponse;
  InquiryProductSearchResponseState(this.inquiryProductSearchResponse);
}

class InquiryHeaderSaveResponseState extends InquiryStates {
  final InquiryHeaderSaveResponse inquiryHeaderSaveResponse;
  InquiryHeaderSaveResponseState(this.inquiryHeaderSaveResponse);
}

class InquiryProductSaveResponseState extends InquiryStates {
  final InquiryProductSaveResponse inquiryProductSaveResponse;
  InquiryProductSaveResponseState(this.inquiryProductSaveResponse);
}

class InquiryNotoProductResponseState extends InquiryStates {
  final InquiryNoToProductResponse inquiryNoToProductResponse;
  InquiryNotoProductResponseState(this.inquiryNoToProductResponse);
}

class InquiryNotoDeleteProductResponseState extends InquiryStates {
  final InquiryNoToDeleteProductResponse inquiryNoToDeleteProductResponse;
  InquiryNotoDeleteProductResponseState(this.inquiryNoToDeleteProductResponse);
}

class InquirySearchByPkIDResponseState extends InquiryStates {
  final InquiryListResponse response;
  InquirySearchByPkIDResponseState(this.response);
}

class InquiryCustomerListByNameCallResponseState extends InquiryStates {
  final CustomerLabelvalueRsponse response;

  InquiryCustomerListByNameCallResponseState(this.response);
}

class InquiryLeadStatusListCallResponseState extends InquiryStates {
  final InquiryStatusListResponse inquiryStatusListResponse;

  InquiryLeadStatusListCallResponseState(this.inquiryStatusListResponse);
}

class CustomerSourceCallEventResponseState extends InquiryStates {
  final CustomerSourceResponse sourceResponse;
  CustomerSourceCallEventResponseState(this.sourceResponse);
}

class FollowupHistoryListResponseState extends InquiryStates {
  final FollowupHistoryListResponse followupHistoryListResponse;
  InquiryDetails inquiryDetails;

  FollowupHistoryListResponseState(
      this.inquiryDetails, this.followupHistoryListResponse);
}

class InquiryShareResponseState extends InquiryStates {
  final InquiryShareResponse inquiryShareResponse;
  InquiryShareResponseState(this.inquiryShareResponse);
}

class FollowerEmployeeListByStatusCallResponseState extends InquiryStates {
  final FollowerEmployeeListResponse response;

  FollowerEmployeeListByStatusCallResponseState(this.response);
}

class InquiryShareEmpListResponseState extends InquiryStates {
  final InquiryShareEmpListResponse response;
  String InquiryNo;
  InquiryShareEmpListResponseState(this.InquiryNo, this.response);
}

class CloserReasonListCallResponseState extends InquiryStates {
  final CloserReasonListResponse closerReasonListResponse;

  CloserReasonListCallResponseState(this.closerReasonListResponse);
}

class CountryListEventResponseState extends InquiryStates {
  final CountryListResponseForPacking countrylistresponse;
  CountryListEventResponseState(this.countrylistresponse);
}

class StateListEventResponseState extends InquiryStates {
  final StateListResponse statelistresponse;
  StateListEventResponseState(this.statelistresponse);
}

class CityListEventResponseState extends InquiryStates {
  final CityApiRespose cityApiRespose;
  CityListEventResponseState(this.cityApiRespose);
}

class SearchInquiryFillterResponseState extends InquiryStates {
  final InquiryListResponse response;
  SearchInquiryFillterResponseState(this.response);
}

class SearchCustomerListByNumberCallResponseState extends InquiryStates {
  final CustomerDetailsResponse response;

  SearchCustomerListByNumberCallResponseState(this.response);
}
