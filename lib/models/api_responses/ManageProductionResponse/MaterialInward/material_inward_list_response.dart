class MaterialInwardListResponse {
  List<MaterialInwardListResponseDetails> MaterialInwardListResponsedetails;
  int totalCount;

  MaterialInwardListResponse(
      {this.MaterialInwardListResponsedetails, this.totalCount});

  MaterialInwardListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      MaterialInwardListResponsedetails = <MaterialInwardListResponseDetails>[];
      json['details'].forEach((v) {
        MaterialInwardListResponsedetails.add(
            new MaterialInwardListResponseDetails.fromJson(v));
      });
    }
    totalCount = json['TotalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.MaterialInwardListResponsedetails != null) {
      data['details'] = this
          .MaterialInwardListResponsedetails
          .map((v) => v.toJson())
          .toList();
    }
    data['TotalCount'] = this.totalCount;
    return data;
  }
}

class MaterialInwardListResponseDetails {
  int rowNum;
  int pkID;
  String inwardNo;
  String inwardDate;
  int customerID;
  String customerName;
  int locationID;
  String address;
  String area;
  String pinCode;
  String city;
  String emailAddress;
  String contactNo1;
  String contactNo2;
  double basicAmt;
  double discountAmt;
  double taxAmt;
  double rOffAmt;
  double netAmt;
  double sGSTAmt;
  double cGSTAmt;
  double iGSTAmt;
  String modeOfTransport;
  String transporterName;
  String vehicleNo;
  String lRNo;
  String lRDate;
  String transportRemark;
  String createdBy;
  String createdDate;
  String updatedBy;
  String updatedDate;
  String createdEmployeeName;
  String updatedEmployeeName;
  double basicAmount;
  double taxAmount;
  double inwardAmount;

  MaterialInwardListResponseDetails(
      {this.rowNum,
      this.pkID,
      this.inwardNo,
      this.inwardDate,
      this.customerID,
      this.customerName,
      this.locationID,
      this.address,
      this.area,
      this.pinCode,
      this.city,
      this.emailAddress,
      this.contactNo1,
      this.contactNo2,
      this.basicAmt,
      this.discountAmt,
      this.taxAmt,
      this.rOffAmt,
      this.netAmt,
      this.sGSTAmt,
      this.cGSTAmt,
      this.iGSTAmt,
      this.modeOfTransport,
      this.transporterName,
      this.vehicleNo,
      this.lRNo,
      this.lRDate,
      this.transportRemark,
      this.createdBy,
      this.createdDate,
      this.updatedBy,
      this.updatedDate,
      this.createdEmployeeName,
      this.updatedEmployeeName,
      this.basicAmount,
      this.taxAmount,
      this.inwardAmount});

  MaterialInwardListResponseDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum'] == null ? 0 : json['RowNum'];
    pkID = json['pkID'] == null ? 0 : json['pkID'];
    inwardNo = json['InwardNo'] == null ? "" : json['InwardNo'];
    inwardDate = json['InwardDate'] == null ? "" : json['InwardDate'];
    customerID = json['CustomerID'] == null ? 0 : json['CustomerID'];
    customerName = json['CustomerName'] == null ? "" : json['CustomerName'];
    locationID = json['LocationID'] == null ? 0 : json['LocationID'];
    address = json['Address'] == null ? "" : json['Address'];
    area = json['Area'] == null ? "" : json['Area'];
    pinCode = json['PinCode'] == null ? "" : json['PinCode'];
    city = json['City'] == null ? "" : json['City'];
    emailAddress = json['EmailAddress'] == null ? "" : json['EmailAddress'];
    contactNo1 = json['ContactNo1'] == null ? "" : json['ContactNo1'];
    contactNo2 = json['ContactNo2'] == null ? "" : json['ContactNo2'];
    basicAmt = json['BasicAmt'] == null ? 0.0 : json['BasicAmt'];
    discountAmt = json['DiscountAmt'] == null ? 0.0 : json['DiscountAmt'];
    taxAmt = json['TaxAmt'] == null ? 0.0 : json['TaxAmt'];
    rOffAmt = json['ROffAmt'] == null ? 0.0 : json['ROffAmt'];
    netAmt = json['NetAmt'] == null ? 0.0 : json['NetAmt'];
    sGSTAmt = json['SGSTAmt'] == null ? 0.0 : json['SGSTAmt'];
    cGSTAmt = json['CGSTAmt'] == null ? 0.0 : json['CGSTAmt'];
    iGSTAmt = json['IGSTAmt'] == null ? 0.0 : json['IGSTAmt'];
    modeOfTransport =
        json['ModeOfTransport'] == null ? "" : json['ModeOfTransport'];
    transporterName =
        json['TransporterName'] == null ? "" : json['TransporterName'];
    vehicleNo = json['VehicleNo'] == null ? "" : json['VehicleNo'];
    lRNo = json['LRNo'] == null ? "" : json['LRNo'];
    lRDate = json['LRDate'] == null ? "" : json['LRDate'];
    transportRemark =
        json['TransportRemark'] == null ? "" : json['TransportRemark'];
    createdBy = json['CreatedBy'] == null ? "" : json['CreatedBy'];
    createdDate = json['CreatedDate'] == null ? "" : json['CreatedDate'];
    updatedBy = json['UpdatedBy'] == null ? "" : json['UpdatedBy'];
    updatedDate = json['UpdatedDate'] == null ? "" : json['UpdatedDate'];
    createdEmployeeName =
        json['CreatedEmployeeName'] == null ? "" : json['CreatedEmployeeName'];
    updatedEmployeeName =
        json['UpdatedEmployeeName'] == null ? "" : json['UpdatedEmployeeName'];
    basicAmount = json['BasicAmount'] == null ? 0.0 : json['BasicAmount'];
    taxAmount = json['TaxAmount'] == null ? 0.0 : json['TaxAmount'];
    inwardAmount = json['InwardAmount'] == null ? 0.0 : json['InwardAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['InwardNo'] = this.inwardNo;
    data['InwardDate'] = this.inwardDate;
    data['CustomerID'] = this.customerID;
    data['CustomerName'] = this.customerName;
    data['LocationID'] = this.locationID;
    data['Address'] = this.address;
    data['Area'] = this.area;
    data['PinCode'] = this.pinCode;
    data['City'] = this.city;
    data['EmailAddress'] = this.emailAddress;
    data['ContactNo1'] = this.contactNo1;
    data['ContactNo2'] = this.contactNo2;
    data['BasicAmt'] = this.basicAmt;
    data['DiscountAmt'] = this.discountAmt;
    data['TaxAmt'] = this.taxAmt;
    data['ROffAmt'] = this.rOffAmt;
    data['NetAmt'] = this.netAmt;
    data['SGSTAmt'] = this.sGSTAmt;
    data['CGSTAmt'] = this.cGSTAmt;
    data['IGSTAmt'] = this.iGSTAmt;
    data['ModeOfTransport'] = this.modeOfTransport;
    data['TransporterName'] = this.transporterName;
    data['VehicleNo'] = this.vehicleNo;
    data['LRNo'] = this.lRNo;
    data['LRDate'] = this.lRDate;
    data['TransportRemark'] = this.transportRemark;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedBy'] = this.updatedBy;
    data['UpdatedDate'] = this.updatedDate;
    data['CreatedEmployeeName'] = this.createdEmployeeName;
    data['UpdatedEmployeeName'] = this.updatedEmployeeName;
    data['BasicAmount'] = this.basicAmount;
    data['TaxAmount'] = this.taxAmount;
    data['InwardAmount'] = this.inwardAmount;
    return data;
  }
}
