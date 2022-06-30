class FollowupHistoryListResponse {
  List<FollowupHistoryDetails> details;
  int totalCount;

  FollowupHistoryListResponse({this.details, this.totalCount});

  FollowupHistoryListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new FollowupHistoryDetails.fromJson(v));
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

class  FollowupHistoryDetails {
  int rowNum;
  int pkID;
  String inquiryNo;
  String inquiryDate;
  int extpkID;
  int customerID;
  String customerName;
  String meetingNotes;
  String followupDate;
  String nextFollowupDate;
  int rating;
  bool noFollowup;
  int inquiryStatusID;
  int followupStatusID;
  String inquiryStatus;
  String followupStatus;
  String inquirySource;
  String inquiryStatusDesc;
  int inquiryStatusDescID;
  int followupPriority;
  String employeeName;
  String quotationNo;
  String latitude;
  String longitude;
  String preferredTime;
  String contactNo1;
  String contactNo2;
  int noFollClosureID;
  String noFollClosureName;
  String contactPerson1;
  String contactNumber1;

  FollowupHistoryDetails(
      {this.rowNum,
        this.pkID,
        this.inquiryNo,
        this.inquiryDate,
        this.extpkID,
        this.customerID,
        this.customerName,
        this.meetingNotes,
        this.followupDate,
        this.nextFollowupDate,
        this.rating,
        this.noFollowup,
        this.inquiryStatusID,
        this.followupStatusID,
        this.inquiryStatus,
        this.followupStatus,
        this.inquirySource,
        this.inquiryStatusDesc,
        this.inquiryStatusDescID,
        this.followupPriority,
        this.employeeName,
        this.quotationNo,
        this.latitude,
        this.longitude,
        this.preferredTime,
        this.contactNo1,
        this.contactNo2,
        this.noFollClosureID,
        this.noFollClosureName,
        this.contactPerson1,
        this.contactNumber1});

  FollowupHistoryDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum'];
    pkID = json['pkID'];
    inquiryNo = json['InquiryNo'];
    inquiryDate = json['InquiryDate'];
    extpkID = json['ExtpkID'];
    customerID = json['CustomerID'];
    customerName = json['CustomerName'];
    meetingNotes = json['MeetingNotes'];
    followupDate = json['FollowupDate'];
    nextFollowupDate = json['NextFollowupDate'];
    rating = json['Rating'];
    noFollowup = json['NoFollowup'];
    inquiryStatusID = json['InquiryStatusID'];
    followupStatusID = json['FollowupStatusID'];
    inquiryStatus = json['InquiryStatus'];
    followupStatus = json['FollowupStatus'];
    inquirySource = json['InquirySource'];
    inquiryStatusDesc = json['InquiryStatus_Desc'];
    inquiryStatusDescID = json['InquiryStatus_Desc_ID'];
    followupPriority = json['FollowupPriority'];
    employeeName = json['EmployeeName'];
    quotationNo = json['QuotationNo'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    preferredTime = json['PreferredTime'];
    contactNo1 = json['ContactNo1'];
    contactNo2 = json['ContactNo2'];
    noFollClosureID = json['NoFollClosureID'];
    noFollClosureName = json['NoFollClosureName'];
    contactPerson1 = json['ContactPerson1'];
    contactNumber1 = json['ContactNumber1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['InquiryNo'] = this.inquiryNo;
    data['InquiryDate'] = this.inquiryDate;
    data['ExtpkID'] = this.extpkID;
    data['CustomerID'] = this.customerID;
    data['CustomerName'] = this.customerName;
    data['MeetingNotes'] = this.meetingNotes;
    data['FollowupDate'] = this.followupDate;
    data['NextFollowupDate'] = this.nextFollowupDate;
    data['Rating'] = this.rating;
    data['NoFollowup'] = this.noFollowup;
    data['InquiryStatusID'] = this.inquiryStatusID;
    data['FollowupStatusID'] = this.followupStatusID;
    data['InquiryStatus'] = this.inquiryStatus;
    data['FollowupStatus'] = this.followupStatus;
    data['InquirySource'] = this.inquirySource;
    data['InquiryStatus_Desc'] = this.inquiryStatusDesc;
    data['InquiryStatus_Desc_ID'] = this.inquiryStatusDescID;
    data['FollowupPriority'] = this.followupPriority;
    data['EmployeeName'] = this.employeeName;
    data['QuotationNo'] = this.quotationNo;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['PreferredTime'] = this.preferredTime;
    data['ContactNo1'] = this.contactNo1;
    data['ContactNo2'] = this.contactNo2;
    data['NoFollClosureID'] = this.noFollClosureID;
    data['NoFollClosureName'] = this.noFollClosureName;
    data['ContactPerson1'] = this.contactPerson1;
    data['ContactNumber1'] = this.contactNumber1;
    return data;
  }
}