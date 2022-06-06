part of 'permission_bloc.dart';

@immutable
abstract class PermissionState {}

class PermissionInitial extends PermissionState {}

class PermissionRequested extends PermissionState {
  PermissionRequested(this.permission);

  final Permission permission;
}

class PermissionGranted extends PermissionState {
  PermissionGranted(this.permission);

  final Permission permission;
}

class PermissionDenied extends PermissionState {
  PermissionDenied(this.permission);

  final Permission permission;
}

class PermissionPermanentlyDenied extends PermissionState {
  PermissionPermanentlyDenied(this.permission);

  final Permission permission;
}

class AppSettingsOpened extends PermissionState {}

class PermissionUndetermined extends PermissionState {
  PermissionUndetermined(this.permission);

  final Permission permission;
}
