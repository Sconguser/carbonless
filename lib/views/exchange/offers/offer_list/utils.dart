import '../../../../models/exchange_offer_model.dart';

List<ExchangeOffer> sortOffers(List<ExchangeOffer>? offers) {
  if (offers == null || offers.isEmpty) return [];
  offers.sort((a, b) {
    if (a.created_at.compareTo(b.created_at) < 0) {
      return 1;
    } else {
      return -1;
    }
  });
  return offers;
}
