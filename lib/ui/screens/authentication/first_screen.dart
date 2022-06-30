import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/other/firstscreen/first_screen_bloc.dart';
import 'package:soleoserp/models/api_requests/login_user_details_api_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/customer_source_response.dart';
import 'package:soleoserp/models/api_responses/designation_list_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/res/dimen_resources.dart';
import 'package:soleoserp/ui/res/image_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/authentication/serial_key_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

class FirstScreen extends BaseStatefulWidget {
  static const routeName = '/firstScreen';

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends BaseState<FirstScreen>
    with BasicScreen, WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  FirstScreenBloc _firstScreenBloc;
  final double _minValue = 8.0;

/*  final TextEditingController edt_User_Name = TextEditingController();

   final TextEditingController edt_User_Password = TextEditingController();*/

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  CompanyDetailsResponse _offlineCompanyData;
  CustomerSourceResponse _offlineCustomerSourceData;
  DesignationApiResponse _offlineCustomerDesignationData;
  LoginUserDetialsResponse _offlineLoggedInDetailsData;
  String InvalidUserMessage = "";
  bool _isObscure = true;
  String SiteUrl = "";

  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorWhite;
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    SiteUrl = _offlineCompanyData.details[0].siteURL;

    _firstScreenBloc = FirstScreenBloc(baseBloc);

    print("URLLLL:" + SiteUrl + "/images/companylogo/CompanyLogo.png");
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
          if (state is LoginUserDetialsCallEventResponseState) {
            _onLoginCallSuccess(state.response);
          }

          return super.build(context);
        },
        listenWhen: (oldState, currentState) {
          //return true for state for which listener method should be called
          if (currentState is LoginUserDetialsCallEventResponseState) {
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

    /*return SingleChildScrollView(
        scrollDirection: Axis.vertical,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: _minValue * 8,
            ),
            buildLogoImage(context),
            SizedBox(
              height: _minValue * 2,
            ),
            buildLoginTitle(),
            buildLoginSubTitle(),
            buildUserNameTextFiled(userName_Controller : edt_User_Name,labelName: "User Id",icon: Icon(Icons.person),maxline: 1,baseTheme:baseTheme),
            buildPasswordTextFiled(user_password_Controller : edt_User_Password),
            buildForgotTitle(),
            buildLoginButton(context,(){
              _onTapOfLogin();

            }),
            buildRegisterbTitle(context),
    ],

        )
    );*/
  }

  ///navigates to homescreen
/*  _onTapOfLogin() {
    if(edt_User_Name.text !="")
      {
        if(edt_User_Password !="")
          {
            _firstScreenBloc
                .add(LoginUserDetailsCallEvent(LoginUserDetialsAPIRequest(userID: edt_User_Name.text.toString(),password: edt_User_Password.text.toString(),companyId: _offlineLoggedInData.pkId)));
          }
        else
          {
            DialogUtils.showCustomDialog(context,title: "Alert",details: "Enter Valid Password");
          }
      }
    else{
      DialogUtils.showCustomDialog(context,title: "Alert",details: "Enter Valid UserName");

    }

  }*/

  /* _onLoginCallSuccess(LoginApiResponse response) {
    SharedPrefHelper.instance.putBool(SharedPrefHelper.IS_LOGGED_IN_BOOL, true);
    SharedPrefHelper.instance.setLoginData(response);
    //edt_User_Name.text = response.companyName.toString();
   // navigateTo(context, HomeScreen.routeName, clearAllStack: true);
  }*/

  _onLoginCallSuccess(LoginUserDetialsResponse response) {
    if (response.details.length != 0) {
      SharedPrefHelper.instance
          .putBool(SharedPrefHelper.IS_LOGGED_IN_DATA, true);
      SharedPrefHelper.instance.setLoginUserData(response);
      _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
      _offlineLoggedInDetailsData =
          SharedPrefHelper.instance.getLoginUserData();
      print("LoginAuthenticateSucess123" +
          "CompanyID : " +
          _offlineCompanyData.details[0].pkId.toString() +
          "LoginUserID : " +
          _offlineLoggedInDetailsData.details[0].userID);

      navigateTo(context, HomeScreen.routeName, clearAllStack: true);
    }
  }

  /*_onCompanyDetailsCallSucess(CompanyDetailsResponse response) {
    // SharedPrefHelper.instance.putBool(SharedPrefHelper.IS_LOGGED_IN_USER_DATA, true);


    SharedPrefHelper.instance.setCompanyData(response);
    _offlineLoggedInData = SharedPrefHelper.instance.getCompanyData();

    print(
        "Company Details : " + response.details[0].companyName.toString() + "");

  }
*/

  Widget _buildTopView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /* Image.asset(
          IMG_HEADER_LOGO,
          width: MediaQuery.of(context).size.width / 1.5,
          fit: BoxFit.fitWidth,
        ),*/

        Container(
          width: 200.0,
          height: 100.0,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Container(
                child: Center(
              child: Image.network(
                  SiteUrl + "/images/companylogo/CompanyLogo.png"),
            )),
          ),
        ),

        /* FittedBox(
            child: Image.network(
                SiteUrl + "/images/companylogo/CompanyLogo.png",
                width: 100,
                height: 150,
                fit: BoxFit.) //values(BoxFit.fitHeight,BoxFit.fitWidth)),
            ),*/
        SizedBox(
          height: 40,
        ),
        /* Text(
          "Login",
          style: baseTheme.textTheme.headline1,
        ),*/
        Text(
          "Login",
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
          "Log in to your existant account",
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
          getCommonTextFormField(context, baseTheme,
              title: "Username",
              hint: "enter username",
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
          }),
          SizedBox(
            height: 25,
          ),
          getCommonTextFormField(context, baseTheme,
              title: "Password",
              hint: "enter password",
              obscureText: _isObscure,
              textInputAction: TextInputAction.done,
              suffixIcon: /*ImageIcon(
                Image.asset(
                  IC_PASSWORD,
                  color: colorPrimary,
                  width: 10,
                  height: 10,
                ).image,
              ),*/
                  IconButton(
                icon: Icon(
                  _isObscure ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
              controller: _passwordController, validator: (value) {
            if (value.toString().trim().isEmpty) {
              return "Please enter this field";
            }
            return null;
          }),
          SizedBox(
            height: 35,
          ),
          /*Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                _onTapOfForgetPassword();
              },
              child: Text(
                "Forget Password?",
                style: baseTheme.textTheme.headline2,
              ),
            ),
          ),*/
          SizedBox(
            height: 45,
          ),
          getCommonButton(baseTheme, () {
            _onTapOfLogin();
          }, "Login"),
          SizedBox(
            height: 20,
          ),
          _buildGoogleButtonView(),
          SizedBox(
            height: 20,
          ),
          getCommonButton(baseTheme, () {
            _onTapOfRegister();
          }, "LogOut"),
          /* Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Do You want to Visit Registration Page?",
                style: baseTheme.textTheme.caption,
              ),
              SizedBox(
                width: 2,
              ),
              InkWell(
                onTap: () {
                  _onTapOfRegister();
                },
                child: Text(
                  "Tap here",
                  style: baseTheme.textTheme.caption.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorPrimary,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ],
          )*/
        ],
      ),
    );
  }

  void _onTapOfForgetPassword() {
    //TODO
  }

  void _onTapOfLogin() {
    if (_formKey.currentState.validate()) {
      _firstScreenBloc.add(LoginUserDetailsCallEvent(LoginUserDetialsAPIRequest(
          userID: _userNameController.text.toString(),
          password: _passwordController.text.toString(),
          companyId: _offlineCompanyData.details[0].pkId)));
    }
    //TODO
  }

  void _onTapOfSignInWithGoogle() {
    //TODO
  }

  void _onTapOfRegister() {
    SharedPrefHelper.instance.putBool(SharedPrefHelper.IS_REGISTERED, false);
    navigateTo(context, SerialKeyScreen.routeName, clearAllStack: true);
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
}
