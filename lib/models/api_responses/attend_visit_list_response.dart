class AttendVisitListResponse {
  List<AttendVisitDetails> details;
  int totalCount;

  AttendVisitListResponse({this.details, this.totalCount});

  AttendVisitListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new AttendVisitDetails.fromJson(v));
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

class AttendVisitDetails {
  int rowNum;
  int pkID;
  int visitID;
  String complaintNo;
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
  String visitNotes;
  int employeeID;
  String employeeName;
  String createdBy;
  String createdDate;
  String updatedBy;
  String updatedDate;

  AttendVisitDetails(
      {this.rowNum,
        this.pkID,
        this.complaintNo,
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
        this.visitNotes,
        this.employeeID,
        this.employeeName,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate});

  AttendVisitDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum']==null?0:json['RowNum'];
    pkID = json['pkID']==null?0:json['pkID'];
    visitID = json['VisitID']==null?0:json['VisitID'];
    complaintNo = json['ComplaintNo']==null?"":json['ComplaintNo'];
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
    visitNotes = json['VisitNotes']==null?"":json['VisitNotes'];
    employeeID = json['EmployeeID']==null?0:json['EmployeeID'];
    employeeName = json['EmployeeName']==null?"":json['EmployeeName'];
    createdBy = json['CreatedBy']==null?"":json['CreatedBy'];
    createdDate = json['CreatedDate']==null?"":json['CreatedDate'];
    updatedBy = json['UpdatedBy']==null?"":json['UpdatedBy'];
    updatedDate = json['UpdatedDate']==null?"":json['UpdatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['VisitID'] =this.visitID;
    data['ComplaintNo'] = this.complaintNo;
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
    data['VisitNotes'] = this.visitNotes;
    data['EmployeeID'] = this.employeeID;
    data['EmployeeName'] = this.employeeName;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedBy'] = this.updatedBy;
    data['UpdatedDate'] = this.updatedDate;
    return data;
  }
}