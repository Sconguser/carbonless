import 'package:carbonless/models/partner_model.dart';
import 'package:carbonless/providers/controllers/partners/partners_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartnersList extends ConsumerStatefulWidget {
  const PartnersList({Key? key}) : super(key: key);

  @override
  ConsumerState<PartnersList> createState() => _PartnersListState();
}

class _PartnersListState extends ConsumerState<PartnersList> {
  @override
  Widget build(BuildContext context) {
    List<Partner>? partners = ref.watch(partnersNotifier);
    return Expanded(
        child: ListView(children: [
      for (Partner partner in partners!) PartnerTile(partner: partner),
    ]));
  }
}

class PartnerTile extends ConsumerStatefulWidget {
  Partner partner;
  PartnerTile({Key? key, required this.partner}) : super(key: key);

  @override
  ConsumerState<PartnerTile> createState() => _PartnerTileState();
}

class _PartnerTileState extends ConsumerState<PartnerTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 200,
      child: Card(
        child: Column(
          children: [
            Text(widget.partner.name),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Go to'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
