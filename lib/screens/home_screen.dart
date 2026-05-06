import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../database/database_helper.dart';
import '../models/task.dart';
import 'add_important_task_screen.dart';
import 'add_regular_task_screen.dart';
import 'task_list_screen.dart';
import 'settings_screen.dart';
import '../widgets/dashboard_card.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _completedCount = 0;
  int _incompleteCount = 0;
  Map<String, int> _tasksPerDay = {};

  @override
  void initState() {
    super.initState();
    _loadTaskStats();
  }

  Future<void> _loadTaskStats() async {
    final completed = await DatabaseHelper().getCompletedTasksCount();
    final incomplete = await DatabaseHelper().getIncompleteTasksCount();
    final perDay = await DatabaseHelper().getTasksCompletedByDate();

    setState(() {
      _completedCount = completed;
      _incompleteCount = incomplete;
      _tasksPerDay = perDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4ECCA7),
        elevation: 0,
        title: const Text(
          'Beranda',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              color: const Color(0xFF4ECCA7),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halo, ${widget.username}! 👋',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Senin, ${DateFormat('d MMM yyyy').format(DateTime.now())}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            // Task Stats
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: DashboardCard(
                      label: 'TUGAS SELESAI',
                      count: _completedCount,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DashboardCard(
                      label: 'BELUM SELESAI',
                      count: _incompleteCount,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            // Chart
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'TUGAS SELESAI / HARI (BONUS)',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: SizedBox(
                      height: 200,
                      child: _tasksPerDay.isEmpty
                          ? const Center(
                              child: Text(
                                'Belum ada data tugas yang selesai',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : BarChart(
                              BarChartData(
                                alignment: BarChartAlignment.spaceAround,
                                maxY: _tasksPerDay.values.isEmpty
                                    ? 1
                                    : _tasksPerDay.values
                                            .reduce((a, b) => a > b ? a : b)
                                            .toDouble() +
                                        1,
                                barTouchData: BarTouchData(enabled: true),
                                titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (double value, TitleMeta meta) {
                                        const dayLabels = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
                                        final index = value.toInt();
                                        if (index >= 0 && index < dayLabels.length) {
                                          return Text(
                                            dayLabels[index],
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10,
                                            ),
                                          );
                                        }
                                        return const Text('');
                                      },
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (double value, TitleMeta meta) {
                                        return Text(
                                          '${value.toInt()}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                barGroups: _tasksPerDay.isEmpty
                                    ? []
                                    : List.generate(
                                        7,
                                        (index) => BarChartGroupData(
                                          x: index,
                                          barRods: [
                                            BarChartRodData(
                                              toY: (_tasksPerDay.values.isNotEmpty
                                                      ? _tasksPerDay.values.toList()[index % _tasksPerDay.length]
                                                      : 0)
                                                  .toDouble(),
                                              color: const Color(0xFF4ECCA7),
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            // Action Buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildActionButton(
                    icon: Icons.add_circle,
                    label: 'Tambah Tugas\nPenting',
                    color: Colors.red,
                    onTap: () {
                      Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AddImportantTaskScreen(),
                            ),
                          )
                          .then((_) => _loadTaskStats());
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.add_circle,
                    label: 'Tambah Tugas\nBiasa',
                    color: Colors.green,
                    onTap: () {
                      Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AddRegularTaskScreen(),
                            ),
                          )
                          .then((_) => _loadTaskStats());
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.list,
                    label: 'Daftar\nTugas',
                    color: Colors.blue,
                    onTap: () {
                      Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (context) => const TaskListScreen(),
                            ),
                          )
                          .then((_) => _loadTaskStats());
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.settings,
                    label: 'Pengaturan',
                    color: Colors.grey,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              SettingsScreen(username: widget.username),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
