import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:live_flutter_plugin/v2_tx_live_premier.dart';

class LivePlayPage extends StatefulWidget {
  const LivePlayPage({super.key});

  @override
  State<LivePlayPage> createState() => _LivePlayPageState();
}

class _LivePlayPageState extends State<LivePlayPage> {
  final LICENSEURL = "";
  final LICENSURLKEY = "";

  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    return Container();
  }

  setupLicense() {
    V2TXLivePremier.setLicence(LICENSEURL, LICENSURLKEY);
  }
}
