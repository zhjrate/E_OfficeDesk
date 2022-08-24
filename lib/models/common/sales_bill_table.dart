class SaleBillTable {
  int id;
  String QuotationNo;
  String ProductSpecification;
  int ProductID;
  String ProductName;
  String Unit;
  double Quantity;
  double UnitRate;
  double DiscountPercent;
  double DiscountAmt;
  double NetRate;
  double Amount;
  double TaxRate;
  double TaxAmount;
  double NetAmount;
  double CGSTPer;
  double SGSTPer;
  double IGSTPer;
  double CGSTAmt;
  double SGSTAmt;
  double IGSTAmt;
  int StateCode;
  int TaxType;
  int pkID;
  String LoginUserID;
  String CompanyId;
  int BundleId;
  double HeaderDiscAmt;

  SaleBillTable(
      this.QuotationNo,
      this.ProductSpecification,
      this.ProductID,
      this.ProductName,
      this.Unit,
      this.Quantity,
      this.UnitRate,
      this.DiscountPercent,
      this.DiscountAmt,
      this.NetRate,
      this.Amount,
      this.TaxRate,
      this.TaxAmount,
      this.NetAmount,
      this.TaxType,
      this.CGSTPer,
      this.SGSTPer,
      this.IGSTPer,
      this.CGSTAmt,
      this.SGSTAmt,
      this.IGSTAmt,
      this.StateCode,
      this.pkID,
      this.LoginUserID,
      this.CompanyId,
      this.BundleId,
      this.HeaderDiscAmt,
      {this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['QuotationNo'] = this.QuotationNo;
    data['pkID'] = this.pkID;
    data['ProductID'] = this.ProductID;
    data['Quantity'] = this.Quantity;
    data['Unit'] = this.Unit;
    data['UnitRate'] = this.UnitRate;
    data['DiscountPercent'] = this.DiscountPercent;
    data['NetRate'] = this.NetRate;
    data['Amount'] = this.Amount;
    data['TaxAmount'] = this.TaxAmount;
    data['NetAmount'] = this.NetAmount;
    data['LoginUserID'] = this.LoginUserID;
    data['TaxRate'] = this.TaxRate;
    data['BundleId'] = this.BundleId;
    data['DiscountAmt'] = this.DiscountAmt;
    data['SGSTPer'] = this.SGSTPer;
    data['SGSTAmt'] = this.SGSTAmt;
    data['CGSTPer'] = this.CGSTPer;
    data['CGSTAmt'] = this.CGSTAmt;
    data['IGSTPer'] = this.IGSTPer;
    data['IGSTAmt'] = this.IGSTAmt;
    data['TaxType'] = this.TaxType;
    data['HeaderDiscAmt'] = this.HeaderDiscAmt;
    data['CompanyId'] = this.CompanyId;
    data['ProductSpecification'] = this.ProductSpecification;
    data['ProductName'] = this.ProductName;
    data['StateCode'] = this.StateCode;

    return data;
  }

  @override
  String toString() {
    return 'SaleBillTable{id: $id, QuotationNo: $QuotationNo, ProductSpecification: $ProductSpecification, ProductID: $ProductID, ProductName: $ProductName, Unit: $Unit, Quantity: $Quantity, UnitRate: $UnitRate, DiscountPercent: $DiscountPercent, DiscountAmt: $DiscountAmt, NetRate: $NetRate, Amount: $Amount, TaxRate: $TaxRate, TaxAmount: $TaxAmount, NetAmount: $NetAmount, CGSTPer: $CGSTPer, SGSTPer: $SGSTPer, IGSTPer: $IGSTPer, CGSTAmt: $CGSTAmt, SGSTAmt: $SGSTAmt, IGSTAmt: $IGSTAmt, StateCode: $StateCode, TaxType: $TaxType, pkID: $pkID, LoginUserID: $LoginUserID, CompanyId: $CompanyId,BundleId:$BundleId , HeaderDiscAmt:$HeaderDiscAmt}';
  }

/* @override
  String toString() {
    return 'QuotationTable{id: $id, QuotationNo:$QuotationNo, Specification : $Specification , ProductID: $ProductID, ProductName: $ProductName, Unit: $Unit, Quantity: $Quantity, UnitRate: $UnitRate, Disc: $Disc, NetRate: $NetRate, Amount: $Amount, TaxPer: $TaxPer, TaxAmount: $TaxAmount, NetAmount: $NetAmount, IsTaxType: $IsTaxType}';
  }
*/
}
