import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primo_pay/components/activation_notifier.dart';
//import 'package:primo_pay/components/pos_activation.dart';
import 'package:primo_pay/components/text_form_controller.dart';
import 'package:primo_pay/helpers/config.dart';
import 'package:primo_pay/main.dart';

class NumericKeypadScreen extends ConsumerStatefulWidget {
  @override
  _NumericKeypadScreenState createState() => _NumericKeypadScreenState();
}

class _NumericKeypadScreenState extends ConsumerState<NumericKeypadScreen> {
  String _formatValue(String value) {
    value = value.replaceAll(RegExp(r'[^0-9]'), '');
    value = value.replaceAll(RegExp(r'^0+'), '');

    if (value.isEmpty) {
      value = '0';
    }
    if (value.length > 2) {
      return '${value.substring(0, value.length - 2)}.${value.substring(value.length - 2)}';
    } else if (value.length == 2) {
      return '0.$value';
    } else if (value.isNotEmpty) {
      return '0.0$value';
    } else {
      return '';
    }
  }

  void _onKeyPressed(String key, ref) {
    var value = ref.read(myTextProvider) + key;
    final textFormController = ref.watch(textEditingControllerProvider);
    textFormController.controller.text = _formatValue(value);
    ref.read(myTextProvider.notifier).update(_formatValue(value));
  }

  void _onDeletePressed(ref) {
    var value = ref.read(myTextProvider);
    if (value.isNotEmpty) {
      final textFormController = ref.watch(textEditingControllerProvider);
      var newValue = value.substring(0, value.length - 1);
      textFormController.controller.text = _formatValue(newValue);
      ref.read(myTextProvider.notifier).update(_formatValue(newValue));
    }
  }

  Timer? _timer;

  void _handleLongPressStart(LongPressStartDetails details) {
    _timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      _onDeletePressed(ref); // Calling the repeat function
    });
  }

  void _handleLongPressEnd(LongPressEndDetails details) {
    _timer?.cancel(); // Stop the timer when the button is released
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildNumericButton(String value) {
      return Expanded(
        child: GestureDetector(
          onTap: () {
            _onKeyPressed(value, ref);
          },
          child: Container(
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ButtonColor,
              border: Border.all(color: Color.fromARGB(255, 255, 255, 255)),
            ),
            child: Text(
              value,
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 48, 48, 48)),
            ),
          ),
        ),
      );
    }

    Widget _buildDeleteButton() {
      return Expanded(
        child: GestureDetector(
          onLongPressStart: _handleLongPressStart,
          onLongPressEnd: _handleLongPressEnd,
          onTap: () {
            _onDeletePressed(ref);
          },
          child: Container(
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ButtonColor,
              border:
                  Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
            ),
            child: Icon(
              Icons.backspace,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    Widget _buildPosIndicator() {
      final isActivated = ref.watch(activationStateProvider);
      return Expanded(
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActivated == false
                ? PosActivationColor
                : PosDeactivationColor,
            border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
          ),
          child:
              Text((isActivated == false) ? "POS \nInactive" : "POS \nActive"),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildNumericButton('1'),
              _buildNumericButton('2'),
              _buildNumericButton('3'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildNumericButton('4'),
              _buildNumericButton('5'),
              _buildNumericButton('6'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildNumericButton('7'),
              _buildNumericButton('8'),
              _buildNumericButton('9'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildPosIndicator(),
              _buildNumericButton('0'),
              _buildDeleteButton(),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
