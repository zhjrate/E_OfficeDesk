class DolphinComplaintVisitSaveRequest {
  String ComplaintNo;
  String CustomerID;
  String VisitDate;
  String TimeFrom;
  String TimeTo;
  String VisitNotes;
  String VisitType;
  String PartName;
  String VisitChargeType;
  String VisitCharge;
  String ComplaintStatus;
  String SolutionType;
  String ServiceType;
  String MachineSRNo;
  String ProblemType;
  String FaultyPartSRNo;
  String NewPartSRNo;
  String ProblemNotes;
  String VisitDocument;
  String LoginUserID;
  String CompanyId;

  DolphinComplaintVisitSaveRequest(
      {this.ComplaintNo,
      this.CustomerID,
      this.VisitDate,
      this.TimeFrom,
      this.TimeTo,
      this.VisitNotes,
      this.VisitType,
      this.PartName,
      this.VisitChargeType,
      this.VisitCharge,
      this.ComplaintStatus,
      this.SolutionType,
      this.ServiceType,
      this.MachineSRNo,
      this.ProblemType,
      this.FaultyPartSRNo,
      this.NewPartSRNo,
      this.ProblemNotes,
      this.VisitDocument,
      this.LoginUserID,
      this.CompanyId});

  DolphinComplaintVisitSaveRequest.fromJson(Map<String, dynamic> json) {
   
    ComplaintNo = json['ComplaintNo'];
    CustomerID = json['CustomerID'];
    VisitDate = json['VisitDate'];
    TimeFrom = json['TimeFrom'];
    TimeTo = json['TimeTo'];
    VisitNotes = json['VisitNotes'];
    VisitType = json['VisitType'];
    PartName = json['PartName'];
    VisitChargeType = json['VisitChargeType'];
    VisitCharge = json['VisitCharge'];
    ComplaintStatus = json['ComplaintStatus'];
    SolutionType = json['SolutionType'];
    ServiceType = json['ServiceType'];
    MachineSRNo = json['MachineSRNo'];
    ProblemType = json['ProblemType'];
    FaultyPartSRNo = json['FaultyPartSRNo'];
    NewPartSRNo = json['NewPartSRNo'];
    ProblemNotes = json['ProblemNotes'];
    VisitDocument = json['VisitDocument'];
    LoginUserID = json['LoginUserID'];
    CompanyId = json['CompanyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ComplaintNo'] = this.ComplaintNo;
    data['CustomerID'] = this.CustomerID;
    data['VisitDate'] = this.VisitDate;
    data['TimeFrom'] = this.TimeFrom;
    data['TimeTo'] = this.TimeTo;
    data['VisitNotes'] = this.VisitNotes;
    data['VisitType'] = this.VisitType;
    data['PartName'] = this.PartName;
    data['VisitChargeType'] = this.VisitChargeType;
    data['VisitCharge'] = this.VisitCharge;
    data['ComplaintStatus'] = this.ComplaintStatus;
    data['SolutionType'] = this.SolutionType;
    data['ServiceType'] = this.ServiceType;
    data['MachineSRNo'] = this.MachineSRNo;
    data['ProblemType'] = this.ProblemType;
    data['FaultyPartSRNo'] = this.FaultyPartSRNo;
    data['NewPartSRNo'] = this.NewPartSRNo;
    data['ProblemNotes'] = this.ProblemNotes;
    data['VisitDocument'] = this.VisitDocument;
    data['LoginUserID'] = this.LoginUserID;
    data['CompanyId'] = this.CompanyId;

    return data;
  }
}
