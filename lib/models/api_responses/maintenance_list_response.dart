class MaintenanceListResponse {
  List<MaintenanceDetails> details;
  int totalCount;

  MaintenanceListResponse({this.details, this.totalCount});

  MaintenanceListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new MaintenanceDetails.fromJson(v));
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

class MaintenanceDetails {
  int rowNum;
  int pkID;
  String inquiryNo;
  String startDate;
  String endDate;
  String contractType;
  int customerID;
  String customerName;
  String contactPerson;
  String contactNumber;
  String emailAddress;
  String contractFooter;
  String contractTNC;
  String cityName;
  String stateName;
  double totalAmount;
  String employeeName;
  String designation;
  String createdBy;
  int companyID;

  MaintenanceDetails(
      {this.rowNum,
      this.pkID,
      this.inquiryNo,
      this.startDate,
      this.endDate,
      this.contractType,
      this.customerID,
      this.customerName,
      this.contactPerson,
      this.contactNumber,
      this.emailAddress,
      this.contractFooter,
      this.contractTNC,
      this.cityName,
      this.stateName,
      this.totalAmount,
      this.employeeName,
      this.designation,
      this.createdBy,
      this.companyID});

  MaintenanceDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum'] == null ? 0 : json['RowNum'];
    pkID = json['pkID'] == null ? 0 : json['pkID'];
    inquiryNo = json['InquiryNo'] == null ? "" : json['InquiryNo'];
    startDate = json['StartDate'] == null ? "" : json['StartDate'];
    endDate = json['EndDate'] == null ? "" : json['EndDate'];
    contractType = json['ContractType'] == null ? "" : json['ContractType'];
    customerID = json['CustomerID'] == null ? 0 : json['CustomerID'];
    customerName = json['CustomerName'] == null ? "" : json['CustomerName'];
    contactPerson = json['ContactPerson'] == null ? "" : json['ContactPerson'];
    contactNumber = json['ContactNumber'] == null ? "" : json['ContactNumber'];
    emailAddress = json['EmailAddress'] == null ? "" : json['EmailAddress'];
    contractFooter =
        json['ContractFooter'] == null ? "" : json['ContractFooter'];
    contractTNC = json['ContractTNC'] == null ? "" : json['ContractTNC'];
    cityName = json['CityName'] == null ? "" : json['CityName'];
    stateName = json['StateName'] == null ? "" : json['StateName'];
    totalAmount = json['TotalAmount'] == null ? 0.00 : json['TotalAmount'];
    employeeName = json['EmployeeName'] == null ? "" : json['EmployeeName'];
    designation = json['Designation'] == null ? "" : json['Designation'];
    createdBy = json['CreatedBy'] == null ? "" : json['CreatedBy'];
    companyID = json['CompanyID'] == null ? 0 : json['CompanyID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['InquiryNo'] = this.inquiryNo;
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    data['ContractType'] = this.contractType;
    data['CustomerID'] = this.customerID;
    data['CustomerName'] = this.customerName;
    data['ContactPerson'] = this.contactPerson;
    data['ContactNumber'] = this.contactNumber;
    data['EmailAddress'] = this.emailAddress;
    data['ContractFooter'] = this.contractFooter;
    data['ContractTNC'] = this.contractTNC;
    data['CityName'] = this.cityName;
    data['StateName'] = this.stateName;
    data['TotalAmount'] = this.totalAmount;
    data['EmployeeName'] = this.employeeName;
    data['Designation'] = this.designation;
    data['CreatedBy'] = this.createdBy;
    data['CompanyID'] = this.companyID;
    return data;
  }
}
