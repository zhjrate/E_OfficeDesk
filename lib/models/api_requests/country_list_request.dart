class CountryListRequest {
  String CountryCode;
  String CompanyID;

  CountryListRequest({this.CountryCode,this.CompanyID});

  CountryListRequest.fromJson(Map<String, dynamic> json) {
    CountryCode = json['CountryCode'];
    CompanyID = json['CompanyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CountryCode'] = this.CountryCode;
    data['CompanyId'] = this.CompanyID;

    return data;
  }
}