class FollowupFilterListRequest {
  String CompanyId;
  String LoginUserID;
  int PageNo;
  int PageSize;

  FollowupFilterListRequest({this.CompanyId,this.LoginUserID,this.PageNo,this.PageSize});

  FollowupFilterListRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    LoginUserID = json['LoginUserID'];
    PageNo = json['PageNo'];
    PageSize = json['PageSize'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['LoginUserID'] = this.LoginUserID;
    data['PageNo'] = this.PageNo;
    data['PageSize'] = this.PageSize;


    return data;
  }
}