class SaleBill_OtherChargeTable {
  int id;
  double Headerdiscount;
  double Tot_BasicAmt;
  double OtherChargeWithTaxamt;
  double Tot_GstAmt;
  double OtherChargeExcludeTaxamt;
  double Tot_NetAmount;
  int ChargeID1;
  double ChargeAmt1;
  double ChargeBasicAmt1;
  double ChargeGSTAmt1;
  int ChargeID2;
  double ChargeAmt2;
  double ChargeBasicAmt2;
  double ChargeGSTAmt2;
  int ChargeID3;
  double ChargeAmt3;
  double ChargeBasicAmt3;
  double ChargeGSTAmt3;
  int ChargeID4;
  double ChargeAmt4;
  double ChargeBasicAmt4;
  double ChargeGSTAmt4;
  int ChargeID5;
  double ChargeAmt5;
  double ChargeBasicAmt5;
  double ChargeGSTAmt5;

  SaleBill_OtherChargeTable(
      this.Headerdiscount,
      this.Tot_BasicAmt,
      this.OtherChargeWithTaxamt,
      this.Tot_GstAmt,
      this.OtherChargeExcludeTaxamt,
      this.Tot_NetAmount,
      this.ChargeID1,
      this.ChargeAmt1,
      this.ChargeBasicAmt1,
      this.ChargeGSTAmt1,
      this.ChargeID2,
      this.ChargeAmt2,
      this.ChargeBasicAmt2,
      this.ChargeGSTAmt2,
      this.ChargeID3,
      this.ChargeAmt3,
      this.ChargeBasicAmt3,
      this.ChargeGSTAmt3,
      this.ChargeID4,
      this.ChargeAmt4,
      this.ChargeBasicAmt4,
      this.ChargeGSTAmt4,
      this.ChargeID5,
      this.ChargeAmt5,
      this.ChargeBasicAmt5,
      this.ChargeGSTAmt5,
      {this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['Headerdiscount'] = this.Headerdiscount;
    data['Tot_BasicAmt'] = this.Tot_BasicAmt;
    data['OtherChargeWithTaxamt'] = this.OtherChargeWithTaxamt;
    data['Tot_GstAmt'] = this.Tot_GstAmt;
    data['OtherChargeExcludeTaxamt'] = this.OtherChargeExcludeTaxamt;
    data['Tot_NetAmount'] = this.Tot_NetAmount;
    data['ChargeID1'] = this.ChargeID1;
    data['ChargeAmt1'] = this.ChargeAmt1;
    data['ChargeBasicAmt1'] = this.ChargeBasicAmt1;
    data['ChargeGSTAmt1'] = this.ChargeGSTAmt1;
    data['ChargeID2'] = this.ChargeID2;
    data['ChargeAmt2'] = this.ChargeAmt2;
    data['ChargeBasicAmt2'] = this.ChargeBasicAmt2;
    data['ChargeGSTAmt2'] = this.ChargeGSTAmt2;
    data['ChargeID3'] = this.ChargeID3;
    data['ChargeAmt3'] = this.ChargeAmt3;
    data['ChargeBasicAmt3'] = this.ChargeBasicAmt3;
    data['ChargeGSTAmt3'] = this.ChargeGSTAmt3;
    data['ChargeID4'] = this.ChargeID4;
    data['ChargeAmt4'] = this.ChargeAmt4;
    data['ChargeBasicAmt4'] = this.ChargeBasicAmt4;
    data['ChargeGSTAmt4'] = this.ChargeGSTAmt4;
    data['ChargeID5'] = this.ChargeID5;
    data['ChargeAmt5'] = this.ChargeAmt5;
    data['ChargeBasicAmt5'] = this.ChargeBasicAmt5;
    data['ChargeGSTAmt5'] = this.ChargeGSTAmt5;

    return data;
  }

  @override
  String toString() {
    return 'SaleBill_OtherChargeTable{id: $id, Headerdiscount: $Headerdiscount, Tot_BasicAmt: $Tot_BasicAmt, OtherChargeWithTaxamt: $OtherChargeWithTaxamt, Tot_GstAmt: $Tot_GstAmt, OtherChargeExcludeTaxamt: $OtherChargeExcludeTaxamt, Tot_NetAmount: $Tot_NetAmount, ChargeID1: $ChargeID1, ChargeAmt1: $ChargeAmt1, ChargeBasicAmt1: $ChargeBasicAmt1, ChargeGSTAmt1: $ChargeGSTAmt1, ChargeID2: $ChargeID2, ChargeAmt2: $ChargeAmt2, ChargeBasicAmt2: $ChargeBasicAmt2, ChargeGSTAmt2: $ChargeGSTAmt2, ChargeID3: $ChargeID3, ChargeAmt3: $ChargeAmt3, ChargeBasicAmt3: $ChargeBasicAmt3, ChargeGSTAmt3: $ChargeGSTAmt3, ChargeID4: $ChargeID4, ChargeAmt4: $ChargeAmt4, ChargeBasicAmt4: $ChargeBasicAmt4, ChargeGSTAmt4: $ChargeGSTAmt4, ChargeID5: $ChargeID5, ChargeAmt5: $ChargeAmt5, ChargeBasicAmt5: $ChargeBasicAmt5, ChargeGSTAmt5: $ChargeGSTAmt5}';
  }
}
