part of 'permission_bloc.dart';

@immutable
abstract class PermissionEvent {}

class RequestPermission extends PermissionEvent {
  RequestPermission(this.permission);

  final Permission permission;
}

class CheckPermissionStatus extends PermissionEvent {
  CheckPermissionStatus(this.permission);

  final Permission permission;
}

class CheckStoragePermissionStatus extends PermissionEvent {
  CheckStoragePermissionStatus();
}

class RequestStoragePermission extends PermissionEvent {
  RequestStoragePermission();
}

class OpenAppSettings extends PermissionEvent {}
