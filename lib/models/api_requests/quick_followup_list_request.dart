class QuickFollowupListRequest {
 // String FollowupDate;
  String CompanyId;
  String FollowupStatus;

  QuickFollowupListRequest({/*this.FollowupDate,*/this.CompanyId,this.FollowupStatus});

  QuickFollowupListRequest.fromJson(Map<String, dynamic> json) {
   // FollowupDate = json['FollowupDate'];
    CompanyId = json['CompanyId'];
    FollowupStatus = json['FollowupStatus'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['FollowupDate'] = this.FollowupDate;
    data['CompanyId'] = this.CompanyId;
    data['FollowupStatus'] = this.FollowupStatus;

    return data;
  }
}