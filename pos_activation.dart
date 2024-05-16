//import 'package:android_intent_plus/android_intent.dart';
//import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primo_pay/components/activation_notifier.dart';

//import 'package:flutter/widgets.dart';
class PosActivationButton extends ConsumerStatefulWidget {
  @override
  _PosActivationButtonState createState() => _PosActivationButtonState();
}

class _PosActivationButtonState extends ConsumerState<PosActivationButton> {
  // bool _isActivated = false;
//
  // void _POSActivation() async {
  // setState(() {
  // _isActivated = true; // Set the state as activated
  //  Add additional activation logic here
  // final intent = AndroidIntent(
  // action: "action_view",
  // data: Uri(
  // scheme: 'vivapayclient',
  // host: 'pay',
  // path: 'v1',
  // queryParameters: {
  // 'appId': 'com.example.primo_pay',
  // 'action': 'activatePos',
  // 'apikey': 'qwerty123456',
  // 'apiSecret': 'qwerty123456',
  // 'sourceID': 'qwerty123456',
  // 'pinCode': '123142',
  // 'skipExternalDeviceSetup': 'true',
  // 'activateMoto': 'true',
  // 'activateQRCodes': 'true',
  // 'disableManualAmountEntry': 'true',
  // 'forceCardPresentmentForRefund': 'true',
  // 'lockRefund': 'true',
  // 'lockTransactionsList': 'true',
  // 'lockMoto': 'true',
  // 'lockPreauth': 'true',
  // 'callback': 'vivapayclient://result',
  // },
  // ).toString(),
  // flags: [
  // Flag.FLAG_ACTIVITY_NEW_TASK,
  // Flag.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS,
  // ],
  // );
  // intent.launch();
  // });
  // }
//
  // void _POSDeactivation() {
  // setState(() {
  // _isActivated = false;
  // });
  //  This function should handle the deactivation of the POS
  // print("Deactivating POS");
  //  Further implementation goes here
  // }
//
  @override
  Widget build(BuildContext context) {
    final isActivated = ref.watch(activationStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("POS Activation"),
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.all(1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pos Activation Button",
              textScaler: TextScaler.linear(1.3),
            ),
            Switch(
              activeTrackColor: Colors.green[400],
              inactiveTrackColor: Color.fromARGB(255, 81, 81, 81),
              value: isActivated,
              onChanged: (value) {
                if (value) {
                  ref
                      .read(activationStateProvider.notifier)
                      .activate(); // Activate POS if value is true
                } else {
                  ref
                      .read(activationStateProvider.notifier)
                      .deactivate(); // Deactivate POS if value is false
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
