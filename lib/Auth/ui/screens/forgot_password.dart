import 'package:beru_app/Widgets/custom_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../Widgets/button.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';
import '../widgets/background_auth.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  FormGroup buildForm() =>
      fb.group(<String, Object>{
        'email': FormControl<String>(
          validators: [Validators.required, Validators.email],
        ),
      });

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.black, toolbarHeight: 0),
      body: Column(
        children: [
          _headForgotPassword(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                _message(),
                ReactiveFormBuilder(
                  form: buildForm,
                  builder: (context, form, child) {
                    return Column(
                      children: [
                        ReactiveTextField<String>(
                          formControlName: 'email',
                          validationMessages: (control) => {
                            ValidationMessage.required:
                            'The email must not be empty',
                            ValidationMessage.email:
                            'The email value must be a valid email',
                            'unique': 'This email is already in use',
                          },
                          textInputAction: TextInputAction.next,
                          decoration: customInput('Email'),
                        ),
                        _buttonForgotPassword(form),
                        _back()
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _headForgotPassword() {
    return Container(
      color: AppColors.black,
      child: const BackgroundAuth(
        title: "LOGIN",
      ),
    );
  }

  Widget _back() {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(false),
      child: const Text(
        'Ingresar ao Aplicatico',
        style: TextStyle(fontFamily: AppFonts.fontLight, color: AppColors.black),
      ),
    );
  }

  Widget _message() {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      alignment: Alignment.center,
      child: const Text(
        "RECOVER PASSWORD",
        textAlign: TextAlign.start,
        style: TextStyle(fontFamily: AppFonts.fontMedium, fontSize: 20),
        maxLines: 3,
      ),
    );
  }

  Widget _buttonForgotPassword(form) {
    return Button(
      padding: const EdgeInsets.symmetric(vertical: 20),
      label: "SEND",
      onTab: () => {
        if (form.valid) {print(form.value)} else {form.markAllAsTouched()}
      },
    );
  }
}