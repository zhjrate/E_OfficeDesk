class InstallationSearchCustomerResponse {
  List<InstallationCustomerSearchDetails> details;
  int totalCount;

  InstallationSearchCustomerResponse({this.details, this.totalCount});

  InstallationSearchCustomerResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new InstallationCustomerSearchDetails.fromJson(v));
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

class InstallationCustomerSearchDetails {
  String label;
  int value;
  String inquiryNo;
  int stateCode;
  String stateName;
  int cityCode;
  String cityName;
  double erpClosing;
  String countryCode;
  String countryName;
  String customerSourceName;
  String emailAddress;
  String contactNo1;

  InstallationCustomerSearchDetails(
      {this.label,
        this.value,
        this.inquiryNo,
        this.stateCode,
        this.stateName,
        this.cityCode,
        this.cityName,
        this.erpClosing,
        this.countryCode,
        this.countryName,
        this.customerSourceName,
        this.emailAddress,
        this.contactNo1});

  InstallationCustomerSearchDetails.fromJson(Map<String, dynamic> json) {
    label = json['label']==null?"":json['label'];
    value = json['value']==null?0:json['value'];
    inquiryNo = json['InquiryNo']==null?"":json['InquiryNo'];
    stateCode = json['StateCode']==null?0:json['StateCode'];
    stateName = json['StateName']==null?"":json['StateName'];
    cityCode = json['CityCode']==null?0:json['CityCode'];
    cityName = json['CityName']==null?"":json['CityName'];
    erpClosing = json['ErpClosing']==null?0.00:json['ErpClosing'];
    countryCode = json['CountryCode']==null?"":json['CountryCode'];
    countryName = json['CountryName']==null?"":json['CountryName'];
    customerSourceName = json['CustomerSourceName']==null?"":json['CustomerSourceName'];
    emailAddress = json['EmailAddress']==null?"":json['EmailAddress'];
    contactNo1 = json['ContactNo1']==null?"":json['ContactNo1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    data['InquiryNo'] = this.inquiryNo;
    data['StateCode'] = this.stateCode;
    data['StateName'] = this.stateName;
    data['CityCode'] = this.cityCode;
    data['CityName'] = this.cityName;
    data['ErpClosing'] = this.erpClosing;
    data['CountryCode'] = this.countryCode;
    data['CountryName'] = this.countryName;
    data['CustomerSourceName'] = this.customerSourceName;
    data['EmailAddress'] = this.emailAddress;
    data['ContactNo1'] = this.contactNo1;
    return data;
  }
}