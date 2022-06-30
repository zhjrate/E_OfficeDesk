class OutWordNoListResponse {
  List<OutWordDetails> details;
  int totalCount;

  OutWordNoListResponse({this.details, this.totalCount});

  OutWordNoListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new OutWordDetails.fromJson(v));
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

class OutWordDetails {
  String orderNo;
  int customerID;
  String customerName;
  int productID;
  String productName;
  String address;
  String area;
  String countryCode;
  String countryName;
  int stateCode;
  String stateName;
  int cityCode;
  String cityName;
  String pinCode;

  OutWordDetails(
      {this.orderNo,
        this.customerID,
        this.customerName,
        this.productID,
        this.productName,
        this.address,
        this.area,
        this.countryCode,
        this.countryName,
        this.stateCode,
        this.stateName,
        this.cityCode,
        this.cityName,
        this.pinCode});

  OutWordDetails.fromJson(Map<String, dynamic> json) {
    orderNo = json['OrderNo'];
    customerID = json['CustomerID'];
    customerName = json['CustomerName'];
    productID = json['ProductID'];
    productName = json['ProductName'];
    address = json['Address'];
    area = json['Area'];
    countryCode = json['CountryCode'];
    countryName = json['CountryName'];
    stateCode = json['StateCode'];
    stateName = json['StateName'];
    cityCode = json['CityCode'];
    cityName = json['CityName'];
    pinCode = json['PinCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OrderNo'] = this.orderNo;
    data['CustomerID'] = this.customerID;
    data['CustomerName'] = this.customerName;
    data['ProductID'] = this.productID;
    data['ProductName'] = this.productName;
    data['Address'] = this.address;
    data['Area'] = this.area;
    data['CountryCode'] = this.countryCode;
    data['CountryName'] = this.countryName;
    data['StateCode'] = this.stateCode;
    data['StateName'] = this.stateName;
    data['CityCode'] = this.cityCode;
    data['CityName'] = this.cityName;
    data['PinCode'] = this.pinCode;
    return data;
  }
}