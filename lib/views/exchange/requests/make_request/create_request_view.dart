import 'package:carbonless_free/models/exchange_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../localization/messages.i18n.dart';
import '../../../../main.dart';
import '../../../../models/exchange_offer_model.dart';
import '../../../../providers/controllers/exchange/requests/make_request_controller_provider.dart';
import '../../../../providers/states/exchange/make_request_state.dart';
import '../../../../shared/bottom_nav_bar.dart';
import '../../../../shared/constants.dart';
import '../../../../shared/widgets.dart';

class MakeOfferView extends ConsumerWidget {
  final ExchangeOffer offer;
  final _formKey = GlobalKey<FormBuilderState>();
  MakeOfferView({Key? key, required this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    String requestBody = ref.watch(requestBodyStateProvider);
    MakeRequestState makeRequestState =
        ref.watch(makeRequestControllerProvider);
    return BottomNavigationBarView(
      scaffoldChild: Container(
        padding: standardOuterPadding,
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              buildTextFormField(
                requestBody,
                ref,
                requestBodyStateProvider,
                false,
                _locale.market.offer_message,
                'requestBody',
                FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(
                        errorText: _locale.validators.errors.cannot_be_empty),
                    FormBuilderValidators.max(
                      maxCharactersInMultilineForm,
                      errorText: _locale.validators.errors
                          .max_characters(maxCharactersInMultilineForm),
                    ),
                  ],
                ),
                maxlines: 10,
              ),
              makeRequestState == const MakeRequestLoading()
                  ? spinner
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ref
                              .read(makeRequestControllerProvider.notifier)
                              .sendRequest(requestBody);
                        }
                      },
                      child: Text(_locale.market.submit),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  final requestBodyStateProvider = StateProvider<String>((ref) {
    return '';
  });
}
