class LeaveApprovalSaveAPIRequest {
  String ApprovalStatus;
  String LoginUserID;
  int CompanyId;

  LeaveApprovalSaveAPIRequest({ this.ApprovalStatus,this.LoginUserID,this.CompanyId});

  LeaveApprovalSaveAPIRequest.fromJson(Map<String, dynamic> json) {
    ApprovalStatus = json['ApprovalStatus'];
    LoginUserID = json['LoginUserId'];
    CompanyId = json['CompanyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ApprovalStatus'] = this.ApprovalStatus;
    data['LoginUserId'] = this.LoginUserID;
    data['CompanyId'] = this.CompanyId;

    return data;
  }
}

/*pkID:
ApprovalStatus:Rejected
LoginUserID:admin
Reason:
CompanyId:10032*/