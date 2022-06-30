class CustomerIdToContactListResponse {
  List<CustomerIdToContactDetails> details;
  int totalCount;

  CustomerIdToContactListResponse({this.details, this.totalCount});

  CustomerIdToContactListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new CustomerIdToContactDetails.fromJson(v));
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

class CustomerIdToContactDetails {
  int rowNum;
  int pkID;
  int customerID;
  String customerName;
  String customerType;
  String contactPerson1;
  String contactDesigCode1;
  String desigName;
  String contactNumber1;
  String contactEmail1;
  String createdBy;
  String createdDate;
  String updatedBy;
  String updatedDate;

  CustomerIdToContactDetails(
      {this.rowNum,
        this.pkID,
        this.customerID,
        this.customerName,
        this.customerType,
        this.contactPerson1,
        this.contactDesigCode1,
        this.desigName,
        this.contactNumber1,
        this.contactEmail1,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate});

  CustomerIdToContactDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum'];
    pkID = json['pkID'];
    customerID = json['CustomerID'];
    customerName = json['CustomerName'];
    customerType = json['CustomerType'];
    contactPerson1 = json['ContactPerson1'];
    contactDesigCode1 = json['ContactDesigCode1'];
    desigName = json['DesigName'];
    contactNumber1 = json['ContactNumber1'];
    contactEmail1 = json['ContactEmail1'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
    updatedBy = json['UpdatedBy'];
    updatedDate = json['UpdatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['CustomerID'] = this.customerID;
    data['CustomerName'] = this.customerName;
    data['CustomerType'] = this.customerType;
    data['ContactPerson1'] = this.contactPerson1;
    data['ContactDesigCode1'] = this.contactDesigCode1;
    data['DesigName'] = this.desigName;
    data['ContactNumber1'] = this.contactNumber1;
    data['ContactEmail1'] = this.contactEmail1;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedBy'] = this.updatedBy;
    data['UpdatedDate'] = this.updatedDate;
    return data;
  }
}