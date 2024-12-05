import 'package:all_service/presentation/screens/auth/login_screen.dart';
import 'package:all_service/presentation/screens/auth/register_screen.dart';
import 'package:all_service/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
	initialLocation: '/',
	routes: [
	
		GoRoute(
			path: '/',
			builder: (context, state) => const HomeScreen()
		),
		
		GoRoute(
			path: '/login',
			builder: (context, state) => const LogInScreen()
		),

    GoRoute(
			path: '/register',
			builder: (context, state) => const SignUpScreen()
		),
		
	]
);