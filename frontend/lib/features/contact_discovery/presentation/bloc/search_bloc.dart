import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/discovery_repository.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState>{
  final DiscoveryRepository discoveryRepository;
  Timer? _debounceTimer;

  SearchBloc({required this.discoveryRepository}) : super(SearchInitial()) {
    on<SearchQueryChanged>(_onQueryChanged);
    on<ExecuteQuery>(_onExecuteSearch);
  }

  void _onQueryChanged(SearchQueryChanged event, Emitter<SearchState> emit) {
    _debounceTimer?.cancel();

    if(event.query.trim().length < 2){
      emit(SearchInitial());
      return;
    }

    _debounceTimer = Timer(const Duration(microseconds: 300),(){
      add(ExecuteQuery(event.query));
    });
  }

  Future<void> _onExecuteSearch(ExecuteQuery event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    try{
      final users = await discoveryRepository.searchGlobalUsers(event.query);
      emit(SearchSuccess(users));
    }catch(e){
      emit(SearchFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}