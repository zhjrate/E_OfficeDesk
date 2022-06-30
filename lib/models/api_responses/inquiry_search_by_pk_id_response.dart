class InquirySearchByPkIdResponse {
  List<InquirySearchByPkIdDetails> details;
  int totalCount;

  InquirySearchByPkIdResponse({this.details, this.totalCount});

  InquirySearchByPkIdResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new InquirySearchByPkIdDetails.fromJson(v));
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

class InquirySearchByPkIdDetails {
  int rowNum;
  int pkID;
  String inquiryNo;
  String inquiryDate;
  String referenceName;
  String inquirySource;
  int customerID;
  String customerName;
  String emailAddress;
  String followupNotes;
  String followupDate;
  String meetingNotes;
  int inquiryStatusID;
  String inquiryStatus;
  int followupTypeID;
  String priority;
  String preferredTime;
  String followupType;
  double totalAmount;
  String employeeName;
  String designation;
  String createdBy;
  String createdDate;

  InquirySearchByPkIdDetails(
      {this.rowNum,
        this.pkID,
        this.inquiryNo,
        this.inquiryDate,
        this.referenceName,
        this.inquirySource,
        this.customerID,
        this.customerName,
        this.emailAddress,
        this.followupNotes,
        this.followupDate,
        this.meetingNotes,
        this.inquiryStatusID,
        this.inquiryStatus,
        this.followupTypeID,
        this.priority,
        this.preferredTime,
        this.followupType,
        this.totalAmount,
        this.employeeName,
        this.designation,
        this.createdBy,
        this.createdDate});

  InquirySearchByPkIdDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum'];
    pkID = json['pkID'];
    inquiryNo = json['InquiryNo'];
    inquiryDate = json['InquiryDate'];
    referenceName = json['ReferenceName'];
    inquirySource = json['InquirySource'];
    customerID = json['CustomerID'];
    customerName = json['CustomerName'];
    emailAddress = json['EmailAddress'];
    followupNotes = json['FollowupNotes'];
    followupDate = json['FollowupDate'];
    meetingNotes = json['MeetingNotes'];
    inquiryStatusID = json['InquiryStatusID'];
    inquiryStatus = json['InquiryStatus'];
    followupTypeID = json['FollowupTypeID'];
    priority = json['Priority'];
    preferredTime = json['PreferredTime'];
    followupType = json['FollowupType'];
    totalAmount = json['TotalAmount'];
    employeeName = json['EmployeeName'];
    designation = json['Designation'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['InquiryNo'] = this.inquiryNo;
    data['InquiryDate'] = this.inquiryDate;
    data['ReferenceName'] = this.referenceName;
    data['InquirySource'] = this.inquirySource;
    data['CustomerID'] = this.customerID;
    data['CustomerName'] = this.customerName;
    data['EmailAddress'] = this.emailAddress;
    data['FollowupNotes'] = this.followupNotes;
    data['FollowupDate'] = this.followupDate;
    data['MeetingNotes'] = this.meetingNotes;
    data['InquiryStatusID'] = this.inquiryStatusID;
    data['InquiryStatus'] = this.inquiryStatus;
    data['FollowupTypeID'] = this.followupTypeID;
    data['Priority'] = this.priority;
    data['PreferredTime'] = this.preferredTime;
    data['FollowupType'] = this.followupType;
    data['TotalAmount'] = this.totalAmount;
    data['EmployeeName'] = this.employeeName;
    data['Designation'] = this.designation;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    return data;
  }
}