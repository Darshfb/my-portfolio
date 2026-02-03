
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialIconHelper {
  static final Map<String, IconData> icons = {
    'linkedin': FontAwesomeIcons.linkedin,
    'github': FontAwesomeIcons.github,
    'twitter': FontAwesomeIcons.twitter,
    'instagram': FontAwesomeIcons.instagram,
    'facebook': FontAwesomeIcons.facebook,
    'youtube': FontAwesomeIcons.youtube,
    'medium': FontAwesomeIcons.medium,
    'website': FontAwesomeIcons.globe,
    'email': FontAwesomeIcons.envelope,
    'upwork': FontAwesomeIcons.briefcase, // Upwork doesn't have a direct FA icon in core free
    'whatsapp': FontAwesomeIcons.whatsapp,
    'telegram': FontAwesomeIcons.telegram,
  };

  static IconData getIcon(String key) {
    return icons[key.toLowerCase()] ?? Icons.link;
  }
}
