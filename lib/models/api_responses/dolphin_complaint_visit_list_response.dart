class DolphinComplaintVisitListResponse {
  List<DolphinComplaintVisitDetails> details;
  int totalCount;

  DolphinComplaintVisitListResponse({this.details, this.totalCount});

  DolphinComplaintVisitListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new DolphinComplaintVisitDetails.fromJson(v));
      });
    }
    totalCount = json['TotalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    data['TotalCount'] = this.totalCount;
    return data;
  }
}

class DolphinComplaintVisitDetails {
  int rowNum;
  int pkID;
  int complaintNo;
  String complaintNoString;
  String complaintDate;
  String complaintStatus;
  int customerID;
  String customerName;
  String preferredDate;
  String preferredTimeFrom;
  String preferredTimeTo;
  String visitDate;
  String timeFrom;
  String timeTo;
  String visitType;
  String visitChargeType;
  double visitCharge;
  String solutionType;
  String serviceType;
  String machineSRNo;
  String problemType;
  String partName;
  String faultyPartSRNo;
  String newPartSRNo;
  String problemNotes;
  String visitNotes;
  int employeeID;
  String employeeName;
  String visitDocument;
  String createdBy;
  String createdDate;
  String createdByEmployee;

  DolphinComplaintVisitDetails(
      {this.rowNum,
        this.pkID,
        this.complaintNo,
        this.complaintNoString,
        this.complaintDate,
        this.complaintStatus,
        this.customerID,
        this.customerName,
        this.preferredDate,
        this.preferredTimeFrom,
        this.preferredTimeTo,
        this.visitDate,
        this.timeFrom,
        this.timeTo,
        this.visitType,
        this.visitChargeType,
        this.visitCharge,
        this.solutionType,
        this.serviceType,
        this.machineSRNo,
        this.problemType,
        this.partName,
        this.faultyPartSRNo,
        this.newPartSRNo,
        this.problemNotes,
        this.visitNotes,
        this.employeeID,
        this.employeeName,
        this.visitDocument,
        this.createdBy,
        this.createdDate,
        this.createdByEmployee});

  DolphinComplaintVisitDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum']==null?0:json['RowNum'];
    pkID = json['pkID']==null?0:json['pkID'];
    complaintNo = json['ComplaintNo']==null?0:json['ComplaintNo'];
    complaintNoString = json['ComplaintNoString']==null?"":json['ComplaintNoString'];
    complaintDate = json['ComplaintDate']==null?"":json['ComplaintDate'];
    complaintStatus = json['ComplaintStatus']==null?"":json['ComplaintStatus'];
    customerID = json['CustomerID']==null?0:json['CustomerID'];
    customerName = json['CustomerName']==null?"":json['CustomerName'];
    preferredDate = json['PreferredDate']==null?"":json['PreferredDate'];
    preferredTimeFrom = json['PreferredTimeFrom']==null?"":json['PreferredTimeFrom'];
    preferredTimeTo = json['PreferredTimeTo']==null?"":json['PreferredTimeTo'];
    visitDate = json['VisitDate']==null?"":json['VisitDate'];
    timeFrom = json['TimeFrom']==null?"":json['TimeFrom'];
    timeTo = json['TimeTo']==null?"":json['TimeTo'];
    visitType = json['VisitType']==null?"":json['VisitType'];
    visitChargeType = json['VisitChargeType']==null?"":json['VisitChargeType'];
    visitCharge = json['VisitCharge']==null?0.00:json['VisitCharge'];
    solutionType = json['SolutionType']==null?"":json['SolutionType'];
    serviceType = json['ServiceType']==null?"":json['ServiceType'];
    machineSRNo = json['MachineSRNo']==null?"":json['MachineSRNo'];
    problemType = json['ProblemType']==null?"":json['ProblemType'];
    partName = json['PartName']==null?"":json['PartName'];
    faultyPartSRNo = json['FaultyPartSRNo']==null?"":json['FaultyPartSRNo'];
    newPartSRNo = json['NewPartSRNo']==null?"":json['NewPartSRNo'];
    problemNotes = json['ProblemNotes']==null?"":json['ProblemNotes'];
    visitNotes = json['VisitNotes']==null?"":json['VisitNotes'];
    employeeID = json['EmployeeID']==null?0:json['EmployeeID'];
    employeeName = json['EmployeeName']==null?"":json['EmployeeName'];
    visitDocument = json['VisitDocument']==null?"":json['VisitDocument'];
    createdBy = json['CreatedBy']==null?"":json['CreatedBy'];
    createdDate = json['CreatedDate']==null?"":json['CreatedDate'];
    createdByEmployee = json['CreatedByEmployee']==null?"":json['CreatedByEmployee'];



    /*if(json['CreatedByEmployee']==null)
      {
        createdByEmployee = "";
      }
    else{
      createdByEmployee = json['CreatedByEmployee'];
    }*/



  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['ComplaintNo'] = this.complaintNo;
    data['ComplaintNoString'] = this.complaintNoString;
    data['ComplaintDate'] = this.complaintDate;
    data['ComplaintStatus'] = this.complaintStatus;
    data['CustomerID'] = this.customerID;
    data['CustomerName'] = this.customerName;
    data['PreferredDate'] = this.preferredDate;
    data['PreferredTimeFrom'] = this.preferredTimeFrom;
    data['PreferredTimeTo'] = this.preferredTimeTo;
    data['VisitDate'] = this.visitDate;
    data['TimeFrom'] = this.timeFrom;
    data['TimeTo'] = this.timeTo;
    data['VisitType'] = this.visitType;
    data['VisitChargeType'] = this.visitChargeType;
    data['VisitCharge'] = this.visitCharge;
    data['SolutionType'] = this.solutionType;
    data['ServiceType'] = this.serviceType;
    data['MachineSRNo'] = this.machineSRNo;
    data['ProblemType'] = this.problemType;
    data['PartName'] = this.partName;
    data['FaultyPartSRNo'] = this.faultyPartSRNo;
    data['NewPartSRNo'] = this.newPartSRNo;
    data['ProblemNotes'] = this.problemNotes;
    data['VisitNotes'] = this.visitNotes;
    data['EmployeeID'] = this.employeeID;
    data['EmployeeName'] = this.employeeName;
    data['VisitDocument'] = this.visitDocument;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['CreatedByEmployee'] = this.createdByEmployee;
    return data;
  }
}