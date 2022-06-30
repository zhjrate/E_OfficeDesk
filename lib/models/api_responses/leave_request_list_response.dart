class LeaveRequestListResponse {
  List<LeaveRequestDetails> details;
  int totalCount;

  LeaveRequestListResponse({this.details, this.totalCount});

  LeaveRequestListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new LeaveRequestDetails.fromJson(v));
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

class LeaveRequestDetails {
  int rowNum;
  int pkID;
  int employeeID;
  String employeeName;
  String fromDate;
  String toDate;
  String reasonForLeave;
  String approvalStatus;
  String approvedBy;
  String approvedOn;
  String createdBy;
  String createdDate;
  String updatedBy;
  String updatedDate;
  String leaveType;
  int leaveTypeID;

  LeaveRequestDetails(
      {this.rowNum,
        this.pkID,
        this.employeeID,
        this.employeeName,
        this.fromDate,
        this.toDate,
        this.reasonForLeave,
        this.approvalStatus,
        this.approvedBy,
        this.approvedOn,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate,
        this.leaveType,
        this.leaveTypeID,
      });

  LeaveRequestDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum'] == null ? 0 : json['RowNum'];
    pkID = json['pkID'] == null ? 0 : json['pkID'];
    employeeID = json['EmployeeID']  == null ? 0 : json['EmployeeID'];
    employeeName = json['EmployeeName'] == null ? "" : json['EmployeeName'];
    fromDate = json['FromDate'] == null ? "" : json['FromDate'];
    toDate = json['ToDate'] == null ? "" : json['ToDate'];
    reasonForLeave = json['ReasonForLeave'] == null ? "" : json['ReasonForLeave'];
    approvalStatus = json['ApprovalStatus'] == null ? "" : json['ApprovalStatus'];
    approvedBy = json['ApprovedBy'] == null ? "" : json['ApprovedBy'];
    approvedOn = json['ApprovedOn'] == null ? "" : json['ApprovedOn'];
    createdBy = json['CreatedBy'] == null ? "" : json['CreatedBy'];
    createdDate = json['CreatedDate'] == null ? "" : json['CreatedDate'];
    updatedBy = json['UpdatedBy']  == null ? "" : json['UpdatedBy'];
    updatedDate = json['UpdatedDate'] == null ? "" : json['UpdatedDate'];
    leaveType = json['LeaveType'] == null ? "" : json['LeaveType'];
    leaveTypeID = json['LeaveTypeID']  == null ? 0 : json['LeaveTypeID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['EmployeeID'] = this.employeeID;
    data['EmployeeName'] = this.employeeName;
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    data['ReasonForLeave'] = this.reasonForLeave;
    data['ApprovalStatus'] = this.approvalStatus;
    data['ApprovedBy'] = this.approvedBy;
    data['ApprovedOn'] = this.approvedOn;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedBy'] = this.updatedBy;
    data['UpdatedDate'] = this.updatedDate;
    data['LeaveType'] = this.leaveType;
    data['LeaveTypeID'] = this.leaveTypeID;

    return data;
  }
}