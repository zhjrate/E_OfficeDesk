part of 'followup_bloc.dart';


@immutable
abstract class FollowupEvents {}

///all events of AuthenticationEvents
class FollowupListCallEvent extends FollowupEvents {
  final int pageNo;
  final FollowupListApiRequest followupListApiRequest;
  FollowupListCallEvent(this.pageNo,this.followupListApiRequest);
}

class SearchFollowupListByNameCallEvent extends FollowupEvents {
  final SearchFollowupListByNameRequest request;

  SearchFollowupListByNameCallEvent(this.request);
}



class SearchFollowupCustomerListByNameCallEvent extends FollowupEvents {
  final CustomerLabelValueRequest request;

  SearchFollowupCustomerListByNameCallEvent(this.request);
}





class FollowupInquiryNoListByNameCallEvent extends FollowupEvents {
  final FollowerInquiryNoListRequest followerInquiryNoListRequest;

  FollowupInquiryNoListByNameCallEvent(this.followerInquiryNoListRequest);
}

class FollowupSaveByNameCallEvent extends FollowupEvents {
  final int pkID;
  final BuildContext context;
  final FollowupSaveApiRequest followupSaveApiRequest;
  final String Msg;
  FollowupSaveByNameCallEvent(this.Msg,this.context,this.pkID,this.followupSaveApiRequest);
}

class QuickFollowupSaveByNameCallEvent extends FollowupEvents {
  final int pkID;
  final BuildContext context;
  final FollowupSaveApiRequest followupSaveApiRequest;
  final String Msg;
  QuickFollowupSaveByNameCallEvent(this.Msg,this.context,this.pkID,this.followupSaveApiRequest);
}



class FollowupDeleteByNameCallEvent extends FollowupEvents {
  final int pkID;

  final FollowupDeleteRequest followupDeleteRequest;

  FollowupDeleteByNameCallEvent(this.pkID,this.followupDeleteRequest);
}


class QuickFollowupDeleteByNameCallEvent extends FollowupEvents {
  final int pkID;

  final FollowupDeleteRequest followupDeleteRequest;

  QuickFollowupDeleteByNameCallEvent(this.pkID,this.followupDeleteRequest);
}

class FollowupFilterListCallEvent extends FollowupEvents {

  String filtername;
  final FollowupFilterListRequest followupFilterListRequest;

  FollowupFilterListCallEvent(this.filtername,this.followupFilterListRequest);
}

class FollowupInquiryByCustomerIDCallEvent extends FollowupEvents {

  final FollowerInquiryByCustomerIDRequest followerInquiryByCustomerIDRequest;

  FollowupInquiryByCustomerIDCallEvent(this.followerInquiryByCustomerIDRequest);
}

class FollowupUploadImageNameCallEvent extends FollowupEvents {

  final File expenseImageFile;
  final FollowUpUploadImageAPIRequest expenseUploadImageAPIRequest;

  FollowupUploadImageNameCallEvent(this.expenseImageFile,this.expenseUploadImageAPIRequest);
}

class FollowupImageDeleteCallEvent extends FollowupEvents {
  final int pkID;

  final FollowupImageDeleteRequest followupImageDeleteRequest;

  FollowupImageDeleteCallEvent(this.pkID,this.followupImageDeleteRequest);
}

class FollowupTypeListByNameCallEvent extends FollowupEvents {
  final FollowupTypeListRequest followupTypeListRequest;

  FollowupTypeListByNameCallEvent(this.followupTypeListRequest);
}

class InquiryLeadStatusTypeListByNameCallEvent extends FollowupEvents {
  final FollowupInquiryStatusTypeListRequest followupInquiryStatusTypeListRequest;

  InquiryLeadStatusTypeListByNameCallEvent(this.followupInquiryStatusTypeListRequest);
}

class CloserReasonTypeListByNameCallEvent extends FollowupEvents {
  final CloserReasonTypeListRequest closerReasonTypeListRequest;

  CloserReasonTypeListByNameCallEvent(this.closerReasonTypeListRequest);
}
class FollowupHistoryListRequestCallEvent extends FollowupEvents {
  final FollowupHistoryListRequest followupHistoryListRequest;

  FollowupHistoryListRequestCallEvent(this.followupHistoryListRequest);
}

class QuickFollowupListRequestEvent extends FollowupEvents {
  final QuickFollowupListRequest quickFollowupListRequest;

  QuickFollowupListRequestEvent(this.quickFollowupListRequest);
}
