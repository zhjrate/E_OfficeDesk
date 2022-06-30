/*CompanyId:4132
LoginUserId:admin
pkID:8
Image:1526648287301.jpg
LeadID:2092147554*/



class TeleCallerUploadImgApiRequest {

  String CompanyID;
  String LoginUserId;
  String pkID;
  String Image;
  String LeadID;


  TeleCallerUploadImgApiRequest({this.CompanyID,this.LoginUserId,this.pkID,this.Image,this.LeadID});

  TeleCallerUploadImgApiRequest.fromJson(Map<String, dynamic> json) {
    CompanyID = json['CompanyId'];
    LoginUserId = json['LoginUserId'];
    pkID = json['pkID'];
    Image = json['Image'];
    LeadID = json['LeadID'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['CompanyId'] = this.CompanyID;
    data['LoginUserId'] = this.LoginUserId;
    data['pkID'] = this.pkID;
    data['Image'] = this.Image;
    data['LeadID'] = this.LeadID;

    return data;
  }
}