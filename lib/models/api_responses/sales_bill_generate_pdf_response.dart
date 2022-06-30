class SalesBillPDFGenerateResponse {
  List<SalesBillDetails> details;
  int totalCount;

  SalesBillPDFGenerateResponse({this.details, this.totalCount});

  SalesBillPDFGenerateResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new SalesBillDetails.fromJson(v));
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

class SalesBillDetails {
  String column1;

  SalesBillDetails({this.column1});

  SalesBillDetails.fromJson(Map<String, dynamic> json) {
    column1 = json['Column1'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Column1'] = this.column1;

    return data;
  }
}