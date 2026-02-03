import 'package:flutter/material.dart';
import 'dart:js' as js;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myprofile/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:seo/seo.dart';
import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/services/app_config_cubit.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/projects/presentation/cubit/projects_cubit.dart';
import 'features/social_links/presentation/cubit/social_links_cubit.dart';
import 'features/resume/presentation/cubit/resume_cubit.dart';
import 'features/blog/presentation/bloc/blog_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  
  final prefs = await SharedPreferences.getInstance();
  
  try {
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }

  configureDependencies();
  
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AppConfigCubit(prefs)),
          BlocProvider(create: (_) => getIt<AuthCubit>()),
          BlocProvider(create: (_) => getIt<ProjectsCubit>()),
          BlocProvider(create: (_) => getIt<SocialLinksCubit>()..fetchSocialLinks()),
          BlocProvider(create: (_) => getIt<ResumeCubit>()..fetchResumeMetadata()),
          BlocProvider(create: (_) => getIt<BlogBloc>()),
        ],
        child: const MyApp(),
      ),
    ),
  );

  // Remove the browser loading indicator
  js.context.callMethod('removeLoader');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppConfigCubit, AppConfigState>(
      builder: (context, state) {
        return SeoController(
          tree: WidgetTree(context: context),
          child: MaterialApp.router(
            title: 'common.app_name'.tr(),
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: [
              ...context.localizationDelegates,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
