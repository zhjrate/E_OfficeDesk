import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/manage_production/production_bloc.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/general_utils.dart';

class SiteSurveyAddEditScreen extends BaseStatefulWidget {
  static const routeName = '/SiteSurveyAddEditScreen';

  _SiteSurveyAddEditScreenState createState() =>
      _SiteSurveyAddEditScreenState();
}

class _SiteSurveyAddEditScreenState extends BaseState<SiteSurveyAddEditScreen>
    with BasicScreen, WidgetsBindingObserver {
  ProductionBloc _manageProductionBloc;

  /**************************************Text Editing Controllers***************************************/

  /*****************************Mandatory Details******************************/

  TextEditingController _document_no = TextEditingController();
  TextEditingController _document_no_ID = TextEditingController();
  TextEditingController _sheet_no = TextEditingController();
  TextEditingController _sheet_no_ID = TextEditingController();
  TextEditingController _survey_date = TextEditingController();
  TextEditingController _survey_date_ID = TextEditingController();
  TextEditingController _customer_name = TextEditingController();
  TextEditingController _customer_name_ID = TextEditingController();

  /*******************************Site Information & Customer Details*******************************/
  TextEditingController _contact_person_name_1 = TextEditingController();
  TextEditingController _contact_person_name_1_ID = TextEditingController();
  TextEditingController _contact_number_1 = TextEditingController();
  TextEditingController _contact_number_1_ID = TextEditingController();
  TextEditingController _contact_address_1 = TextEditingController();
  TextEditingController _contact_address_1_ID = TextEditingController();
  TextEditingController _email_address_1 = TextEditingController();
  TextEditingController _email_address_1_ID = TextEditingController();
  TextEditingController _designation_1 = TextEditingController();
  TextEditingController _designation_1_ID = TextEditingController();
  TextEditingController _contact_person_name_2 = TextEditingController();
  TextEditingController _contact_person_name_2_ID = TextEditingController();
  TextEditingController _contact_number_2 = TextEditingController();
  TextEditingController _contact_number_2_ID = TextEditingController();
  TextEditingController _contact_address_2 = TextEditingController();
  TextEditingController _contact_address_2_ID = TextEditingController();
  TextEditingController _email_address_2 = TextEditingController();
  TextEditingController _email_address_2_ID = TextEditingController();
  TextEditingController _designation_2 = TextEditingController();
  TextEditingController _designation_2_ID = TextEditingController();
  TextEditingController _full_site_address = TextEditingController();
  TextEditingController _full_site_address_ID = TextEditingController();
  TextEditingController _latitude = TextEditingController();
  TextEditingController _latitude_ID = TextEditingController();
  TextEditingController _longitude = TextEditingController();
  TextEditingController _longitude_ID = TextEditingController();
  TextEditingController _altitude = TextEditingController();
  TextEditingController _altitude_ID = TextEditingController();
  TextEditingController _nearest_railway_station = TextEditingController();
  TextEditingController _nearest_railway_station_ID = TextEditingController();
  TextEditingController _nearest_airport = TextEditingController();
  TextEditingController _nearest_airport_ID = TextEditingController();
  TextEditingController _avail_of_water_and_electricity =
      TextEditingController();
  TextEditingController _avail_of_water_and_electricity_ID =
      TextEditingController();

  /*******************************Civil Mechanical Details*******************************/

  /*******************Name Of Location*******************/
  TextEditingController _location_name_roof_top_rcc = TextEditingController();
  TextEditingController _location_name_roof_top_rcc_ID =
      TextEditingController();
  TextEditingController _location_name_roof_top_metal_sheet =
      TextEditingController();
  TextEditingController _location_name_roof_top_metal_sheet_ID =
      TextEditingController();
  TextEditingController _location_name_ground_mount = TextEditingController();
  TextEditingController _location_name_ground_mount_ID =
      TextEditingController();

  /*******************Tilt Angle*******************/
  TextEditingController _tilt_angle_roof_top_rcc = TextEditingController();
  TextEditingController _tilt_angle_roof_top_rcc_ID = TextEditingController();
  TextEditingController _tilt_angle_roof_top_metal_sheet =
      TextEditingController();
  TextEditingController _tilt_angle_roof_top_metal_sheet_ID =
      TextEditingController();
  TextEditingController _tilt_angle_ground_mount = TextEditingController();
  TextEditingController _tilt_angle_ground_mount_ID = TextEditingController();

  /*******************Available Area*******************/
  TextEditingController _available_area_roof_top_rcc = TextEditingController();
  TextEditingController _available_area_roof_top_rcc_ID =
      TextEditingController();
  TextEditingController _available_area_roof_top_metal_sheet =
      TextEditingController();
  TextEditingController _available_area_roof_top_metal_sheet_ID =
      TextEditingController();
  TextEditingController _available_area_ground_mount = TextEditingController();
  TextEditingController _available_area_ground_mount_ID =
      TextEditingController();

  /*******************Orientation*******************/
  TextEditingController _orientation_roof_top_rcc = TextEditingController();
  TextEditingController _orientation_roof_top_rcc_ID = TextEditingController();
  TextEditingController _orientation_roof_top_metal_sheet =
      TextEditingController();
  TextEditingController _orientation_roof_top_metal_sheet_ID =
      TextEditingController();
  TextEditingController _orientation_ground_mount = TextEditingController();
  TextEditingController _orientation_name_ground_mount_ID =
      TextEditingController();

  TextEditingController _structure_type = TextEditingController();
  TextEditingController _structure_type_ID = TextEditingController();
  TextEditingController penetration_allowed = TextEditingController();
  TextEditingController penetration_allowed_ID = TextEditingController();

  /*******************************Electrical Details*******************************/

  /*******************DG Rating Numbers*******************/
  TextEditingController _dg_rating_numbers_on_grid = TextEditingController();
  TextEditingController _dg_rating_numbers_on_grid_ID = TextEditingController();
  TextEditingController _dg_rating_numbers_Off_grid = TextEditingController();
  TextEditingController _dg_rating_numbers_Off_grid_ID =
      TextEditingController();
  TextEditingController _dg_rating_numbers_Hybrid = TextEditingController();
  TextEditingController _dg_rating_numbers_Hybrid_ID = TextEditingController();

  /*******************Contact Demands*******************/
  TextEditingController _contract_demand_on_grid = TextEditingController();
  TextEditingController _contract_demand_on_grid_ID = TextEditingController();
  TextEditingController _contract_demand_Off_grid = TextEditingController();
  TextEditingController _contract_demand_Off_grid_ID = TextEditingController();
  TextEditingController _contract_demand_Hybrid = TextEditingController();
  TextEditingController _contract_demand_Hybrid_ID = TextEditingController();

  /*******************Installation Capacity*******************/
  TextEditingController _installation_capacity_numbers_on_grid =
      TextEditingController();
  TextEditingController _installation_capacity_numbers_on_grid_ID =
      TextEditingController();
  TextEditingController _installation_capacity_numbers_Off_grid =
      TextEditingController();
  TextEditingController _installation_capacity_numbers_Off_grid_ID =
      TextEditingController();
  TextEditingController _installation_capacity_numbers_Hybrid =
      TextEditingController();
  TextEditingController _installation_capacity_numbers_Hybrid_ID =
      TextEditingController();

  /*******************Other Installation Details*******************/
  TextEditingController _installation_type = TextEditingController();
  TextEditingController _installation_type_ID = TextEditingController();
  TextEditingController _dg = TextEditingController();
  TextEditingController _dg_ID = TextEditingController();
  TextEditingController _dg_operation = TextEditingController();
  TextEditingController _dg_operation_ID = TextEditingController();
  TextEditingController _data_monitoring = TextEditingController();
  TextEditingController _data_monitoring_ID = TextEditingController();
  TextEditingController _weather_monitoring = TextEditingController();
  TextEditingController _weather_monitoring_ID = TextEditingController();
  TextEditingController _avail_breaker_to_feed = TextEditingController();
  TextEditingController _avail_breaker_to_feed_ID = TextEditingController();
  TextEditingController _bus_bar_type_size = TextEditingController();
  TextEditingController _bus_bar_type_size_ID = TextEditingController();

  /*******************Transformer Details*******************/
  TextEditingController _kva_rating = TextEditingController();
  TextEditingController _kva_rating_ID = TextEditingController();
  TextEditingController _primary_voltage = TextEditingController();
  TextEditingController _primary_voltage_ID = TextEditingController();
  TextEditingController _secondary_voltage = TextEditingController();
  TextEditingController _secondary_voltage_ID = TextEditingController();
  TextEditingController _z_impedance = TextEditingController();
  TextEditingController _z_impedance_ID = TextEditingController();
  TextEditingController _vector_group = TextEditingController();
  TextEditingController _vector_group_ID = TextEditingController();

  /*******************************Common Required Inputs*******************************/
  TextEditingController _o_and_m_requirements = TextEditingController();
  TextEditingController _o_and_m_requirements_ID = TextEditingController();
  TextEditingController _module_clearing_requirements = TextEditingController();
  TextEditingController _module_clearing_requirements_ID =
      TextEditingController();
  TextEditingController _roof_plan_elevation_drawing_sld =
      TextEditingController();
  TextEditingController _roof_plan_elevation_drawing_sld_ID =
      TextEditingController();
  TextEditingController _load_details = TextEditingController();
  TextEditingController _load_details_ID = TextEditingController();

  /*******************************Required Inputs for Metal Sheet Roof*******************************/
  TextEditingController _sheet_type_and_structure = TextEditingController();
  TextEditingController _sheet_type_and_structure_ID = TextEditingController();
  TextEditingController _distance_between_purlin = TextEditingController();
  TextEditingController _distance_between_purlin_ID = TextEditingController();
  TextEditingController _roof_sheet = TextEditingController();
  TextEditingController _roof_sheet_ID = TextEditingController();
  TextEditingController _structure_stability = TextEditingController();
  TextEditingController _structure_stability_ID = TextEditingController();
  TextEditingController _skylight_and_ventilators = TextEditingController();
  TextEditingController _skylight_and_ventilators_ID = TextEditingController();
  TextEditingController _sheet_type_access_ladder_to_roof =
      TextEditingController();
  TextEditingController _sheet_type_access_ladder_to_roof_ID =
      TextEditingController();

  /*******************************Required Inputs for Ground Mounts*******************************/
  TextEditingController _soil_test_report = TextEditingController();
  TextEditingController _soil_test_report_ID = TextEditingController();
  TextEditingController _contour_survey = TextEditingController();
  TextEditingController _contour_survey_ID = TextEditingController();
  TextEditingController _fix_seasonal_tilt = TextEditingController();
  TextEditingController _fix_seasonal_tilt_ID = TextEditingController();
  TextEditingController _string_central_inverter = TextEditingController();
  TextEditingController _string_central_inverter_ID = TextEditingController();

  @override
  void initState() {
    _manageProductionBloc = ProductionBloc(baseBloc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => _manageProductionBloc,
        child: BlocConsumer<ProductionBloc, ProductionStates>(
          builder: (BuildContext context, ManageProductionStates) {
            return super.build(context);
          },
          buildWhen: (oldState, currentState) {
            return false;
          },
          listener: (BuildContext context, ManageProductionStates) {
            return super.build(context);
          },
          listenWhen: (oldState, currentState) {
            return false;
          },
        ));
  }

  @override
  Widget buildBody(BuildContext context) {
    return WillPopScope(
      onWillPop:_onBackPressed ,
      child: Scaffold(
        appBar: NewGradientAppBar(
          gradient:
              LinearGradient(colors: [Colors.blue, Colors.purple, Colors.red]),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 15,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.water_damage_sharp,
                  color: colorWhite,
                  size: 20,
                ),
                onPressed: () {
                  //_onTapOfLogOut();
                  navigateTo(context, HomeScreen.routeName, clearAllStack: true);
                })
          ],
          title: Text(
            "Site Survey Details",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                mandatoryDetails(),
                space(5.0, 0.0),
                siteInformationCustomerDetail(),
                space(5.0, 0.0),
                civilMechanicalDetail(),
                space(5.0, 0.0),
                electricalDetail(),
                space(5.0, 0.0),
                commonRequiredInputs(),
                space(5.0, 0.0),
                requiredInputForMetalSheetRoof(),
                space(5.0, 0.0),
                requiredInputForGroundMounts(),
                space(10.0, 0.0),
                save()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, HomeScreen.routeName, clearAllStack: true);
  }

  Widget mandatoryDetails() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                  child: customTextLabel("Document No.",
                      leftPad: 9, bottomPad: 2)),
              Flexible(
                child: customTextLabel("Sheet No.", leftPad: 9, bottomPad: 2),
              )
            ],
          ),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: EditText(context,
                    inputTextStyle: TextStyle(fontSize: 14),
                    hint: "Document No.",
                    radius: 15,
                    controller: _document_no,
                    boxheight: 40,
                    keyboardType: TextInputType.number),
              ),
              Flexible(
                flex: 1,
                child: EditText(context,
                    inputTextStyle: TextStyle(fontSize: 14),
                    hint: "Sheet No.",
                    radius: 15,
                    controller: _sheet_no,
                    boxheight: 40,
                    keyboardType: TextInputType.number),
              ),
            ],
          ),
          space(15.0, 0.0),
          customTextLabel("Survey Date", leftPad: 9, bottomPad: 2),
          EditText(context,
              inputTextStyle: TextStyle(fontSize: 14),
              hint: "DD-MM-YYYY",
              radius: 15,
              controller: _survey_date,
              boxheight: 40,
              keyboardType: TextInputType.number,
              readOnly: true,
              suffixIcon: Container(
                  margin: EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.calendar_today,
                    size: 15,
                    color: colorGrayVeryDark,
                  ))),
          space(15, 0),
          customTextLabel("Customer Name", leftPad: 9, bottomPad: 2),
          EditText(context,
              title: "Customer Name",
              hint: "Tap to Select Customer Name",
              controller: _customer_name,
              suffixIcon: Icon(Icons.arrow_drop_down, color: colorGrayVeryDark),
              readOnly: true,
              radius: 15,
              boxheight: 40)
        ],
      ),
    );
  }

  Widget siteInformationCustomerDetail() {
    return customExpansionTileType1(
        "Site Information Customer Details",
        Column(
          children: [
            space(10.0, 0.0),
            // Contact Person 1 Details
            customExpansionTileType1(
                "Contact Person 1 Details",
                Column(
                  children: [
                    customTextLabel("Name of Contact Person 1",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Contact Person Name 1",
                        radius: 15,
                        controller: _contact_person_name_1,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Contact No. 1",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Contact No. 1",
                        radius: 15,
                        controller: _contact_number_1,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Contact Address 1",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Contact Address 1",
                        radius: 15,
                        controller: _contact_address_1,
                        boxheight: 70,
                        keyboardType: TextInputType.text,
                        maxLines: 3),
                    space(10.0, 0.0),
                    customTextLabel("Email Address 1",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Email Address 1",
                        radius: 15,
                        controller: _email_address_1,
                        boxheight: 40,
                        keyboardType: TextInputType.emailAddress),
                    space(10.0, 0.0),
                    customTextLabel("Designation 1",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Designation 1",
                        radius: 15,
                        controller: _designation_1,
                        boxheight: 40,
                        keyboardType: TextInputType.emailAddress),
                  ],
                ),
                Icon(Icons.account_circle_rounded)),
            space(10.0, 0.0),
            // Contact Person 2 Details
            customExpansionTileType1(
                "Contact Person 2 Details",
                Column(
                  children: [
                    customTextLabel("Name of Contact Person 2",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Contact Person Name 2",
                        radius: 15,
                        controller: _contact_person_name_2,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Contact No. 2",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Contact No. 2",
                        radius: 15,
                        controller: _contact_number_2,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Contact Address 2",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Contact Address 2",
                        radius: 15,
                        controller: _contact_address_2,
                        boxheight: 70,
                        keyboardType: TextInputType.text,
                        maxLines: 3),
                    space(10.0, 0.0),
                    customTextLabel("Email Address 2",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Email Address 2",
                        radius: 15,
                        controller: _email_address_2,
                        boxheight: 40,
                        keyboardType: TextInputType.emailAddress),
                    space(10.0, 0.0),
                    customTextLabel("Designation 2",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Designation 2",
                        radius: 15,
                        controller: _designation_2,
                        boxheight: 40,
                        keyboardType: TextInputType.emailAddress),
                  ],
                ),
                Icon(Icons.account_circle_rounded)),
            space(10.0, 0.0),
            //  Other Details
            customExpansionTileType1(
                "Other Details",
                Column(
                  children: [
                    customTextLabel("Full Site Address",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Full Site Address",
                        radius: 15,
                        controller: _full_site_address,
                        boxheight: 70,
                        keyboardType: TextInputType.text,
                        maxLines: 3),
                    space(10.0, 0.0),
                    Row(
                      children: [
                        Flexible(
                            child: customTextLabel("Latitude",
                                leftPad: 9.0, bottomPad: 0.0)),
                        Flexible(
                            child: customTextLabel("Longitude",
                                leftPad: 9.0, bottomPad: 0.0)),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: EditText(context,
                                inputTextStyle: TextStyle(fontSize: 14),
                                hint: "Latitude",
                                radius: 15,
                                controller: _latitude,
                                boxheight: 40,
                                keyboardType: TextInputType.text)),
                        Flexible(
                            child: EditText(context,
                                inputTextStyle: TextStyle(fontSize: 14),
                                hint: "Longitude",
                                radius: 15,
                                controller: _longitude,
                                boxheight: 40,
                                keyboardType: TextInputType.text)),
                      ],
                    ),
                    space(10.0, 0.0),
                    customTextLabel("Altitude", leftPad: 9.0, bottomPad: 0.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Altitude",
                        radius: 15,
                        controller: _altitude,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Nearest Railway Station",
                        leftPad: 9.0, bottomPad: 0.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Nearest Railway Station",
                        radius: 15,
                        controller: _nearest_railway_station,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Nearest Airport",
                        leftPad: 9.0, bottomPad: 0.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Nearest Airport",
                        radius: 15,
                        controller: _nearest_airport,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Avail Of Water & Electricity",
                        leftPad: 9.0, bottomPad: 0.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Avail of Water & Electricity",
                        radius: 15,
                        controller: _avail_of_water_and_electricity,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                  ],
                ),
                Icon(Icons.details)),
            space(10.0, 0.0),
          ],
        ),
        Icon(Icons.web_asset_off_sharp),
        color: colorPink);
  }

  Widget civilMechanicalDetail() {
    return customExpansionTileType1(
        "Civil & Mechanical Detail",
        Column(
          children: [
            space(10.0, 0.0),
            //  Mount Type - RoofTop-RCC
            customExpansionTileType1(
                "RoofTop-RCC",
                Column(
                  children: [
                    customTextLabel("Name Of Location",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Name Of Location",
                        radius: 15,
                        controller: _location_name_roof_top_rcc,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Tilt Angle", leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Tilt Angle",
                        radius: 15,
                        controller: _tilt_angle_roof_top_rcc,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Available Area",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Available Area",
                        radius: 15,
                        controller: _available_area_roof_top_rcc,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Orientation",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Orientation",
                        radius: 15,
                        controller: _orientation_roof_top_rcc,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                  ],
                ),
                Icon(Icons.roofing)),

            space(10.0, 0.0),
            //  Mount Type - RoofTop-Metal Sheet
            customExpansionTileType1(
                "RoofTop-Metal Sheet",
                Column(
                  children: [
                    customTextLabel("Name Of Location",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Name Of Location",
                        radius: 15,
                        controller: _location_name_roof_top_metal_sheet,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Tilt Angle", leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Tilt Angle",
                        radius: 15,
                        controller: _tilt_angle_roof_top_metal_sheet,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Available Area",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Available Area",
                        radius: 15,
                        controller: _available_area_roof_top_metal_sheet,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Orientation",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Orientation",
                        radius: 15,
                        controller: _orientation_roof_top_metal_sheet,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                  ],
                ),
                Icon(Icons.roofing)),

            space(10.0, 0.0),
            //  Mount Type - RoofTop-Metal Sheet
            customExpansionTileType1(
                "Ground Mount",
                Column(
                  children: [
                    customTextLabel("Name Of Location",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Name Of Location",
                        radius: 15,
                        controller: _location_name_ground_mount,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Tilt Angle", leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Tilt Angle",
                        radius: 15,
                        controller: _tilt_angle_ground_mount,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Available Area",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Available Area",
                        radius: 15,
                        controller: _available_area_ground_mount,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Orientation",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Orientation",
                        radius: 15,
                        controller: _orientation_ground_mount,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                  ],
                ),
                Icon(Icons.roofing)),

            space(10.0, 0.0),

            customTextLabel("Structure Type", leftPad: 9.0, bottomPad: 2.0),
            EditText(context,
                inputTextStyle: TextStyle(fontSize: 14),
                hint: "Structure Type",
                radius: 15,
                controller: _structure_type,
                boxheight: 40,
                keyboardType: TextInputType.text),
            space(10.0, 0.0),
            customTextLabel("Penetration Allowed",
                leftPad: 9.0, bottomPad: 2.0),
            EditText(context,
                inputTextStyle: TextStyle(fontSize: 14),
                hint: "Penetration Allowed",
                radius: 15,
                controller: penetration_allowed,
                boxheight: 40,
                keyboardType: TextInputType.text),
            space(10.0, 0.0),
          ],
        ),
        Icon(Icons.construction),
        color: colorPink);
  }

  Widget electricalDetail() {
    return customExpansionTileType1(
        "Electrical Detail",
        Column(
          children: [
            space(10.0, 0.0),
            //  Plant Type - On Grid
            customExpansionTileType1(
                "On-Grid",
                Column(
                  children: [
                    customTextLabel("DG Rating & Numbers",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "DG Rating & Numbers",
                        radius: 15,
                        controller: _dg_rating_numbers_on_grid,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Contract Demand",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Contact Demand",
                        radius: 15,
                        controller: _contract_demand_on_grid,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Installation Capacity",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Installation Capacity",
                        radius: 15,
                        controller: _installation_capacity_numbers_on_grid,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                  ],
                ),
                Icon(Icons.grid_3x3)),

            space(10.0, 0.0),
            //  Plant Type - On Grid
            customExpansionTileType1(
                "Off-Grid",
                Column(
                  children: [
                    customTextLabel("DG Rating & Numbers",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "DG Rating & Numbers",
                        radius: 15,
                        controller: _dg_rating_numbers_Off_grid,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Contract Demand",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Contact Demand",
                        radius: 15,
                        controller: _contract_demand_Off_grid,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Installation Capacity",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Installation Capacity",
                        radius: 15,
                        controller: _installation_capacity_numbers_Off_grid,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                  ],
                ),
                Icon(Icons.grid_3x3)),
            space(10.0, 0.0),

            //  Plant Type - On Grid
            customExpansionTileType1(
                "Hybrid",
                Column(
                  children: [
                    customTextLabel("DG Rating & Numbers",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "DG Rating & Numbers",
                        radius: 15,
                        controller: _dg_rating_numbers_Hybrid,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Contract Demand",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Contact Demand",
                        radius: 15,
                        controller: _contract_demand_Hybrid,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Installation Capacity",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Installation Capacity",
                        radius: 15,
                        controller: _installation_capacity_numbers_Hybrid,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                  ],
                ),
                Icon(Icons.grid_3x3)),
            space(10.0, 0.0),

            //  Plant Type - On Grid
            customExpansionTileType1(
                "Additional Details",
                Column(
                  children: [
                    customTextLabel("Installation Type",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Installation Type",
                        radius: 15,
                        controller: _installation_type,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("DG", leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Synchronization",
                        radius: 15,
                        controller: _dg,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("DG Operation",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Mode",
                        radius: 15,
                        controller: _dg_operation,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Data Monitoring",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Data Monitoring",
                        radius: 15,
                        controller: _data_monitoring,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Weather Monitoring",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "System",
                        radius: 15,
                        controller: _weather_monitoring,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Avail Broker To Feed",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Solar",
                        radius: 15,
                        controller: _avail_breaker_to_feed,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    customTextLabel("Bus Bar Type & Size",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Bus Bar Type & Size",
                        radius: 15,
                        controller: _bus_bar_type_size,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                  ],
                ),
                Icon(Icons.details)),
            space(10.0, 0.0),

            //  Plant Type - On Grid
            customExpansionTileType1(
                "Transformer Detail",
                Column(
                  children: [
                    customTextLabel("KVA Rating", leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "KVA Rating",
                        radius: 15,
                        controller: _kva_rating,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Primary Voltage",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Primary Voltage",
                        radius: 15,
                        controller: _primary_voltage,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Secondary Voltage",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Secondary Voltage",
                        radius: 15,
                        controller: _secondary_voltage,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("%Z Impedance",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "Impedance",
                        radius: 15,
                        controller: _z_impedance,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                    space(10.0, 0.0),
                    customTextLabel("Vector Group",
                        leftPad: 9.0, bottomPad: 2.0),
                    EditText(context,
                        inputTextStyle: TextStyle(fontSize: 14),
                        hint: "System",
                        radius: 15,
                        controller: _vector_group,
                        boxheight: 40,
                        keyboardType: TextInputType.text),
                  ],
                ),
                Icon(Icons.transform)),
            space(10.0, 0.0),
          ],
        ),
        Icon(Icons.offline_bolt),
        color: colorPink);
  }

  Widget commonRequiredInputs() {
    return customExpansionTileType1(
        "Common Required Inputs",
        Column(children: [
          space(10, 0.0),
          customTextLabel("Site Photographs", leftPad: 9.0, bottomPad: 2.0),
          getChooseFileButton(() {}),
          space(10, 0.0),
          customTextLabel("Site Videos", leftPad: 9.0, bottomPad: 2.0),
          getChooseFileButton(() {}),
          space(10, 0.0),
          customTextLabel("Transformer Number Plates",
              leftPad: 9.0, bottomPad: 2.0),
          getChooseFileButton(() {}),
          space(10, 0.0),
          customTextLabel("Site Sketch With Object",
              leftPad: 9.0, bottomPad: 2.0),
          getChooseFileButton(() {}),
          space(10, 0.0),
          customTextLabel("O & M Requirements", leftPad: 9.0, bottomPad: 2.0),
          EditText(context,
              inputTextStyle: TextStyle(fontSize: 14),
              hint: "O & M Requirements",
              radius: 15,
              controller: _o_and_m_requirements,
              boxheight: 70,
              maxLines: 3,
              keyboardType: TextInputType.text),
          space(10, 0.0),
          customTextLabel("Module Clearing Requirements",
              leftPad: 9.0, bottomPad: 2.0),
          EditText(context,
              inputTextStyle: TextStyle(fontSize: 14),
              hint: "Module Clearing Requirements",
              radius: 15,
              controller: _module_clearing_requirements,
              boxheight: 70,
              maxLines: 3,
              keyboardType: TextInputType.text),
          space(10, 0.0),
          customTextLabel("Roof Plan, Elevation, SLD",
              leftPad: 9.0, bottomPad: 2.0),
          EditText(context,
              inputTextStyle: TextStyle(fontSize: 14),
              hint: "Roof Plan, Elevation, SLD",
              radius: 15,
              controller: _roof_plan_elevation_drawing_sld,
              boxheight: 70,
              maxLines: 3,
              keyboardType: TextInputType.text),
          getChooseFileButton(() {}),
          space(10, 0.0),
          customTextLabel("Load Details", leftPad: 9.0, bottomPad: 2.0),
          EditText(context,
              inputTextStyle: TextStyle(fontSize: 14),
              hint: "Load Details",
              radius: 15,
              controller: _load_details,
              boxheight: 70,
              maxLines: 3,
              keyboardType: TextInputType.text),
        ]),
        Icon(Icons.input_rounded),
        color: colorPink);
  }

  Widget requiredInputForMetalSheetRoof() {
    return customExpansionTileType1(
        "Required Inputs For Metal Sheet Roof",
        Column(children: [
          space(10, 0.0),
          customTextLabel("Sheet Type & Structure",
              leftPad: 9.0, bottomPad: 2.0),
          EditText(context,
              inputTextStyle: TextStyle(fontSize: 14),
              hint: "Sheet Type & Structure",
              radius: 15,
              controller: _sheet_type_and_structure,
              boxheight: 70,
              maxLines: 3,
              keyboardType: TextInputType.text),
          space(10, 0.0),
          customTextLabel("Distance between Purlins",
              leftPad: 9.0, bottomPad: 2.0),
          EditText(context,
              inputTextStyle: TextStyle(fontSize: 14),
              hint: "Distance between Purlins",
              radius: 15,
              controller: _distance_between_purlin,
              boxheight: 70,
              maxLines: 3,
              keyboardType: TextInputType.text),
          getChooseFileButton(() {}),
          space(10, 0.0),
          customTextLabel("Roof Sheet", leftPad: 9.0, bottomPad: 2.0),
          EditText(context,
              inputTextStyle: TextStyle(fontSize: 14),
              hint: "Roof Sheet",
              radius: 15,
              controller: _roof_sheet,
              boxheight: 70,
              maxLines: 3,
              keyboardType: TextInputType.text),
          space(10, 0.0),
          customTextLabel("Structure Stability", leftPad: 9.0, bottomPad: 2.0),
          EditText(context,
              inputTextStyle: TextStyle(fontSize: 14),
              hint: "Structure Stability",
              radius: 15,
              controller: _structure_stability,
              boxheight: 70,
              maxLines: 3,
              keyboardType: TextInputType.text),
          getChooseFileButton(() {}),
          space(10, 0.0),
          customTextLabel("SkyLight Ventilators", leftPad: 9.0, bottomPad: 2.0),
          EditText(context,
              inputTextStyle: TextStyle(fontSize: 14),
              hint: "SkyLight Ventilators",
              radius: 15,
              controller: _skylight_and_ventilators,
              boxheight: 70,
              maxLines: 3,
              keyboardType: TextInputType.text),
          getChooseFileButton(() {}),
          space(10, 0.0),
          customTextLabel("Access Ledger to Roof",
              leftPad: 9.0, bottomPad: 2.0),
          EditText(context,
              inputTextStyle: TextStyle(fontSize: 14),
              hint: "Access Ledger to Roof",
              radius: 15,
              controller: _sheet_type_access_ladder_to_roof,
              boxheight: 70,
              maxLines: 3,
              keyboardType: TextInputType.text),
          space(10, 0.0),
        ]),
        Icon(Icons.settings_input_antenna),
        color: colorPink);
  }

  Widget requiredInputForGroundMounts() {
    return customExpansionTileType1(
        "Required Inputs For Ground Mounts",
        Column(children: [
          space(10, 0.0),
          customTextLabel("Soil Test Report", leftPad: 9.0, bottomPad: 2.0),
          EditText(context,
              inputTextStyle: TextStyle(fontSize: 14),
              hint: "Soil Test Report",
              radius: 15,
              controller: _soil_test_report,
              boxheight: 70,
              maxLines: 3,
              keyboardType: TextInputType.text),
          getChooseFileButton(() {}),
          space(10, 0.0),
          customTextLabel("Contour Survey", leftPad: 9.0, bottomPad: 2.0),
          EditText(context,
              inputTextStyle: TextStyle(fontSize: 14),
              hint: "Contour Survey",
              radius: 15,
              controller: _contour_survey,
              boxheight: 70,
              maxLines: 3,
              keyboardType: TextInputType.text),
          getChooseFileButton(() {}),
          space(10, 0.0),
          customTextLabel("Fix Seasonal Tilt", leftPad: 9.0, bottomPad: 2.0),
          EditText(context,
              inputTextStyle: TextStyle(fontSize: 14),
              hint: "Fix Seasonal Tilt",
              radius: 15,
              controller: _fix_seasonal_tilt,
              boxheight: 70,
              maxLines: 3,
              keyboardType: TextInputType.text),
          space(10, 0.0),
          customTextLabel("String/Central Inverter",
              leftPad: 9.0, bottomPad: 2.0),
          EditText(context,
              inputTextStyle: TextStyle(fontSize: 14),
              hint: "String/Central Inverter",
              radius: 15,
              controller: _string_central_inverter,
              boxheight: 70,
              maxLines: 3,
              keyboardType: TextInputType.text),
          space(10, 0.0),
        ]),
        Icon(Icons.settings_input_antenna),
        color: colorPink);
  }

  Widget getChooseFileButton(Function onPressed) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(top: 15, bottom: 10, left: 20),
        width: 130,
        height: 25,
        decoration: BoxDecoration(
          color: colorPrimary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          child: getCommonButton(baseTheme, () {}, "Choose File",
              backGroundColor: colorPrimary, textSize: 12),
        ),
      ),
    );
  }

  Widget save() {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8),
      width: double.maxFinite,
      height: 50,
      child: TextButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          onSurface: Color(0xff362d8b),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
          elevation: 3,
        ),
        child: Text(
          "Save",
          textAlign: TextAlign.center,
          style: baseTheme.textTheme.button.copyWith(
              color: colorWhite,
              fontSize: 18,
              fontFamily: 'Sans Serif',
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
