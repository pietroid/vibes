import 'package:go_router/go_router.dart';
import 'package:vibes/manager/view/manager_screen.dart';

class AppRouter {
  GoRouter get router => GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const ManagerScreen(),
          ),
        ],
      );
}
