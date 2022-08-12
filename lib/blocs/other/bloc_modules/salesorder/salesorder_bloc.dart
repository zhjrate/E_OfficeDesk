import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/models/api_requests/SalesOrder/bank_details_list_request.dart';
import 'package:soleoserp/models/api_requests/quotation_project_list_request.dart';
import 'package:soleoserp/models/api_requests/quotation_terms_condition_request.dart';
import 'package:soleoserp/models/api_requests/sales_order_generate_pdf_request.dart';
import 'package:soleoserp/models/api_requests/salesorder_list_request.dart';
import 'package:soleoserp/models/api_requests/search_salesorder_list_by_name_request.dart';
import 'package:soleoserp/models/api_requests/search_salesorder_list_by_number_request.dart';
import 'package:soleoserp/models/api_responses/SaleOrder/bank_details_list_response.dart';
import 'package:soleoserp/models/api_responses/quotation_project_list_response.dart';
import 'package:soleoserp/models/api_responses/quotation_terms_condition_response.dart';
import 'package:soleoserp/models/api_responses/sales_order_pdf_generate_pdf_response.dart';
import 'package:soleoserp/models/api_responses/salesorder_list_response.dart';
import 'package:soleoserp/models/api_responses/search_salesorder_list_response.dart';
import 'package:soleoserp/repositories/repository.dart';

part 'salesorder_events.dart';
part 'salesorder_states.dart';

class SalesOrderBloc extends Bloc<SalesOrderEvents, SalesOrderStates> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;

  SalesOrderBloc(this.baseBloc) : super(SalesOrderInitialState());

  @override
  Stream<SalesOrderStates> mapEventToState(SalesOrderEvents event) async* {
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

    if (event is SaleOrderBankDetailsListRequestEvent) {
      yield* _map_bankDetailsEvent_state(event);
    }

    if (event is QuotationProjectListCallEvent) {
      yield* _mapQuotationProjectListCallEventToState(event);
    }

    if (event is QuotationTermsConditionCallEvent) {
      yield* _mapQuotationTermsConditionEventToState(event);
    }
  }

  ///event functions to states implementation
  Stream<SalesOrderStates> _mapSalesOrderListCallEventToState(
      SalesOrderListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      SalesOrderListResponse response = await userRepository.getSalesOrderList(
          event.pageNo, event.salesOrderListApiRequest);
      yield SalesOrderListCallResponseState(response, event.pageNo);
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
      SalesOrderListResponse response = await userRepository
          .getSalesOrderListSearchByNumber(event.pkID, event.request);
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

  Stream<SalesOrderStates> _map_bankDetailsEvent_state(
      SaleOrderBankDetailsListRequestEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      BankDetailsListResponse response =
          await userRepository.getBankDetailsAPI(event.request);
      yield BankDetailsListResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<SalesOrderStates> _mapQuotationProjectListCallEventToState(
      QuotationProjectListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      QuotationProjectListResponse response =
          await userRepository.getQuotationProjectList(event.request);
      yield QuotationProjectListResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<SalesOrderStates> _mapQuotationTermsConditionEventToState(
      QuotationTermsConditionCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      QuotationTermsCondtionResponse response =
          await userRepository.getQuotationTermConditionList(event.request);
      yield QuotationTermsCondtionResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
}
