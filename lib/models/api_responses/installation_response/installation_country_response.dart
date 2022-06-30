class InstallationCountryResponse {
  List<InstallationCountryDetails> details;
  int totalCount;

  InstallationCountryResponse({this.details, this.totalCount});

  InstallationCountryResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new InstallationCountryDetails.fromJson(v));
      });
    }
    totalCount = json['TotalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    data['TotalCount'] = this.totalCount;
    return data;
  }
}

class InstallationCountryDetails {
  int rowNum;
  String countryCode;
  String countryName;
  String currencyName;
  String currencySymbol;
  String countryISO;
  bool activeFlag;

  InstallationCountryDetails(
      {this.rowNum,
        this.countryCode,
        this.countryName,
        this.currencyName,
        this.currencySymbol,
        this.countryISO,
        this.activeFlag});

  InstallationCountryDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum']==null?0: json['RowNum'];
    countryCode = json['CountryCode']==null?"":json['CountryCode'];
    countryName = json['CountryName']==null?"":json['CountryName'];
    currencyName = json['CurrencyName']==null?"":json['CurrencyName'];
    currencySymbol = json['CurrencySymbol']==null?"":json['CurrencySymbol'];
    countryISO = json['CountryISO']==null?"":json['CountryISO'];
    activeFlag = json['ActiveFlag']==null?false:json['ActiveFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['CountryCode'] = this.countryCode;
    data['CountryName'] = this.countryName;
    data['CurrencyName'] = this.currencyName;
    data['CurrencySymbol'] = this.currencySymbol;
    data['CountryISO'] = this.countryISO;
    data['ActiveFlag'] = this.activeFlag;
    return data;
  }
}