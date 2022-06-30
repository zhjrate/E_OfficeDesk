class PackingAssamblyEditModeRequest {
  String PCNo;
  String CompanyId;

  PackingAssamblyEditModeRequest({this.PCNo,this.CompanyId});

  PackingAssamblyEditModeRequest.fromJson(Map<String, dynamic> json) {
    PCNo = json['PCNo'];
    CompanyId = json['CompanyId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PCNo'] = this.PCNo;
    data['CompanyId'] = this.CompanyId;

    return data;
  }
}