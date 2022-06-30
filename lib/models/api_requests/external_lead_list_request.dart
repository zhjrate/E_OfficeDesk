
class ExternalLeadListRequest {
  String pkID;
  String acid;
  String LeadStatus;
  String LoginUserID;
  String CompanyId;

  ExternalLeadListRequest({
      this.pkID, this.acid, this.LeadStatus, this.LoginUserID, this.CompanyId});



  ExternalLeadListRequest.fromJson(Map<String, dynamic> json) {
    pkID = json['pkID'];
    acid = json['acid'];
    LeadStatus = json['LeadStatus'];
    LoginUserID = json['LoginUserID'];
    CompanyId = json['CompanyId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkID'] = this.pkID;
    data['acid'] = this.acid;
    data['LeadStatus'] = this.LeadStatus;
    data['LoginUserID'] = this.LoginUserID;
    data['CompanyId'] = this.CompanyId;
    data['SerialKey'] = "";

    return data;
  }
}