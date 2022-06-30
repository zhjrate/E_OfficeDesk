class FollowupSaveApiRequest {


  String pkID;
  String FollowupDate;
  String CustomerID;
  String InquiryNo;
  String MeetingNotes;
  String NextFollowupDate;
  String Rating;
  String FollowupTypeId;
  String LoginUserID;
  String Address;
  String NoFollowup;
  String InquiryStatusId;
  String Latitude;
  String Longitude;
  String PreferredTime;
  String ClosureReasonId;
  String CompanyId;
  String FollowupPriority;
  String FollowUpImage;
  String timeIn;
  String timeOut;
  String latitude_IN;
  String longitude_IN;
  String latitude_OUT;
  String longitude_OUT;
  String locationAddress_IN;
  String locationAddress_OUT;







  /*TimeIn:3:46 PM
TimeOut:4:20 PM
Latitude_IN:123789
Longitude_IN:987321
Latitude_OUT:147741
Longitude_OUT:258852
LocationAddress_IN:12345678
LocationAddress_OUT:97845612*/


/*pkID:55
FollowupDate:2021-12-06
CustomerID:4
InquiryNo:JUL20-009
MeetingNotes:Testing for Inquiry Status ID
NextFollowupDate:2021-12-15
Rating:3
FollowupTypeId:5
LoginUserID:admin
Address:Tata Consultancy Services
NoFollowup:2
InquiryStatusId:8
Latitude:23432
Longitude:21322
PreferredTime:06:45 PM
ClosureReasonId:
CompanyId:10032
FollowupPriority:3*/


  FollowupSaveApiRequest({
    this.pkID,
    this.FollowupDate,
    this.CustomerID,
    this.InquiryNo,
    this.MeetingNotes,
    this.NextFollowupDate,
    this.Rating,
    this.FollowupTypeId,
    this.LoginUserID,
    this.Address,
    this.NoFollowup,
    this.InquiryStatusId,
    this.Latitude,
    this.Longitude,
    this.PreferredTime,
    this.ClosureReasonId,
    this.CompanyId,
    this.FollowupPriority,
    this.FollowUpImage,
    this.timeIn,
    this.timeOut,
    this.latitude_IN,
    this.latitude_OUT,
    this.longitude_IN,
    this.longitude_OUT,
    this.locationAddress_IN,
    this.locationAddress_OUT

  });

  FollowupSaveApiRequest.fromJson(Map<String, dynamic> json) {
    pkID = json["pkID"];
    FollowupDate = json["FollowupDate"];
    CustomerID = json["CustomerID"];
    InquiryNo = json["InquiryNo"];
    MeetingNotes = json["MeetingNotes"];
    NextFollowupDate = json["NextFollowupDate"];
    Rating = json["Rating"];
    FollowupTypeId = json["FollowupTypeId"];
    LoginUserID = json["LoginUserID"];
    Address = json["Address"];
    NoFollowup = json["NoFollowup"];
    InquiryStatusId = json["InquiryStatusId"];
    Latitude = json["Latitude"];
    Longitude = json["Longitude"];
    PreferredTime = json["PreferredTime"];
    ClosureReasonId = json["ClosureReasonId"];
    CompanyId = json["CompanyId"];
    FollowupPriority = json["FollowupPriority"];
    FollowUpImage = json['FollowUpImage'];
    timeIn = json['TimeIn'];
    timeOut = json['TimeOut'];
    latitude_IN = json['Latitude_IN'];
    latitude_OUT = json['Latitude_OUT'];
    longitude_IN = json['Longitude_IN'];
    longitude_OUT = json['Longitude_OUT'];
    locationAddress_IN = json['LocationAddress_IN'];
    locationAddress_OUT = json['LocationAddress_OUT'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["pkID"] = this.pkID;
    data["FollowupDate"] = this.FollowupDate;
    data["CustomerID"] = this.CustomerID;
    data["InquiryNo"] = this.InquiryNo;
    data["MeetingNotes"] = this.MeetingNotes;
    data["NextFollowupDate"] = this.NextFollowupDate;
    data["Rating"] = this.Rating;
    data["FollowupTypeId"] = this.FollowupTypeId;
    data["LoginUserID"] = this.LoginUserID;
    data["Address"] = this.Address;
    data["NoFollowup"] = this.NoFollowup;
    data["InquiryStatusId"] = this.InquiryStatusId;
    data["Latitude"] = this.Latitude;
    data["Longitude"] = this.Longitude;
    data["PreferredTime"] = this.PreferredTime;
    data["ClosureReasonId"] = this.ClosureReasonId;
    data["CompanyId"] = this.CompanyId;
    data["FollowupPriority"] = this.FollowupPriority;
    data["FollowUpImage"] = this.FollowUpImage;
    data["TimeIn"] = this.timeIn;
    data["TimeOut"] = this.timeOut;
    data["Latitude_IN"] = this.latitude_IN;
    data["Latitude_OUT"] = this.latitude_OUT;
    data["Longitude_IN"] = this.longitude_IN;
    data["Longitude_OUT"] = this.longitude_OUT;
    data["LocationAddress_IN"] = this.locationAddress_IN;
    data["LocationAddress_OUT"] = this.locationAddress_OUT;

    return data;
  }
}
