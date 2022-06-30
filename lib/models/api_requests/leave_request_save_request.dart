class LeaveRequestSaveAPIRequest {
  String CompanyId;
  String EmployeeID;
  String LeaveTypeID;
  String FromDate;
  String ToDate;
  String ReasonForLeave;
  String LoginUserID;
  String shouldmail;





  LeaveRequestSaveAPIRequest({this.CompanyId, this.EmployeeID,this.LeaveTypeID,this.FromDate,this.ToDate,this.ReasonForLeave,this.LoginUserID,this.shouldmail
  });

  LeaveRequestSaveAPIRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    EmployeeID = json['EmployeeID'];
    LeaveTypeID = json['LeaveTypeID'];
    FromDate = json['FromDate'];
    ToDate = json['ToDate'];
    ReasonForLeave = json['ReasonForLeave'];
    LoginUserID = json['LoginUserID'];
    shouldmail = json['shouldmail'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['EmployeeID'] = this.EmployeeID;
    data['LeaveTypeID'] = this.LeaveTypeID;
    data['FromDate'] = this.FromDate;
    data['ToDate'] = this.ToDate;
    data['ReasonForLeave'] = this.ReasonForLeave;
    data['LoginUserID'] = this.LoginUserID;
    data['shouldmail'] = this.shouldmail;

    return data;
  }
}
