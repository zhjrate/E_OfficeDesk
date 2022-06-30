class FollowupFilterListResponse {
  List<FilterDetails> details;
  int totalCount;

  FollowupFilterListResponse({this.details, this.totalCount});

  FollowupFilterListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details =  [];
      json['details'].forEach((v) {
        details.add(new FilterDetails.fromJson(v));
      });
    }
    totalCount = json['TotalCount'] == null ? 0 : json['TotalCount'];
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

class FilterDetails {
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
  int noFollowup;
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
  String FollowUpImage;
  String timeIn;
  String timeOut;



  /*"TimeIn": "12:38:00",
                "TimeOut": "00:00:00",
                "Latitude_IN": "23.0115056",
                "Latitude_OUT": "",
                "Longitude_IN": "72.5235425",
                "Longitude_OUT": "",
                "LocationAddress_IN": "",
                "LocationAddress_OUT": ""*/


  /* "RowNum": 1,
                "pkID": 449216,
                "InquiryNo": "APR21-147",
                "InquiryDate": "2021-04-15T00:00:00",
                "ExtpkID": 0,
                "CustomerID": 80080,
                "CustomerName": "Maruti Enterprises Rajkot 3*4 Loan",
                "MeetingNotes": "Call for loan Update",
                "FollowupDate": "2021-12-22T00:00:00",
                "NextFollowupDate": "2022-01-20T00:00:00",
                "Rating": 0,
                "NoFollowup": 0,
                "InquiryStatusID": 10049,
                "FollowupStatusID": 10049,
                "InquiryStatus": "whasApp",
                "FollowupStatus": "whasApp",
                "InquirySource": "Direct Call Coming",
                "InquiryStatus_Desc": "Loan Apply",
                "InquiryStatus_Desc_ID": 30060,
                "FollowupPriority": 2,
                "EmployeeName": "Vikesh Patel",
                "QuotationNo": null,
                "Latitude": null,
                "Longitude": null,
                "PreferredTime": "",
                "ContactNo1": "9265768798",
                "ContactNo2": "",
                "NoFollClosureID": 0,
                "NoFollClosureName": "--Not Available--",
                "ContactPerson1": "Pal Narendra",
                "ContactNumber1": "9265768798"*/


  FilterDetails(
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
        this.contactNumber1,
        this.FollowUpImage,
        this.timeIn,
        this.timeOut
      });

  FilterDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum']== null ? 0 : json['RowNum'];
    pkID = json['pkID']== null ? 0 : json['pkID'];
    inquiryNo = json['InquiryNo'] == null ? "" : json['InquiryNo'];
    inquiryDate = json['InquiryDate'] == null ? "" : json['InquiryDate'];
    extpkID = json['ExtpkID']== null ? 0 : json['ExtpkID'];
    customerID = json['CustomerID']== null ? 0 : json['CustomerID'];
    customerName = json['CustomerName'] == null ? "" : json['CustomerName'];
    meetingNotes = json['MeetingNotes']== null ? "" : json['MeetingNotes'];
    followupDate = json['FollowupDate']== null ? "" : json['FollowupDate'];
    nextFollowupDate = json['NextFollowupDate']== null ? "" : json['NextFollowupDate'];
    rating = json['Rating']== null ? 0 : json['Rating'];
    noFollowup = json['NoFollowup']== null ? 0 : json['NoFollowup'];
    inquiryStatusID = json['InquiryStatusID']== null ? 0 : json['InquiryStatusID'];
    followupStatusID = json['FollowupStatusID']== null ? 0 : json['FollowupStatusID'];
    inquiryStatus = json['InquiryStatus']== null ? "" : json['InquiryStatus'];
    followupStatus = json['FollowupStatus']== null ? "" : json['FollowupStatus'];
    inquirySource = json['InquirySource']== null ? "" : json['InquirySource'];
    inquiryStatusDesc = json['InquiryStatus_Desc']== null ? "" : json['InquiryStatus_Desc'];
    inquiryStatusDescID = json['InquiryStatus_Desc_ID']== null ? 0 : json['InquiryStatus_Desc_ID'];
    followupPriority = json['FollowupPriority']== null ? 0 : json['FollowupPriority'];
    employeeName = json['EmployeeName']== null ? "" : json['EmployeeName'];
    quotationNo = json['QuotationNo']== null ? "" : json['QuotationNo'];
    latitude = json['Latitude']== null ? "" : json['Latitude'];
    longitude = json['Longitude']== null ? "" : json['Longitude'];
    preferredTime = json['PreferredTime']== null ? "" : json['PreferredTime'];
    contactNo1 = json['ContactNo1']== null ? "" : json['ContactNo1'];
    contactNo2 = json['ContactNo2']== null ? "" : json['ContactNo2'];
    noFollClosureID = json['NoFollClosureID']== null ? 0 : json['NoFollClosureID'];
    noFollClosureName = json['NoFollClosureName']== null ? "" : json['NoFollClosureName'];
    contactPerson1 = json['ContactPerson1']== null ? "" : json['ContactPerson1'];
    contactNumber1 = json['ContactNumber1']== null ? "" : json['ContactNumber1'];
    FollowUpImage = json['FollowUpImage']==null ? "" : json['FollowUpImage'];
    timeIn = json['TimeIn']==null  ? "" : json['TimeIn'];
    timeOut = json['TimeOut']==null || json['TimeOut']=="00:00:00" ? "" : json['TimeOut'];

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
    data['FollowUpImage']= this.FollowUpImage;
    data['TimeIn']= this.timeIn;
    data['TimeOut']= this.timeOut;

    return data;
  }
}