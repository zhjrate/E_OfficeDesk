/*ApprovalStatus:
LoginUserID:admin
CompanyId:10032
pkID:*/

class LoanApprovalListRequest {
  String pkID;
  String ApprovalStatus;

  String LoginUserID;
  int CompanyId;

  /*pkID:
LoginUserID:admin
PageNo:1
PageSize:100
CompanyId:10032*/

  LoanApprovalListRequest({this.pkID, this.ApprovalStatus,this.LoginUserID,this.CompanyId});

  LoanApprovalListRequest.fromJson(Map<String, dynamic> json) {
    pkID = json['pkID'];
    ApprovalStatus = json['ApprovalStatus'];
    LoginUserID = json['LoginUserID'];
    CompanyId = json['CompanyId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkID'] = this.pkID;
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