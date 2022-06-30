class CityApiRequest {
  String StateCode;
  String CompanyID;
  String CityName;
  CityApiRequest({this.StateCode,this.CompanyID,this.CityName});

  CityApiRequest.fromJson(Map<String, dynamic> json) {
    StateCode = json['StateCode'];//json['TalukaCode'];
    CompanyID = json['CompanyId'];
    CityName = json['Word'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StateCode'] = this.StateCode;
    data['CompanyId'] = this.CompanyID;
    data['Word'] = this.CityName;

    return data;
  }
}