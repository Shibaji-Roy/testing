import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivationNotifier extends StateNotifier<bool> {
  ActivationNotifier() : super(false);

  Future<void> activate() async {
    state = true; // Sets the state and triggers the listener
    // Add your activation logic here
    final intent = AndroidIntent(
      action: "action_view",
      data: Uri(
        scheme: 'vivapayclient',
        host: 'pay',
        path: 'v1',
        queryParameters: {
          'appId': 'com.example.primo_pay',
          'action': 'activatePos',
          'apikey': 'qwerty123456',
          'apiSecret': 'qwerty123456',
          'sourceID': 'qwerty123456',
          'pinCode': '123142',
          'skipExternalDeviceSetup': 'true',
          'activateMoto': 'true',
          'activateQRCodes': 'true',
          'disableManualAmountEntry': 'true',
          'forceCardPresentmentForRefund': 'true',
          'lockRefund': 'true',
          'lockTransactionsList': 'true',
          'lockMoto': 'true',
          'lockPreauth': 'true',
          'callback': 'vivapayclient://result',
        },
      ).toString(),
      flags: [
        Flag.FLAG_ACTIVITY_NEW_TASK,
        Flag.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS,
      ],
    );
    await intent
        .launch(); // Make sure to await the launch to handle it properly

    print("Activating POS");
  }

  Future<void> deactivate() async {
    state = false; // Sets the state and triggers the listener
    // Add your deactivation logic here
    print("Deactivating POS");
  }
}

final activationStateProvider =
    StateNotifierProvider<ActivationNotifier, bool>((ref) {
  return ActivationNotifier();
});
