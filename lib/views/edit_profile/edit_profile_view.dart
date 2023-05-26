import 'package:carbonless/auth/auth_repository.dart';
import 'package:carbonless/main.dart';
import 'package:carbonless/shared/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../localization/messages.i18n.dart';
import '../../shared/constants.dart';

final nameStateProvider = StateProvider<String>((ref) {
  return ref.read(authRepositoryProvider).user!.name;
});
final lastnameStateProvider = StateProvider<String>((ref) {
  return ref.read(authRepositoryProvider).user!.lastname;
});

class EditProfileView extends ConsumerWidget {
  EditProfileView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String name = ref.watch(nameStateProvider);
    String lastname = ref.watch(lastnameStateProvider);
    Messages _locale = ref.watch(messagesProvider);
    return Container(
        padding: EdgeInsets.all(10),
        child: FormBuilder(
          key: _formKey,
          child: Container(
            // width: width / 4 * 3,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                _locale.drawer.edit_data,
                style: logoTextStyle,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    buildTextFormField(
                      name,
                      ref,
                      nameStateProvider,
                      false,
                      _locale.forms.name,
                      'name',
                      FormBuilderValidators.required(
                        errorText: _locale.validators.errors.cannot_be_empty,
                      ),
                    ),
                    buildSizedBoxBetweenTextInputs(),
                    buildTextFormField(
                      lastname,
                      ref,
                      lastnameStateProvider,
                      false,
                      _locale.forms.lastname,
                      'lastname',
                      FormBuilderValidators.required(
                        errorText: _locale.validators.errors.cannot_be_empty,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          child: Text(_locale.button.save_changes),
                          onPressed: () {},
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          child: Text(_locale.button.change_password),
                          onPressed: () {},
                        )
                      ],
                    )
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
