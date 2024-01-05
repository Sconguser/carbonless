import 'package:carbonless_free/main.dart';
import 'package:carbonless_free/shared/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../localization/messages.i18n.dart';
import '../../../models/exchange_offer_model.dart';
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
    return BottomNavigationBarView(
      scaffoldChild: Column(
        children: [
          Text('Złóż ofertę'),
          FormBuilder(
            key: _formKey,
            child: buildTextFormField(
              offer,
              ref,
              offerStateProvider,
              false,
              'Zloz oferte',
              'offer',
              FormBuilderValidators.compose(
                [
                  FormBuilderValidators.required(
                      errorText: _locale.validators.errors.cannot_be_empty),
                  FormBuilderValidators.max(
                    maxCharactersInMultilineForm,
                    errorText:
                        _locale.validators.errors.password_max_20_characters,
                  ),
                ],
              ),
              maxlines: 10,
            ),
          ),
        ],
      ),
    );
  }

  final offerStateProvider = StateProvider<String>((ref) {
    return '';
  });
}
