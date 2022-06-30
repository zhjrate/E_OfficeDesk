class ContactModel {
  int id;
  //final String name, mobile, email,designation,designationCode;
 // final int ;
  String CustomerID,LoginUserID,CompanyId;
  final String pkId,ContactDesignationName,ContactDesigCode1,ContactPerson1,ContactNumber1,ContactEmail1;
  //ContactModel( this.name, this.mobile, this.email,this.designation,this.designationCode,{this.id });
  ContactModel( this.pkId, this.CustomerID, this.ContactDesignationName,this.ContactDesigCode1,this.CompanyId,this.ContactPerson1,this.ContactNumber1,this.ContactEmail1,this.LoginUserID,{this.id });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['id'] = this.id;
   /* data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['designation'] = this.designation;
    data['designationCode'] = this.designationCode;
*/
    data['pkId'] = this.pkId;
    data['CustomerID'] = this.CustomerID;
    data['ContactDesignationName'] = this.ContactDesignationName;
    data['ContactDesigCode1'] = this.ContactDesigCode1;
    data['CompanyId'] = this.CompanyId;
    data['ContactPerson1'] = this.ContactPerson1;
    data['ContactNumber1'] = this.ContactNumber1;
    data['ContactEmail1'] = this.ContactEmail1;
    data['LoginUserID'] = this.LoginUserID;


    return data;
  }

  @override
  String toString() {
    return 'ContactModel{id: $id, pkId: $pkId, CustomerID: $CustomerID, ContactDesignationName: $ContactDesignationName,ContactDesigCode1: $ContactDesigCode1,CompanyId: $CompanyId,ContactPerson1: $ContactPerson1,ContactNumber1: $ContactNumber1,ContactEmail1: $ContactEmail1,LoginUserID: $LoginUserID}';
  }
}