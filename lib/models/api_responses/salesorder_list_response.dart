class SalesOrderListResponse {
  List<SalesOrderDetails> details;
  int totalCount;

  SalesOrderListResponse({this.details, this.totalCount});

  SalesOrderListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new SalesOrderDetails.fromJson(v));
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

class SalesOrderDetails {
  int rowNum;
  int pkID;
  String orderNo;
  String orderDate;
  String quotationNo;
  String inquiryNo;
  String billNo;
  int bankID;
  String bankName;
  String bankAccountName;
  String bankAccountNo;
  String branchName;
  String bankIFSC;
  String bankSWIFT;
  String patientName;
  String patientType;
  double finalAmount;
  double percentage;
  double estimatedAmt;
  String emailHeader;
  String emailContent;
  String projectName;
  String deliveryDate;
  String termsCondition;
  String deliveryTerms;
  String paymentTerms;
  String approvalStatus;
  String referenceNo;
  String referenceDate;
  int customerID;
  String customerName;
  String projectStage;
  String address;
  String area;
  String pinCode;
  String city;
  String emailAddress;
  String contactNo1;
  String contactNo2;
  int employeeID;
  String employeeName;
  String mobileNo;
  double basicAmt;
  double discountAmt;
  double taxAmt;
  double sGSTAmt;
  double cGSTAmt;
  double iGSTAmt;
  double roffAmt;
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
  double advancePer;
  double advanceAmt;
  String currencyName;
  String currencySymbol;
  double exchangeRate;
  String refType;
  String refNo;
  String createdBy;
  String createdDate;
  String updatedBy;
  String updatedDate;
  String approvedBy;
  String approvedDate;
  String createdEmployeeName;
  String updatedEmployeeName;
  int companyID;
  int createdID;
  String inquiryStatus;
  double orderAmount;
  String pOFileName;

  SalesOrderDetails(
      {this.rowNum,
        this.pkID,
        this.orderNo,
        this.orderDate,
        this.quotationNo,
        this.inquiryNo,
        this.billNo,
        this.bankID,
        this.bankName,
        this.bankAccountName,
        this.bankAccountNo,
        this.branchName,
        this.bankIFSC,
        this.bankSWIFT,
        this.patientName,
        this.patientType,
        this.finalAmount,
        this.percentage,
        this.estimatedAmt,
        this.emailHeader,
        this.emailContent,
        this.projectName,
        this.deliveryDate,
        this.termsCondition,
        this.deliveryTerms,
        this.paymentTerms,
        this.approvalStatus,
        this.referenceNo,
        this.referenceDate,
        this.customerID,
        this.customerName,
        this.projectStage,
        this.address,
        this.area,
        this.pinCode,
        this.city,
        this.emailAddress,
        this.contactNo1,
        this.contactNo2,
        this.employeeID,
        this.employeeName,
        this.mobileNo,
        this.basicAmt,
        this.discountAmt,
        this.taxAmt,
        this.sGSTAmt,
        this.cGSTAmt,
        this.iGSTAmt,
        this.roffAmt,
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
        this.advancePer,
        this.advanceAmt,
        this.currencyName,
        this.currencySymbol,
        this.exchangeRate,
        this.refType,
        this.refNo,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate,
        this.approvedBy,
        this.approvedDate,
        this.createdEmployeeName,
        this.updatedEmployeeName,
        this.companyID,
        this.createdID,
        this.inquiryStatus,
        this.orderAmount,
        this.pOFileName});

  SalesOrderDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum']==null?0:json['RowNum'];
    pkID = json['pkID']==null?0:json['pkID'];
    orderNo = json['OrderNo']==null?"":json['OrderNo'];
    orderDate = json['OrderDate']==null?"":json['OrderDate'];
    quotationNo = json['QuotationNo']==null?"":json['QuotationNo'];
    inquiryNo = json['InquiryNo']==null?"":json['InquiryNo'];
    billNo = json['BillNo']==null?"":json['BillNo'];
    bankID = json['BankID']==null?0:json['BankID'];
    bankName = json['BankName']==null?"":json['BankName'];
    bankAccountName = json['BankAccountName']==null?"":json['BankAccountName'];
    bankAccountNo = json['BankAccountNo']==null?"":json['BankAccountNo'];
    branchName = json['BranchName']==null?"":json['BranchName'];
    bankIFSC = json['BankIFSC']==null?"":json['BankIFSC'];
    bankSWIFT = json['BankSWIFT']==null?"":json['BankSWIFT'];
    patientName = json['PatientName']==null?"":json['PatientName'];
    patientType = json['PatientType']==null?"":json['PatientType'];
    finalAmount = json['FinalAmount']==null?0.00:json['FinalAmount'];
    percentage = json['Percentage']==null?0.00:json['Percentage'];
    estimatedAmt = json['EstimatedAmt']==null?0.00:json['EstimatedAmt'];
    emailHeader = json['EmailHeader']==null?"":json['EmailHeader'];
    emailContent = json['EmailContent']==null?"":json['EmailContent'];
    projectName = json['ProjectName']==null?"":json['ProjectName'];
    deliveryDate = json['DeliveryDate']==null?"":json['DeliveryDate'];
    termsCondition = json['TermsCondition']==null?"":json['TermsCondition'];
    deliveryTerms = json['DeliveryTerms']==null?"":json['DeliveryTerms'];
    paymentTerms = json['PaymentTerms']==null?"":json['PaymentTerms'];
    approvalStatus = json['ApprovalStatus']==null?"":json['ApprovalStatus'];
    referenceNo = json['ReferenceNo']==null?"":json['ReferenceNo'];
    referenceDate = json['ReferenceDate']==null?"":json['ReferenceDate'];
    customerID = json['CustomerID']==null?0:json['CustomerID'];
    customerName = json['CustomerName']==null?"":json['CustomerName'];
    projectStage = json['ProjectStage']==null?"":json['ProjectStage'];
    address = json['Address']==null?"":json['Address'];
    area = json['Area']==null?"":json['Area'];
    pinCode = json['PinCode']==null?"":json['PinCode'];
    city = json['City']==null?"":json['City'];
    emailAddress = json['EmailAddress']==null?"":json['EmailAddress'];
    contactNo1 = json['ContactNo1']==null?"":json['ContactNo1'];
    contactNo2 = json['ContactNo2']==null?"":json['ContactNo2'];
    employeeID = json['EmployeeID']==null?0:json['EmployeeID'];
    employeeName = json['EmployeeName']==null?"":json['EmployeeName'];
    mobileNo = json['MobileNo']==null?"":json['MobileNo'];
    basicAmt = json['BasicAmt']==null?0.00:json['BasicAmt'];
    discountAmt = json['DiscountAmt']==null?"":json['DiscountAmt'];
    taxAmt = json['TaxAmt']==null?0.00:json['TaxAmt'];
    sGSTAmt = json['SGSTAmt']==null?0.00:json['SGSTAmt'];
    cGSTAmt = json['CGSTAmt']==null?0.00:json['CGSTAmt'];
    iGSTAmt = json['IGSTAmt']==null?0.00:json['IGSTAmt'];
    roffAmt = json['RoffAmt']==null?0.00:json['RoffAmt'];
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
    advancePer = json['AdvancePer']==null?0.00:json['AdvancePer'];
    advanceAmt = json['AdvanceAmt']==null?0.00:json['AdvanceAmt'];
    currencyName = json['CurrencyName']==null?"":json['CurrencyName'];
    currencySymbol = json['CurrencySymbol']==null?"":json['CurrencySymbol'];
    exchangeRate = json['ExchangeRate']==null?0.00:json['ExchangeRate'];
    refType = json['RefType']==null?"":json['RefType'];
    refNo = json['RefNo']==null?"":json['RefNo'];
    createdBy = json['CreatedBy']==null?"":json['CreatedBy'];
    createdDate = json['CreatedDate']==null?"":json['CreatedDate'];
    updatedBy = json['UpdatedBy']==null?"":json['UpdatedBy'];
    updatedDate = json['UpdatedDate']==null?"":json['UpdatedDate'];
    approvedBy = json['ApprovedBy']==null?"":json['ApprovedBy'];
    approvedDate = json['ApprovedDate']==null?"":json['ApprovedDate'];
    createdEmployeeName = json['CreatedEmployeeName']==null?"":json['CreatedEmployeeName'];
    updatedEmployeeName = json['UpdatedEmployeeName']==null?"":json['UpdatedEmployeeName'];
    companyID = json['CompanyID']==null?0:json['CompanyID'];
    createdID = json['CreatedID']==null?0:json['CreatedID'];
    inquiryStatus = json['InquiryStatus']==null?"":json['InquiryStatus'];
    orderAmount = json['OrderAmount']==null?0.00:json['OrderAmount'];
    pOFileName = json['POFileName']==null?"":json['POFileName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['OrderNo'] = this.orderNo;
    data['OrderDate'] = this.orderDate;
    data['QuotationNo'] = this.quotationNo;
    data['InquiryNo'] = this.inquiryNo;
    data['BillNo'] = this.billNo;
    data['BankID'] = this.bankID;
    data['BankName'] = this.bankName;
    data['BankAccountName'] = this.bankAccountName;
    data['BankAccountNo'] = this.bankAccountNo;
    data['BranchName'] = this.branchName;
    data['BankIFSC'] = this.bankIFSC;
    data['BankSWIFT'] = this.bankSWIFT;
    data['PatientName'] = this.patientName;
    data['PatientType'] = this.patientType;
    data['FinalAmount'] = this.finalAmount;
    data['Percentage'] = this.percentage;
    data['EstimatedAmt'] = this.estimatedAmt;
    data['EmailHeader'] = this.emailHeader;
    data['EmailContent'] = this.emailContent;
    data['ProjectName'] = this.projectName;
    data['DeliveryDate'] = this.deliveryDate;
    data['TermsCondition'] = this.termsCondition;
    data['DeliveryTerms'] = this.deliveryTerms;
    data['PaymentTerms'] = this.paymentTerms;
    data['ApprovalStatus'] = this.approvalStatus;
    data['ReferenceNo'] = this.referenceNo;
    data['ReferenceDate'] = this.referenceDate;
    data['CustomerID'] = this.customerID;
    data['CustomerName'] = this.customerName;
    data['ProjectStage'] = this.projectStage;
    data['Address'] = this.address;
    data['Area'] = this.area;
    data['PinCode'] = this.pinCode;
    data['City'] = this.city;
    data['EmailAddress'] = this.emailAddress;
    data['ContactNo1'] = this.contactNo1;
    data['ContactNo2'] = this.contactNo2;
    data['EmployeeID'] = this.employeeID;
    data['EmployeeName'] = this.employeeName;
    data['MobileNo'] = this.mobileNo;
    data['BasicAmt'] = this.basicAmt;
    data['DiscountAmt'] = this.discountAmt;
    data['TaxAmt'] = this.taxAmt;
    data['SGSTAmt'] = this.sGSTAmt;
    data['CGSTAmt'] = this.cGSTAmt;
    data['IGSTAmt'] = this.iGSTAmt;
    data['RoffAmt'] = this.roffAmt;
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
    data['AdvancePer'] = this.advancePer;
    data['AdvanceAmt'] = this.advanceAmt;
    data['CurrencyName'] = this.currencyName;
    data['CurrencySymbol'] = this.currencySymbol;
    data['ExchangeRate'] = this.exchangeRate;
    data['RefType'] = this.refType;
    data['RefNo'] = this.refNo;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedBy'] = this.updatedBy;
    data['UpdatedDate'] = this.updatedDate;
    data['ApprovedBy'] = this.approvedBy;
    data['ApprovedDate'] = this.approvedDate;
    data['CreatedEmployeeName'] = this.createdEmployeeName;
    data['UpdatedEmployeeName'] = this.updatedEmployeeName;
    data['CompanyID'] = this.companyID;
    data['CreatedID'] = this.createdID;
    data['InquiryStatus'] = this.inquiryStatus;
    data['OrderAmount'] = this.orderAmount;
    data['POFileName'] = this.pOFileName;
    return data;
  }
}