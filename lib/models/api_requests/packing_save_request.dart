class PackingSaveRequest {
  String CustomerID;
  String PCNo;
  String EmployeeID;
  String PCdate;
  String FinalizeDate;
  String DispatchDate;
  String Address;
  String Area;
  String CityCode;
  String StateCode;
  String CountryCode;
  String SoNo;
  String SoDate;
  String FinishProductID;
  String Application;
  String LoginUserID;
  String CompanyId;

  PackingSaveRequest({
    this.CustomerID,
    this.PCNo,
    this.EmployeeID,
    this.PCdate,
    this.FinalizeDate,
    this.DispatchDate,
    this.Address,
    this.Area,
    this.CityCode,
    this.StateCode,
    this.CountryCode,
    this.SoNo,
    this.SoDate,
    this.FinishProductID,
    this.Application,
    this.LoginUserID,
    this.CompanyId,
  });

  PackingSaveRequest.fromJson(Map<String, dynamic> json) {
    CustomerID = json['CustomerID'];
    PCNo = json['PCNo'];
    EmployeeID = json['EmployeeID'];
    PCdate = json['PCdate'];
    FinalizeDate = json['FinalizeDate'];
    DispatchDate = json['DispatchDate'];
    Address = json['Address'];
    Area = json['Area'];
    CityCode = json['CityCode'];
    StateCode = json['StateCode'];
    CountryCode = json['CountryCode'];
    SoNo = json['SoNo'];
    SoDate = json['SoDate'];
    FinishProductID = json['FinishProductID'];
    Application = json['Application'];
    LoginUserID = json['LoginUserID'];
    CompanyId = json['CompanyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['CustomerID'] = this.CustomerID;
    data['PCNo'] = this.PCNo;
    data['EmployeeID'] = this.EmployeeID;
    data['PCdate'] = this.PCdate;
    data['FinalizeDate'] = this.FinalizeDate;
    data['DispatchDate'] = this.DispatchDate;
    data['Address'] = this.Address;
    data['Area'] = this.Area;
    data['CityCode'] = this.CityCode;
    data['StateCode'] = this.StateCode;
    data['CountryCode'] = this.CountryCode;
    data['SoNo'] = this.SoNo;
    data['SoDate'] = this.SoDate;
    data['FinishProductID'] = this.FinishProductID;
    data['Application'] = this.Application;
    data['LoginUserID'] = this.LoginUserID;
    data['CompanyId'] = this.CompanyId;

    return data;
  }
}
