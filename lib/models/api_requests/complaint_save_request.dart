class ComplaintSaveRequest {
  /*ComplaintDate:2022-02-07
ComplaintNo:
CustomerID:20431
ReferenceNo:123987
ComplaintNotes:Test For Complaint No Retrive On Web
ComplaintType:Online
ComplaintStatus:Open
EmployeeID:51
PreferredDate:2022-01-10
TimeFrom:10:00 Am
TimeTo:11:00 AM
LoginUserID:admin
CompanyId:10032*/
  String ComplaintDate;
  String ComplaintNo;
  String CustomerID;
  String ReferenceNo;
  String ComplaintNotes;
  String ComplaintType;
  String ComplaintStatus;
  String EmployeeID;
  String PreferredDate;
  String TimeFrom;
  String TimeTo;
  String LoginUserID;
  String CompanyId;

  ComplaintSaveRequest({
    this.ComplaintDate,
    this.ComplaintNo,
    this.CustomerID,
    this.ReferenceNo,
    this.ComplaintNotes,
    this.ComplaintType,
    this.ComplaintStatus,
    this.EmployeeID,
    this.PreferredDate,
    this.TimeFrom,
    this.TimeTo,
    this.LoginUserID,
    this.CompanyId});


  ComplaintSaveRequest.fromJson(Map<String, dynamic> json) {


    ComplaintDate   = json['ComplaintDate'];
    ComplaintNo     = json['ComplaintNo'];
    CustomerID      = json['CustomerID'];
    ReferenceNo     = json['ReferenceNo'];
    ComplaintNotes  = json['ComplaintNotes'];
    ComplaintType   = json['ComplaintType'];
    ComplaintStatus = json['ComplaintStatus'];
    EmployeeID      = json['EmployeeID'];
    PreferredDate   = json['PreferredDate'];
    TimeFrom        = json['TimeFrom'];
    TimeTo          = json['TimeTo'];
    LoginUserID     = json['LoginUserID'];
    CompanyId       = json['CompanyId'];



  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['ComplaintDate'] = this.ComplaintDate;
    data['ComplaintNo'] = this.ComplaintNo;
    data['CustomerID'] = this.CustomerID;
    data['ReferenceNo'] = this.ReferenceNo;
    data['ComplaintNotes'] = this.ComplaintNotes;
    data['ComplaintType'] = this.ComplaintType;
    data['ComplaintStatus'] = this.ComplaintStatus;
    data['EmployeeID'] = this.EmployeeID;
    data['PreferredDate'] = this.PreferredDate;
    data['TimeFrom'] = this.TimeFrom;
    data['TimeTo'] = this.TimeTo;
    data['LoginUserID'] = this.LoginUserID;
    data['CompanyId'] = this.CompanyId;

    return data;
  }
}