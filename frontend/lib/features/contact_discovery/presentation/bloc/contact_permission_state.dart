
import 'package:flutter/foundation.dart';

@immutable
abstract class ContactPermissionState {}

class ContactPermissionInital extends ContactPermissionState {}

class ContactPermissionChecking extends ContactPermissionState {}

class ContactPermissionGranted extends ContactPermissionState {}

class ContactPermissionDenied extends ContactPermissionState {}

class ContactPermissionPermanentlyDenied extends ContactPermissionState {}

