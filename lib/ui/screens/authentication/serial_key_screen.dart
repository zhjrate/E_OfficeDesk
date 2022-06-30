import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/other/firstscreen/first_screen_bloc.dart';
import 'package:soleoserp/models/api_requests/company_details_request.dart';
import 'package:soleoserp/models/api_requests/customer_category_request.dart';
import 'package:soleoserp/models/api_requests/customer_source_list_request.dart';
import 'package:soleoserp/models/api_requests/designation_list_request.dart';
import 'package:soleoserp/models/api_requests/login_user_details_api_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/customer_category_list.dart';
import 'package:soleoserp/models/api_responses/customer_source_response.dart';
import 'package:soleoserp/models/api_responses/designation_list_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/res/font_resources.dart';
import 'package:soleoserp/ui/res/image_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/authentication/first_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/dialog_utils.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

class SerialKeyScreen extends BaseStatefulWidget {
  static const routeName = '/SerialKeyScreen';


  _SerialKeyScreenState createState() => _SerialKeyScreenState();
}

class _SerialKeyScreenState extends BaseState<SerialKeyScreen>
    with BasicScreen, WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  FirstScreenBloc _firstScreenBloc;
  final double _minValue = 8.0;

/*  final TextEditingController edt_User_Name = TextEditingController();

   final TextEditingController edt_User_Password = TextEditingController();*/
  int count = 0;

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  CompanyDetailsResponse _offlineLoggedInData;
  CustomerSourceResponse _offlineCustomerSourceData;
  DesignationApiResponse _offlineCustomerDesignationData;
  LoginUserDetialsResponse _offlineLoggedInDetailsData;
  String InvalidUserMessage = "";
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorWhite;
    _firstScreenBloc = FirstScreenBloc(baseBloc);
  /*  _firstScreenBloc
      ..add(CompanyDetailsCallEvent(
          CompanyDetailsApiRequest(serialKey: "ABCD-EFGH-IJKL-MNOW")));*/

  }

  ///listener to multiple states of bloc to handles api responses
  ///use only BlocListener if only need to listen to events
/*
  @override
  Widget build(BuildContext context) {
    return BlocListener<FirstScreenBloc, FirstScreenStates>(
      bloc: _authenticationBloc,
      listener: (BuildContext context, FirstScreenStates state) {
        if (state is FirstScreenResponseState) {
          _onFirstScreenCallSuccess(state.response);
        }
      },
      child: super.build(context),
    );
  }
*/

  ///listener and builder to multiple states of bloc to handles api responses
  ///use BlocProvider if need to listen and build
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _firstScreenBloc,
      child: BlocConsumer<FirstScreenBloc, FirstScreenStates>(
        builder: (BuildContext context, FirstScreenStates state) {
          //handle states



          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          //return true for state for which builder method should be called

          return false;
        },
        listener: (BuildContext context, FirstScreenStates state) {
          //handle states
          if (state is ComapnyDetailsEventResponseState) {
            _onCompanyDetailsCallSucess(state.companyDetailsResponse);
          }

          return super.build(context);
        },
        listenWhen: (oldState, currentState) {
          //return true for state for which listener method should be called
          if (currentState is ComapnyDetailsEventResponseState) {
            return true;
          }
          return false;
        },
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    /*edt_User_Name.text = "admin";
    edt_User_Password.text = "admin!@#";*/

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            left: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN,
            right: DEFAULT_SCREEN_LEFT_RIGHT_MARGIN,
            top: 50,
            bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildTopView(), SizedBox(height: 50), _buildLoginForm()],
        ),
      ),
    );

  }




  _onCompanyDetailsCallSucess(CompanyDetailsResponse response) {
    // SharedPrefHelper.instance.putBool(SharedPrefHelper.IS_LOGGED_IN_USER_DATA, true);

    if(response.details.length!=0)
      {
        SharedPrefHelper.instance.setCompanyData(response);
        _offlineLoggedInData = SharedPrefHelper.instance.getCompanyData();
        SharedPrefHelper.instance.putBool(SharedPrefHelper.IS_REGISTERED, true);

        navigateTo(context, FirstScreen.routeName, clearAllStack: true);

        print(
            "Company Details : " + response.details[0].companyName.toString() + "");
      }
    else
      {
        showCommonDialogWithSingleOption(context, "Invalid SerialKey",
            positiveButtonTitle: "OK");
      }



  }



  Widget _buildTopView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          IMG_HEADER_LOGO,
          width: MediaQuery.of(context).size.width / 1.8,
          fit: BoxFit.fitWidth,
        ),
       /* Container(
          alignment: Alignment.topLeft,
         // width: MediaQuery.of(context).size.width / 1.5,
          child: Icon(Icons.vpn_key_outlined,
            color: colorPrimary,
            size: 78,

          ),
        ),*/
        SizedBox(
          height: 40,
        ),
        /* Text(
          "Login",
          style: baseTheme.textTheme.headline1,
        ),*/
        Text(
          "Registration",
          style: TextStyle(
            color: Color(0xff3a3285),
            fontSize: 48,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Register your account",
          style: TextStyle(
            color: Color(0xff019ee9),
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
        /*  getCommonTextFormField(context, baseTheme,
              title: "Serial Key",
              hint: "enter Serial Key",
              keyboardType: TextInputType.emailAddress,
              suffixIcon: ImageIcon(
                Image.asset(
                  IC_USERNAME,
                  color: colorPrimary,
                  width: 10,
                  height: 10,
                ).image,
              ),
              controller: _userNameController, validator: (value) {
                if (value.toString().trim().isEmpty) {
                  return "Please enter this field";
                }
                return null;
              }),*/
           SerialKeyTextField(),
          SizedBox(
            height: 25,
          ),

          Container(
            margin: EdgeInsets.all(10),
            child:   getCommonButton(baseTheme, () {
              _onTapOfLogin();
            }, "Register"),
          ),
        
          SizedBox(
            height: 20,
          ),
          _buildGoogleButtonView(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  void _onTapOfForgetPassword() {
    //TODO
  }

  void _onTapOfLogin() {
    if (_userNameController.text !="") {
     /* _firstScreenBloc.add(LoginUserDetailsCallEvent(LoginUserDetialsAPIRequest(
          userID: _userNameController.text.toString(),
          password: _passwordController.text.toString(),
          companyId: _offlineLoggedInData.details[0].pkId)));*/
      _firstScreenBloc
        ..add(CompanyDetailsCallEvent(
            CompanyDetailsApiRequest(serialKey: _userNameController.text.toString())));
    }
    else
      {
        showCommonDialogWithSingleOption(context, "Serial Key field is blank !",
            positiveButtonTitle: "OK");
      }
    //TODO
  }

  void _onTapOfSignInWithGoogle() {
    //TODO
  }

  void _onTapOfRegister() {
    // navigateTo(context, RegisterScreen.routeName, clearAllStack: true);
  }

  Widget _buildGoogleButtonView() {
    return Visibility(
      visible: false,
      child: Container(
        width: double.maxFinite,
        height: COMMON_BUTTON_HEIGHT,
        // ignore: deprecated_member_use
        child: RaisedButton(
          onPressed: () {
            _onTapOfSignInWithGoogle();
          },
          color: colorRedLight,
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.all(Radius.circular(COMMON_BUTTON_RADIUS)),
          ),
          elevation: 0.0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                IC_GOOGLE,
                width: 30,
                height: 30,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "Sign in with Google",
                textAlign: TextAlign.center,
                style: baseTheme.textTheme.button,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget SerialKeyTextField() {

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 20),

            child: Text(

                "Serial Key",
                style:TextStyle(fontSize: 15,color: colorPrimary)// baseTheme.textTheme.headline2.copyWith(color: colorBlack),

            ),
          ),
          SizedBox(
            height: 5,
          ),
          Card(
            elevation: 5,
            color: Color(0xffE0E0E0),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: 60,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                        maxLength: 19,
                        controller: _userNameController,
                        cursorColor: Color(0xFFF1E6FF),
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.vpn_key,


                          ),
                          hintText: "xxxx-xxxx-xxxx-xxxx",
                          border: InputBorder.none,
                          counterStyle: TextStyle(
                              height: double.minPositive),
                          counterText: "",
                        ),
                        onChanged: (String value) async {
                          setState(() {
                            if (count <=
                                _userNameController
                                    .text.length &&
                                (_userNameController.text.length ==
                                    4 ||
                                    _userNameController
                                        .text.length ==
                                        9 ||
                                    _userNameController
                                        .text.length ==
                                        14)) {
                              _userNameController.text =
                                  _userNameController.text + "-";
                              int pos = _userNameController
                                  .text.length;
                              _userNameController.selection =
                                  TextSelection.fromPosition(
                                      TextPosition(
                                          offset: pos));
                            } else if (count >=
                                _userNameController
                                    .text.length &&
                                (_userNameController
                                    .text.length ==
                                    4 ||
                                    _userNameController
                                        .text.length ==
                                        9 ||
                                    _userNameController
                                        .text.length ==
                                        14)) {
                              _userNameController.text =
                                  _userNameController.text
                                      .substring(
                                      0,
                                      _userNameController
                                          .text.length -
                                          1);
                              int pos = _userNameController
                                  .text.length;
                              _userNameController.selection =
                                  TextSelection.fromPosition(
                                      TextPosition(
                                          offset: pos));
                            }
                            count =
                                _userNameController.text.length;
                          });
                        })
                  ),

                ],
              ),
            ),
          )
        ],
      ),

    );



/*
    return TextFormField(
        maxLength: 19,
        controller: _userNameController,
        cursorColor: Color(0xFFF1E6FF),
        decoration: InputDecoration(
          icon: Icon(
            Icons.vpn_key,


          ),
          hintText: "xxxx-xxxx-xxxx-xxxx",
          border: InputBorder.none,
          counterStyle: TextStyle(
              height: double.minPositive),
          counterText: "",
        ),
        onChanged: (String value) async {
          setState(() {
            if (count <=
                _userNameController
                    .text.length &&
                (_userNameController.text.length ==
                    4 ||
                    _userNameController
                        .text.length ==
                        9 ||
                    _userNameController
                        .text.length ==
                        14)) {
              _userNameController.text =
                  _userNameController.text + "-";
              int pos = _userNameController
                  .text.length;
              _userNameController.selection =
                  TextSelection.fromPosition(
                      TextPosition(
                          offset: pos));
            } else if (count >=
                _userNameController
                    .text.length &&
                (_userNameController
                    .text.length ==
                    4 ||
                    _userNameController
                        .text.length ==
                        9 ||
                    _userNameController
                        .text.length ==
                        14)) {
              _userNameController.text =
                  _userNameController.text
                      .substring(
                      0,
                      _userNameController
                          .text.length -
                          1);
              int pos = _userNameController
                  .text.length;
              _userNameController.selection =
                  TextSelection.fromPosition(
                      TextPosition(
                          offset: pos));
            }
            count =
                _userNameController.text.length;
          });
        });
*/

  }




}
