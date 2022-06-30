class QuotationOtherChargesListRequest {
  String pkID;

  QuotationOtherChargesListRequest({this.pkID});

  QuotationOtherChargesListRequest.fromJson(Map<String, dynamic> json) {
    pkID = json['pkID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkID'] = this.pkID;

    return data;
  }
}