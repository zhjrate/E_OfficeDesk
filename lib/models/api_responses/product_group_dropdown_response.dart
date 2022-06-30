class ProductGroupDropDownResponse {
  List<ProductGroupDropDownDetails> details;
  int totalCount;

  ProductGroupDropDownResponse({this.details, this.totalCount});

  ProductGroupDropDownResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new ProductGroupDropDownDetails.fromJson(v));
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

class ProductGroupDropDownDetails {
  int pkID;
  String productGroupName;
  bool activeFlag;
  String createdBy;
  String createdDate;
  String updatedBy;
  String updatedDate;

  ProductGroupDropDownDetails(
      {this.pkID,
        this.productGroupName,
        this.activeFlag,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate});

  ProductGroupDropDownDetails.fromJson(Map<String, dynamic> json) {
    pkID = json['pkID']==null?0:json['pkID'];
    productGroupName = json['ProductGroupName']==null?"":json['ProductGroupName'];
    activeFlag = json['ActiveFlag']==null?false:json['ActiveFlag'];
    createdBy = json['CreatedBy']==null?"":json['CreatedBy'];
    createdDate = json['CreatedDate']==null?"":json['CreatedDate'];
    updatedBy = json['UpdatedBy']==null?"":json['UpdatedBy'];
    updatedDate = json['UpdatedDate']==null?"":json['UpdatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkID'] = this.pkID;
    data['ProductGroupName'] = this.productGroupName;
    data['ActiveFlag'] = this.activeFlag;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedBy'] = this.updatedBy;
    data['UpdatedDate'] = this.updatedDate;
    return data;
  }
}