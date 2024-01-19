import 'package:carbonless_free/providers/controllers/exchange/offers/create_offer_controller_provider.dart';
import 'package:carbonless_free/providers/states/exchange/make_offer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../localization/messages.i18n.dart';
import '../../../../main.dart';
import '../../../../shared/bottom_nav_bar.dart';
import '../../../../shared/constants.dart';
import '../../../../shared/widgets.dart';

class CreateOfferView extends ConsumerWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  CreateOfferView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String title = ref.watch(titleStateProvider);
    String description = ref.watch(descriptionStateProvider);
    String location = ref.watch(locationStateProvider);
    String exchangeValue = ref.watch(exchangeValueStateProvider);
    MakeOfferState makeOfferState = ref.watch(createOfferControllerProvider);
    Messages _locale = ref.watch(messagesProvider);
    return BottomNavigationBarView(
      scaffoldChild: SingleChildScrollView(
        child: Container(
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
                      _locale.market.title,
                      'tytul',
                      FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                              errorText:
                                  _locale.validators.errors.cannot_be_empty),
                          FormBuilderValidators.max(
                            maxCharactersInForm,
                            errorText: _locale.validators.errors
                                .max_characters(maxCharactersInForm),
                          ),
                        ],
                      ),
                    ),
                    buildSizedBoxBetweenTextInputs(),
                    buildTextFormField(
                      location,
                      ref,
                      locationStateProvider,
                      false,
                      _locale.market.location,
                      'location',
                      FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                              errorText:
                                  _locale.validators.errors.cannot_be_empty),
                          FormBuilderValidators.max(
                            maxCharactersInForm,
                            errorText: _locale.validators.errors
                                .max_characters(maxCharactersInForm),
                          ),
                        ],
                      ),
                    ),
                    buildSizedBoxBetweenTextInputs(),
                    buildTextFormField(
                      exchangeValue,
                      ref,
                      exchangeValueStateProvider,
                      false,
                      _locale.market.exchange_value,
                      'wartosc',
                      FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                              errorText:
                                  _locale.validators.errors.cannot_be_empty),
                          FormBuilderValidators.max(
                            maxCharactersInForm,
                            errorText: _locale.validators.errors
                                .max_characters(maxCharactersInForm),
                          ),
                        ],
                      ),
                    ),
                    buildSizedBoxBetweenTextInputs(),
                    buildTextFormField(
                      description,
                      ref,
                      descriptionStateProvider,
                      false,
                      _locale.market.description,
                      'opis',
                      FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                              errorText:
                                  _locale.validators.errors.cannot_be_empty),
                          FormBuilderValidators.max(
                            maxCharactersInMultilineForm,
                            errorText: _locale.validators.errors
                                .max_characters(maxCharactersInMultilineForm),
                          ),
                        ],
                      ),
                      maxlines: 10,
                    ),
                    buildSizedBoxBetweenTextInputs(),
                    makeOfferState == const MakeOfferLoading()
                        ? spinner
                        : ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ref
                                    .read(
                                        createOfferControllerProvider.notifier)
                                    .createOffer(title, description, location,
                                        exchangeValue);
                              }
                            },
                            child: Text(_locale.market.submit),
                          ),
                  ],
                ))),
      ),
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
