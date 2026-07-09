

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'contact_permission_event.dart';
import 'contact_permission_state.dart';

class ContactPermissionBloc extends Bloc<ContactPermissionEvent, ContactPermissionState>{
  ContactPermissionBloc(): super(ContactPermissionInital()){
    on<CheckContactPermission>(_onCheckPermission);
    on<RequestContactPermission>(_onRequestPermission);
    on<OpenAppSettingsEvent>(_onOpenSettings);
  }

  Future<void> _onCheckPermission (CheckContactPermission event, Emitter<ContactPermissionState> emit)async{
    emit(ContactPermissionChecking());
    final status = await Permission.contacts.status;

    if(status.isGranted){
      emit(ContactPermissionGranted());
    }else if(status.isPermanentlyDenied){
      emit(ContactPermissionPermanentlyDenied());
    }else{
      emit(ContactPermissionDenied());
    }
  }

  Future<void> _onRequestPermission(RequestContactPermission event, Emitter<ContactPermissionState> emit)async{
    final status = await Permission.contacts.request();

    if(status.isGranted){
      emit(ContactPermissionGranted());
    }else if(status.isPermanentlyDenied){
      emit(ContactPermissionPermanentlyDenied());
    }else{
      emit(ContactPermissionDenied());
    }
  }

  Future<void> _onOpenSettings(OpenAppSettingsEvent event, Emitter<ContactPermissionState> emit)async{
    await openAppSettings();

    final status = await Permission.contacts.status;
    if(status.isGranted){
      emit(ContactPermissionGranted());
    }
  }
}