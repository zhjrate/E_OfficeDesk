class FollowupInquiryNoListResponse {
  List<Details> details;
  int totalCount;

  FollowupInquiryNoListResponse({this.details, this.totalCount});

  FollowupInquiryNoListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
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

class Details {
  int rowNum;
  int pkID;
  String inquiryNo;
  Null inquiryDate;
  int customerID;
  String customerName;
  String meetingNotes;
  String followupDate;
  String nextFollowupDate;
  int rating;
  int noFollowup;
  int inquiryStatusID;
  String inquiryStatus;
  Null inquirySource;
  String employeeName;
  Null latitude;
  Null longitude;
  String leadStatus;
  Null quotationNo;
  String createdDate;
  String preferredTime;
  int noFollClosureID;
  String noFollClosureName;

  Details(
      {this.rowNum,
        this.pkID,
        this.inquiryNo,
        this.inquiryDate,
        this.customerID,
        this.customerName,
        this.meetingNotes,
        this.followupDate,
        this.nextFollowupDate,
        this.rating,
        this.noFollowup,
        this.inquiryStatusID,
        this.inquiryStatus,
        this.inquirySource,
        this.employeeName,
        this.latitude,
        this.longitude,
        this.leadStatus,
        this.quotationNo,
        this.createdDate,
        this.preferredTime,
        this.noFollClosureID,
        this.noFollClosureName});

  Details.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum'];
    pkID = json['pkID'];
    inquiryNo = json['InquiryNo'];
    inquiryDate = json['InquiryDate'];
    customerID = json['CustomerID'];
    customerName = json['CustomerName'];
    meetingNotes = json['MeetingNotes'];
    followupDate = json['FollowupDate'];
    nextFollowupDate = json['NextFollowupDate'];
    rating = json['Rating'];
    noFollowup = json['NoFollowup'];
    inquiryStatusID = json['InquiryStatusID'];
    inquiryStatus = json['InquiryStatus'];
    inquirySource = json['InquirySource'];
    employeeName = json['EmployeeName'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    leadStatus = json['LeadStatus'];
    quotationNo = json['QuotationNo'];
    createdDate = json['CreatedDate'];
    preferredTime = json['PreferredTime'];
    noFollClosureID = json['NoFollClosureID'];
    noFollClosureName = json['NoFollClosureName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['InquiryNo'] = this.inquiryNo;
    data['InquiryDate'] = this.inquiryDate;
    data['CustomerID'] = this.customerID;
    data['CustomerName'] = this.customerName;
    data['MeetingNotes'] = this.meetingNotes;
    data['FollowupDate'] = this.followupDate;
    data['NextFollowupDate'] = this.nextFollowupDate;
    data['Rating'] = this.rating;
    data['NoFollowup'] = this.noFollowup;
    data['InquiryStatusID'] = this.inquiryStatusID;
    data['InquiryStatus'] = this.inquiryStatus;
    data['InquirySource'] = this.inquirySource;
    data['EmployeeName'] = this.employeeName;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['LeadStatus'] = this.leadStatus;
    data['QuotationNo'] = this.quotationNo;
    data['CreatedDate'] = this.createdDate;
    data['PreferredTime'] = this.preferredTime;
    data['NoFollClosureID'] = this.noFollClosureID;
    data['NoFollClosureName'] = this.noFollClosureName;
    return data;
  }
}