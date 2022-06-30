class QuotationTermsCondtionResponse {
  List<QuotationTermsCondtionDetails> details;
  int totalCount;

  QuotationTermsCondtionResponse({this.details, this.totalCount});

  QuotationTermsCondtionResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new QuotationTermsCondtionDetails.fromJson(v));
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

class QuotationTermsCondtionDetails {
  int rowNum;
  int pkID;
  String category;
  String tNCHeader;
  String tNCContent;

  QuotationTermsCondtionDetails(
      {this.rowNum, this.pkID, this.category, this.tNCHeader, this.tNCContent});

  QuotationTermsCondtionDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum'];
    pkID = json['pkID'];
    category = json['Category'];
    tNCHeader = json['TNC_Header'];
    tNCContent = json['TNC_Content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['Category'] = this.category;
    data['TNC_Header'] = this.tNCHeader;
    data['TNC_Content'] = this.tNCContent;
    return data;
  }
}