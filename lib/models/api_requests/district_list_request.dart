class DistrictApiRequest {
  String CompanyId;
  String DistrictName;
  String StateCode;

  DistrictApiRequest({this.CompanyId,this.DistrictName,this.StateCode});

  DistrictApiRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    DistrictName = json['DistrictName'];
    StateCode = json['StateCode'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['DistrictName'] = this.DistrictName;
    data['StateCode'] = this.StateCode;

    return data;
  }
}