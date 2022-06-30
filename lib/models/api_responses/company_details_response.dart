class CompanyDetailsResponse {
  List<CompanyProfile> details;
  int totalCount;

  CompanyDetailsResponse({this.details, this.totalCount});

  CompanyDetailsResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new CompanyProfile.fromJson(v));
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

class CompanyProfile {
  int pkId;
  String companyName;
  String siteURL;
  String expiryDate;
  String mobileAppVersion;
  int portNo;
  int iSAMC;
  String AndroidApp;
  String IOSApp;
  String MapApiKey;

  CompanyProfile(
      {this.pkId,
      this.companyName,
      this.siteURL,
      this.expiryDate,
      this.mobileAppVersion,
      this.portNo,
      this.iSAMC,
      this.AndroidApp,
      this.IOSApp,
      this.MapApiKey});

  CompanyProfile.fromJson(Map<String, dynamic> json) {
    pkId = json['pkId'] == null ? 0 : json['pkId'];
    companyName = json['CompanyName'] == null ? "" : json['CompanyName'];
    siteURL = json['SiteURL'] == null ? "" : json['SiteURL'];
    expiryDate = json['ExpiryDate'] == null ? "" : json['ExpiryDate'];
    mobileAppVersion =
        json['MobileAppVersion'] == null ? "" : json['MobileAppVersion'];
    portNo = json['PortNo'] == null ? 0 : json['PortNo'];
    iSAMC = json['ISAMC'] == null ? 0 : json['ISAMC'];
    AndroidApp = json['AndroidApp'] == null ? "" : json['AndroidApp'];
    IOSApp = json['IOSApp'] == null ? "" : json['IOSApp'];
    MapApiKey = json['MapApiKey'] == null ? "" : json['MapApiKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkId'] = this.pkId;
    data['CompanyName'] = this.companyName;
    data['SiteURL'] = this.siteURL;
    data['ExpiryDate'] = this.expiryDate;
    data['MobileAppVersion'] = this.mobileAppVersion;
    data['PortNo'] = this.portNo;
    data['ISAMC'] = this.iSAMC;
    data['AndroidApp'] = this.AndroidApp;
    data['IOSApp'] = this.IOSApp;
    data['MapApiKey'] = this.MapApiKey;
    return data;
  }
}
