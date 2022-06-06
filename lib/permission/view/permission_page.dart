import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsaver/permission/bloc/permission_bloc.dart';

class PermissionPage extends StatelessWidget {
  const PermissionPage({Key? key}) : super(key: key);

  void a_function() async {
    final docDir = await getApplicationDocumentsDirectory();
    print(docDir.path);
    final tempDir = await getTemporaryDirectory();
    print(tempDir.path);
    final whatsAppDir = Directory(
            '/storage/emulated/0/Android/data/io.github.amansikarwar.whatsaver.dev/files')
        .renameSync(
            '/storage/emulated/0/Android/data/io.github.amansikarwar.whatsaver.dev/data');
    print(whatsAppDir.path);
  }

  @override
  Widget build(BuildContext context) {
    a_function();
    return BlocProvider<PermissionBloc>(
      create: (context) =>
          PermissionBloc()..add(CheckStoragePermissionStatus()),
      child: const Scaffold(
        body: Center(
          child: PermissionBody(),
        ),
      ),
    );
  }
}

class PermissionBody extends StatelessWidget {
  const PermissionBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PermissionBloc, PermissionState>(
      listener: (context, state) {
        if (state is PermissionGranted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Permission granted'),
            ),
          );
        } else if (state is PermissionDenied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Permission denied'),
            ),
          );
        } else if (state is PermissionPermanentlyDenied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Permission permanently denied'),
            ),
          );
        } else if (state is PermissionUndetermined) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Permission undetermined'),
            ),
          );
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MaterialButton(
              child: const Text('Check permission'),
              onPressed: () => context
                  .read<PermissionBloc>()
                  .add(CheckStoragePermissionStatus()),
            ),
            const SizedBox(height: 16),
            MaterialButton(
              child: const Text('Request permission'),
              onPressed: () => context
                  .read<PermissionBloc>()
                  .add(RequestStoragePermission()),
            ),
            const SizedBox(height: 16),
            MaterialButton(
              child: const Text('Open app settings'),
              onPressed: () =>
                  context.read<PermissionBloc>().add(OpenAppSettings()),
            ),
            const SizedBox(height: 16),
            Text(state.toString()),
          ],
        );
      },
    );
  }
}
