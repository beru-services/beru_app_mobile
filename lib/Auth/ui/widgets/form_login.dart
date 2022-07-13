import 'package:beru_app/Auth/auth_repository.dart';
import 'package:beru_app/Widgets/button.dart';
import 'package:beru_app/Widgets/loading.dart';
import 'package:beru_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:toast/toast.dart';

import '../../../Widgets/custom_input.dart';
import '../../../utils/app_fonts.dart';
import '../screens/forgot_password.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FormLogin();
}

class _FormLogin extends State<FormLogin> {
  bool _makeRequest = false;
  AuthRepository repository = AuthRepository();

  FormGroup buildForm() =>
      fb.group(<String, Object>{
        'email': FormControl<String>(
          validators: [Validators.required, Validators.email],
        ),
        'password': ['', Validators.required, Validators.minLength(8)],
        'user_type': ['D'],
      });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              form(),
            ],
          ),
        ));
  }

  Widget form() {
    return ReactiveFormBuilder(
      form: buildForm,
      builder: (context, form, child) {
        return Column(
          children: [
            ReactiveTextField<String>(
              formControlName: 'email',
              validationMessages: (control) =>
              {
                ValidationMessage.required: 'The email must not be empty',
                ValidationMessage.email:
                'The email value must be a valid email',
                'unique': 'This email is already in use',
                'unique': 'This email is already in use',
              },
              textInputAction: TextInputAction.next,
              decoration: customInput('Email'),
            ),
            const SizedBox(height: 40.0),
            ReactiveTextField<String>(
              formControlName: 'password',
              obscureText: true,
              validationMessages: (control) =>
              {
                ValidationMessage.required:
                'The password must not be empty',
                ValidationMessage.minLength:
                'The password must be at least 8 characters',
              },
              textInputAction: TextInputAction.done,
              decoration: customInput('Password'),
            ),
            const SizedBox(height: 10.0),
            _forgotPassword(),
            (_makeRequest) ? Loading() : _buttonLogin(form)
          ],
        );
      },
    );
  }

  Widget _forgotPassword() {
    return Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.only(bottom: 20),
        child: GestureDetector(
          onTap: () =>
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ForgotPassword()),
              ),
          child: const Text("Forgot Password?",
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: 18,
                  color: AppColors.black, fontFamily: AppFonts.fontMedium)),
        ));
  }

  Widget _buttonLogin(form) {
    return Button(
      padding: const EdgeInsets.symmetric(vertical: 20),
      label: "LOGIN",
      onTab: () async {
        if (!form.valid) {
          form.markAllAsTouched();
          return;
        }
        updateState(true);

        try {
          if (await repository.makeLogin(form.value)) {
            Navigator.pushNamed(context, "/list");
            showToast("Welcome", duration: 5);
          }

        } catch (e) {
          showToast(e.toString(), duration: 5);
        }

        updateState(false);
      },
    );
  }

  void updateState(bool state) {
    setState(() {
      _makeRequest = state;
    });
  }

  void showToast(String msg, {int? duration}) {
    Toast.show(msg, duration: duration, gravity: Toast.bottom);
  }
}
