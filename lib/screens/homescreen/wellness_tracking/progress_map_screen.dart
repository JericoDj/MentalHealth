import 'package:flutter/material.dart';

import '../../../widgets/homescreen_widgets/wellness_tracking/progress_map_widgets/achievements_section.dart';
import '../../../widgets/homescreen_widgets/wellness_tracking/progress_map_widgets/mood_trends_section.dart';
import '../../../widgets/homescreen_widgets/wellness_tracking/progress_map_widgets/progress_section.dart';
import '../../../widgets/homescreen_widgets/wellness_tracking/progress_map_widgets/stress_management_section.dart';

class ProgressMapScreen extends StatefulWidget {
  final int? scrollToIndex;

  const ProgressMapScreen({
    Key? key,
    this.scrollToIndex,
  }) : super(key: key);

  @override
  State<ProgressMapScreen> createState() => _ProgressMapScreenState();
}

class _ProgressMapScreenState extends State<ProgressMapScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(4, (index) => GlobalKey());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.scrollToIndex != null) {
        _scrollToIndex(widget.scrollToIndex!);
      }
    });
  }

  void _scrollToIndex(int index) {
    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Progress Map")),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            const SizedBox(height: 20),

            // User Progress Section (Index 0)
            UserProgressSection(sectionKeys: _sectionKeys),

            const SizedBox(height: 10),

            // Achievements Section (Index 1)
            AchievementsSection(sectionKeys: _sectionKeys),

            const SizedBox(height: 10),

            // Mood Trends Section (Index 2)
            MoodSection(sectionKeys: _sectionKeys),

            const SizedBox(height: 10),

            // Stress Level Section (Index 3)
            StressLevelSection(sectionKeys: _sectionKeys),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
