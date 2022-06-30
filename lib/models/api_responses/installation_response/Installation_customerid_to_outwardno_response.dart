class CustomerIdToOutwardnoResponse {
  List<CustomerIdToOutwardnoDetails> details;
  int totalCount;

  CustomerIdToOutwardnoResponse({this.details, this.totalCount});

  CustomerIdToOutwardnoResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new CustomerIdToOutwardnoDetails.fromJson(v));
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

class CustomerIdToOutwardnoDetails {
  String outwardNo;
  int customerID;
  String customerName;
  int finishProductID;
  String productName;
  String address;
  String area;
  int cityCode;
  String cityName;
  int stateCode;
  String stateName;
  String countryCode;
  String countryName;
  String pinCode;
  String contactNo1;

  CustomerIdToOutwardnoDetails(
      {this.outwardNo,
        this.customerID,
        this.customerName,
        this.finishProductID,
        this.productName,
        this.address,
        this.area,
        this.cityCode,
        this.cityName,
        this.stateCode,
        this.stateName,
        this.countryCode,
        this.countryName,
        this.pinCode,
        this.contactNo1});

  CustomerIdToOutwardnoDetails.fromJson(Map<String, dynamic> json) {
    outwardNo = json['OutwardNo']==null?"":json['OutwardNo'];
    customerID = json['CustomerID']==null?0:json['CustomerID'];
    customerName = json['CustomerName']==null?"":json['CustomerName'];
    finishProductID = json['FinishProductID']==null?0:json['FinishProductID'];
    productName = json['ProductName']==null?"":json['ProductName'];
    address = json['Address']==null?"":json['Address'];
    area = json['Area']==null?"":json['Area'];
    cityCode = json['CityCode']==null?0:json['CityCode'];
    cityName = json['CityName']==null?"":json['CityName'];
    stateCode = json['StateCode']==null?0:json['StateCode'];
    stateName = json['StateName']==null?"":json['StateName'];
    countryCode = json['CountryCode']==null?"":json['CountryCode'];
    countryName = json['CountryName']==null?"":json['CountryName'];
    pinCode = json['PinCode']==null?"":json['PinCode'];
    contactNo1 = json['ContactNo1']==null?"":json['ContactNo1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OutwardNo'] = this.outwardNo;
    data['CustomerID'] = this.customerID;
    data['CustomerName'] = this.customerName;
    data['FinishProductID'] = this.finishProductID;
    data['ProductName'] = this.productName;
    data['Address'] = this.address;
    data['Area'] = this.area;
    data['CityCode'] = this.cityCode;
    data['CityName'] = this.cityName;
    data['StateCode'] = this.stateCode;
    data['StateName'] = this.stateName;
    data['CountryCode'] = this.countryCode;
    data['CountryName'] = this.countryName;
    data['PinCode'] = this.pinCode;
    data['ContactNo1'] = this.contactNo1;
    return data;
  }
}