import 'dart:async';

import 'package:flutter/material.dart';

class MyOtp extends StatefulWidget {
  const MyOtp({Key? key}) : super(key: key);

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {
  List<TextEditingController> controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  late Timer _timer;
  int _totalSeconds = 180;

  // New: FocusNode list to track focus state of each TextField
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSecond,
      (timer) {
        if (_totalSeconds == 0) {
          _timer.cancel();
        } else {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              if (mounted) {
                setState(() {
                  _totalSeconds--;
                });
              }
            },
          );
        }
      },
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text(
          'Sign up',
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: 40,
              bottom: 20,
            ),
            child: Text(
              'OTP Verification',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter the code from the sms we sent',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'to 8801774280874',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                _formatTime(
                  _totalSeconds,
                ),
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          // Modified: Set border color based on focus state
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              6,
              (index) => SizedBox(
                width: 50.0,
                child: TextField(
                  controller: controllers[index],
                  focusNode: focusNodes[index], 
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    counterText: '',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepOrangeAccent),
                    ),
                    enabledBorder: OutlineInputBorder(
                        // borderSide: BorderSide(color: Colors.grey),
                        ),
                  ),
                  onChanged: (value) {
                    if (value.length == 1) {
                      if (index < 5) {
                        FocusScope.of(context).nextFocus();
                      } else {
                        FocusScope.of(context).unfocus();
                      }
                    }
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't receive OTP? ",
              ),
              Text(
                'RECEND',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                textStyle: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text(
                'Submit',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
