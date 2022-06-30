class QuotationOtherChargesListResponse {
  List<OtherChargeDetails> details;
  int totalCount;

  QuotationOtherChargesListResponse({this.details, this.totalCount});

  QuotationOtherChargesListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new OtherChargeDetails.fromJson(v));
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

class OtherChargeDetails {
  int pkId;
  String chargeName;
  double gSTPer;
  String hSNCODE;
  int taxType;
  bool beforeGST;

  OtherChargeDetails(
      {this.pkId,
        this.chargeName,
        this.gSTPer,
        this.hSNCODE,
        this.taxType,
        this.beforeGST});

  OtherChargeDetails.fromJson(Map<String, dynamic> json) {
    pkId = json['pkId'];
    chargeName = json['ChargeName'];
    gSTPer = json['GST_Per'];
    hSNCODE = json['HSNCODE'];
    taxType = json['TaxType'];
    beforeGST = json['BeforeGST'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkId'] = this.pkId;
    data['ChargeName'] = this.chargeName;
    data['GST_Per'] = this.gSTPer;
    data['HSNCODE'] = this.hSNCODE;
    data['TaxType'] = this.taxType;
    data['BeforeGST'] = this.beforeGST;
    return data;
  }
}