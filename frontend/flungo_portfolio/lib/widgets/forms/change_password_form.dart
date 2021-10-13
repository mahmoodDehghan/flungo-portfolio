import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChangePasswordForm extends HookConsumerWidget {
  ChangePasswordForm({
    Key? key,
    required this.updateAdminPass,
    required this.passController,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController passController;
  final TextEditingController _confirmController = useTextEditingController();
  final Function() updateAdminPass;

  String? _passwordValidator(String? entry) {
    String? _err = _filledValidator(entry);
    return _err;
  }

  String? _filledValidator(String? entry) {
    if (entry == null || entry.isEmpty) {
      return 'Please enter the password';
    }
    return null;
  }

  String? _confirmValidator(String? entry) {
    String? _err = _filledValidator(entry);
    if (_err == null) {
      if (passController.value.text != _confirmController.value.text) {
        _err = 'Must be the same with password!';
      }
    }
    return _err;
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      updateAdminPass();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints.tight(
                const Size(300, 50),
              ),
              child: TextFormField(
                validator: _passwordValidator,
                controller: passController,
                decoration: const InputDecoration(
                  labelText: 'Enter the Admin password',
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tight(
                const Size(300, 50),
              ),
              child: TextFormField(
                validator: _confirmValidator,
                controller: _confirmController,
                decoration: const InputDecoration(
                  labelText: 'Confirm the Admin password',
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: _onSubmit,
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
