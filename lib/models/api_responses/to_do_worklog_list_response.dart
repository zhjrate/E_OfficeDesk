class ToDoWorkLogListResponse {
  List<WorkLogDetails> details;
  int totalCount;

  ToDoWorkLogListResponse({this.details, this.totalCount});

  ToDoWorkLogListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new WorkLogDetails.fromJson(v));
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

class WorkLogDetails {
  int rowNum;
  int pkID;
  int headerID;
  String remarks;
  String actionTaken;
  String actionDescription;
  int employeeID;
  String employeeName;
  String createdBy;
  String fromEmployeeName;
  String createdDate;

  WorkLogDetails(
      {this.rowNum,
        this.pkID,
        this.headerID,
        this.remarks,
        this.actionTaken,
        this.actionDescription,
        this.employeeID,
        this.employeeName,
        this.createdBy,
        this.fromEmployeeName,
        this.createdDate});

  WorkLogDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum'];
    pkID = json['pkID'];
    headerID = json['HeaderID'];
    remarks = json['Remarks'];
    actionTaken = json['ActionTaken'];
    actionDescription = json['ActionDescription'];
    employeeID = json['EmployeeID'];
    employeeName = json['EmployeeName'];
    createdBy = json['CreatedBy'];
    fromEmployeeName = json['FromEmployeeName'];
    createdDate = json['CreatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['HeaderID'] = this.headerID;
    data['Remarks'] = this.remarks;
    data['ActionTaken'] = this.actionTaken;
    data['ActionDescription'] = this.actionDescription;
    data['EmployeeID'] = this.employeeID;
    data['EmployeeName'] = this.employeeName;
    data['CreatedBy'] = this.createdBy;
    data['FromEmployeeName'] = this.fromEmployeeName;
    data['CreatedDate'] = this.createdDate;
    return data;
  }
}