class LoanApprovalSaveRequest {
  String ApprovalStatus;
  String LoginUserID;
  String CompanyID;

  LoanApprovalSaveRequest(
      {this.ApprovalStatus, this.LoginUserID, this.CompanyID});

  LoanApprovalSaveRequest.fromJson(Map<String, dynamic> json) {
    ApprovalStatus = json['ApprovalStatus'];
    LoginUserID = json['LoginUserID'];
    CompanyID = json['CompanyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ApprovalStatus'] = this.ApprovalStatus;
    data['LoginUserID'] = this.LoginUserID;
    data['CompanyId'] = this.CompanyID;

    return data;
  }
}
