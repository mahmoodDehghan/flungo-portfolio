import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../widgets/forms/change_password_form.dart';
import '../../models/const_items.dart';
import '../../providers/shared_prefrences_provider.dart';

class AdminChangePassword extends HookConsumerWidget {
  AdminChangePassword({Key? key, required this.isPassChanged})
      : super(key: key);

  final ValueNotifier isPassChanged;
  final TextEditingController _passController = useTextEditingController();
  final message = useState('Enter a password for Admin user');

  void _updateAdminPass(WidgetRef ref) async {
    final baseUrl =
        Platform.isAndroid ? ConstItems.androidBaseUrl : ConstItems.baseUrl;
    final response = await http.put(
      Uri.parse(baseUrl + '/adminapi/updatePass/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:
          jsonEncode(<String, String>{'password': _passController.value.text}),
    );
    if (response.statusCode == 200) {
      final sharePref = await ref.read(sharedPrefrencesProvider.future);
      await sharePref.setBool(ConstItems.adminSetupKey, true);
      isPassChanged.value = true;
    } else {
      message.value = 'Oops! Somethings Wrong happend! please try again later!';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints.tight(
              const Size(double.infinity, 50),
            ),
            child: Center(
              child: Text(
                message.value,
                style: const TextStyle(
                  color: Colors.indigo,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ChangePasswordForm(
            updateAdminPass: () => _updateAdminPass(ref),
            passController: _passController,
          ),
        ],
      ),
    );
  }
}
