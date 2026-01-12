import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_lighthouse/core/theme/app_colors.dart';

import 'routing/app_router.dart';

class ProjectLighthouseApp extends ConsumerWidget {
  const ProjectLighthouseApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Project Lighthouse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: AppColors.primary,
      ),
      routerConfig: router,
    );
  }
}
