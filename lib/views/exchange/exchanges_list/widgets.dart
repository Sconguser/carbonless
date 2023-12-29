import 'package:carbonless_free/shared/constants.dart';
import 'package:flutter/material.dart';

class ExchangeTile extends StatelessWidget {
  final String date;
  final String username;
  final String title;
  final String description;
  final String location;
  const ExchangeTile({
    super.key,
    required this.date,
    required this.username,
    required this.title,
    required this.description,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.2,
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(date),
                  Text(username),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(description),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Icon(Icons.arrow_forward_ios, size: 20)),
        ],
      ),
    );
  }
}
