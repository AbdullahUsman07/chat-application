
import 'package:flutter/foundation.dart';


@immutable
class ContactPermissionEvent {}

class CheckContactPermission extends ContactPermissionEvent {}

class RequestContactPermission extends ContactPermissionEvent {}

class OpenAppSettingsEvent extends ContactPermissionEvent {}