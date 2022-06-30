class QuotationListResponse {
  List<QuotationDetails> details;
  int totalCount;


  QuotationListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details =[];
      json['details'].forEach((v) {
        details.add(new QuotationDetails.fromJson(v));
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

class QuotationDetails {
  int rowNum;
  int pkID;
  String quotationNo;
  String quotationDate;
  String inquiryNo;
  int inquirypkID;
  String inquiryDate;
  String projectName;
  int projectID;
  int customerID;
  String customerName;
  String address;
  String area;
  String pinCode;
  String city;
  String emailAddress;
  String state;
  int bankID;
  String bankName;
  String branchName;
  String bankAccountNo;
  String bankIFSC;
  String bankSWIFT;
  String bankAccountName;
  String contactNo1;
  String contactNo2;
  String quotationSubject;
  String quotationKindAttn;
  String quotationHeader;
  String quotationFooter;
  String assumptionRemark;
  String additionalRemark;
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
  String currencyName;
  String currencySymbol;
  double exchangeRate;
  String createdBy;
  String createdDate;
  String updatedBy;
  String updatedDate;
  int createdID;
  String createdEmployeeName;
  String createdEmployeeMobileNo;
  String updatedEmployeeName;
  int companyID;
  double quotationAmount;
  int projGenCount;
  int projTotalCount;
  String inquiryStatus;
  String quotationType;
  double byBank;
  double byCash;
  double paySlab1;
  double paySlab2;
  double paySlab3;
  double paySlab4;
  String quotationCategory;
  double plantArea;
  int stateCode;
  String stateName;
  int districtCode;
  String districtName;
  String longitude;
  String latitude;
  String irradiation;
  String panelAngle;
  String degradation;
  String panelTechnology;

  QuotationDetails(
      {this.rowNum,
        this.pkID,
        this.quotationNo,
        this.quotationDate,
        this.inquiryNo,
        this.inquirypkID,
        this.inquiryDate,
        this.projectName,
        this.projectID,
        this.customerID,
        this.customerName,
        this.address,
        this.area,
        this.pinCode,
        this.city,
        this.emailAddress,
        this.state,
        this.bankID,
        this.bankName,
        this.branchName,
        this.bankAccountNo,
        this.bankIFSC,
        this.bankSWIFT,
        this.bankAccountName,
        this.contactNo1,
        this.contactNo2,
        this.quotationSubject,
        this.quotationKindAttn,
        this.quotationHeader,
        this.quotationFooter,
        this.assumptionRemark,
        this.additionalRemark,
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
        this.currencyName,
        this.currencySymbol,
        this.exchangeRate,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate,
        this.createdID,
        this.createdEmployeeName,
        this.createdEmployeeMobileNo,
        this.updatedEmployeeName,
        this.companyID,
        this.quotationAmount,
        this.projGenCount,
        this.projTotalCount,
        this.inquiryStatus,
        this.quotationType,
        this.byBank,
        this.byCash,
        this.paySlab1,
        this.paySlab2,
        this.paySlab3,
        this.paySlab4,
        this.quotationCategory,
        this.plantArea,
        this.stateCode,
        this.stateName,
        this.districtCode,
        this.districtName,
        this.longitude,
        this.latitude,
        this.irradiation,
        this.panelAngle,
        this.degradation,
        this.panelTechnology,
      });

  QuotationDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum']==null?0:json['RowNum'];
    pkID = json['pkID']==null?0:json['pkID'];
    quotationNo = json['QuotationNo']==null?"":json['QuotationNo'];
    quotationDate = json['QuotationDate']==null?"":json['QuotationDate'];
    inquiryNo = json['InquiryNo']==null?"":json['InquiryNo'];
    inquirypkID = json['InquirypkID']==null?0:json['InquirypkID'];
    inquiryDate = json['InquiryDate']==null?"":json['InquiryDate'];
    projectName = json['ProjectName']==null?"":json['ProjectName'];
    projectID = json['ProjectID']==null?0:json['ProjectID'];
    customerID = json['CustomerID']==null?0:json['CustomerID'];
    customerName = json['CustomerName']==null?"":json['CustomerName'];
    address = json['Address']==null?"":json['Address'];
    area = json['Area']==null?"":json['Area'];
    pinCode = json['PinCode']==null?"":json['PinCode'];
    city = json['City']==null?"":json['City'];
    emailAddress = json['EmailAddress']==null?"":json['EmailAddress'];
    state = json['State']==null?"":json['State'];
    bankID = json['BankID']==null?0:json['BankID'];
    bankName = json['BankName']==null?"":json['BankName'];
    branchName = json['BranchName']==null?"":json['BranchName'];
    bankAccountNo = json['BankAccountNo']==null?"":json['BankAccountNo'];
    bankIFSC = json['BankIFSC']==null?"":json['BankIFSC'];
    bankSWIFT = json['BankSWIFT']==null?"":json['BankSWIFT'];
    bankAccountName = json['BankAccountName']==null?"":json['BankAccountName'];
    contactNo1 = json['ContactNo1']==null?"":json['ContactNo1'];
    contactNo2 = json['ContactNo2']==null?"":json['ContactNo2'];
    quotationSubject = json['QuotationSubject']==null?"":json['QuotationSubject'];
    quotationKindAttn = json['QuotationKindAttn']==null?"":json['QuotationKindAttn'];
    quotationHeader = json['QuotationHeader']==null?"":json['QuotationHeader'];
    quotationFooter = json['QuotationFooter']==null?"":json['QuotationFooter'];
    assumptionRemark = json['AssumptionRemark']==null?"":json['AssumptionRemark'];
    additionalRemark = json['AdditionalRemark']==null?"":json['AdditionalRemark'];
    basicAmt = json['BasicAmt']==null?0.00:json['BasicAmt'];
    discountAmt = json['DiscountAmt']==null?0.00:json['DiscountAmt'];
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
    currencyName = json['CurrencyName']==null?"":json['CurrencyName'];
    currencySymbol = json['CurrencySymbol']==null?"":json['CurrencySymbol'];
    exchangeRate = json['ExchangeRate']==null?0.00:json['ExchangeRate'];
    createdBy = json['CreatedBy']==null?"":json['CreatedBy'];
    createdDate = json['CreatedDate']==null?"":json['CreatedDate'];
    updatedBy = json['UpdatedBy']==null?"":json['UpdatedBy'];
    updatedDate = json['UpdatedDate']==null?"":json['UpdatedDate'];
    createdID = json['CreatedID']==null?0:json['CreatedID'];
    createdEmployeeName = json['CreatedEmployeeName']==null?"":json['CreatedEmployeeName'];
    createdEmployeeMobileNo = json['CreatedEmployeeMobileNo']==null?"":json['CreatedEmployeeMobileNo'];
    updatedEmployeeName = json['UpdatedEmployeeName']==null?"":json['UpdatedEmployeeName'];
    companyID = json['CompanyID']==null?0:json['CompanyID'];
    quotationAmount = json['QuotationAmount']==null?0.00:json['QuotationAmount'];
    projGenCount = json['ProjGenCount']==null?0:json['ProjGenCount'];
    projTotalCount = json['ProjTotalCount']==null?0:json['ProjTotalCount'];
    inquiryStatus = json['InquiryStatus']==null?"":json['InquiryStatus'];
    quotationType = json['QuotationType']==null?"":json['QuotationType'];
    byBank = json['ByBank']==null?0.00:json['ByBank'];
    byCash = json['ByCash']==null?0.00:json['ByCash'];
    paySlab1 = json['PaySlab1']==null?0.00:json['PaySlab1'];
    paySlab2 = json['PaySlab2']==null?0.00:json['PaySlab2'];
    paySlab3 = json['PaySlab3']==null?0.00:json['PaySlab3'];
    paySlab4 = json['PaySlab4']==null?0.00:json['PaySlab4'];
    quotationCategory = json['QuotationCategory']==null?"":json['QuotationCategory'];
    plantArea = json['PlantArea']==null?0.00:json['PlantArea'];
    stateCode = json['StateCode']==null?0:json['StateCode'];
    stateName = json['StateName']==null?"":json['StateName'];
    districtCode = json['DistrictCode']==null?0:json['DistrictCode'];
    districtName = json['DistrictName']==null?"":json['DistrictName'];
    longitude = json['Longitude']==null?"":json['Longitude'];
    latitude = json['Latitude']==null?"":json['Latitude'];
    irradiation = json['Irradiation']==null?"":json['Irradiation'];
    panelAngle = json['PanelAngle']==null?"":json['PanelAngle'];
    degradation = json['Degradation']==null?"":json['Degradation'];
    panelTechnology = json['PanelTechnology']==null?"":json['PanelTechnology'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['QuotationNo'] = this.quotationNo;
    data['QuotationDate'] = this.quotationDate;
    data['InquiryNo'] = this.inquiryNo;
    data['InquirypkID'] = this.inquirypkID;
    data['InquiryDate'] = this.inquiryDate;
    data['ProjectName'] = this.projectName;
    data['ProjectID'] = this.projectID;
    data['CustomerID'] = this.customerID;
    data['CustomerName'] = this.customerName;
    data['Address'] = this.address;
    data['Area'] = this.area;
    data['PinCode'] = this.pinCode;
    data['City'] = this.city;
    data['EmailAddress'] = this.emailAddress;
    data['State'] = this.state;
    data['BankID'] = this.bankID;
    data['BankName'] = this.bankName;
    data['BranchName'] = this.branchName;
    data['BankAccountNo'] = this.bankAccountNo;
    data['BankIFSC'] = this.bankIFSC;
    data['BankSWIFT'] = this.bankSWIFT;
    data['BankAccountName'] = this.bankAccountName;
    data['ContactNo1'] = this.contactNo1;
    data['ContactNo2'] = this.contactNo2;
    data['QuotationSubject'] = this.quotationSubject;
    data['QuotationKindAttn'] = this.quotationKindAttn;
    data['QuotationHeader'] = this.quotationHeader;
    data['QuotationFooter'] = this.quotationFooter;
    data['AssumptionRemark'] = this.assumptionRemark;
    data['AdditionalRemark'] = this.additionalRemark;
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
    data['CurrencyName'] = this.currencyName;
    data['CurrencySymbol'] = this.currencySymbol;
    data['ExchangeRate'] = this.exchangeRate;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedBy'] = this.updatedBy;
    data['UpdatedDate'] = this.updatedDate;
    data['CreatedID'] = this.createdID;
    data['CreatedEmployeeName'] = this.createdEmployeeName;
    data['CreatedEmployeeMobileNo'] = this.createdEmployeeMobileNo;
    data['UpdatedEmployeeName'] = this.updatedEmployeeName;
    data['CompanyID'] = this.companyID;
    data['QuotationAmount'] = this.quotationAmount;
    data['ProjGenCount'] = this.projGenCount;
    data['ProjTotalCount'] = this.projTotalCount;
    data['InquiryStatus'] = this.inquiryStatus;
    data['QuotationType'] = this.quotationType;
    data['ByBank'] = this.byBank;
    data['ByCash'] = this.byCash;
    data['PaySlab1'] = this.paySlab1;
    data['PaySlab2'] = this.paySlab2;
    data['PaySlab3'] = this.paySlab3;
    data['PaySlab4'] = this.paySlab4;
    data['QuotationCategory'] = this.quotationCategory;
    data['PlantArea'] = this.plantArea;
    data['StateCode'] = this.stateCode;
    data['StateName'] = this.stateName;
    data['DistrictCode'] = this.districtCode;
    data['DistrictName'] = this.districtName;
    data['Longitude'] = this.longitude;
    data['Latitude'] = this.latitude;
    data['Irradiation'] = this.irradiation;
    data['PanelAngle'] = this.panelAngle;
    data['Degradation'] = this.degradation;
    data['PanelTechnology'] = this.panelTechnology;
    return data;
  }
}