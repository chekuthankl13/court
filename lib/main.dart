import 'package:courtclick/core/di/service_locator.dart';
import 'package:courtclick/core/routes/app_routes.dart';
import 'package:courtclick/core/theme/app_theme.dart';
import 'package:courtclick/core/utils/utils.dart';
import 'package:courtclick/features/coming/cubit/coming_cubit.dart';
import 'package:courtclick/features/dashboard/cubit/dashboard_cubit.dart';
import 'package:courtclick/features/search/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  initDi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<DashboardCubit>()),
        BlocProvider(create: (context) => sl<ComingCubit>()),
        BlocProvider(create: (context) => sl<SearchCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: AppRoutes.splash,
      ),
    );
  }
}
