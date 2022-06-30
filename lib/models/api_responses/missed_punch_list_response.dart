class MissedPunchListResponse {
  List<MissedPunchDetails> details;
  int totalCount;

  MissedPunchListResponse({this.details, this.totalCount});

  MissedPunchListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new MissedPunchDetails.fromJson(v));
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

class MissedPunchDetails {
  int rowNum;
  int pkID;
  int employeeID;
  String employeeName;
  String presenceDate;
  String timeIn;
  String timeOut;
  String notes;
  String approvalStatus;
  String approvedBy;
  String approvedOn;
  String createdBy;
  String createdDate;
  String updatedBy;
  String updatedDate;

  MissedPunchDetails(
      {this.rowNum,
        this.pkID,
        this.employeeID,
        this.employeeName,
        this.presenceDate,
        this.timeIn,
        this.timeOut,
        this.notes,
        this.approvalStatus,
        this.approvedBy,
        this.approvedOn,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate});

  MissedPunchDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum']==null?0:json['RowNum'];
    pkID = json['pkID']==null?0:json['pkID'];
    employeeID = json['EmployeeID']==null?0:json['EmployeeID'];
    employeeName = json['EmployeeName']==null?"":json['EmployeeName'];
    presenceDate = json['PresenceDate']==null?"":json['PresenceDate'];
    timeIn = json['TimeIn']==null?"":json['TimeIn'];
    timeOut = json['TimeOut']==null?"":json['TimeOut'];
    notes = json['Notes']==null?"":json['Notes'];
    approvalStatus = json['ApprovalStatus']==null?"":json['ApprovalStatus'];
    approvedBy = json['ApprovedBy']==null?"":json['ApprovedBy'];
    approvedOn = json['ApprovedOn']==null?"":json['ApprovedOn'];
    createdBy = json['CreatedBy']==null?"":json['CreatedBy'];
    createdDate = json['CreatedBy']==null?"":json['CreatedBy'];
    updatedBy = json['UpdatedBy']==null?"":json['UpdatedBy'];
    updatedDate = json['UpdatedDate']==null?"":json['UpdatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['EmployeeID'] = this.employeeID;
    data['EmployeeName'] = this.employeeName;
    data['PresenceDate'] = this.presenceDate;
    data['TimeIn'] = this.timeIn;
    data['TimeOut'] = this.timeOut;
    data['Notes'] = this.notes;
    data['ApprovalStatus'] = this.approvalStatus;
    data['ApprovedBy'] = this.approvedBy;
    data['ApprovedOn'] = this.approvedOn;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedBy'] = this.updatedBy;
    data['UpdatedDate'] = this.updatedDate;
    return data;
  }
}