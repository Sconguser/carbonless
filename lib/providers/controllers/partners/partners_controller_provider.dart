import 'dart:convert';

import '/models/location_model.dart';
import '/models/partner_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../../auth/auth_repository.dart';
import '../../../services/http_utils/http_service.dart';
import '../../../services/http_utils/request_provider.dart';
import '../geolocation/geolocation_controller_provider.dart';
import '../loaders/view_loading_controller_provider.dart';

class PartnersNotifier extends StateNotifier<List<Partner>> {
  PartnersNotifier(List<Partner> state, this.ref) : super(state);
  final Ref ref;

  bool _initialized = false;

  void initialize() async {
    if (!_initialized) {
      ref.read(viewLoadingControllerProvider.notifier).viewLoadingOn();
      await _getPartnersWithRange();
      _initialized = true;
      ref.read(viewLoadingControllerProvider.notifier).viewLoadingOff();
    }
  }

  void setListOfPartners(List<dynamic> partners) {
    List<Partner> partnerList = [];
    for (dynamic partner in partners) {
      partnerList.add(Partner.fromJson(partner));
    }
    state = partnerList;
  }

  Future<void> _getPartnersWithRange() async {
    await ref.read(geolocationProvider.notifier).getCurrentPosition();
    Location currentLocation = ref.read(geolocationProvider);
    String? bearerToken = ref.read(authRepositoryProvider).bearerToken;
    double lat = double.parse(currentLocation.latitude);
    double long = double.parse(currentLocation.longitude);
    double range = 20;
    if (bearerToken == null) {
      return Future.error('Bearer token is null');
    }
    Map<String, dynamic> queryParameters = {
      'latitude': lat.toString(),
      'longitude': long.toString(),
      'range': range.toString()
    };
    http.Response response = await ref.read(httpServiceProvider).executeHttp(
          RequestType.GET,
          null,
          queryParameters,
          Endpoint.PARTNERS,
          ref.read(authRepositoryProvider).getToken(),
        );

    List<dynamic> decodedList = jsonDecode(response.body);
    ref.read(partnersNotifier.notifier).setListOfPartners(decodedList);
  }
}

final partnersNotifier =
    StateNotifierProvider<PartnersNotifier, List<Partner>>((ref) {
  List<Partner>? partners = [];
  return PartnersNotifier(partners, ref);
});
