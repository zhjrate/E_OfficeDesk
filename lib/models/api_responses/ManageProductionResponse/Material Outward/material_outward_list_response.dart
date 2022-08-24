class MaterialOutwardListResponse {
  List<MaterialOutwardListResponseDetails> materialOutwardListResponseDetails;
  int totalCount;

  MaterialOutwardListResponse(
      {this.materialOutwardListResponseDetails, this.totalCount});

  MaterialOutwardListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      materialOutwardListResponseDetails =
          <MaterialOutwardListResponseDetails>[];
      json['details'].forEach((v) {
        materialOutwardListResponseDetails
            .add(new MaterialOutwardListResponseDetails.fromJson(v));
      });
    }
    totalCount = json['TotalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.materialOutwardListResponseDetails != null) {
      data['details'] = this
          .materialOutwardListResponseDetails
          .map((v) => v.toJson())
          .toList();
    }
    data['TotalCount'] = this.totalCount;
    return data;
  }
}

class MaterialOutwardListResponseDetails {
  int rowNum;
  int pkID;
  String outwardNo;
  String outwardDate;
  String orderNo;
  String orderStatus;
  String exporterRef;
  String supOrderRef;
  String supOrderDate;
  String otherRef;
  String referenceNo;
  String docRefNoList;
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
  String createdBy;
  String createdDate;
  String updatedBy;
  String updatedDate;
  String createdEmployeeName;
  String updatedEmployeeName;
  double basicAmount;
  double taxAmount;
  double outwardAmount;
  String modeOfTransport;
  String transporterName;
  String vehicleNo;
  String lRNo;
  String lRDate;
  String dCNo;
  String dCDate;
  String deliveryNote;
  String remarks;
  String manualOutwardNo;

  MaterialOutwardListResponseDetails(
      {this.rowNum,
      this.pkID,
      this.outwardNo,
      this.outwardDate,
      this.orderNo,
      this.orderStatus,
      this.exporterRef,
      this.supOrderRef,
      this.supOrderDate,
      this.otherRef,
      this.referenceNo,
      this.docRefNoList,
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
      this.createdBy,
      this.createdDate,
      this.updatedBy,
      this.updatedDate,
      this.createdEmployeeName,
      this.updatedEmployeeName,
      this.basicAmount,
      this.taxAmount,
      this.outwardAmount,
      this.modeOfTransport,
      this.transporterName,
      this.vehicleNo,
      this.lRNo,
      this.lRDate,
      this.dCNo,
      this.dCDate,
      this.deliveryNote,
      this.remarks,
      this.manualOutwardNo});

  MaterialOutwardListResponseDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum'] == null ? 0 : json['RowNum'];
    pkID = json['pkID'] == null ? 0 : json['pkID'];
    outwardNo = json['OutwardNo'] == null ? "" : json['OutwardNo'];
    outwardDate = json['OutwardDate'] == null ? "" : json['OutwardDate'];
    orderNo = json['OrderNo'] == null ? "" : json['OrderNo'];
    orderStatus = json['OrderStatus'] == null ? "" : json['OrderStatus'];
    exporterRef = json['ExporterRef'] == null ? "" : json['ExporterRef'];
    supOrderRef = json['SupOrderRef'] == null ? "" : json['SupOrderRef'];
    supOrderDate = json['SupOrderDate'] == null ? "" : json['SupOrderDate'];
    otherRef = json['OtherRef'] == null ? "" : json['OtherRef'];
    referenceNo = json['ReferenceNo'] == null ? "" : json['ReferenceNo'];
    docRefNoList = json['DocRefNoList'] == null ? "" : json['DocRefNoList'];
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
    outwardAmount = json['OutwardAmount'] == null ? 0.0 : json['OutwardAmount'];
    modeOfTransport =
        json['ModeOfTransport'] == null ? "" : json['ModeOfTransport'];
    transporterName =
        json['TransporterName'] == null ? "" : json['TransporterName'];
    vehicleNo = json['VehicleNo'] == null ? "" : json['VehicleNo'];
    lRNo = json['LRNo'] == null ? "" : json['LRNo'];
    lRDate = json['LRDate'] == null ? "" : json['LRDate'];
    dCNo = json['DCNo'] == null ? "" : json['DCNo'];
    dCDate = json['DCDate'] == null ? "" : json['DCDate'];
    deliveryNote = json['DeliveryNote'] == null ? "" : json['DeliveryNote'];
    remarks = json['Remarks'] == null ? "" : json['Remarks'];
    manualOutwardNo =
        json['ManualOutwardNo'] == null ? "" : json['ManualOutwardNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['OutwardNo'] = this.outwardNo;
    data['OutwardDate'] = this.outwardDate;
    data['OrderNo'] = this.orderNo;
    data['OrderStatus'] = this.orderStatus;
    data['ExporterRef'] = this.exporterRef;
    data['SupOrderRef'] = this.supOrderRef;
    data['SupOrderDate'] = this.supOrderDate;
    data['OtherRef'] = this.otherRef;
    data['ReferenceNo'] = this.referenceNo;
    data['DocRefNoList'] = this.docRefNoList;
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
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedBy'] = this.updatedBy;
    data['UpdatedDate'] = this.updatedDate;
    data['CreatedEmployeeName'] = this.createdEmployeeName;
    data['UpdatedEmployeeName'] = this.updatedEmployeeName;
    data['BasicAmount'] = this.basicAmount;
    data['TaxAmount'] = this.taxAmount;
    data['OutwardAmount'] = this.outwardAmount;
    data['ModeOfTransport'] = this.modeOfTransport;
    data['TransporterName'] = this.transporterName;
    data['VehicleNo'] = this.vehicleNo;
    data['LRNo'] = this.lRNo;
    data['LRDate'] = this.lRDate;
    data['DCNo'] = this.dCNo;
    data['DCDate'] = this.dCDate;
    data['DeliveryNote'] = this.deliveryNote;
    data['Remarks'] = this.remarks;
    data['ManualOutwardNo'] = this.manualOutwardNo;
    return data;
  }
}
