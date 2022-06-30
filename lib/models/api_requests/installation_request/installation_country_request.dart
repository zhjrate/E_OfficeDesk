class InstallationCountryRequest {
  int CompanyId;
  String CountryCode;
  String ListMode;



  InstallationCountryRequest({this.CompanyId, this.CountryCode,this.ListMode});

  InstallationCountryRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    CountryCode = json['CountryCode'];
    ListMode = json['ListMode'];



  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['CountryCode'] = this.CountryCode;
    data['ListMode'] = this.ListMode;


    return data;
  }
}
