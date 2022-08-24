import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/repositories/repository.dart';

part 'purchase_order_event.dart';
part 'purchase_order_state.dart';

class ManagePurchaseBloc
    extends Bloc<PurchaseOrderEvent, ManagePurchaseStates> {
  Repository userRepository = Repository.getInstance();
  BaseBloc baseBloc;

  ///Bloc Constructor
  ManagePurchaseBloc(this.baseBloc) : super(ManagePurchaseStatesInitialState());

  @override
  Stream<ManagePurchaseStates> mapEventToState(
      PurchaseOrderEvent event) async* {}
}
