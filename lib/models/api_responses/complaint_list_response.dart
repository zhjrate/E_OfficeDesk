class ComplaintListResponse {
  List<ComplaintDetails> details;
  int totalCount;

  ComplaintListResponse({this.details, this.totalCount});

  ComplaintListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new ComplaintDetails.fromJson(v));
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

class ComplaintDetails {
  int rowNum;
  int pkID;
  String complaintNo;
  String complaintDate;
  String referenceNo;
  String complaintStatus;
  String complaintType;
  int customerID;
  String customerName;
  String complaintNotes;
  int employeeID;
  String employeeName;
  String preferredDate;
  String timeFrom;
  String timeTo;
  String createdBy;
  String createdDate;
  String updatedBy;
  String updatedDate;


  ComplaintDetails(
      {this.rowNum,
        this.pkID,
        this.complaintNo,
        this.complaintDate,
        this.referenceNo,
        this.complaintStatus,
        this.complaintType,
        this.customerID,
        this.customerName,
        this.complaintNotes,
        this.employeeID,
        this.employeeName,
        this.preferredDate,
        this.timeFrom,
        this.timeTo,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate});

  ComplaintDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum']==null?0:json['RowNum'];
    pkID = json['pkID']==null?0:json['pkID'];
    complaintNo = json['ComplaintNo']==null?"":json['ComplaintNo'];
    complaintDate = json['ComplaintDate']==null?"":json['ComplaintDate'];
    referenceNo = json['ReferenceNo']==null?"":json['ReferenceNo'];
    complaintStatus = json['ComplaintStatus']==null?"":json['ComplaintStatus'];
    complaintType = json['ComplaintType']==null?"":json['ComplaintType'];
    customerID = json['CustomerID']==null?0:json['CustomerID'];
    customerName = json['CustomerName']==null?"":json['CustomerName'];
    complaintNotes = json['ComplaintNotes']==null?"":json['ComplaintNotes'];
    employeeID = json['EmployeeID']==null?0:json['EmployeeID'];
    employeeName = json['EmployeeName']==null?"":json['EmployeeName'];
    preferredDate = json['PreferredDate']==null?"":json['PreferredDate'];
    timeFrom = json['TimeFrom']==null?"":json['TimeFrom'];
    timeTo = json['TimeTo']==null?"":json['TimeTo'];
    createdBy = json['CreatedBy']==null?"":json['CreatedBy'];
    createdDate = json['CreatedDate']==null?"":json['CreatedDate'];
    updatedBy = json['UpdatedBy']==null?"":json['UpdatedBy'];
    updatedDate = json['UpdatedDate']==null?"":json['UpdatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['ComplaintNo'] = this.complaintNo;
    data['ComplaintDate'] = this.complaintDate;
    data['ReferenceNo'] = this.referenceNo;
    data['ComplaintStatus'] = this.complaintStatus;
    data['ComplaintType'] = this.complaintType;
    data['CustomerID'] = this.customerID;
    data['CustomerName'] = this.customerName;
    data['ComplaintNotes'] = this.complaintNotes;
    data['EmployeeID'] = this.employeeID;
    data['EmployeeName'] = this.employeeName;
    data['PreferredDate'] = this.preferredDate;
    data['TimeFrom'] = this.timeFrom;
    data['TimeTo'] = this.timeTo;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedBy'] = this.updatedBy;
    data['UpdatedDate'] = this.updatedDate;

    return data;
  }
}