class SalesBillListResponse {
  List<SaleBillDetails> details;
  int totalCount;

  SalesBillListResponse({this.details, this.totalCount});

  SalesBillListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new SaleBillDetails.fromJson(v));
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

class SaleBillDetails {
  int rowNum;
  int pkID;
  String invoiceNo;
  String invoiceDate;
  double basicAmt;
  double discountAmt;
  double taxAmt;
  double rOffAmt;
  double netAmt;
  double cGSTAmt;
  double sGSTAmt;
  double iGSTAmt;
  String inquiryNo;
  String orderNo;
  String quotationNo;
  String complaintNo;
  String refType;
  String referenceNo;
  String refNo;
  String supplierRef;
  String supplierRefDate;
  String otherRef;
  String patientName;
  String patientType;
  double amount;
  double percentage;
  double estimatedAmt;
  String emailContent;
  String emailSubject;
  int fixedLedgerID;
  String fixedLedgerName;
  String docRefNoList;
  int customerID;
  String customerName;
  String gSTNO;
  int bankID;
  int locationID;
  String locationName;
  String bankName;
  String branchName;
  String bankAccountName;
  String bankAccountNo;
  String bankIFSC;
  String bankSWIFT;
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
  int terminationOfDeliery;
  String terminationOfDelieryName;
  int terminationOfDelieryCity;
  String terminationOfDelieryCityName;
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
  String modeOfTransport;
  String transporterName;
  String vehicleNo;
  String deliveryNote;
  String deliveryDate;
  String lRNo;
  String dispatchDocNo;
  String lRDate;
  String ewayBillNo;
  String modeOfPayment;
  String transportRemark;
  String deliverTo;
  String currencyName;
  String currencySymbol;
  int exchangeRate;
  String termsCondition;
  String createdBy;
  String createdDate;
  String updatedBy;
  String updatedDate;
  int createdID;
  String createdEmployeeName;
  String createdEmployeeMobile;
  String updatedEmployeeName;
  int companyID;
  double billAmount;

  SaleBillDetails(
      {this.rowNum,
        this.pkID,
        this.invoiceNo,
        this.invoiceDate,
        this.basicAmt,
        this.discountAmt,
        this.taxAmt,
        this.rOffAmt,
        this.netAmt,
        this.cGSTAmt,
        this.sGSTAmt,
        this.iGSTAmt,
        this.inquiryNo,
        this.orderNo,
        this.quotationNo,
        this.complaintNo,
        this.refType,
        this.referenceNo,
        this.refNo,
        this.supplierRef,
        this.supplierRefDate,
        this.otherRef,
        this.patientName,
        this.patientType,
        this.amount,
        this.percentage,
        this.estimatedAmt,
        this.emailContent,
        this.emailSubject,
        this.fixedLedgerID,
        this.fixedLedgerName,
        this.docRefNoList,
        this.customerID,
        this.customerName,
        this.gSTNO,
        this.bankID,
        this.locationID,
        this.locationName,
        this.bankName,
        this.branchName,
        this.bankAccountName,
        this.bankAccountNo,
        this.bankIFSC,
        this.bankSWIFT,
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
        this.terminationOfDeliery,
        this.terminationOfDelieryName,
        this.terminationOfDelieryCity,
        this.terminationOfDelieryCityName,
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
        this.modeOfTransport,
        this.transporterName,
        this.vehicleNo,
        this.deliveryNote,
        this.deliveryDate,
        this.lRNo,
        this.dispatchDocNo,
        this.lRDate,
        this.ewayBillNo,
        this.modeOfPayment,
        this.transportRemark,
        this.deliverTo,
        this.currencyName,
        this.currencySymbol,
        this.exchangeRate,
        this.termsCondition,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate,
        this.createdID,
        this.createdEmployeeName,
        this.createdEmployeeMobile,
        this.updatedEmployeeName,
        this.companyID,
        this.billAmount});

  SaleBillDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum']==null?0:json['RowNum'];
    pkID = json['pkID']==null?0:json['pkID'];
    invoiceNo = json['InvoiceNo']==null?"":json['InvoiceNo'];
    invoiceDate = json['InvoiceDate']==null?"":json['InvoiceDate'];
    basicAmt = json['BasicAmt']==null?0.00:json['BasicAmt'];
    discountAmt = json['DiscountAmt']==null?0.00:json['DiscountAmt'];
    taxAmt = json['TaxAmt']==null?0.00:json['TaxAmt'];
    rOffAmt = json['ROffAmt']==null?0.00:json['ROffAmt'];
    netAmt = json['NetAmt']==null?0.00:json['NetAmt'];
    cGSTAmt = json['CGSTAmt']==null?0.00:json['CGSTAmt'];
    sGSTAmt = json['SGSTAmt']==null?0.00:json['SGSTAmt'];
    iGSTAmt = json['IGSTAmt']==null?0.00:json['IGSTAmt'];
    inquiryNo = json['InquiryNo']==null?"":json['InquiryNo'];
    orderNo = json['OrderNo']==null?"":json['OrderNo'];
    quotationNo = json['QuotationNo']==null?"":json['QuotationNo'];
    complaintNo = json['ComplaintNo']==null?"":json['ComplaintNo'];
    refType = json['RefType']==null?"":json['RefType'];
    referenceNo = json['ReferenceNo']==null?"":json['ReferenceNo'];
    refNo = json['RefNo']==null?"":json['RefNo'];
    supplierRef = json['SupplierRef']==null?"":json['SupplierRef'];
    supplierRefDate = json['SupplierRefDate']==null?"":json['SupplierRefDate'];
    otherRef = json['OtherRef']==null?"":json['OtherRef'];
    patientName = json['PatientName']==null?"":json['PatientName'];
    patientType = json['PatientType']==null?"":json['PatientType'];
    amount = json['Amount']==null?0.00:json['Amount'];
    percentage = json['Percentage']==null?0.00:json['Percentage'];
    estimatedAmt = json['EstimatedAmt']==null?0.00:json['EstimatedAmt'];
    emailContent = json['EmailContent']==null?"":json['EmailContent'];
    emailSubject = json['EmailSubject']==null?"":json['EmailSubject'];
    fixedLedgerID = json['FixedLedgerID']==null?0:json['FixedLedgerID'];
    fixedLedgerName = json['FixedLedgerName']==null?"":json['FixedLedgerName'];
    docRefNoList = json['DocRefNoList']==null?"":json['DocRefNoList'];
    customerID = json['CustomerID']==null?0:json['CustomerID'];
    customerName = json['CustomerName']==null?"":json['CustomerName'];
    gSTNO = json['GSTNO']==null?"":json['GSTNO'];
    bankID = json['BankID']==null?0:json['BankID'];
    locationID = json['LocationID']==null?0:json['LocationID'];
    locationName = json['LocationName']==null?"":json['LocationName'];
    bankName = json['BankName']==null?"":json['BankName'];
    branchName = json['BranchName']==null?"":json['BranchName'];
    bankAccountName = json['BankAccountName']==null?"":json['BankAccountName'];
    bankAccountNo = json['BankAccountNo']==null?"":json['BankAccountNo'];
    bankIFSC = json['BankIFSC']==null?"":json['BankIFSC'];
    bankSWIFT = json['BankSWIFT']==null?"":json['BankSWIFT'];
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
    terminationOfDeliery = json['TerminationOfDeliery']==null?0:json['TerminationOfDeliery'];
    terminationOfDelieryName = json['TerminationOfDelieryName']==null?"":json['TerminationOfDelieryName'];
    terminationOfDelieryCity = json['TerminationOfDelieryCity']==null?0:json['TerminationOfDelieryCity'];
    terminationOfDelieryCityName = json['TerminationOfDelieryCityName']==null?"":json['TerminationOfDelieryCityName'];
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
    modeOfTransport = json['ModeOfTransport']==null?"":json['ModeOfTransport'];
    transporterName = json['TransporterName']==null?"":json['TransporterName'];
    vehicleNo = json['VehicleNo']==null?"":json['VehicleNo'];
    deliveryNote = json['DeliveryNote']==null?"":json['DeliveryNote'];
    deliveryDate = json['DeliveryDate']==null?"":json['DeliveryDate'];
    lRNo = json['LRNo']==null?"":json['LRNo'];
    dispatchDocNo = json['DispatchDocNo']==null?"":json['DispatchDocNo'];
    lRDate = json['LRDate']==null?"":json['LRDate'];
    ewayBillNo = json['EwayBillNo']==null?"":json['EwayBillNo'];
    modeOfPayment = json['ModeOfPayment']==null?"":json['ModeOfPayment'];
    transportRemark = json['TransportRemark']==null?"":json['TransportRemark'];
    deliverTo = json['DeliverTo']==null?"":json['DeliverTo'];
    currencyName = json['CurrencyName']==null?"":json['CurrencyName'];
    currencySymbol = json['CurrencySymbol']==null?"":json['CurrencySymbol'];
    exchangeRate = json['ExchangeRate']==null?0:json['ExchangeRate'];
    termsCondition = json['TermsCondition']==null?"":json['TermsCondition'];
    createdBy = json['CreatedBy']==null?"":json['CreatedBy'];
    createdDate = json['CreatedDate']==null?"":json['CreatedDate'];
    updatedBy = json['UpdatedBy']==null?"":json['UpdatedBy'];
    updatedDate = json['UpdatedDate']==null?"":json['UpdatedDate'];
    createdID = json['CreatedID']==null?0:json['CreatedID'];
    createdEmployeeName = json['CreatedEmployeeName']==null?"":json['CreatedEmployeeName'];
    createdEmployeeMobile = json['CreatedEmployeeMobile']==null?"":json['CreatedEmployeeMobile'];
    updatedEmployeeName = json['UpdatedEmployeeName']==null?"":json['UpdatedEmployeeName'];
    companyID = json['CompanyID']==null?0:json['CompanyID'];
    billAmount = json['BillAmount']==null?0.00:json['BillAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['InvoiceNo'] = this.invoiceNo;
    data['InvoiceDate'] = this.invoiceDate;
    data['BasicAmt'] = this.basicAmt;
    data['DiscountAmt'] = this.discountAmt;
    data['TaxAmt'] = this.taxAmt;
    data['ROffAmt'] = this.rOffAmt;
    data['NetAmt'] = this.netAmt;
    data['CGSTAmt'] = this.cGSTAmt;
    data['SGSTAmt'] = this.sGSTAmt;
    data['IGSTAmt'] = this.iGSTAmt;
    data['InquiryNo'] = this.inquiryNo;
    data['OrderNo'] = this.orderNo;
    data['QuotationNo'] = this.quotationNo;
    data['ComplaintNo'] = this.complaintNo;
    data['RefType'] = this.refType;
    data['ReferenceNo'] = this.referenceNo;
    data['RefNo'] = this.refNo;
    data['SupplierRef'] = this.supplierRef;
    data['SupplierRefDate'] = this.supplierRefDate;
    data['OtherRef'] = this.otherRef;
    data['PatientName'] = this.patientName;
    data['PatientType'] = this.patientType;
    data['Amount'] = this.amount;
    data['Percentage'] = this.percentage;
    data['EstimatedAmt'] = this.estimatedAmt;
    data['EmailContent'] = this.emailContent;
    data['EmailSubject'] = this.emailSubject;
    data['FixedLedgerID'] = this.fixedLedgerID;
    data['FixedLedgerName'] = this.fixedLedgerName;
    data['DocRefNoList'] = this.docRefNoList;
    data['CustomerID'] = this.customerID;
    data['CustomerName'] = this.customerName;
    data['GSTNO'] = this.gSTNO;
    data['BankID'] = this.bankID;
    data['LocationID'] = this.locationID;
    data['LocationName'] = this.locationName;
    data['BankName'] = this.bankName;
    data['BranchName'] = this.branchName;
    data['BankAccountName'] = this.bankAccountName;
    data['BankAccountNo'] = this.bankAccountNo;
    data['BankIFSC'] = this.bankIFSC;
    data['BankSWIFT'] = this.bankSWIFT;
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
    data['TerminationOfDeliery'] = this.terminationOfDeliery;
    data['TerminationOfDelieryName'] = this.terminationOfDelieryName;
    data['TerminationOfDelieryCity'] = this.terminationOfDelieryCity;
    data['TerminationOfDelieryCityName'] = this.terminationOfDelieryCityName;
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
    data['ModeOfTransport'] = this.modeOfTransport;
    data['TransporterName'] = this.transporterName;
    data['VehicleNo'] = this.vehicleNo;
    data['DeliveryNote'] = this.deliveryNote;
    data['DeliveryDate'] = this.deliveryDate;
    data['LRNo'] = this.lRNo;
    data['DispatchDocNo'] = this.dispatchDocNo;
    data['LRDate'] = this.lRDate;
    data['EwayBillNo'] = this.ewayBillNo;
    data['ModeOfPayment'] = this.modeOfPayment;
    data['TransportRemark'] = this.transportRemark;
    data['DeliverTo'] = this.deliverTo;
    data['CurrencyName'] = this.currencyName;
    data['CurrencySymbol'] = this.currencySymbol;
    data['ExchangeRate'] = this.exchangeRate;
    data['TermsCondition'] = this.termsCondition;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedBy'] = this.updatedBy;
    data['UpdatedDate'] = this.updatedDate;
    data['CreatedID'] = this.createdID;
    data['CreatedEmployeeName'] = this.createdEmployeeName;
    data['CreatedEmployeeMobile'] = this.createdEmployeeMobile;
    data['UpdatedEmployeeName'] = this.updatedEmployeeName;
    data['CompanyID'] = this.companyID;
    data['BillAmount'] = this.billAmount;
    return data;
  }
}