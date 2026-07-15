
import 'package:flutter/foundation.dart';
import '../../data/models/discovered_user_model.dart';

@immutable    
abstract class DiscoveryState {}

class DiscoveryInitial extends DiscoveryState {}

class DiscoveryLoading extends DiscoveryState {}

class DiscoverySuccess extends DiscoveryState{
  final List<DiscoveredUserModel> matchedUsers;

  DiscoverySuccess(this.matchedUsers);
}

class DiscoveryFailure extends DiscoveryState{
  final String errorMessage;
  DiscoveryFailure(this.errorMessage);
}