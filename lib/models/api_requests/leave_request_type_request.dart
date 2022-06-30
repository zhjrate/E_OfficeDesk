class LeaveRequestTypeAPIRequest {
  String pkID;
  String PageNo;
  String PageSize;
  String LoginUserID;
  int CompanyId;

  /*pkID:
LoginUserID:admin
PageNo:1
PageSize:100
CompanyId:10032*/

  LeaveRequestTypeAPIRequest({this.pkID, this.PageNo,this.PageSize,this.LoginUserID,this.CompanyId});

  LeaveRequestTypeAPIRequest.fromJson(Map<String, dynamic> json) {
    pkID = json['pkID'];
    PageNo = json['PageNo'];
    PageSize = json['PageSize'];
    LoginUserID = json['LoginUserID'];
    CompanyId = json['CompanyId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkID'] = this.pkID;
    data['PageNo'] = this.PageNo;
    data['PageSize'] = this.PageSize;
    data['LoginUserID'] = this.LoginUserID;
    data['CompanyId'] = this.CompanyId;

    return data;
  }
}

/*pkID:
ApprovalStatus:Rejected
LoginUserID:admin
Reason:
CompanyId:10032*/