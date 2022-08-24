import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/repositories/repository.dart';

part 'cash_voucher_events.dart';
part 'cash_voucher_states.dart';

class CashVoucherScreenBloc
    extends Bloc<CashVoucherScreenEvents, CashVoucherScreenStates> {
  Repository repository = Repository.getInstance();
  BaseBloc baseBloc;

  CashVoucherScreenBloc(this.baseBloc) : super(CashVoucherScreenInitialState());

  @override
  Stream<CashVoucherScreenStates> mapEventToState(
      CashVoucherScreenEvents event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
