class InquiryProductModel {
  int id;
  String InquiryNo,LoginUserID,CompanyId;
  final String ProductName,ProductID,Quantity,UnitPrice,TotalAmount;
  InquiryProductModel(this.LoginUserID, this.CompanyId,this.InquiryNo,this.ProductName,this.ProductID,this.Quantity,this.UnitPrice,this.TotalAmount,{this.id });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['InquiryNo'] = this.InquiryNo;
    data['LoginUserID'] = this.LoginUserID;
    data['CompanyId'] = this.CompanyId;
    data['ProductName'] = this.ProductName;
    data['TotalAmount']=this.TotalAmount;
    data['ProductID'] = this.ProductID;
    data['Quantity'] = this.Quantity;
    data['UnitPrice'] = this.UnitPrice;




    return data;
  }

  @override
  String toString() {
    return 'InquiryProductModel{id: $id, InquiryNo: $InquiryNo,LoginUserID: $LoginUserID, CompanyId: $CompanyId,ProductName: $ProductName,ProductID: $ProductID,Quantity: $Quantity,UnitPrice: $UnitPrice,TotalAmount:$TotalAmount}';
  }
}