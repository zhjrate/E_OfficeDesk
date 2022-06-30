class ProductionActivityDeleteResponse {
  List<ProductionActivityDeleteDetails> details;
  int totalCount;

  ProductionActivityDeleteResponse({this.details, this.totalCount});

  ProductionActivityDeleteResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new ProductionActivityDeleteDetails.fromJson(v));
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

class ProductionActivityDeleteDetails {
  String column1;

  ProductionActivityDeleteDetails({this.column1});

  ProductionActivityDeleteDetails.fromJson(Map<String, dynamic> json) {
    column1 = json['Column1']==null?"":json['Column1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Column1'] = this.column1;
    return data;
  }
}