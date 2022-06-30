
import 'dart:convert';

List<CustomerSearchByIdResponse> CustomerSearchByIdResponseFromJson(String str) =>
    List<CustomerSearchByIdResponse>.from(
        json.decode(str).map((x) => CustomerSearchByIdResponse.fromJson(x)));

String CustomerSearchByIdResponseModelToJson(List<CustomerSearchByIdResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerSearchByIdResponse {
  int rowNum;
  int customerID;
  String customerName;
  String customerType;
  bool blockCustomer;
  String address;
  String area;
  String pinCode;
  int cityCode;
  String cityName;
  int stateCode;
  String stateName;
  int gSTStateCode;
  String address1;
  String area1;
  String pinCode1;
  int cityCode1;
  String cityName1;
  int stateCode1;
  String stateName1;
  int gSTStateCode1;
  String gSTNO;
  String pANNO;
  String cINNO;
  int districtCode;
  int talukaCode;
  int districtCode1;
  int talukaCode1;
  String districtName;
  String talukaName;
  String districtName1;
  String talukaName1;
  String contactNo1;
  String contactNo2;
  String emailAddress;
  String websiteAddress;
  String birthDate;
  String anniversaryDate;
  int orgTypeCode;
  String orgType;
  int parentID;
  double erpClosing;
  String parentName;
  int customerSourceID;
  String customerSourceName;
  int specialityID;
  String specialityName;
  String treatmentType;
  String generateInquiry;
  String countryCode;
  String countryName;
  String countryCode1;
  String countryName1;
  double opening;
  double debit;
  double credit;
  double closing;
  int priceListID;

  /*

  [
  {
    "CustomerID": 14,    "CustomerName": "USER2",    "CustomerType": "Customer",    "Address": "BLOCK NO 89 Swastik Charrasta ANAND",
    "Area": "ANAND",    "PinCode": "",    "CityCode": 1677,    "CityName": "Karakanthal",    "StateCode": 12,    "StateName": "Gujarat",
    "CountryCode": "IND",    "CountryName": "India",    "Address1": "",    "Area1": "",    "PinCode1": "",    "CityCode1": 1678,
    "CityName1": "Ahamadpur",    "StateCode1": 12,    "StateName1": "Gujarat",    "CountryCode1": "IND",    "CountryName1": "India",
    "GSTNO": "23BJBPRE3139T2TR",    "PANNO": "BJBPRE3139T",    "CINNO": "U 12345 DL 2020 PLC 098765",    "ContactNo1": "6356894514",
    "ContactNo2": "7452124578",    "EmailAddress": "USER123@gmail.com",    "WebsiteAddress": "www.google.com",
    "BirthDate": "1997-06-18T00:00:00",    "AnniversaryDate": "2019-06-21T00:00:00",    "CustomerSourceID": 13,    "CustomerSourceName": "Ex Customer",
    "OrgTypeCode": null,    "OrgType": null,    "CreatedDate": "2021-09-30T11:59:47.417",    "CreatedBy": "Mrunal Yoddha",    "ParentID": null,
    "BlockCustomer": true,    "ParentName": "--Not Available--"
  }
]

  */



  CustomerSearchByIdResponse(
      {
        this. rowNum,
        this. customerID,
        this. customerName,
        this. customerType,
        this. blockCustomer,
        this. address,
        this. area,
        this. pinCode,
        this. cityCode,
        this. cityName,
        this. stateCode,
        this. stateName,
        this. gSTStateCode,
        this. address1,
        this. area1,
        this. pinCode1,
        this. cityCode1,
        this. cityName1,
        this. stateCode1,
        this. stateName1,
        this. gSTStateCode1,
        this. gSTNO,
        this. pANNO,
        this. cINNO,
        this. districtCode,
        this. talukaCode,
        this. districtCode1,
        this. talukaCode1,
        this. districtName,
        this. talukaName,
        this. districtName1,
        this. talukaName1,
        this. contactNo1,
        this. contactNo2,
        this. emailAddress,
        this. websiteAddress,
        this. birthDate,
        this. anniversaryDate,
        this. orgTypeCode,
        this. orgType,
        this. parentID,
        this. erpClosing,
        this. parentName,
        this. customerSourceID,
        this. customerSourceName,
        this. specialityID,
        this. specialityName,
        this. treatmentType,
        this. generateInquiry,
        this. countryCode,
        this. countryName,
        this. countryCode1,
        this. countryName1,
        this. opening,
        this. debit,
        this. credit,
        this. closing,
        this. priceListID, 
      
      });

  factory CustomerSearchByIdResponse.fromJson(Map<String, dynamic> json) =>
      CustomerSearchByIdResponse(
       rowNum : json['RowNum'],
       customerID : json['CustomerID'],
       customerName : json['CustomerName'],
       customerType : json['CustomerType'],
       blockCustomer : json['BlockCustomer'],
       address : json['Address'],
       area : json['Area'],
       pinCode : json['PinCode'],
       cityCode : json['CityCode'],
       cityName : json['CityName'],
       stateCode : json['StateCode'],
       stateName : json['StateName'],
       gSTStateCode : json['GSTStateCode'],
      address1 : json['Address1'],
      area1 : json['Area1'],
      pinCode1 : json['PinCode1'],
      cityCode1 : json['CityCode1'],
      cityName1 : json['CityName1'],
      stateCode1 : json['StateCode1'],
      stateName1 : json['StateName1'],
      gSTStateCode1 : json['GSTStateCode1'],
      gSTNO : json['GSTNO'],
      pANNO : json['PANNO'],
      cINNO : json['CINNO'],
      districtCode : json['DistrictCode'],
      talukaCode : json['TalukaCode'],
      districtCode1 : json['DistrictCode1'],
      talukaCode1 : json['TalukaCode1'],
      districtName : json['DistrictName'],
      talukaName : json['TalukaName'],
      districtName1 : json['DistrictName1'],
      talukaName1 : json['TalukaName1'],
      contactNo1 : json['ContactNo1'],
      contactNo2 : json['ContactNo2'],
      emailAddress : json['EmailAddress'],
      websiteAddress : json['WebsiteAddress'],
      birthDate : json['BirthDate'],
      anniversaryDate : json['AnniversaryDate'],
      orgTypeCode : json['OrgTypeCode'],
      orgType : json['OrgType'],
      parentID : json['ParentID'],
      erpClosing : json['ErpClosing'],
      parentName : json['ParentName'],
      customerSourceID : json['CustomerSourceID'],
      customerSourceName : json['CustomerSourceName'],
      specialityID : json['SpecialityID'],
      specialityName : json['SpecialityName'],
      treatmentType : json['TreatmentType'],
      generateInquiry : json['GenerateInquiry'],
      countryCode : json['CountryCode'],
      countryName : json['CountryName'],
      countryCode1 : json['CountryCode1'],
      countryName1 : json['CountryName1'],
      opening : json['Opening'],
      debit : json['Debit'],
      credit : json['Credit'],
      closing : json['Closing'],
      priceListID : json['PriceListID'],
      );


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['CustomerID'] = this.customerID;
    data['CustomerName'] = this.customerName;
    data['CustomerType'] = this.customerType;
    data['BlockCustomer'] = this.blockCustomer;
    data['Address'] = this.address;
    data['Area'] = this.area;
    data['PinCode'] = this.pinCode;
    data['CityCode'] = this.cityCode;
    data['CityName'] = this.cityName;
    data['StateCode'] = this.stateCode;
    data['StateName'] = this.stateName;
    data['GSTStateCode'] = this.gSTStateCode;
    data['Address1'] = this.address1;
    data['Area1'] = this.area1;
    data['PinCode1'] = this.pinCode1;
    data['CityCode1'] = this.cityCode1;
    data['CityName1'] = this.cityName1;
    data['StateCode1'] = this.stateCode1;
    data['StateName1'] = this.stateName1;
    data['GSTStateCode1'] = this.gSTStateCode1;
    data['GSTNO'] = this.gSTNO;
    data['PANNO'] = this.pANNO;
    data['CINNO'] = this.cINNO;
    data['DistrictCode'] = this.districtCode;
    data['TalukaCode'] = this.talukaCode;
    data['DistrictCode1'] = this.districtCode1;
    data['TalukaCode1'] = this.talukaCode1;
    data['DistrictName'] = this.districtName;
    data['TalukaName'] = this.talukaName;
    data['DistrictName1'] = this.districtName1;
    data['TalukaName1'] = this.talukaName1;
    data['ContactNo1'] = this.contactNo1;
    data['ContactNo2'] = this.contactNo2;
    data['EmailAddress'] = this.emailAddress;
    data['WebsiteAddress'] = this.websiteAddress;
    data['BirthDate'] = this.birthDate;
    data['AnniversaryDate'] = this.anniversaryDate;
    data['OrgTypeCode'] = this.orgTypeCode;
    data['OrgType'] = this.orgType;
    data['ParentID'] = this.parentID;
    data['ErpClosing'] = this.erpClosing;
    data['ParentName'] = this.parentName;
    data['CustomerSourceID'] = this.customerSourceID;
    data['CustomerSourceName'] = this.customerSourceName;
    data['SpecialityID'] = this.specialityID;
    data['SpecialityName'] = this.specialityName;
    data['TreatmentType'] = this.treatmentType;
    data['GenerateInquiry'] = this.generateInquiry;
    data['CountryCode'] = this.countryCode;
    data['CountryName'] = this.countryName;
    data['CountryCode1'] = this.countryCode1;
    data['CountryName1'] = this.countryName1;
    data['Opening'] = this.opening;
    data['Debit'] = this.debit;
    data['Credit'] = this.credit;
    data['Closing'] = this.closing;
    data['PriceListID'] = this.priceListID;
    return data;
  }
}