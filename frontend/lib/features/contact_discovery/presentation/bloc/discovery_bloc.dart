import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/discovery_repository.dart';
import 'discovery_event.dart';
import 'discovery_state.dart';

class DiscoveryBloc extends Bloc<DiscoveryEvent, DiscoveryState> {
  final DiscoveryRepository discoveryRepository;

  DiscoveryBloc({required this.discoveryRepository}) : super(DiscoveryInitial()) {
    on<SyncContactEvent>(_onSyncContacts);
  }

  Future<void> _onSyncContacts(
    SyncContactEvent event,
    Emitter<DiscoveryState> emit,
  ) async {
    emit(DiscoveryLoading());
    try {
      final matchedUsers = await discoveryRepository.syncDeviceContacts();
      emit(DiscoverySuccess(matchedUsers));
    } catch (e) {
      emit(DiscoveryFailure(e.toString()));
    }
  }
}