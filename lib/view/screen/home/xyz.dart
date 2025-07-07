import 'package:flutter/material.dart';
import 'package:my_tester/controller/authentication/login_provider.dart';
import 'package:my_tester/data/model/vendor_id_model.dart';
import 'package:provider/provider.dart';

import '../../../utility/local_storage.dart';
class LogoDisplay extends StatefulWidget {
  const LogoDisplay({Key? key}) : super(key: key);

  @override
  State<LogoDisplay> createState() => _LogoDisplayState();
}

class _LogoDisplayState extends State<LogoDisplay> {
  String? logoUrl;

  @override
  void initState() {
    super.initState();
    loadLogo();
  }

  void loadLogo() async {
    final url = await StorageHelper.getLogoUrl();
    setState(() {
      logoUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return logoUrl != null
        ? Image.network(logoUrl!, height: 40)
        : const SizedBox(); // or CircularProgressIndicator() if needed
  }
}
