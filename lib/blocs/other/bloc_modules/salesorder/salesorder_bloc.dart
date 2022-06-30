import 'package:flutter/material.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/models/api_requests/sales_order_generate_pdf_request.dart';
import 'package:soleoserp/models/api_requests/salesorder_list_request.dart';
import 'package:soleoserp/models/api_requests/search_salesorder_list_by_name_request.dart';
import 'package:soleoserp/models/api_requests/search_salesorder_list_by_number_request.dart';
import 'package:soleoserp/models/api_responses/sales_order_pdf_generate_pdf_response.dart';
import 'package:soleoserp/models/api_responses/salesorder_list_response.dart';
import 'package:soleoserp/models/api_responses/search_salesorder_list_response.dart';
import 'package:soleoserp/repositories/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'salesorder_events.dart';

part 'salesorder_states.dart';

class SalesOrderBloc extends Bloc<SalesOrderEvents, SalesOrderStates> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;

  SalesOrderBloc(this.baseBloc) : super(SalesOrderInitialState());

  @override
  Stream<SalesOrderStates> mapEventToState(
      SalesOrderEvents event) async* {
    /// sets state based on events
    if (event is SalesOrderListCallEvent) {
      yield* _mapSalesOrderListCallEventToState(event);
    }
    if (event is SearchSalesOrderListByNameCallEvent) {
      yield* _mapSearchSalesOrderListByNameCallEventToState(event);
    }
    if (event is SearchSalesOrderListByNumberCallEvent) {
      yield* _mapSearchSalesOrderListByNumberCallEventToState(event);
    }

    if (event is SalesOrderPDFGenerateCallEvent) {
      yield* _mapSalesOrderPDFGenerateCallEventToState(event);
    }


  }

  ///event functions to states implementation
  Stream<SalesOrderStates> _mapSalesOrderListCallEventToState(
      SalesOrderListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      SalesOrderListResponse response =
      await userRepository.getSalesOrderList(event.pageNo,event.salesOrderListApiRequest);
      yield SalesOrderListCallResponseState(response,event.pageNo);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }


  Stream<SalesOrderStates> _mapSearchSalesOrderListByNumberCallEventToState(
      SearchSalesOrderListByNumberCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      SalesOrderListResponse response =
      await userRepository.getSalesOrderListSearchByNumber(event.pkID,event.request);
      yield SearchSalesOrderListByNumberCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<SalesOrderStates> _mapSearchSalesOrderListByNameCallEventToState(
      SearchSalesOrderListByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      SearchSalesOrderListResponse response =
      await userRepository.getSalesOrderListSearchByName(event.request);
      yield SearchSalesOrderListByNameCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<SalesOrderStates> _mapSalesOrderPDFGenerateCallEventToState(
      SalesOrderPDFGenerateCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      SalesOrderPDFGenerateResponse response =
      await userRepository.getSalesOrderPDFGenerate(event.request);
      yield SalesOrderPDFGenerateResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

}