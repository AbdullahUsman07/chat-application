import 'package:flutter/foundation.dart';

@immutable   
abstract class SearchEvent {}

class SearchQueryChanged extends SearchEvent {
  final String query;
  SearchQueryChanged(this.query);
}

class ExecuteQuery extends SearchEvent {
  final String query;
  ExecuteQuery(this.query);
}