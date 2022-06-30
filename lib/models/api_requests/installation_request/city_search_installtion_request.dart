class CitySearchInstallationApiRequest {
  String StateCode;
  String CompanyID;
  String CityName;
  String Word;
  CitySearchInstallationApiRequest({this.StateCode,this.CompanyID,this.CityName,this.Word});

  CitySearchInstallationApiRequest.fromJson(Map<String, dynamic> json) {
    StateCode = json['TalukaCode'];
    CompanyID = json['CompanyId'];
    CityName = json['Word'];
    Word = json['Word'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StateCode'] = this.StateCode;
    data['CompanyId'] = this.CompanyID;
    data['Word'] = this.CityName;
    data['Word'] = this.Word;

    return data;
  }
}