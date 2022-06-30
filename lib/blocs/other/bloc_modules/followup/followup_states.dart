part of 'followup_bloc.dart';


abstract class FollowupStates extends BaseStates {
  const FollowupStates();
}

///all states of AuthenticationStates
class FollowupInitialState extends FollowupStates {}

class FollowupListCallResponseState extends FollowupStates {
  final FollowupListResponse response;
  final int newPage;
  FollowupListCallResponseState(this.response,this.newPage);
}

class SearchFollowupListByStatusCallResponseState extends FollowupStates {
  final FollowupListResponse response;

  SearchFollowupListByStatusCallResponseState(this.response);
}



class FollowupCustomerListByNameCallResponseState extends FollowupStates {
  final CustomerLabelvalueRsponse response;

  FollowupCustomerListByNameCallResponseState(this.response);
}



class FollowupInquiryStatusListCallResponseState extends FollowupStates {
  final InquiryStatusListResponse inquiryStatusListResponse;

  FollowupInquiryStatusListCallResponseState(this.inquiryStatusListResponse);
}



class FollowupInquiryNoListCallResponseState extends FollowupStates {
  final FollowupInquiryNoListResponse followupInquiryNoListResponse;

  FollowupInquiryNoListCallResponseState(this.followupInquiryNoListResponse);
}
class FollowupSaveCallResponseState extends FollowupStates {
  final FollowupSaveSuccessResponse followupSaveResponse;
  final BuildContext context;
  FollowupSaveCallResponseState(this.context,this.followupSaveResponse);
}
class FollowupDeleteCallResponseState extends FollowupStates {
  final FollowupDeleteResponse followupDeleteResponse;

  FollowupDeleteCallResponseState(this.followupDeleteResponse);
}
class FollowupFilterListCallResponseState extends FollowupStates {
  final FollowupFilterListResponse followupFilterListResponse;
  final int newPage;

  FollowupFilterListCallResponseState(this.newPage,this.followupFilterListResponse);
}

class FollowupInquiryByCustomerIdCallResponseState extends FollowupStates {
  final FollowupInquiryByCustomerIDResponse followupInquiryByCustomerIDResponse;

  FollowupInquiryByCustomerIdCallResponseState(this.followupInquiryByCustomerIDResponse);
}

class FollowupUploadImageCallResponseState extends FollowupStates {
  final FollowupImageUploadResponse followupImageUploadResponse;

  FollowupUploadImageCallResponseState(this.followupImageUploadResponse);
}
class FollowupImageDeleteCallResponseState extends FollowupStates {
  final FollowupDeleteImageResponse followupDeleteImageResponse;

  FollowupImageDeleteCallResponseState(this.followupDeleteImageResponse);
}
class FollowupTypeListCallResponseState extends FollowupStates {
  final FollowupTypeListResponse followupTypeListResponse;

  FollowupTypeListCallResponseState(this.followupTypeListResponse);
}

class InquiryLeadStatusListCallResponseState extends FollowupStates {
  final InquiryStatusListResponse inquiryStatusListResponse;

  InquiryLeadStatusListCallResponseState(this.inquiryStatusListResponse);
}

class CloserReasonListCallResponseState extends FollowupStates {
  final CloserReasonListResponse closerReasonListResponse;

  CloserReasonListCallResponseState(this.closerReasonListResponse);
}


class FollowupHistoryListResponseState extends FollowupStates {
  final FollowupHistoryListResponse followupHistoryListResponse;

  FollowupHistoryListResponseState(this.followupHistoryListResponse);
}


class QuickFollowupListResponseState extends FollowupStates {
  final QuickFollowupListResponse quickFollowupListResponse;

  QuickFollowupListResponseState(this.quickFollowupListResponse);
}