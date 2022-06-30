/*pkID:
acid:
LoginUserID:admin
SerialKey:
CompanyId:10032
LeadStatus:Qualified*/



class TeleCallerListRequest {
  String pkID;
  String acid;
  String LeadStatus;
  String LoginUserID;
  String CompanyId;
  String SerialKey;
  String SearchKey;

  TeleCallerListRequest({
    this.pkID, this.acid, this.LeadStatus, this.LoginUserID, this.CompanyId,this.SerialKey,this.SearchKey});



  TeleCallerListRequest.fromJson(Map<String, dynamic> json) {
    pkID = json['pkID'];
    acid = json['acid'];
    LeadStatus = json['LeadStatus'];
    LoginUserID = json['LoginUserID'];
    CompanyId = json['CompanyId'];
    SerialKey = json['SerialKey'];
    SearchKey= json['SearchKey'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkID'] = this.pkID;
    data['acid'] = this.acid;
    data['LeadStatus'] = this.LeadStatus;
    data['LoginUserID'] = this.LoginUserID;
    data['CompanyId'] = this.CompanyId;
    data['SerialKey'] = this.SerialKey;
    data['SearchKey']=this.SearchKey;

    return data;
  }
}