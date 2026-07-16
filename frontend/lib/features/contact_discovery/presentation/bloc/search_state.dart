import 'package:flutter/foundation.dart';
import '../../data/models/discovered_user_model.dart';

@immutable   
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<DiscoveredUserModel> results;
  SearchSuccess(this.results);
}

class SearchFailure extends SearchState{
  final String errorMessage;
  SearchFailure(this.errorMessage);
}