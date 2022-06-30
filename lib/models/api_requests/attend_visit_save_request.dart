/*ComplaintNo:10057
CustomerID:4
VisitDate:2022-02-07
TimeFrom:8:54 PM
TimeTo:9:25 PM
VisitNotes:Test From Home For Complaint Visit
VisitType:Charged
VisitChargeType:Cash
VisitCharge:1200
ComplaintStatus:Close
LoginUserID:admin
CompanyId:10032*/

class AttendVisitSaveRequest {

  String ComplaintNo;
  String CustomerID;
  String VisitDate;
  String TimeFrom;
  String TimeTo;
  String VisitNotes;
  String VisitType;
  String VisitChargeType;
  String VisitCharge;
  String ComplaintStatus;
  String LoginUserID;
  String CompanyId;

  AttendVisitSaveRequest({
    this.VisitDate,
    this.ComplaintNo,
    this.CustomerID,
    this.VisitChargeType,
    this.VisitNotes,
    this.VisitType,
    this.ComplaintStatus,
    this.VisitCharge,
    this.TimeFrom,
    this.TimeTo,
    this.LoginUserID,
    this.CompanyId});


  AttendVisitSaveRequest.fromJson(Map<String, dynamic> json) {


    VisitDate   = json['VisitDate'];
    ComplaintNo     = json['ComplaintNo'];
    CustomerID      = json['CustomerID'];
    VisitChargeType     = json['VisitChargeType'];
    VisitNotes  = json['VisitNotes'];
    VisitType   = json['VisitType'];
    ComplaintStatus = json['ComplaintStatus'];
    VisitCharge      = json['VisitCharge'];
    TimeFrom        = json['TimeFrom'];
    TimeTo          = json['TimeTo'];
    LoginUserID     = json['LoginUserID'];
    CompanyId       = json['CompanyId'];



  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['VisitDate'] = this.VisitDate;
    data['ComplaintNo'] = this.ComplaintNo;
    data['CustomerID'] = this.CustomerID;
    data['VisitChargeType'] = this.VisitChargeType;
    data['VisitNotes'] = this.VisitNotes;
    data['VisitType'] = this.VisitType;
    data['ComplaintStatus'] = this.ComplaintStatus;
    data['VisitCharge'] = this.VisitCharge;
    data['TimeFrom'] = this.TimeFrom;
    data['TimeTo'] = this.TimeTo;
    data['LoginUserID'] = this.LoginUserID;
    data['CompanyId'] = this.CompanyId;

    return data;
  }
}