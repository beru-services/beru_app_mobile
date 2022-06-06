import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../Widgets/button.dart';
import '../../../Widgets/custom_input.dart';

class FormForgotPassword extends StatefulWidget {
  const FormForgotPassword({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FormForgotPassword();
}

class _FormForgotPassword extends State<FormForgotPassword> {
  FormGroup buildForm() => fb.group(<String, Object>{
        'email': FormControl<String>(
          validators: [Validators.required, Validators.email],
        ),
      });

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
            _buttonForgotPassword(form),
          ],
        );
      },
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
