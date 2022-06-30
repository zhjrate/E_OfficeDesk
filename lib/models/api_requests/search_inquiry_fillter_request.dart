class SearchInquiryListFillterByNameRequest {
  /*String CompanyId;
  String LoginUserID;
  String needALL;
  String word;*/
  String CompanyId;
  String CustomerName;



  String ProductName;
  String InquiryNo;
  String StateCode;
  String CityCode;
  String CountryCode;
  String Priority;
  String NameOnly;
  String Word;


  SearchInquiryListFillterByNameRequest({
    this.CompanyId,
    this.CustomerName,
    this.ProductName,
    this.InquiryNo,
    this.StateCode,
    this.CityCode,
    this.CountryCode,
    this.Priority,
    this.NameOnly,
    this.Word});


  SearchInquiryListFillterByNameRequest.fromJson(Map<String, dynamic> json) {
    /*CompanyId = json['CompanyId'];
    LoginUserID = json['LoginUserID'];
    word = json['word'];
    needALL = json['needALL'];*/


    CompanyId=json['CompanyId'];
    CustomerName=json['CustomerName'];
    ProductName=json['ProductName'];
    InquiryNo=json['InquiryNo'];
    StateCode=json['StateCode'];
    CityCode=json['CityCode'];
    CountryCode=json['CountryCode'];
    Priority=json['Priority'];
    NameOnly=json['NameOnly'];
    Word=json['Word'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    /*data['CompanyId'] = this.CompanyId;
    data['LoginUserID'] = this.LoginUserID;
    data['word'] = this.word;
    data['needALL'] = this.needALL;*/


    data['CompanyId']   =this.CompanyId;
    data['CustomerName']=this.CustomerName;
    data['ProductName'] =this.ProductName;
    data['InquiryNo']   =this.InquiryNo;
    data['StateCode']   =this.StateCode;
    data['CityCode']    =this.CityCode;
    data['CountryCode'] =this.CountryCode;
    data['Priority']    =this.Priority;
    data['NameOnly']    =this.NameOnly;
    data['Word']        =this.Word;

    return data;
  }
}
