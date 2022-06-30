/*CompanyId:10032
word:
needALL:1
LoginUserID:admin
LeadStatus:*/


class ExternalLeadSearchRequest {
  String CompanyId;

  String word;
  String needALL;
  String LoginUserID;
  String LeadStatus;

  ExternalLeadSearchRequest({
    this.CompanyId, this.word, this.needALL, this.LoginUserID, this.LeadStatus});



  ExternalLeadSearchRequest.fromJson(Map<String, dynamic> json) {

    CompanyId = json['CompanyId'];
    word = json['word'];
    needALL = json['needALL'];
    LoginUserID = json['LoginUserID'];
    LeadStatus = json['LeadStatus']=="ALL Leads"?"":json['LeadStatus'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['word'] = this.word;
    data['needALL'] = this.needALL;
    data['LoginUserID'] = this.LoginUserID;
    data['LeadStatus'] = this.LeadStatus;

    return data;
  }
}