class QuickFollowupListResponse {
  List<QuickFollowupListResponseDetails> details;
  int totalCount;

  QuickFollowupListResponse({this.details, this.totalCount});

  QuickFollowupListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new QuickFollowupListResponseDetails.fromJson(v));
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

class QuickFollowupListResponseDetails {
  int pkID;
  String followupDate;
  String nextFollowupDate;
  int customerID;
  String customerName;
  String contactNo1;
  String meetingNotes;
  String inquiryNo;
  int inquiryStatusID;
  String inquiryStatus;
  bool noFollowup;
  int followupPriority;
  String address;
  String timeIn;
  String timeOut;
  String latitudeIN;
  String latitudeOUT;
  String longitude_IN;
  String longitude_OUT;
  String locationAddressIN;
  String locationAddressOUT;
  String createdBy;

  QuickFollowupListResponseDetails({
    this.pkID,
    this.followupDate,
    this.nextFollowupDate,
    this.customerID,
    this.customerName,
    this.contactNo1,
    this.meetingNotes,
    this.inquiryNo,
    this.inquiryStatusID,
    this.inquiryStatus,
    this.noFollowup,
    this.followupPriority,
    this.address,
    this.timeIn,
    this.timeOut,
    this.latitudeIN,
    this.latitudeOUT,
    this.longitude_IN,
    this.longitude_OUT,
    this.locationAddressIN,
    this.locationAddressOUT,
    this.createdBy,
  });

  QuickFollowupListResponseDetails.fromJson(Map<String, dynamic> json) {
    pkID = json['pkID'] == null ? 0 : json['pkID'];
    followupDate = json['FollowupDate'] == null ? "" : json['FollowupDate'];
    nextFollowupDate =
        json['NextFollowupDate'] == null ? "" : json['NextFollowupDate'];
    customerID = json['CustomerID'] == null ? 0 : json['CustomerID'];
    customerName = json['CustomerName'] == null ? "" : json['CustomerName'];
    contactNo1 = json['ContactNo1'] == null ? "" : json['ContactNo1'];
    meetingNotes = json['MeetingNotes'] == null ? "" : json['MeetingNotes'];
    inquiryNo = json['InquiryNo'] == null ? "" : json['InquiryNo'];
    inquiryStatusID =
        json['InquiryStatusID'] == null ? 0 : json['InquiryStatusID'];
    inquiryStatus = json['InquiryStatus'] == null ? "" : json['InquiryStatus'];
    noFollowup = json['NoFollowup'] == null ? false : json['NoFollowup'];
    followupPriority =
        json['FollowupPriority'] == null ? 0 : json['FollowupPriority'];
    address = json['Address'] == null ? "" : json['Address'];
    timeIn = json['TimeIn'] == null || json['TimeIn'] == "00:00:00"
        ? ""
        : json['TimeIn'];
    timeOut = json['TimeOut'] == null || json['TimeOut'] == "00:00:00"
        ? ""
        : json['TimeOut'];
    latitudeIN = json['Latitude_IN'] == null ? "" : json['Latitude_IN'];
    latitudeOUT = json['Latitude_OUT'] == null ? "" : json['Latitude_OUT'];
    longitude_IN = json['Longitude_IN'] == null ? "" : json['Longitude_IN'];
    longitude_OUT = json['Longitude_OUT'] == null ? "" : json['Longitude_OUT'];
    locationAddressIN =
        json['LocationAddress_IN'] == null ? "" : json['LocationAddress_IN'];
    locationAddressOUT =
        json['LocationAddress_OUT'] == null ? "" : json['LocationAddress_OUT'];
    createdBy = json['CreatedBy'] == null ? "" : json['CreatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkID'] = this.pkID;
    data['FollowupDate'] = this.followupDate;
    data['NextFollowupDate'] = this.nextFollowupDate;
    data['CustomerID'] = this.customerID;
    data['CustomerName'] = this.customerName;
    data['ContactNo1'] = this.contactNo1;
    data['MeetingNotes'] = this.meetingNotes;
    data['InquiryNo'] = this.inquiryNo;
    data['InquiryStatusID'] = this.inquiryStatusID;
    data['InquiryStatus'] = this.inquiryStatus;
    data['NoFollowup'] = this.noFollowup;
    data['FollowupPriority'] = this.followupPriority;
    data['Address'] = this.address;
    data['TimeIn'] = this.timeIn;
    data['TimeOut'] = this.timeOut;
    data['Latitude_IN'] = this.latitudeIN;
    data['Latitude_OUT'] = this.latitudeOUT;
    data['Longitude_IN'] = this.longitude_IN;
    data['Longitude_OUT'] = this.longitude_OUT;
    data['LocationAddress_IN'] = this.locationAddressIN;
    data['LocationAddress_OUT'] = this.locationAddressOUT;
    data['CreatedBy'] = this.createdBy;
    return data;
  }
}
