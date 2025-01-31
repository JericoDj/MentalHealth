import 'package:flutter/material.dart';

import '../../../widgets/homescreen_widgets/wellness_tracking/progress_map_widgets/achievements_section.dart';
import '../../../widgets/homescreen_widgets/wellness_tracking/progress_map_widgets/mood_trends_section.dart';
import '../../../widgets/homescreen_widgets/wellness_tracking/progress_map_widgets/progress_section.dart';
import '../../../widgets/homescreen_widgets/wellness_tracking/progress_map_widgets/stress_management_section.dart';

class ProgressMapScreen extends StatefulWidget {
  final int? scrollToIndex;
  final String? selectedDay;

  const ProgressMapScreen({
    Key? key,
    this.scrollToIndex,
    this.selectedDay,
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
      } else if (widget.selectedDay != null) {
        _scrollToMoodSection();
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

  void _scrollToMoodSection() {
    final moodContext = _sectionKeys[2].currentContext;
    if (moodContext != null) {
      Scrollable.ensureVisible(
        moodContext,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              MoodSection(sectionKeys: _sectionKeys, selectedDay: widget.selectedDay),
      
              const SizedBox(height: 10),
      
              // Stress Level Section (Index 3)
              StressLevelSection(sectionKeys: _sectionKeys),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
