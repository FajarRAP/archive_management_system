import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../dependency_injection.dart';
import '../../features/archive/domain/entities/archive_entity.dart';
import '../../features/archive/domain/entities/archive_loan_entity.dart';
import '../../features/archive/presentation/pages/add_archive_page.dart';
import '../../features/archive/presentation/pages/archive_page.dart';
import '../../features/archive/presentation/pages/borrow_archive_page.dart';
import '../../features/archive/presentation/pages/home_page.dart';
import '../../features/archive/presentation/pages/report_page.dart';
import '../../features/archive/presentation/pages/return_archive_detail.dart';
import '../../features/archive/presentation/pages/return_archive_page.dart';
import '../../features/archive/presentation/pages/update_delete_archive_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/profile_page.dart';
import '../common/constants.dart';
import '../common/scaffold_with_bottom_nav_bar.dart';

final isLoggedIn = getIt.get<SupabaseClient>().auth.currentSession != null;

final router = GoRouter(
  initialLocation: isLoggedIn ? homeRoute : loginRoute,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          ScaffoldWithBottomNavBar(navigationShell: navigationShell),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: homeRoute,
              builder: (context, state) => const HomePage(),
              routes: <RouteBase>[
                GoRoute(
                  path: 'archive',
                  builder: (context, state) => const ArchivePage(),
                  routes: <RouteBase>[
                    GoRoute(
                      path: ':id',
                      builder: (context, state) => UpdateDeleteArchivePage(
                        archive: state.extra as ArchiveEntity,
                      ),
                    ),
                  ],
                ),
                GoRoute(
                  path: 'add-archive',
                  builder: (context, state) => const AddArchivePage(),
                ),
                GoRoute(
                  path: 'return-archive',
                  builder: (context, state) => const ReturnArchivePage(),
                  routes: <RouteBase>[
                    GoRoute(
                      path: 'detail',
                      builder: (context, state) => ReturnArchiveDetail(
                        archiveLoan: state.extra as ArchiveLoanEntity,
                      ),
                    ),
                  ],
                ),
                GoRoute(
                  path: 'borrow-archive',
                  builder: (context, state) =>
                      BorrowArchivePage(archive: state.extra as ArchiveEntity),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: reportRoute,
              builder: (context, state) => const ReportPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: profileRoute,
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
  ],
);
