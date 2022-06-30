import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/models/api_requests/city_list_request.dart';
import 'package:soleoserp/models/api_requests/installation_request/city_search_installtion_request.dart';
import 'package:soleoserp/models/api_requests/installation_request/installation_country_request.dart';
import 'package:soleoserp/models/api_requests/installation_request/installation_customerid_to_outwardno_request.dart';
import 'package:soleoserp/models/api_requests/installation_request/installation_delete_request.dart';
import 'package:soleoserp/models/api_requests/installation_request/installation_employee_request.dart';
import 'package:soleoserp/models/api_requests/installation_request/installation_list_request.dart';
import 'package:soleoserp/models/api_requests/installation_request/installation_save_request.dart';
import 'package:soleoserp/models/api_requests/installation_request/installation_search_customer_request.dart';
import 'package:soleoserp/models/api_requests/search_installation_request.dart';
import 'package:soleoserp/models/api_requests/state_list_request.dart';
import 'package:soleoserp/models/api_responses/installation_response/Installation_customerid_to_outwardno_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/installation_city_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/installation_country_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/installation_delete_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/installation_employee_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/installation_list_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/installation_search_customer_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/save_installation_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/search_installation_label_response.dart';
import 'package:soleoserp/models/api_responses/installation_response/state_search_response.dart';
import 'package:soleoserp/repositories/repository.dart';

part 'installation_event.dart';
part 'installation_state.dart';

class InstallationBloc extends Bloc<InstalltionListEvent, InstallationListState> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;


  ///Bloc Constructor
  InstallationBloc(this.baseBloc) : super(InstallationListInitialState());

  @override
  Stream<InstallationListState> mapEventToState(
      InstalltionListEvent event) async* {

    /// Check If Event is Exist from below Function
    if (event is InstalltionListCallEvent) {
      yield* _mapInstalltionListCallEventToState(event);
    }if (event is SearchInstallationCallEvent) {
      yield* _mapSearchInstallationCallEventToState(event);
    }if (event is SearchInstallationLabelCallEvent) {
      yield* _mapSearchInstallationLabelCallEventToState(event);
    }if (event is SaveInstallationCallEvent) {
      yield* _mapSaveInstallationCallEventToState(event);
    }if (event is DeleteInstallationCallEvent) {
      yield* _mapDeleteInstallationCallEventToState(event);
    }if (event is InstallationSearchCustomerCallEvent) {
      yield* _mapInstallationSearchCustomerCallEventToState(event);
    }
    if (event is InstallationCountryCallEvent) {
      yield* _mapInstallationCountryCallEventToState(event);
    }if (event is StateSearchCallEvent) {
      yield* _mapStateSearchCallEventToState(event);
    }if (event is CitySearchCallEvent) {
      yield* _mapCitySearchCallEventToState(event);
    }if (event is CustomerIdToOutwardCallEvent) {
      yield* _mapCustomerIdToOutwardCallEventToState(event);
    }
    if (event is InstallationEmployeeCallEvent) {
      yield* _mapInstallationEmployeeCallEventToState(event);
    }
  }
  Stream<InstallationListState> _mapInstalltionListCallEventToState(
      InstalltionListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      print("hi");
      InstallationListResponse respo =  await userRepository.InstallationListCall(event.pageNo,event.installationListRequest);

      yield InstallationListCallResponseState(event.pageNo,respo);

    } catch (error, stacktrace) {
      print(error.toString());

      baseBloc.emit(ApiCallFailureState(error));
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
  Stream<InstallationListState> _mapSearchInstallationCallEventToState(
      SearchInstallationCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      print("hi");
      InstallationListResponse respo =  await userRepository.searchinstallation(event.searchInstallationRequest);

      yield SearchInstallationCallResponseState(respo);

    } catch (error, stacktrace) {
      print(error.toString());

      baseBloc.emit(ApiCallFailureState(error));
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
  Stream<InstallationListState> _mapSearchInstallationLabelCallEventToState(
      SearchInstallationLabelCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      print("hi");
      SearchInstallationLabelResponse respo =  await userRepository.searchinstallationlabel(event.searchInstallationRequest);

      yield SearchInstallationLabelCallResponseState(respo);

    } catch (error, stacktrace) {
      print(error.toString());

      baseBloc.emit(ApiCallFailureState(error));
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
  Stream<InstallationListState> _mapSaveInstallationCallEventToState(
      SaveInstallationCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      print("hi");
      SaveInstallationResponse respo =  await userRepository.saveinstallation(event.id,event.saveInstallationRequest);

      yield SaveInstallationCallResponseState(respo);

    } catch (error, stacktrace) {
      print(error.toString());

      baseBloc.emit(ApiCallFailureState(error));
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
  Stream<InstallationListState> _mapDeleteInstallationCallEventToState(
      DeleteInstallationCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      print("hi");
      InstallationDeleteRespose respo =  await userRepository.deleteinstallation(event.pkID,event.installationDeleteRequest);

      yield DeleteInstallationCallResponseState(respo);

    } catch (error, stacktrace) {
      print(error.toString());

      baseBloc.emit(ApiCallFailureState(error));
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
  Stream<InstallationListState> _mapInstallationSearchCustomerCallEventToState(
      InstallationSearchCustomerCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      print("hi");
      InstallationSearchCustomerResponse respo =  await userRepository.installationcustomersearch(event.installationCustomerSearchRequest);

      yield InstallationCustomerSearchCallResponseState(respo);

    } catch (error, stacktrace) {
      print(error.toString());

      baseBloc.emit(ApiCallFailureState(error));
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
  Stream<InstallationListState> _mapInstallationCountryCallEventToState(
      InstallationCountryCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      print("hi");
      InstallationCountryResponse respo =  await userRepository.installationcontry(event.installationCountryRequest);

      yield InstallationCountryCallResponseState(respo);

    } catch (error, stacktrace) {
      print(error.toString());

      baseBloc.emit(ApiCallFailureState(error));
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
  Stream<InstallationListState> _mapStateSearchCallEventToState(
      StateSearchCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      print("hi");
      StateResponse respo =  await userRepository.installationstate(event.stateListRequest);

      yield StateSearchCallResponseState(respo);

    } catch (error, stacktrace) {
      print(error.toString());

      baseBloc.emit(ApiCallFailureState(error));
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
  Stream<InstallationListState> _mapCitySearchCallEventToState(
      CitySearchCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      print("hi");
      InstallationCityResponse respo =  await userRepository.installationcity(event.cityApiRequest);

      yield CitySearchCallResponseState(respo);

    } catch (error, stacktrace) {
      print(error.toString());

      baseBloc.emit(ApiCallFailureState(error));
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
  Stream<InstallationListState> _mapCustomerIdToOutwardCallEventToState(
      CustomerIdToOutwardCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      print("hi");
      CustomerIdToOutwardnoResponse respo =  await userRepository.idtooutwardno(event.installationCustomerIdToOutwardnoRequest);

      yield CustomerIdToOutwardCallResponseState(respo);

    } catch (error, stacktrace) {
      print(error.toString());

      baseBloc.emit(ApiCallFailureState(error));
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
  Stream<InstallationListState> _mapInstallationEmployeeCallEventToState(
      InstallationEmployeeCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      print("hi");
      InstallationEmployeeResponse respo =  await userRepository.installationemployee(event.installationEmployeeRequest);

      yield InstallationEmployeeCallResponseState(respo);

    } catch (error, stacktrace) {
      print(error.toString());

      baseBloc.emit(ApiCallFailureState(error));
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


}


