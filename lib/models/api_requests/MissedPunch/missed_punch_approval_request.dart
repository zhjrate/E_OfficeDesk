/*ApprovalStatus:
LoginUserID:admin
CompanyId:10032
pkID:*/

class MissedPunchApprovalListRequest {
  String ApprovalStatus;

  String LoginUserID;
  int CompanyId;

  /*pkID:
LoginUserID:admin
PageNo:1
PageSize:100
CompanyId:10032*/

  MissedPunchApprovalListRequest(
      {this.ApprovalStatus, this.LoginUserID, this.CompanyId});

  MissedPunchApprovalListRequest.fromJson(Map<String, dynamic> json) {
    ApprovalStatus = json['ApprovalStatus'];
    LoginUserID = json['LoginUserID'];
    CompanyId = json['CompanyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ApprovalStatus'] = this.ApprovalStatus;
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
