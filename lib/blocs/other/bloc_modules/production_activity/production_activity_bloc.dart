
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/models/api_requests/installation_request/installation_employee_request.dart';
import 'package:soleoserp/models/api_requests/product_activity_request/productionActivity_save_request.dart';
import 'package:soleoserp/models/api_requests/product_activity_request/production_activity_delete_request.dart';
import 'package:soleoserp/models/api_requests/product_activity_request/production_activity_list_request.dart';
import 'package:soleoserp/models/api_requests/product_activity_request/production_packing_list_request.dart';
import 'package:soleoserp/models/api_requests/product_activity_request/typeofwork_request.dart';
import 'package:soleoserp/models/api_responses/installation_response/installation_employee_response.dart';
import 'package:soleoserp/models/api_responses/production_activity_response/productactivity_typeofwork_response.dart';

import 'package:soleoserp/models/api_responses/production_activity_response/productionActivity_save_response.dart';
import 'package:soleoserp/models/api_responses/production_activity_response/production_activity_delete_reponse.dart';
import 'package:soleoserp/models/api_responses/production_activity_response/production_activity_list_response.dart';
import 'package:soleoserp/models/api_responses/production_activity_response/production_activity_packingno_response.dart';
import 'package:soleoserp/repositories/repository.dart';


part 'production_activity_state.dart';
part 'production_activity_event.dart';


class ProductionActivityBloc extends Bloc<ProductionActivityListEvent, ProductionActivityListState> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;


  ///Bloc Constructor
  ProductionActivityBloc(this.baseBloc)
      : super(ProductionActivityListInitialState());

  @override
  Stream<ProductionActivityListState> mapEventToState(
      ProductionActivityListEvent event) async* {

    /// Check If Event is Exist from below Function
    if (event is ProductionActivityListCallEvent) {
      yield* _mapProductionActivityListCallEventToState(event);
    }

    if (event is ProductionActivityTypeofWorkCallEvent) {
      yield* _mapProductionActivityTypeofWorkCallEventToState(event);
    }
    if (event is EmployeeCallEvent) {
      yield* _mapEmployeeCallEventToState(event);
    }
    if (event is PackingListCallEvent) {
      yield* _mapPackingListCallEventToState(event);
    }
    if (event is ProductionActivitySaveCallEvent) {
      yield* _mapProductionActivitySaveCallEventToState(event);
    }
    if (event is ProductionActivityDeleteCallEvent) {
      yield* _mapProductionActivityDeleteCallEventToState(event);
    }
  }
  Stream<ProductionActivityListState> _mapProductionActivityListCallEventToState(
      ProductionActivityListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      print("hi");
      ProductionActivityResponse respo =  await userRepository.ProductionActivityListCall(event.productionActivityRequest);

      yield ProductionActivityListCallResponseState(respo);

    } catch (error, stacktrace) {
      print(error.toString());

      baseBloc.emit(ApiCallFailureState(error));
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
  Stream<ProductionActivityListState> _mapProductionActivityTypeofWorkCallEventToState(
      ProductionActivityTypeofWorkCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      print("hi");
      TypeOfWorkResponse respo =  await userRepository.ProductionTypeofwork(event.typeOfWorkRequest);

      yield ProductionActivityTypeofWorkCallResponseState(respo);

    } catch (error, stacktrace) {
      print(error.toString());

      baseBloc.emit(ApiCallFailureState(error));
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
  Stream<ProductionActivityListState> _mapEmployeeCallEventToState(
      EmployeeCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      print("hi");
      InstallationEmployeeResponse respo =  await userRepository.installationemployee(event.installationEmployeeRequest);

      yield EmployeeCallResponseState(respo);

    } catch (error, stacktrace) {
      print(error.toString());

      baseBloc.emit(ApiCallFailureState(error));
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
  Stream<ProductionActivityListState> _mapPackingListCallEventToState(
      PackingListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      print("hi");
      PackingListResponse respo =  await userRepository.packinglist(event.productionPackingListRequest);

      yield PackingListCallResponseState(respo);

    } catch (error, stacktrace) {
      print(error.toString());

      baseBloc.emit(ApiCallFailureState(error));
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
  Stream<ProductionActivityListState> _mapProductionActivitySaveCallEventToState(
      ProductionActivitySaveCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      print("hi");
      ProductionActivitySaveResponse respo =  await userRepository.productionactivitysave(event.id,event.saveProductionActivityRequest);

      yield ProductionActivitySaveCallResponseState(respo);

    } catch (error, stacktrace) {
      print(error.toString());

      baseBloc.emit(ApiCallFailureState(error));
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
  Stream<ProductionActivityListState> _mapProductionActivityDeleteCallEventToState(
      ProductionActivityDeleteCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      //call your api as follows
      print("hi");
      ProductionActivityDeleteResponse respo =  await userRepository.productionactivitydelete(event.id,event.productionActivityDeleteRequest);

      yield ProductionActivityDeleteCallResponseState(respo);

    } catch (error, stacktrace) {
      print(error.toString());

      baseBloc.emit(ApiCallFailureState(error));
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


}