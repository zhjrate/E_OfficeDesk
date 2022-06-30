class TeleCallerNewListRequest {
  String pkID;
  String acid;
  String LeadStatus;
  String LoginUserID;
  String CompanyId;
  String SearchKey;
  String SerialKey;

  TeleCallerNewListRequest({
    this.pkID, this.acid, this.LeadStatus, this.LoginUserID, this.CompanyId,this.SearchKey,this.SerialKey});



  TeleCallerNewListRequest.fromJson(Map<String, dynamic> json) {
    pkID = json['pkID'];
    acid = json['acid'];
    LeadStatus = json['LeadStatus'];
    LoginUserID = json['LoginUserID'];
    CompanyId = json['CompanyId'];
    SearchKey = json['SearchKey'];
    SerialKey = json['SerialKey'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkID'] = this.pkID;
    data['acid'] = this.acid;
    data['LeadStatus'] = this.LeadStatus;
    data['LoginUserID'] = this.LoginUserID;
    data['CompanyId'] = this.CompanyId;
    data['SearchKey'] = this.SearchKey;
    data['SerialKey'] = this.SerialKey;


    return data;
  }
}