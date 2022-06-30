/*pkID:
FollowupDate:2021-12-20
CustomerID:20665
InquiryNo:
InquiryDate:2021-11-27
MeetingNotes:Please Enter The
InquirySource:36
ReferenceName:Patel & Patel Company
FollowupNotes:Please Enter the number
InquiryStatusID:2
LoginUserID:admin
Latitude:3243
Longitude:4321
FollowupTypeID:
PreferredTime:10:25 AM
Priority:Low
CompanyId:10032*/

class InquiryHeaderSaveRequest {
  String pkID;
  String FollowupDate;
  String CustomerID;
  String InquiryNo;
  String InquiryDate;
  String MeetingNotes;
  String InquirySource;
  String ReferenceName;
  String FollowupNotes;
  String InquiryStatusID;
  String LoginUserID;
  String Latitude;
  String Longitude;
  String FollowupTypeID;
  String PreferredTime;
  String Priority;
  String CompanyId;
  String ClosureReason;

  InquiryHeaderSaveRequest(
      {this.pkID,
      this.FollowupDate,
      this.CustomerID,
      this.InquiryNo,
      this.InquiryDate,
      this.MeetingNotes,
      this.InquirySource,
      this.ReferenceName,
      this.FollowupNotes,
      this.InquiryStatusID,
      this.LoginUserID,
      this.Longitude,
      this.Latitude,
      this.FollowupTypeID,
      this.PreferredTime,
        this.Priority,
      this.CompanyId,
        this.ClosureReason

      });

  InquiryHeaderSaveRequest.fromJson(Map<String, dynamic> json) {
    pkID = json['pkID'];
    FollowupDate = json['FollowupDate'];
    CustomerID = json['CustomerID'];
    InquiryNo = json['InquiryNo'];
    InquiryDate = json['InquiryDate'];
    MeetingNotes = json['MeetingNotes'];
    InquirySource = json['InquirySource'];
    ReferenceName = json['ReferenceName'];
    FollowupNotes = json['FollowupNotes'];
    InquiryStatusID = json['InquiryStatusID'];
    LoginUserID = json['LoginUserID'];
    Latitude = json['Latitude'];
    Longitude = json['Longitude'];
    FollowupTypeID = json['FollowupTypeID'];
    PreferredTime = json['PreferredTime'];
    Priority= json['Priority'];
    CompanyId = json['CompanyId'];
    ClosureReason = json['ClosureReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();


    data['pkID'] = this.pkID;
    data['FollowupDate']= this.FollowupDate;
    data['CustomerID']= this.CustomerID;
    data['InquiryNo']= this.InquiryNo;
    data['InquiryDate']= this.InquiryDate;
    data['MeetingNotes']= this.MeetingNotes;
    data['InquirySource']= this.InquirySource;
    data['ReferenceName']= this.ReferenceName;
    data['FollowupNotes']= this.FollowupNotes;
    data['InquiryStatusID']= this.InquiryStatusID;
    data['LoginUserID']= this.LoginUserID;
    data['Latitude']= this.Latitude;
    data['Longitude']= this.Longitude;
    data['FollowupTypeID']= this.FollowupTypeID;
    data['PreferredTime']= this.PreferredTime;
    data['Priority']= this.Priority;
    data['CompanyId']= this.CompanyId;
    data['ClosureReason']=this.ClosureReason;

    return data;
  }
}
