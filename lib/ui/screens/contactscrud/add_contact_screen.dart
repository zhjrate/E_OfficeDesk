import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/other/bloc_modules/customer/customer_bloc.dart';
import 'package:soleoserp/models/api_requests/designation_list_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/models/common/all_name_id_list.dart';
import 'package:soleoserp/models/common/contact_model.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/screens/contactscrud/contacts_list_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/offline_db_helper.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

class AddContactScreenArguments {
  ContactModel model;

  AddContactScreenArguments(this.model);
}

class AddContactScreen extends BaseStatefulWidget {
  static const routeName = '/addContactsScreen';
  final AddContactScreenArguments arguments;

  AddContactScreen(this.arguments);

  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends BaseState<AddContactScreen>
    with BasicScreen, WidgetsBindingObserver {
  // DesignationApiResponse _offlineCustomerDesignationData;
  LoginUserDetialsResponse _offlineLoggedInData;
  CompanyDetailsResponse _offlineCompanyData;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _designationController = TextEditingController();
  TextEditingController _designationCode = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isForUpdate = false;
  CustomerBloc _CustomerBloc;
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Designation = [];
  bool emailValid;

  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorWhite;
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    emailValid = false;
    // _offlineCustomerDesignationData =  SharedPrefHelper.instance.getCustomerDesignationData();
    // _onDesignationCallSuccess(_offlineCustomerDesignationData);
    if (widget.arguments != null) {
      //for update
      isForUpdate = true;
      _nameController.text = widget.arguments.model.ContactPerson1;
      _emailController.text = widget.arguments.model.ContactEmail1;
      _mobileController.text = widget.arguments.model.ContactNumber1;
      _designationController.text =
          widget.arguments.model.ContactDesignationName;
      _designationCode.text = widget.arguments.model.ContactDesigCode1;
    }
    _CustomerBloc = CustomerBloc(baseBloc);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _CustomerBloc,
      child: BlocConsumer<CustomerBloc, CustomerStates>(
        builder: (BuildContext context, CustomerStates state) {
          //handle states

          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          //return true for state for which builder method should be called

          return false;
        },
        listener: (BuildContext context, CustomerStates state) {
          if (state is DesignationListEventResponseState) {
            _onDesignationCallSuccess(state);
          }
        },
        listenWhen: (oldState, currentState) {
          //return true for state for which listener method should be called
          if (currentState is DesignationListEventResponseState) {
            return true;
          }
/*
          if (currentState is DistrictListEventResponseState) {
            return true;
          }
*/

          return false;
        },
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        getCommonAppBar(
            context, baseTheme, "${isForUpdate ? "Update" : "Add"} Contact",
            showBack: true, showHome: true),
        Expanded(
          child: SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomerName(),
                  SizedBox(
                    height: 20,
                  ),
                  MobileNo(),
                  /*  getCommonTextFormField(context, baseTheme,
                          title: "Name",
                          controller: _nameController, validator: (value) {
                            if (value.toString().trim().isEmpty) {
                              return "Please enter this field";
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      getCommonTextFormField(context, baseTheme,
                          title: "Mobile no.",
                          keyboardType: TextInputType.phone,
                          controller: _mobileController, validator: (value) {
                            if (value.toString().trim().isEmpty) {
                              return "Please enter this field";
                            } else if (value.toString().trim().length != 10) {
                              return "Please enter valid value in this field";
                            }
                            return null;
                          }),*/
                  SizedBox(
                    height: 20,
                  ),
                  Email(),
                  SizedBox(
                    height: 20,
                  ),
                  CustomDropDown1(
                    "Designation",
                    enable1: false,
                    icon: Icon(Icons.arrow_drop_down),
                    controllerForLeft: _designationController,
                    Custom_values1: arr_ALL_Name_ID_For_Designation,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  getCommonButton(baseTheme, () {
                    _onTapOfAdd();
                  }, isForUpdate ? "Update" : "Add")
                ],
              ),
            ),
          )),
        ),
      ],
    );
  }

  _onTapOfAdd() async {
    if (_emailController.text != "") {
      emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(_emailController.text);
    } else {
      emailValid = false;
    }

    if (_formKey.currentState.validate()) {
      if (emailValid == true) {
        if (isForUpdate) {
          showCommonDialogWithTwoOptions(context,
              "Are you sure you want to Update Addition Contact Details ?",
              negativeButtonTitle: "No",
              positiveButtonTitle: "Yes", onTapOfPositiveButton: () async {
            await OfflineDbHelper.getInstance().updateContact(ContactModel(
                "0",
                "0",
                _designationController.text.toString().trim(),
                _designationCode.text.toString().trim(),
                "0",
                _nameController.text.toString().trim(),
                _mobileController.text.toString().trim(),
                _emailController.text.toString().trim(),
                "admin",
                id: widget.arguments.model.id

                /* _nameController.text.toString().trim(),
            _mobileController.text.toString().trim(),
            _emailController.text.toString().trim(),
            _designationController.text.toString().trim(),
            _designationCode.text.toString().trim(),
            id: widget.arguments.model.id*/
                // "1","51506","Name","5","10032","ABC","7802365954","ABC.com","admin", id: widget.arguments.model.id
                ));

            navigateTo(context, ContactsListScreen.routeName,
                clearAllStack: true);
          });
        } else {
          showCommonDialogWithTwoOptions(context,
              "Are you sure you want to Add Addition Contact Details ?",
              negativeButtonTitle: "No",
              positiveButtonTitle: "Yes", onTapOfPositiveButton: () async {
            await OfflineDbHelper.getInstance().insertContact(ContactModel(
                "0",
                "0",
                _designationController.text.toString().trim(),
                _designationCode.text.toString().trim(),
                "0",
                _nameController.text.toString().trim(),
                _mobileController.text.toString().trim(),
                _emailController.text.toString().trim(),
                "admin"));
            navigateTo(context, ContactsListScreen.routeName,
                clearAllStack: true);
          });
        }
      } else {
        showCommonDialogWithSingleOption(context, "Enter valid email !",
            positiveButtonTitle: "OK");
      }
    }
  }

  void _onDesignationCallSuccess(DesignationListEventResponseState state) {
    if (state.designationApiResponse.details.length != 0) {
      arr_ALL_Name_ID_For_Designation.clear();

      for (var i = 0; i < state.designationApiResponse.details.length; i++) {
        print("DesignationDetails : " +
            state.designationApiResponse.details[i].designation);
        ALL_Name_ID all_name_id = ALL_Name_ID();
        all_name_id.Name = state.designationApiResponse.details[i].designation;
        all_name_id.Name1 = state.designationApiResponse.details[i].desigCode;
        arr_ALL_Name_ID_For_Designation.add(all_name_id);
      }

      showcustomdialog(
          values: arr_ALL_Name_ID_For_Designation,
          context1: context,
          controller: _designationController,
          controller2: _designationCode,
          lable: "Select Designation");
    }
  }

  Widget CustomDropDown1(String Category,
      {bool enable1,
      Icon icon,
      TextEditingController controllerForLeft,
      List<ALL_Name_ID> Custom_values1}) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () => _CustomerBloc.add(DesignationCallEvent(
                DesignationApiRequest(
                    DesigCode: "",
                    CompanyId: _offlineCompanyData.details[0].pkId
                        .toString()))), //.toString()))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text("Designation",
                      style: TextStyle(
                          fontSize: 12,
                          color: colorPrimary,
                          fontWeight: FontWeight
                              .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                      ),
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  elevation: 5,
                  color: colorLightGray,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.only(left: 20, right: 20, top: 3),
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                              controller: controllerForLeft,
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: "Tap to select designation",
                                labelStyle: TextStyle(
                                  color: Color(0xFF000000),
                                ),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF000000),
                              ) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                              ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: colorGrayDark,
                        )
                      ],
                    ),
                  ),
                ),
                /* Card(
                  elevation: 5,
                  color: colorLightGray,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.only(left: 20, right: 20,top: 3),
                    width: double.maxFinite,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(

                              controller: _designationCode,
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: "Tap to select designationCode",
                                labelStyle: TextStyle(
                                  color: Color(0xFF000000),
                                ),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF000000),
                              ) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: colorGrayDark,
                        )
                      ],
                    ),
                  ),
                )*/
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget CustomerName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("Customer Name *",
              style: TextStyle(
                  fontSize: 12,
                  color: colorPrimary,
                  fontWeight: FontWeight
                      .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

              ),
        ),
        SizedBox(
          height: 5,
        ),
        Card(
          elevation: 5,
          color: colorLightGray,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            height: 60,
            padding: EdgeInsets.only(left: 20, right: 20),
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      controller: _nameController,
                      validator: (value) {
                        if (value.toString().trim().isEmpty) {
                          return "Please enter this field";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Tap to enter Name",
                        labelStyle: TextStyle(
                          color: Color(0xFF000000),
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF000000),
                      ) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                      ),
                ),
                Icon(
                  Icons.person,
                  color: colorGrayDark,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget MobileNo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("Contact No",
              style: TextStyle(
                  fontSize: 12,
                  color: colorPrimary,
                  fontWeight: FontWeight
                      .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

              ),
        ),
        SizedBox(
          height: 5,
        ),
        Card(
          elevation: 5,
          color: colorLightGray,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            height: 60,
            padding: EdgeInsets.only(left: 20, right: 20),
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                      /*validator: (value) {
                        if (value.toString().trim().isEmpty) {
                          return "Please enter this field";
                        } else if (value.toString().trim().length != 10) {
                          return "Please enter valid value in this field";
                        }
                        return null;
                      },*/
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      controller: _mobileController,
                      decoration: InputDecoration(
                        hintText: "Tap to enter Contact No",
                        labelStyle: TextStyle(
                          color: Color(0xFF000000),
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF000000),
                      ) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                      ),
                ),
                Icon(
                  Icons.phone_android,
                  color: colorGrayDark,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget Email() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text("Email",
              style: TextStyle(
                  fontSize: 12,
                  color: colorPrimary,
                  fontWeight: FontWeight
                      .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

              ),
        ),
        SizedBox(
          height: 5,
        ),
        Card(
          elevation: 5,
          color: colorLightGray,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            height: 60,
            padding: EdgeInsets.only(left: 20, right: 20),
            width: double.maxFinite,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                      /*validator: (value) {
                        if (value.toString().trim().isEmpty) {
                          return "Please enter this field";
                        } else if (!RegExp(EMAIL_PATTERN).hasMatch(value)) {
                          return "Please enter valid value in this field";
                        }
                        return null;
                      },*/
                      textInputAction: TextInputAction.done,
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Tap to enter Email",
                        labelStyle: TextStyle(
                          color: Color(0xFF000000),
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF000000),
                      ) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                      ),
                ),
                Icon(
                  Icons.email,
                  color: colorGrayDark,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
