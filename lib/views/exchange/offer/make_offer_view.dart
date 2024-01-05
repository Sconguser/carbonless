import 'package:carbonless_free/main.dart';
import 'package:carbonless_free/providers/controllers/exchange/make_offer_controller_provider.dart';
import 'package:carbonless_free/shared/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../localization/messages.i18n.dart';
import '../../../models/exchange_offer_model.dart';
import '../../../providers/states/exchange/make_offer_state.dart';
import '../../../shared/bottom_nav_bar.dart';
import '../../../shared/constants.dart';

class MakeOfferView extends ConsumerWidget {
  final ExchangeOffer offer;
  final _formKey = GlobalKey<FormBuilderState>();
  MakeOfferView({Key? key, required this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    String offer = ref.watch(offerStateProvider);
    MakeOfferState makeOfferState = ref.watch(makeOfferControllerProvider);
    return BottomNavigationBarView(
      scaffoldChild: Container(
        padding: standardOuterPadding,
        child: Column(
          children: [
            FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  buildTextFormField(
                    offer,
                    ref,
                    offerStateProvider,
                    false,
                    _locale.market.offer_message,
                    'offer',
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
                    maxlines: 10,
                  ),
                  makeOfferState == const MakeOfferLoading()
                      ? spinner
                      : ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ref
                                  .read(makeOfferControllerProvider.notifier)
                                  .sendOffer(offer);
                            }
                          },
                          child: Text(_locale.market.submit),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final offerStateProvider = StateProvider<String>((ref) {
    return '';
  });
}
