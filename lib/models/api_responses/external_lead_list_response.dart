class ExternalLeadListResponse {
  List<ExternalLeadDetails> details;
  int totalCount;

  ExternalLeadListResponse({this.details, this.totalCount});

  ExternalLeadListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new ExternalLeadDetails.fromJson(v));
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

class ExternalLeadDetails {
  int pkId;
  int rowNum;
  String senderName;
  String senderMail;
  String queryDatetime;
  String companyName;
  String countryFlagURL;
  String message;
  String address;
  String city;
  String pincode;
  String state;
  String forProduct;
  String primaryMobileNo;
  int customerId;
  int productID;
  String customerName;
  String productName;
  String secondaryMobileNo;
  String leadSource;
  int employeeID;
  String employeeName;
  String leadStatus;
  int stateCode;
  int cityCode;
  String inquiryNo;
  int inquiryNopkID;
  String createdBy;
  String createdDate;
  int exLeadClosure;
  String acid;
  String exLeadClosureReason;
  String stateName;
  String cityName;
  String countryCode;
  String countryName;
  String closureRemark;

  ExternalLeadDetails(
      {this.pkId,
        this.rowNum,
        this.senderName,
        this.senderMail,
        this.queryDatetime,
        this.companyName,
        this.countryFlagURL,
        this.message,
        this.address,
        this.city,
        this.pincode,
        this.state,
        this.forProduct,
        this.primaryMobileNo,
        this.customerId,
        this.productID,
        this.customerName,
        this.productName,
        this.secondaryMobileNo,
        this.leadSource,
        this.employeeID,
        this.employeeName,
        this.leadStatus,
        this.stateCode,
        this.cityCode,
        this.inquiryNo,
        this.inquiryNopkID,
        this.createdBy,
        this.createdDate,
        this.exLeadClosure,
        this.acid,
        this.exLeadClosureReason,
        this.stateName,
        this.cityName,
        this.countryCode,
        this.countryName,
        this.closureRemark});

  ExternalLeadDetails.fromJson(Map<String, dynamic> json) {
    pkId = json['pkId']== null ?0: json['pkId'];
    rowNum = json['RowNum']== null ?0: json['RowNum'];
    senderName = json['SenderName']== null ?"": json['SenderName'];
    senderMail = json['SenderMail']== null ?"": json['SenderMail'];
    queryDatetime = json['QueryDatetime']== null ?"": json['QueryDatetime'];
    companyName = json['CompanyName']== null ?"": json['CompanyName'];
    countryFlagURL = json['CountryFlagURL']== null ?"": json['CountryFlagURL'];
    message = json['Message']== null ?"": json['Message'];
    address = json['Address']== null ?"": json['Address'];
    city = json['City']== null ?"": json['City'];
    pincode = json['Pincode']== null ?"": json['Pincode'];
    state = json['State']== null ?"": json['State'];
    forProduct = json['ForProduct']== null ?"": json['ForProduct'];
    primaryMobileNo = json['PrimaryMobileNo']== null ?"": json['PrimaryMobileNo'];
    customerId = json['CustomerId']== null ?0: json['CustomerId'];
    productID = json['ProductID']== null ?0: json['ProductID'];
    customerName = json['CustomerName']== null ?"": json['CustomerName'];
    productName = json['ProductName']== null ?"": json['ProductName'];
    secondaryMobileNo = json['SecondaryMobileNo']== null ?"": json['SecondaryMobileNo'];
    leadSource = json['LeadSource']== null ?"": json['LeadSource'];
    employeeID = json['EmployeeID']== null ?0: json['EmployeeID'];
    employeeName = json['EmployeeName']== null ?"": json['EmployeeName'];
    leadStatus = json['LeadStatus']== null ?"": json['LeadStatus'];
    stateCode = json['StateCode']== null ?0: json['StateCode'];
    cityCode = json['CityCode']== null ?0: json['CityCode'];
    inquiryNo = json['InquiryNo']== null ?"": json['InquiryNo'];
    inquiryNopkID = json['InquiryNopkID']== null ?0: json['InquiryNopkID'];
    createdBy = json['CreatedBy']== null ?"": json['CreatedBy'];
    createdDate = json['CreatedDate']== null ?"": json['CreatedDate'];
    exLeadClosure = json['ExLeadClosure']== null ?0: json['ExLeadClosure'];
    acid = json['acid']== null ?"": json['acid'];
    exLeadClosureReason = json['ExLeadClosureReason']== null ?"": json['ExLeadClosureReason'];
    stateName = json['StateName']== null ?"": json['StateName'];
    cityName = json['CityName']== null ?"": json['CityName'];
    countryCode = json['CountryCode']== null ?"": json['CountryCode'];
    countryName = json['CountryName']== null ?"": json['CountryName'];
    closureRemark = json['ClosureRemark']== null ?"": json['ClosureRemark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkId'] = this.pkId;
    data['RowNum'] = this.rowNum;
    data['SenderName'] = this.senderName;
    data['SenderMail'] = this.senderMail;
    data['QueryDatetime'] = this.queryDatetime;
    data['CompanyName'] = this.companyName;
    data['CountryFlagURL'] = this.countryFlagURL;
    data['Message'] = this.message;
    data['Address'] = this.address;
    data['City'] = this.city;
    data['Pincode'] = this.pincode;
    data['State'] = this.state;
    data['ForProduct'] = this.forProduct;
    data['PrimaryMobileNo'] = this.primaryMobileNo;
    data['CustomerId'] = this.customerId;
    data['ProductID'] = this.productID;
    data['CustomerName'] = this.customerName;
    data['ProductName'] = this.productName;
    data['SecondaryMobileNo'] = this.secondaryMobileNo;
    data['LeadSource'] = this.leadSource;
    data['EmployeeID'] = this.employeeID;
    data['EmployeeName'] = this.employeeName;
    data['LeadStatus'] = this.leadStatus;
    data['StateCode'] = this.stateCode;
    data['CityCode'] = this.cityCode;
    data['InquiryNo'] = this.inquiryNo;
    data['InquiryNopkID'] = this.inquiryNopkID;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['ExLeadClosure'] = this.exLeadClosure;
    data['acid'] = this.acid;
    data['ExLeadClosureReason'] = this.exLeadClosureReason;
    data['StateName'] = this.stateName;
    data['CityName'] = this.cityName;
    data['CountryCode'] = this.countryCode;
    data['CountryName'] = this.countryName;
    data['ClosureRemark'] = this.closureRemark;
    return data;
  }
}