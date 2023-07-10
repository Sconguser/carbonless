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
final passwordStateProvider = StateProvider<String>((ref) => '');
final passwordConfirmationStateProvider = StateProvider<String>((ref) => '');

class EditProfileView extends ConsumerWidget {
  EditProfileView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String name = ref.watch(nameStateProvider);
    String lastname = ref.watch(lastnameStateProvider);
    String password = ref.watch(passwordStateProvider);
    String passwordConfirmation = ref.watch(passwordConfirmationStateProvider);
    Messages _locale = ref.watch(messagesProvider);
    return Container(
        padding: standardOuterPadding,
        child: FormBuilder(
          key: _formKey,
          child: Container(
            // width: width / 4 * 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _locale.drawer.edit_data,
                  style: logoTextStyle,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: ExpansionPanelList(
                    elevation: 0,
                    expansionCallback: (int index, bool isOpen) {
                      if (index == 0) {
                        ref
                            .read(editDataExpansionStateProvider.notifier)
                            .state = !isOpen;
                      } else if (index == 1) {
                        ref
                            .read(changePasswordExpansionStateProvider.notifier)
                            .state = !isOpen;
                      }
                    },
                    children: [
                      ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Center(
                            child: Text(
                              _locale.editData.personal_data,
                              style: logoTextStyle,
                            ),
                          );
                        },
                        body: buildEditDataColumn(name, ref, _locale, lastname),
                        isExpanded: ref.watch(editDataExpansionStateProvider),
                        backgroundColor: tertiaryColor,
                        canTapOnHeader: true,
                      ),
                      ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Center(
                            child: Text(
                              _locale.editData.change_password,
                              style: logoTextStyle,
                            ),
                          );
                        },
                        body: buildChangePasswordColumn(
                            password, ref, _locale, passwordConfirmation),
                        isExpanded:
                            ref.watch(changePasswordExpansionStateProvider),
                        backgroundColor: tertiaryColor,
                        canTapOnHeader: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Column buildEditDataColumn(
      String name, WidgetRef ref, Messages _locale, String lastname) {
    return Column(
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
          ],
        )
      ],
    );
  }
}

Column buildChangePasswordColumn(String password, WidgetRef ref,
    Messages _locale, String passwordConfirmation) {
  return Column(
    children: [
      buildTextFormField(
        password,
        ref,
        passwordStateProvider,
        true,
        _locale.forms.password,
        'password',
        FormBuilderValidators.required(
          errorText: _locale.validators.errors.cannot_be_empty,
        ),
      ),
      buildSizedBoxBetweenTextInputs(),
      buildTextFormField(
        passwordConfirmation,
        ref,
        passwordConfirmationStateProvider,
        true,
        _locale.forms.password_confirmation,
        'password_confirmation',
        FormBuilderValidators.compose(
          [
            FormBuilderValidators.required(
                errorText: _locale.validators.errors.cannot_be_empty),
            FormBuilderValidators.max(
              maxCharactersInForm,
              errorText: _locale.validators.errors.password_max_20_characters,
            ),
            FormBuilderValidators.min(
              minPasswordCharacters,
              errorText: _locale.validators.errors.password_min_6_characters,
            )
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            child: Text(_locale.button.save_changes),
            onPressed: () {},
          ),
        ],
      )
    ],
  );
}

final editDataExpansionStateProvider = StateProvider((ref) => false);
final changePasswordExpansionStateProvider = StateProvider((ref) => false);
