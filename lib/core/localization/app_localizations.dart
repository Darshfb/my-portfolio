import 'dart:ui';

class AppLocalizations {
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('ar', 'EG'),
  ];

  static Map<String, Map<String, String>> translations = {
    'en': {
      'app_title': 'Premium Portfolio',
      'home': 'Home',
      'projects': 'Projects',
      'about': 'About',
      'contact': 'Contact',
      'admin_login': 'Admin Login',
      'welcome': 'Welcome to my Premium Portfolio',
    },
    'ar': {
      'app_title': 'الملف الشخصي الفاخر',
      'home': 'الرئيسية',
      'projects': 'المشاريع',
      'about': 'عني',
      'contact': 'تواصل معي',
      'admin_login': 'دخول المشرف',
      'welcome': 'مرحباً بكم في ملفي الشخصي المتميز',
    },
  };
}
