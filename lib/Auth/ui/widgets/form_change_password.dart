import 'package:beru_app/Auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:toast/toast.dart';

import '../../../Widgets/button.dart';
import '../../../Widgets/custom_input.dart';
import '../../../Widgets/loading.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';

class FormChangePassword extends StatefulWidget {
  final String email;

  const FormChangePassword({Key? key, required this.email}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FormChangePassword();
}

class _FormChangePassword extends State<FormChangePassword> {
  bool _makeRequest = false;
  AuthRepository authRepository = AuthRepository();

  FormGroup buildForm() => fb.group(<String, Object>{
        'current_password': ['', Validators.required, Validators.minLength(8)],
        'password': ['', Validators.required, Validators.minLength(8)],
        'confirm_password': ['', Validators.required, Validators.minLength(8)],
        'user_type': ['D'],
        'email': [widget.email]
      });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [form(), _back()],
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
              formControlName: 'current_password',
              obscureText: true,
              validationMessages: (control) => {
                ValidationMessage.required: 'The password must not be empty',
                ValidationMessage.minLength:
                    'The password must be at least 8 characters',
              },
              textInputAction: TextInputAction.next,
              decoration: customInput('Current password'),
            ),
            ReactiveTextField<String>(
              formControlName: 'password',
              obscureText: true,
              validationMessages: (control) => {
                ValidationMessage.required: 'The email must not be empty',
                ValidationMessage.email:
                    'The email value must be a valid email',
              },
              textInputAction: TextInputAction.next,
              decoration: customInput('New password'),
            ),
            ReactiveTextField<String>(
              formControlName: 'confirm_password',
              obscureText: true,
              validationMessages: (control) => {
                ValidationMessage.required: 'The email must not be empty',
                ValidationMessage.email:
                    'The email value must be a valid email',
              },
              textInputAction: TextInputAction.next,
              decoration: customInput('Confirm password'),
            ),
            (_makeRequest) ? Loading() : _buttonSendChangePassword(form)
          ],
        );
      },
    );
  }

  Widget _buttonSendChangePassword(FormGroup form) {
    return Button(
      padding: const EdgeInsets.symmetric(vertical: 20),
      label: "SEND",
      onTab: () async {
        if (!form.valid) {
          form.markAllAsTouched();
          return;
        }

        if (form.control("password").value !=
            form.control("confirm_password").value) {
          showToast("Wrong password in the confirmation field", duration: 5);
          return;
        }

        try {
          updateState(true);

          if(await authRepository.changePassword(form.value)) {
            showToast("Password updated successfully", duration: 5);
            Navigator.pushNamed(context, "/");
          }

        } catch (e) {
          showToast(e.toString(), duration: 5);
        }

        updateState(false);
      },
    );
  }

  void showToast(String msg, {int? duration}) {
    Toast.show(msg, duration: duration, gravity: Toast.bottom);
  }

  void updateState(bool state) {
    setState(() {
      _makeRequest = state;
    });
  }

  Widget _back() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/'),
      child: const Text(
        "Back to login",
        style:
            TextStyle(fontFamily: AppFonts.fontLight, color: AppColors.black),
      ),
    );
  }
}
