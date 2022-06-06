// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:whatsapp_status_api/whatsapp_status_api.dart';
import 'package:whatsaver/app/app.dart';
import 'package:whatsaver/bootstrap.dart';

void main() {
  bootstrap(() => const App());
  print(const WhatsappStatusApi().getImages());
}
