class LeaveRequestListAPIRequest {
 /* String pkID;
  String ApprovalStatus;
  String Reason;
  String LoginUserID;
  int CompanyId;*/
  /*EmployeeID:51
ApprovalStatus:Approved
Month:
Year:
CompanyId:10032*/

  String EmployeeID;
  String ApprovalStatus;
  String Month;
  String Year;
  int CompanyId;

  LeaveRequestListAPIRequest({this.EmployeeID, this.ApprovalStatus,this.Month,this.Year,this.CompanyId});

  LeaveRequestListAPIRequest.fromJson(Map<String, dynamic> json) {
    EmployeeID = json['EmployeeID'];
    ApprovalStatus = json['ApprovalStatus'];
    Month = json['Month'];
    Year = json['Year'];
    CompanyId = json['CompanyId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeID'] = this.EmployeeID;
    data['ApprovalStatus'] = this.ApprovalStatus;
    data['Month'] = this.Month;
    data['Year'] = this.Year;
    data['CompanyId'] = this.CompanyId;

    return data;
  }
}

/*pkID:
ApprovalStatus:Rejected
LoginUserID:admin
Reason:
CompanyId:10032*/