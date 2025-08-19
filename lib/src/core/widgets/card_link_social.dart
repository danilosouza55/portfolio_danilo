import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CardLinkSocialWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final double width;
  final String link;

  const CardLinkSocialWidget({
    Key? key,
    required this.title,
    required this.icon,
    this.link = '',
    this.width = 130,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        launchUrl(Uri.parse(link));
      },
      child: Card(
        elevation: 10,
        child: Container(
          width: width,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon),
              const SizedBox(width: 5),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
