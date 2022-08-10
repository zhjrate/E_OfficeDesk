
class MissedPunchApprovalSaveRequest {
  String ApprovalStatus;
  String LoginUserID;
  int CompanyId;

  MissedPunchApprovalSaveRequest(
      {this.ApprovalStatus, this.LoginUserID, this.CompanyId});

  MissedPunchApprovalSaveRequest.fromJson(Map<String, dynamic> json) {
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
