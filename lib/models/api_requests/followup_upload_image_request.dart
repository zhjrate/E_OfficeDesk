/*CompanyId:10032
LoginUserId:admin
pkID:10046
fileName:logo.png*/




import 'dart:io';

class FollowUpUploadImageAPIRequest {
  String CompanyId;
  String pkID;
  String LoginUserId;
  String fileName;
  String FollowupID;
  String InquiryNo;
  String Type;
  File file;
  /*CompanyId:10032
LoginUserId:admin
fileName:screen_one[1].jpg
pkID:0
FollowupID:22
InquiryNo:DEC21-004
Type:0*/


  FollowUpUploadImageAPIRequest(
      {this.CompanyId,
        this.pkID,
        this.LoginUserId,
        this.fileName,this.FollowupID,this.InquiryNo,this.Type,this.file});

  FollowUpUploadImageAPIRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    pkID = json['pkID'];
    LoginUserId = json['LoginUserId'];
    fileName = json['fileName'];
    FollowupID = json['FollowupID'];
    InquiryNo = json['InquiryNo'];
    Type = json['Type'];
    file = json[''];

  }

  Map<String, dynamic> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['CompanyId'] = this.CompanyId;
    data['pkID'] = this.pkID;
    data['LoginUserId'] = this.LoginUserId;
    data['FollowupID'] = this.FollowupID;
    data['InquiryNo'] = this.InquiryNo;
    data['Type'] = this.Type;
    data['fileName'] = this.fileName;

    // data['']=this.file;
    return data;
  }
}
