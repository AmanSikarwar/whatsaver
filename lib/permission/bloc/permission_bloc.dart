import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc() : super(PermissionInitial()) {
    on<PermissionEvent>((event, emit) async {
      if (event is RequestPermission) {
        _requestPermission(event.permission);
        emit(PermissionRequested(event.permission));
      } else if (event is CheckPermissionStatus) {
        emit(await _checkPermissionStatus(event.permission));
      } else if (event is CheckStoragePermissionStatus) {
        emit(await _checkPermissionStatus(Permission.storage));
      } else if (event is RequestStoragePermission) {
        _requestPermission(Permission.manageExternalStorage);
        emit(PermissionRequested(Permission.storage));
      } else if (event is OpenAppSettings) {
        _openAppSettings();
        emit(AppSettingsOpened());
      }
    });
  }
}

void _openAppSettings() => openAppSettings();

Future<PermissionState> _checkPermissionStatus(Permission permission) async {
  final status = await permission.status;
  if (status == PermissionStatus.granted) {
    return PermissionGranted(permission);
  } else {
    if (status == PermissionStatus.denied) {
      return PermissionDenied(permission);
    } else if (status == PermissionStatus.permanentlyDenied) {
      return PermissionPermanentlyDenied(permission);
    } else {
      return PermissionUndetermined(permission);
    }
  }
}

void _requestPermission(Permission permission) => permission.request();
