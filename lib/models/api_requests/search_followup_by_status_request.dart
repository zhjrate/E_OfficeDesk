class SearchFollowupListByNameRequest {
  String FollowupStatus;
  String  FollowupStatusID;
  String SearchKey;
  String Month;
  String Year;
  String CompanyId;
  String LoginUserID;

  SearchFollowupListByNameRequest({this.FollowupStatus, this.FollowupStatusID = "",this.SearchKey,this.Month,this.Year,this.CompanyId,this.LoginUserID});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FollowupStatus'] = this.FollowupStatus;
    data['FollowupStatusID'] = this.FollowupStatusID;
    data['SearchKey'] = this.SearchKey;
    data['Month'] = this.Month;
    data['Year'] = this.Year;
    data['CompanyId'] = this.CompanyId;
    data['LoginUserID'] = this.LoginUserID;

    return data;
  }
}
