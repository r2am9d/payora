import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:payora/core/mixins/index.dart';
import 'package:payora/core/utils/index.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState>
    with MultiStateMixin<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial()) {
    on<WalletSetVisibility>(
      _setVisibility,
      transformer: sequential(),
    );

    // Hold state
    holdState(() => const WalletVisibility());
  }

  FutureOr<void> _setVisibility(
    WalletSetVisibility event,
    Emitter<WalletState> emit,
  ) async {
    try {
      emit(WalletVisibility(visibility: event.visibility));
    } on Exception catch (e, trace) {
      AppLog.e(e.toString(), error: e, trace: trace); // coverage:ignore-line
    }
  }
}
