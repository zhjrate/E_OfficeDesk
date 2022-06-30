class SearchQuotationListByNumberRequest {
  String CompanyId;
  String QuotationNo;



  SearchQuotationListByNumberRequest({this.CompanyId,this.QuotationNo});

  SearchQuotationListByNumberRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    QuotationNo = json['QuotationNo'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    //data['QuotationNo'] = this.QuotationNo;


    return data;
  }
}