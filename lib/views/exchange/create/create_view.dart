import 'package:carbonless_free/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../localization/messages.i18n.dart';
import '../../../main.dart';
import '../../../shared/bottom_nav_bar.dart';
import '../../../shared/widgets.dart';

class CreateOfferView extends ConsumerWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  CreateOfferView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String title = ref.watch(titleStateProvider);
    String description = ref.watch(descriptionStateProvider);
    String location = ref.watch(locationStateProvider);
    String exchangeValue = ref.watch(exchangeValueStateProvider);
    Messages _locale = ref.watch(messagesProvider);
    return BottomNavigationBarView(
      scaffoldChild: Container(
          padding: standardOuterPadding,
          child: FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  buildTextFormField(
                    title,
                    ref,
                    titleStateProvider,
                    false,
                    'tytul',
                    'tytul',
                    FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(
                            errorText:
                                _locale.validators.errors.cannot_be_empty),
                        FormBuilderValidators.max(
                          maxCharactersInMultilineForm,
                          errorText: _locale
                              .validators.errors.password_max_20_characters,
                        ),
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }

  final descriptionStateProvider = StateProvider<String>((ref) {
    return '';
  });
  final titleStateProvider = StateProvider<String>((ref) {
    return '';
  });
  final locationStateProvider = StateProvider<String>((ref) {
    return '';
  });
  final exchangeValueStateProvider = StateProvider<String>((ref) {
    return '';
  });
}
