import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/models/api_requests/ManageProductionRequest/MaterialInwardRequest/material_inward_list_request.dart';
import 'package:soleoserp/models/api_requests/ManageProductionRequest/MaterialOutward/material_outward_list_request.dart';
import 'package:soleoserp/models/api_responses/ManageProductionResponse/Material%20Outward/material_outward_list_response.dart';
import 'package:soleoserp/models/api_responses/ManageProductionResponse/MaterialInward/material_inward_list_response.dart';
import 'package:soleoserp/repositories/repository.dart';

part 'production_event.dart';
part 'production_state.dart';

class ProductionBloc extends Bloc<ProductionEvents, ProductionStates> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;

  ProductionBloc(this.baseBloc) : super(ProductionInitialStates());

  @override
  Stream<ProductionStates> mapEventToState(ProductionEvents event) async* {
    /// sets state based on events
    if (event is MaterialInwardListCallEvent) {
      yield* _mapMaterialInwardListCallEventToState(event);
    }
    if (event is MaterialOutwardListCallEvent) {
      yield* _mapMaterialOutwardListCallEventToState(event);
    }
  }

  ///event functions to states implementation
  Stream<ProductionStates> _mapMaterialInwardListCallEventToState(
      MaterialInwardListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      MaterialInwardListResponse response = await userRepository
          .materialInwardListAPI(event.pageNo, event.materialInwardListRequest);
      yield MaterialInwardListCallResponseState(response, event.pageNo);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), () {});

      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }

  Stream<ProductionStates> _mapMaterialOutwardListCallEventToState(
      MaterialOutwardListCallEvent event) async* {
    try {
      baseBloc.emit(ShowProgressIndicatorState(true));
      MaterialOutwardListResponse response =
          await userRepository.materialOutwardListAPI(
              event.pageNo, event.materialOutwardListRequest);
      yield MaterialOutwardListCallResponseState(response, event.pageNo);
    } catch (error, stacktrace) {
      baseBloc.emit(ApiCallFailureState(error));
      print(stacktrace);
    } finally {
      await Future.delayed(const Duration(milliseconds: 500), () {});

      baseBloc.emit(ShowProgressIndicatorState(false));
    }
  }
}
