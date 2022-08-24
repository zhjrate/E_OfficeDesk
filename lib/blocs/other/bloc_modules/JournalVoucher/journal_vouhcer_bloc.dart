import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soleoserp/blocs/base/base_bloc.dart';
import 'package:soleoserp/repositories/repository.dart';

part 'journal_voucher_events.dart';
part 'journal_voucher_states.dart';

class JournalVoucherBloc
    extends Bloc<JournalVoucherEvents, JournalVoucherStates> {
  Repository repository = Repository.getInstance();
  BaseBloc baseBloc;

  JournalVoucherBloc(this.baseBloc) : super(JournalVoucherInitialStates());

  @override
  Stream<JournalVoucherStates> mapEventToState(JournalVoucherEvents event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
