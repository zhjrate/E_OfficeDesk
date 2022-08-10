import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/models/api_requests/SalesBill/sales_bill_search_by_id_request.dart';
import 'package:soleoserp/models/api_requests/SalesBill/sales_bill_search_by_name_request.dart';
import 'package:soleoserp/models/api_requests/sales_bill_generate_pdf_request.dart';
import 'package:soleoserp/models/api_requests/sales_bill_list_request.dart';
import 'package:soleoserp/models/api_requests/search_sale_bill_list_by_name_request.dart';
import 'package:soleoserp/models/api_responses/SaleBill/sales_bill_search_by_name_response.dart';
import 'package:soleoserp/models/api_responses/sales_bill_generate_pdf_response.dart';
import 'package:soleoserp/models/api_responses/sales_bill_list_response.dart';
import 'package:soleoserp/models/api_responses/search_sales_bill_search_response.dart';
import 'package:soleoserp/repositories/repository.dart';

part 'salebill_states.dart';
part 'salesbill_event.dart';

class SalesBillBloc extends Bloc<SalesBillEvents, SalesBillStates> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;

  SalesBillBloc(this.baseBloc) : super(SalesBillInitialState());

  @override
  Stream<SalesBillStates> mapEventToState(SalesBillEvents event) async* {
    /// sets state based on events
    if (event is SalesBillListCallEvent) {
      yield* _mapQuotationListCallEventToState(event);
    }
    /*if (event is SearchQuotationListByNameCallEvent) {
      yield* _mapSearchQuotationListByNameCallEventToState(event);
    }*/
    if (event is SearchSaleBillListByNameCallEvent) {
      yield* _mapSearchSaleBillListByNameCallEventToState(event);
    }

    if (event is SalesBillPDFGenerateCallEvent) {
      yield* _mapSalesBillPDFGenerateCallEventToState(event);
    }

    if (event is SalesBillSearchByIdRequestCallEvent) {
      yield* _mapSearchSaleBillListByIDCallEventToState(event);
    }
  }

  ///event functions to states implementation
  Stream<SalesBillStates> _mapQuotationListCallEventToState(
      SalesBillListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      SalesBillListResponse response = await userRepository.getSalesBillList(
          event.pageNo, event.salesBillListRequest);
      yield SalesBillListCallResponseState(response, event.pageNo);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<SalesBillStates> _mapSearchSaleBillListByNameCallEventToState(
      SearchSaleBillListByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      SearchSalesBillListResponse response =
          await userRepository.getSalesBillListSearchByName(event.request);
      yield SearchSalesBillListByNameCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<SalesBillStates> _mapSearchSaleBillListByIDCallEventToState(
      SalesBillSearchByIdRequestCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      SalesBillListResponse response = await userRepository
          .getSalesBillSearchDetailsAPI(event.custID, event.request);
      yield SalesBillSearchByIDResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

/*  Stream<QuotationStates> _mapSearchQuotationListByNumberCallEventToState(
      SearchQuotationListByNumberCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      QuotationListResponse response =
      await userRepository.getQuotationListSearchByNumber(event.pkID,event.request);
      yield SearchQuotationListByNumberCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<QuotationStates> _mapSearchQuotationListByNameCallEventToState(
      SearchQuotationListByNameCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      SearchQuotationListResponse response =
      await userRepository.getQuotationListSearchByName(event.request);
      yield SearchQuotationListByNameCallResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }*/

  Stream<SalesBillStates> _mapSalesBillPDFGenerateCallEventToState(
      SalesBillPDFGenerateCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      SalesBillPDFGenerateResponse response =
          await userRepository.getSalesBillPDFGenerate(event.request);
      yield SalesBillPDFGenerateResponseState(response);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
}
