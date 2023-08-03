import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();
  int _activeStepIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Step> listStep = [
      //step 1
      Step(
        state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 0,
        title: const Text("Account"),
        content: Column(
          children: [
            TextField(
              controller: _userNameController,
              decoration: const InputDecoration(
                labelText: "UserName",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            //
            const SizedBox(height: 5),
            //
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // step 2
      Step(
          state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: const Text("Address"),
          content: Column(
            children: [
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: "Address",
                ),
              ),
            ],
          )),
      //step 3
      Step(
        state: _activeStepIndex <= 3 ? StepState.editing : StepState.complete,
        isActive: _activeStepIndex >= 3,
        title: const Text("Confirm"),
        content: Column(
          children: [
            //
            Text("UserName: ${_userNameController.text}"),
            Text("PassWord: ${_passwordController.text}"),
            Text("Address: ${_addressController.text}"),
          ],
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Muti Step Widget"),
      ),
      //
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _activeStepIndex,
        steps: listStep,
        //
        controlsBuilder:
            (BuildContext buildContext, ControlsDetails controlsBuilder) {
          return Row(
            children: [
              //
              if (_activeStepIndex <= 1)
                ElevatedButton(
                    onPressed: controlsBuilder.onStepContinue,
                    child: const Text("Next")),
              //

              if (_activeStepIndex == listStep.length - 1)
                ElevatedButton(
                    onPressed: () {
                      print("Summite");
                    },
                    child: const Text("Summite")),
              //
              const SizedBox(width: 5),
              if (_activeStepIndex > 0)
                ElevatedButton(
                    onPressed: controlsBuilder.onStepCancel,
                    child: const Text("Back")),
            ],
          );
        },
        //
        onStepContinue: () {
          setState(() {
            if (_activeStepIndex < listStep.length - 1) {
              _activeStepIndex += 1;
            }
          });
        },
        //
        onStepCancel: () {
          setState(() {
            if (_activeStepIndex == 0) {
              return;
            }
            _activeStepIndex -= 1;
          });
        },
      ),
    );
  }
}
