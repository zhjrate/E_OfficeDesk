class FollowupListResponse {
  List<Details> details;
  int totalCount;

  FollowupListResponse({this.details, this.totalCount});

  FollowupListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details =[];
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
  String inquiryDate;
  int customerID;
  String customerName;
  String meetingNotes;
  String followupDate;
  String nextFollowupDate;
  int rating;
  bool noFollowup;
  int inquiryStatusID;
  String inquiryStatus;
  int inquiryStatusTypeId;
  String createdBy;
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
        this.inquiryStatusTypeId,
        this.createdBy,
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
    inquiryStatusTypeId = json['InquiryStatusTypeId'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
    preferredTime = json['PreferredTime'];
    noFollClosureID = json['NoFollClosureID'];
    noFollClosureName = json['NoFollClosureName'];
    /*

   "RowNum": 1,
                "pkID": 27,
                "InquiryNo": "NOV21-004",
                "InquiryDate": "2021-11-29T00:00:00",
                "CustomerID": 51493,
                "CustomerName": "Dolphin 1",
                "MeetingNotes": "Please Enter the number",
                "FollowupDate": "2021-11-29T00:00:00",
                "NextFollowupDate": "2021-11-29T00:00:00",
                "Rating": 5,
                "NoFollowup": false,
                "InquiryStatusID": 0,
                "InquiryStatus": "--Not Available--",
                "InquiryStatus_Desc": "--Not Available--",
                "EmployeeName": "Mrunal Yoddha",
                "Latitude": "3243",
                "Longitude": "4321",
                "PreferredTime": "10:25 AM",
                "InquiryStatusTypeId": 0,
                "CreatedDate": "2021-11-29T11:09:12.68",
                "CreatedBy": "admin",
                "NoFollClosureID": null,
                "NoFollClosureName": "--Not Available--

   */

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
    data['InquiryStatusTypeId'] = this.inquiryStatusTypeId;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['PreferredTime'] = this.preferredTime;
    data['NoFollClosureID'] = this.noFollClosureID;
    data['NoFollClosureName'] = this.noFollClosureName;
    return data;
  }
}