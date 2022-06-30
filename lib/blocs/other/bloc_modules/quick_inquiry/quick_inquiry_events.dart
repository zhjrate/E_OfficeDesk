part of 'quick_inquiry_bloc.dart';

@immutable
abstract class QuickInquiryEvents {}

///all events of AuthenticationEvents

class CountryCallEvent extends QuickInquiryEvents {
  final CountryListRequest countryListRequest;
  CountryCallEvent(this.countryListRequest);
}

class StateCallEvent extends QuickInquiryEvents {
  final StateListRequest stateListRequest;
  StateCallEvent(this.stateListRequest);
}


class DistrictCallEvent extends QuickInquiryEvents {
  final DistrictApiRequest districtApiRequest;
  DistrictCallEvent(this.districtApiRequest);
}

class TalukaCallEvent extends QuickInquiryEvents {
  final TalukaApiRequest talukaApiRequest;
  TalukaCallEvent(this.talukaApiRequest);
}

class CityCallEvent extends QuickInquiryEvents {
  final CityApiRequest cityApiRequest;
  CityCallEvent(this.cityApiRequest);
}


class CustomerAddEditCallEvent extends QuickInquiryEvents {
  final CustomerAddEditApiRequest customerAddEditApiRequest;
  CustomerAddEditCallEvent(this.customerAddEditApiRequest);
}



class CustomerCategoryCallEvent extends QuickInquiryEvents {
  final CustomerCategoryRequest request1;
  CustomerCategoryCallEvent(this.request1);
}

class CustomerSourceCallEvent extends QuickInquiryEvents {
  final CustomerSourceRequest request1;
  CustomerSourceCallEvent(this.request1);
}

class DesignationCallEvent extends QuickInquiryEvents {
  final DesignationApiRequest designationApiRequest;
  DesignationCallEvent(this.designationApiRequest);
}

class InquiryLeadStatusTypeListByNameCallEvent extends QuickInquiryEvents {
  final FollowupInquiryStatusTypeListRequest followupInquiryStatusTypeListRequest;

  InquiryLeadStatusTypeListByNameCallEvent(this.followupInquiryStatusTypeListRequest);
}

class InquiryHeaderSaveNameCallEvent extends QuickInquiryEvents {
  final int pkID;

  final InquiryHeaderSaveRequest inquiryHeaderSaveRequest;

  InquiryHeaderSaveNameCallEvent(this.pkID,this.inquiryHeaderSaveRequest);
}
class InquiryProductSaveCallEvent extends QuickInquiryEvents {
  final List<InquiryProductModel> inquiryProductModel;
  InquiryProductSaveCallEvent(this.inquiryProductModel);
}
class FollowupTypeListByNameCallEvent extends QuickInquiryEvents {
  final FollowupTypeListRequest followupTypeListRequest;

  FollowupTypeListByNameCallEvent(this.followupTypeListRequest);
}

class SearchCustomerListByNameCallEvent extends QuickInquiryEvents {
  final CustomerLabelValueRequest request;

  SearchCustomerListByNameCallEvent(this.request);
}

class SearchCustomerListByNumberCallEvent extends QuickInquiryEvents {
  final CustomerSearchByIdRequest request;

  SearchCustomerListByNumberCallEvent(this.request);
}