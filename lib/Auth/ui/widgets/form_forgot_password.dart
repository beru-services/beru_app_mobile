import 'package:beru_app/Auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../Widgets/button.dart';
import '../../../Widgets/custom_input.dart';
import '../../../Widgets/loading.dart';
import '../screens/change_password_screen.dart';

class FormForgotPassword extends StatefulWidget {
  const FormForgotPassword({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FormForgotPassword();
}

class _FormForgotPassword extends State<FormForgotPassword> {
  AuthRepository authRepository = AuthRepository();
  bool _makeRequest = false;

  FormGroup buildForm() => fb.group(<String, Object>{
        'email': FormControl<String>(
          validators: [Validators.required, Validators.email],
        ),
        'user_type': FormControl<String>(
          value: 'D'
        )
      });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
      form: buildForm,
      builder: (context, form, child) {
        return Column(
          children: [
            ReactiveTextField<String>(
              formControlName: 'email',
              validationMessages: (control) => {
                ValidationMessage.required: 'The email must not be empty',
                ValidationMessage.email:
                    'The email value must be a valid email',
                'unique': 'This email is already in use',
              },
              textInputAction: TextInputAction.next,
              decoration: customInput('Email'),
            ),
            (_makeRequest) ? Loading() : _buttonForgotPassword(form),
          ],
        );
      },
    );
  }

  Widget _buttonForgotPassword(form) {
    return Button(
      padding: const EdgeInsets.symmetric(vertical: 20),
      label: "SEND",
      onTab: () async {
        if (form.valid) {
          updateState(true);
          if (await authRepository.recoveryPassword(form.value)) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangePasswordScreen(
                        email: form.control('email').value)));
          }

          updateState(false);
        } else {
          form.markAllAsTouched();
        }
      },
    );
  }

  void updateState(bool state) {
    setState(() {
      _makeRequest = state;
    });
  }
}
