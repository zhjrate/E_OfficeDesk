class QuotationNoToProductResponse {
  List<QuotationProductDetails> details;
  int totalCount;

  QuotationNoToProductResponse({this.details, this.totalCount});

  QuotationNoToProductResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new QuotationProductDetails.fromJson(v));
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

class QuotationProductDetails {
  int rowNum;
  int pkID;
  String quotationNo;
  String quotationDate;
  String inquiryNo;
  String projectName;
  int customerID;
  String customerName;
  String quotationSubject;
  String quotationKindAttn;
  int bundleId;
  String bundleName;
  int productID;
  String productName;
  String productNameLong;
  String productSpecification;
  double quantity;
  String unit;
  double unitRate;
  double discountPercent;
  double netRate;
  double amount;
  double taxRate;
  double taxAmount;
  double netAmount;
  double discountAmt;
  double sGSTPer;
  double sGSTAmt;
  double cGSTPer;
  double cGSTAmt;
  double iGSTPer;
  double iGSTAmt;
  int taxType;
  double headerDiscAmt;
  double roffAmt;
  double basicAmt;
  double headerDiscountAmt;
  int chargeID1;
  int chargeID2;
  int chargeID3;
  int chargeID4;
  int chargeID5;
  String chargeName1;
  String chargeName2;
  String chargeName3;
  String chargeName4;
  String chargeName5;
  double chargeAmt1;
  double chargeAmt2;
  double chargeAmt3;
  double chargeAmt4;
  double chargeAmt5;
  double chargeBasicAmt1;
  double chargeBasicAmt2;
  double chargeBasicAmt3;
  double chargeBasicAmt4;
  double chargeBasicAmt5;
  double chargeGSTAmt1;
  double chargeGSTAmt2;
  double chargeGSTAmt3;
  double chargeGSTAmt4;
  double chargeGSTAmt5;
  double netAmt;
  double minRate;
  double maxRate;

  QuotationProductDetails(
      {this.rowNum,
        this.pkID,
        this.quotationNo,
        this.quotationDate,
        this.inquiryNo,
        this.projectName,
        this.customerID,
        this.customerName,
        this.quotationSubject,
        this.quotationKindAttn,
        this.bundleId,
        this.bundleName,
        this.productID,
        this.productName,
        this.productNameLong,
        this.productSpecification,
        this.quantity,
        this.unit,
        this.unitRate,
        this.discountPercent,
        this.netRate,
        this.amount,
        this.taxRate,
        this.taxAmount,
        this.netAmount,
        this.discountAmt,
        this.sGSTPer,
        this.sGSTAmt,
        this.cGSTPer,
        this.cGSTAmt,
        this.iGSTPer,
        this.iGSTAmt,
        this.taxType,
        this.headerDiscAmt,
        this.roffAmt,
        this.basicAmt,
        this.headerDiscountAmt,
        this.chargeID1,
        this.chargeID2,
        this.chargeID3,
        this.chargeID4,
        this.chargeID5,
        this.chargeName1,
        this.chargeName2,
        this.chargeName3,
        this.chargeName4,
        this.chargeName5,
        this.chargeAmt1,
        this.chargeAmt2,
        this.chargeAmt3,
        this.chargeAmt4,
        this.chargeAmt5,
        this.chargeBasicAmt1,
        this.chargeBasicAmt2,
        this.chargeBasicAmt3,
        this.chargeBasicAmt4,
        this.chargeBasicAmt5,
        this.chargeGSTAmt1,
        this.chargeGSTAmt2,
        this.chargeGSTAmt3,
        this.chargeGSTAmt4,
        this.chargeGSTAmt5,
        this.netAmt,
        this.minRate,
        this.maxRate});

  QuotationProductDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum']==null?0:json['RowNum'];
    pkID = json['pkID']==null?0:json['pkID'];
    quotationNo = json['QuotationNo']==null?"":json['QuotationNo'];
    quotationDate = json['QuotationDate']==null?"":json['QuotationDate'];
    inquiryNo = json['InquiryNo']==null?"":json['InquiryNo'];
    projectName = json['ProjectName']==null?"":json['ProjectName'];
    customerID = json['CustomerID']==null?0:json['CustomerID'];
    customerName = json['CustomerName']==null?"":json['CustomerName'];
    quotationSubject = json['QuotationSubject']==null?"":json['QuotationSubject'];
    quotationKindAttn = json['QuotationKindAttn']==null?"":json['QuotationKindAttn'];
    bundleId = json['BundleId']==null?0:json['BundleId'];
    bundleName = json['BundleName']==null?"":json['BundleName'];
    productID = json['ProductID']==null?0:json['ProductID'];
    productName = json['ProductName']==null?"":json['ProductName'];
    productNameLong = json['ProductNameLong']==null?"":json['ProductNameLong'];
    productSpecification = json['ProductSpecification']==null?"":json['ProductSpecification'];
    quantity = json['Quantity']==null?0.00:json['Quantity'];
    unit = json['Unit']==null?"":json['Unit'];
    unitRate = json['UnitRate']==null?0.00:json['UnitRate'];
    discountPercent = json['DiscountPercent']==null?0.00:json['DiscountPercent'];
    netRate = json['NetRate']==null?0.00:json['NetRate'];
    amount = json['Amount']==null?0.00:json['Amount'];
    taxRate = json['TaxRate']==null?0.00:json['TaxRate'];
    taxAmount = json['TaxAmount']==null?0.00:json['TaxAmount'];
    netAmount = json['NetAmount']==null?0.00:json['NetAmount'];
    discountAmt = json['DiscountAmt']==null?0.00:json['DiscountAmt'];
    sGSTPer = json['SGSTPer']==null?0.00:json['SGSTPer'];
    sGSTAmt = json['SGSTAmt']==null?0.00:json['SGSTAmt'];
    cGSTPer = json['CGSTPer']==null?0.00:json['CGSTPer'];
    cGSTAmt = json['CGSTAmt']==null?0.00:json['CGSTAmt'];
    iGSTPer = json['IGSTPer']==null?0.00:json['IGSTPer'];
    iGSTAmt = json['IGSTAmt']==null?0.00:json['IGSTAmt'];
    taxType = json['TaxType']==null?0:json['TaxType'];
    headerDiscAmt = json['HeaderDiscAmt']==null?0.00:json['HeaderDiscAmt'];
    roffAmt = json['RoffAmt']==null?0.00:json['RoffAmt'];
    basicAmt = json['BasicAmt']==null?0.00:json['BasicAmt'];
    headerDiscountAmt = json['HeaderDiscountAmt']==null?0.00:json['HeaderDiscountAmt'];
    chargeID1 = json['ChargeID1']==null?0:json['ChargeID1'];
    chargeID2 = json['ChargeID2']==null?0:json['ChargeID2'];
    chargeID3 = json['ChargeID3']==null?0:json['ChargeID3'];
    chargeID4 = json['ChargeID4']==null?0:json['ChargeID4'];
    chargeID5 = json['ChargeID5']==null?0:json['ChargeID5'];
    chargeName1 = json['ChargeName1']==null?"":json['ChargeName1'];
    chargeName2 = json['ChargeName2']==null?"":json['ChargeName2'];
    chargeName3 = json['ChargeName3']==null?"":json['ChargeName3'];
    chargeName4 = json['ChargeName4']==null?"":json['ChargeName4'];
    chargeName5 = json['ChargeName5']==null?"":json['ChargeName5'];
    chargeAmt1 = json['ChargeAmt1']==null?0.00:json['ChargeAmt1'];
    chargeAmt2 = json['ChargeAmt2']==null?0.00:json['ChargeAmt2'];
    chargeAmt3 = json['ChargeAmt3']==null?0.00:json['ChargeAmt3'];
    chargeAmt4 = json['ChargeAmt4']==null?0.00:json['ChargeAmt4'];
    chargeAmt5 = json['ChargeAmt5']==null?0.00:json['ChargeAmt5'];
    chargeBasicAmt1 = json['ChargeBasicAmt1']==null?0.00:json['ChargeBasicAmt1'];
    chargeBasicAmt2 = json['ChargeBasicAmt2']==null?0.00:json['ChargeBasicAmt2'];
    chargeBasicAmt3 = json['ChargeBasicAmt3']==null?0.00:json['ChargeBasicAmt3'];
    chargeBasicAmt4 = json['ChargeBasicAmt4']==null?0.00:json['ChargeBasicAmt4'];
    chargeBasicAmt5 = json['ChargeBasicAmt5']==null?0.00:json['ChargeBasicAmt5'];
    chargeGSTAmt1 = json['ChargeGSTAmt1']==null?0.00:json['ChargeGSTAmt1'];
    chargeGSTAmt2 = json['ChargeGSTAmt2']==null?0.00:json['ChargeGSTAmt2'];
    chargeGSTAmt3 = json['ChargeGSTAmt3']==null?0.00:json['ChargeGSTAmt3'];
    chargeGSTAmt4 = json['ChargeGSTAmt4']==null?0.00:json['ChargeGSTAmt4'];
    chargeGSTAmt5 = json['ChargeGSTAmt5']==null?0.00:json['ChargeGSTAmt5'];
    netAmt = json['NetAmt']==null?0.00:json['NetAmt'];
    minRate = json['MinRate']==null?0.00:json['MinRate'];
    maxRate = json['MaxRate']==null?0.00:json['MaxRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['QuotationNo'] = this.quotationNo;
    data['QuotationDate'] = this.quotationDate;
    data['InquiryNo'] = this.inquiryNo;
    data['ProjectName'] = this.projectName;
    data['CustomerID'] = this.customerID;
    data['CustomerName'] = this.customerName;
    data['QuotationSubject'] = this.quotationSubject;
    data['QuotationKindAttn'] = this.quotationKindAttn;
    data['BundleId'] = this.bundleId;
    data['BundleName'] = this.bundleName;
    data['ProductID'] = this.productID;
    data['ProductName'] = this.productName;
    data['ProductNameLong'] = this.productNameLong;
    data['ProductSpecification'] = this.productSpecification;
    data['Quantity'] = this.quantity;
    data['Unit'] = this.unit;
    data['UnitRate'] = this.unitRate;
    data['DiscountPercent'] = this.discountPercent;
    data['NetRate'] = this.netRate;
    data['Amount'] = this.amount;
    data['TaxRate'] = this.taxRate;
    data['TaxAmount'] = this.taxAmount;
    data['NetAmount'] = this.netAmount;
    data['DiscountAmt'] = this.discountAmt;
    data['SGSTPer'] = this.sGSTPer;
    data['SGSTAmt'] = this.sGSTAmt;
    data['CGSTPer'] = this.cGSTPer;
    data['CGSTAmt'] = this.cGSTAmt;
    data['IGSTPer'] = this.iGSTPer;
    data['IGSTAmt'] = this.iGSTAmt;
    data['TaxType'] = this.taxType;
    data['HeaderDiscAmt'] = this.headerDiscAmt;
    data['RoffAmt'] = this.roffAmt;
    data['BasicAmt'] = this.basicAmt;
    data['HeaderDiscountAmt'] = this.headerDiscountAmt;
    data['ChargeID1'] = this.chargeID1;
    data['ChargeID2'] = this.chargeID2;
    data['ChargeID3'] = this.chargeID3;
    data['ChargeID4'] = this.chargeID4;
    data['ChargeID5'] = this.chargeID5;
    data['ChargeName1'] = this.chargeName1;
    data['ChargeName2'] = this.chargeName2;
    data['ChargeName3'] = this.chargeName3;
    data['ChargeName4'] = this.chargeName4;
    data['ChargeName5'] = this.chargeName5;
    data['ChargeAmt1'] = this.chargeAmt1;
    data['ChargeAmt2'] = this.chargeAmt2;
    data['ChargeAmt3'] = this.chargeAmt3;
    data['ChargeAmt4'] = this.chargeAmt4;
    data['ChargeAmt5'] = this.chargeAmt5;
    data['ChargeBasicAmt1'] = this.chargeBasicAmt1;
    data['ChargeBasicAmt2'] = this.chargeBasicAmt2;
    data['ChargeBasicAmt3'] = this.chargeBasicAmt3;
    data['ChargeBasicAmt4'] = this.chargeBasicAmt4;
    data['ChargeBasicAmt5'] = this.chargeBasicAmt5;
    data['ChargeGSTAmt1'] = this.chargeGSTAmt1;
    data['ChargeGSTAmt2'] = this.chargeGSTAmt2;
    data['ChargeGSTAmt3'] = this.chargeGSTAmt3;
    data['ChargeGSTAmt4'] = this.chargeGSTAmt4;
    data['ChargeGSTAmt5'] = this.chargeGSTAmt5;
    data['NetAmt'] = this.netAmt;
    data['MinRate'] = this.minRate;
    data['MaxRate'] = this.maxRate;
    return data;
  }
}