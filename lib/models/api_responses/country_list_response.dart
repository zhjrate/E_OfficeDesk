class CountryListResponse {
  List<SearchDetails> details;
  int totalCount;

  CountryListResponse({this.details, this.totalCount});

  CountryListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new SearchDetails.fromJson(v));
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

class SearchDetails {
  int rowNum;
  String countryCode;
  String countryName;
  String currencyName;
  String currencySymbol;
  String countryISO;
  bool activeFlag;

  SearchDetails(
      {this.rowNum,
        this.countryCode,
        this.countryName,
        this.currencyName,
        this.currencySymbol,
        this.countryISO,
        this.activeFlag});

  SearchDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum'];
    countryCode = json['CountryCode'];
    countryName = json['CountryName'];
    currencyName = json['CurrencyName'];
    currencySymbol = json['CurrencySymbol'];
    countryISO = json['CountryISO'];
    activeFlag = json['ActiveFlag'];
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