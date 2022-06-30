part of 'inquiry_bloc.dart';

@immutable
abstract class InquiryEvents {}

///all events of AuthenticationEvents
class InquiryListCallEvent extends InquiryEvents {
  final int pageNo;
  final InquiryListApiRequest inquiryListApiRequest;
  InquiryListCallEvent(this.pageNo, this.inquiryListApiRequest);
}

class SearchInquiryListByNameCallEvent extends InquiryEvents {
  final SearchInquiryListByNameRequest request;

  SearchInquiryListByNameCallEvent(this.request);
}

class SearchInquiryListByNumberCallEvent extends InquiryEvents {
  final SearchInquiryListByNumberRequest request;

  SearchInquiryListByNumberCallEvent(this.request);
}

/*class InquiryLeadSourceCallEvent extends InquiryEvents {
  final CustomerSourceRequest request1;
  InquiryLeadSourceCallEvent(this.request1);
}*/

class InquiryDeleteByNameCallEvent extends InquiryEvents {
  final int pkID;

  final FollowupDeleteRequest followupDeleteRequest;

  InquiryDeleteByNameCallEvent(this.pkID, this.followupDeleteRequest);
}

class InquiryProductSearchNameCallEvent extends InquiryEvents {
  final InquiryProductSearchRequest inquiryProductSearchRequest;

  InquiryProductSearchNameCallEvent(this.inquiryProductSearchRequest);
}

class InquiryHeaderSaveNameCallEvent extends InquiryEvents {
  final int pkID;

  final InquiryHeaderSaveRequest inquiryHeaderSaveRequest;

  InquiryHeaderSaveNameCallEvent(this.pkID, this.inquiryHeaderSaveRequest);
}

class InquiryProductSaveCallEvent extends InquiryEvents {
  final List<InquiryProductModel> inquiryProductModel;
  InquiryProductSaveCallEvent(this.inquiryProductModel);
}

class InquiryNotoProductCallEvent extends InquiryEvents {
  final InquiryNoToProductListRequest inquiryNoToProductListRequest;

  InquiryNotoProductCallEvent(this.inquiryNoToProductListRequest);
}

class InquiryNotoDeleteProductCallEvent extends InquiryEvents {
  final String InqNo;
  final InquiryNoToDeleteProductRequest inquiryNoToDeleteProductRequest;

  InquiryNotoDeleteProductCallEvent(
      this.InqNo, this.inquiryNoToDeleteProductRequest);
}

class InquirySearchByPkIDCallEvent extends InquiryEvents {
  final String pkID;
  final InquirySearchByPkIdRequest inquirySearchByPkIdRequest;

  InquirySearchByPkIDCallEvent(this.pkID, this.inquirySearchByPkIdRequest);
}

class SearchInquiryCustomerListByNameCallEvent extends InquiryEvents {
  final CustomerLabelValueRequest request;

  SearchInquiryCustomerListByNameCallEvent(this.request);
}

class InquiryLeadStatusTypeListByNameCallEvent extends InquiryEvents {
  final FollowupInquiryStatusTypeListRequest
      followupInquiryStatusTypeListRequest;

  InquiryLeadStatusTypeListByNameCallEvent(
      this.followupInquiryStatusTypeListRequest);
}

class CustomerSourceCallEvent extends InquiryEvents {
  final CustomerSourceRequest request1;
  CustomerSourceCallEvent(this.request1);
}

class InquiryNoToFollowupDetailsRequestCallEvent extends InquiryEvents {
  final InquiryNoToFollowupDetailsRequest inquiryNoToFollowupDetailsRequest;
  InquiryDetails inquiryDetails;
  InquiryNoToFollowupDetailsRequestCallEvent(
      this.inquiryDetails, this.inquiryNoToFollowupDetailsRequest);
}

class InquiryShareModelCallEvent extends InquiryEvents {
  final List<InquiryShareModel> inquiryShareModel;
  InquiryShareModelCallEvent(this.inquiryShareModel);
}

class FollowerEmployeeListCallEvent extends InquiryEvents {
  final FollowerEmployeeListRequest followerEmployeeListRequest;
  FollowerEmployeeListCallEvent(this.followerEmployeeListRequest);
}

class InquiryShareEmpListRequestEvent extends InquiryEvents {
  final InquiryShareEmpListRequest inquiryShareEmpListRequest;
  InquiryShareEmpListRequestEvent(this.inquiryShareEmpListRequest);
}

class CloserReasonTypeListByNameCallEvent extends InquiryEvents {
  final CloserReasonTypeListRequest closerReasonTypeListRequest;

  CloserReasonTypeListByNameCallEvent(this.closerReasonTypeListRequest);
}

class CountryCallEvent extends InquiryEvents {
  final CountryListRequest countryListRequest;
  CountryCallEvent(this.countryListRequest);
}

class StateCallEvent extends InquiryEvents {
  final StateListRequest stateListRequest;
  StateCallEvent(this.stateListRequest);
}

class CityCallEvent extends InquiryEvents {
  final CityApiRequest cityApiRequest;
  CityCallEvent(this.cityApiRequest);
}

class SearchInquiryListFillterByNameRequestEvent extends InquiryEvents {
  SearchInquiryListFillterByNameRequest searchInquiryListFillterByNameRequest;

  SearchInquiryListFillterByNameRequestEvent(
      this.searchInquiryListFillterByNameRequest);
}

class SearchCustomerListByNumberCallEvent extends InquiryEvents {
  final CustomerSearchByIdRequest request;

  SearchCustomerListByNumberCallEvent(this.request);
}
