class InquiryListResponse {
  List<InquiryDetails> details;
  int totalCount;

  InquiryListResponse({this.details, this.totalCount});

  InquiryListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new InquiryDetails.fromJson(v));
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

class InquiryDetails {
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
  String InquirySourceName;
  String ContactNo;
  String closureReason;
  int closureReasonID;

  InquiryDetails(
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
      this.createdDate,
      this.InquirySourceName,
        this.ContactNo,
        this.closureReason,
        this.closureReasonID,

      });

  InquiryDetails.fromJson(Map<String, dynamic> json) {

    rowNum = json['rowNum'] == null ? 0 : json['rowNum'];
    pkID = json['pkID'] == null ? 0 : json['pkID'];
    inquiryNo = json['InquiryNo'] == null ? "" : json['InquiryNo'];
    inquiryDate = json['InquiryDate'] == null ? "" : json['InquiryDate'];
    referenceName = json['ReferenceName'] == null ? "" : json['ReferenceName'];
    inquirySource = json['InquirySource'] == null ? "" : json['InquirySource'];
    customerID = json['CustomerID'] == null ? 0 : json['CustomerID'];
    customerName = json['CustomerName'] == null ? "" : json['CustomerName'];
    emailAddress = json['EmailAddress'] == null ? "" : json['EmailAddress'];
    followupNotes = json['FollowupNotes'] == null ? "" : json['FollowupNotes'];
    followupDate = json['FollowupDate'] == null ? "": json['FollowupDate'];
    meetingNotes = json['MeetingNotes'] == null ? "" : json['MeetingNotes'];
    inquiryStatusID = json['InquiryStatusID'] == null ? 0 : json['InquiryStatusID'];
    inquiryStatus = json['InquiryStatus'] == null ? "" : json['InquiryStatus'];
    followupTypeID = json['FollowupTypeID'] == null ? 0 : json['FollowupTypeID'];
    priority = json['Priority'] == null ? "" : json['Priority'];
    preferredTime = json['PreferredTime'] == null ? "" : json['PreferredTime'];
    followupType = json['FollowupType'] == null ? "" : json['FollowupType'];
    totalAmount = json['TotalAmount'] == null ? 0.00 : json['TotalAmount'];
    employeeName = json['EmployeeName'] == null ? "" : json['EmployeeName'];
    designation = json['Designation'] == null ? "" : json['Designation'];
    createdBy = json['CreatedBy'] == null ? "" : json['CreatedBy'];
    createdDate = json['CreatedDate'] == null ? "" : json['CreatedDate'];
    InquirySourceName = json['InquirySourceName'] == null ? "" : json['InquirySourceName'];
    ContactNo = json['ContactNo'] == null ? "" : json['ContactNo'];
    closureReason = json['ClosureReason'] == null ? "" : json['ClosureReason'];
    closureReasonID = json['ClosureReasonID'] == null ? 0 : json['ClosureReasonID'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum']          = this.rowNum;
    data['pkID']            = this.pkID;
    data['InquiryNo']       = this.inquiryNo;
    data['InquiryDate']       = this.inquiryDate;
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
    data['InquirySourceName']= this.InquirySourceName;
    data['ContactNo'] =this.ContactNo;
    data['ClosureReason'] =this.closureReason;
    data['ClosureReasonID'] =this.closureReasonID;

    return data;
  }
}
