import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/species_master_data.dart';
import '../../providers/tree_provider.dart';
import '../widgets/custom_appbar.dart';
import 'custom_painter/species1_painter.dart';
import 'custom_painter/species2_painter.dart';
import 'custom_painter/species3_painter.dart';

class ForestPage extends ConsumerWidget {
  final String uid;
  const ForestPage({super.key, required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forestAsync = ref.watch(forestProvider(uid));
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Beautiful forest background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF87CEEB), // Sky blue
                  Color(0xFFE0F6FF), // Light blue
                  Color(0xFFF0F8E8), // Very light green
                  Color(0xFFD4F4DD), // Light green
                  Color(0xFF90C695), // Medium green (grass)
                  Color(0xFF7FB069), // Darker green (ground)
                ],
                stops: [0.0, 0.3, 0.5, 0.7, 0.85, 1.0],
              ),
            ),
          ),
          
          // Sun in the sky
          Positioned(
            top: 80,
            right: 40,
            child: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xFFFDD835),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x40FDD835),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
          ),

          // Clouds
          Positioned(
            top: 100,
            left: 50,
            child: _buildCloud(80, 40),
          ),
          Positioned(
            top: 120,
            left: 200,
            child: _buildCloud(60, 30),
          ),
          Positioned(
            top: 80,
            right: 150,
            child: _buildCloud(70, 35),
          ),

          // Mountains in background
          Positioned(
            bottom: screenSize.height * 0.4,
            left: 0,
            right: 0,
            child: CustomPaint(
              painter: MountainPainter(),
              size: Size(screenSize.width, 120),
            ),
          ),

          // Ground texture with grass
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: screenSize.height * 0.3,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF8FBC8F),
                    Color(0xFF6B8E23),
                    Color(0xFF556B2F),
                  ],
                ),
              ),
              child: CustomPaint(
                painter: GrassPainter(),
                size: Size.infinite,
              ),
            ),
          ),

          // Main content
          CustomScrollView(
            slivers: [
              const CustomSliverAppBar(title: "My Forest"),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            await seedUserProgressAndForest(uid);
                            ref.invalidate(forestProvider(uid));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("🌱 Forest growth simulated for 30 days!"),
                                backgroundColor: Color(0xFF4CAF50),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E7D32),
                            foregroundColor: Colors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          icon: const Icon(Icons.auto_awesome, size: 20),
                          label: const Text(
                            "Simulate 30-Day Growth",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: forestAsync.when(
                  data: (trees) => _buildForestView(trees, screenSize),
                  loading: () => const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Growing your forest...",
                          style: TextStyle(
                            color: Color(0xFF2E7D32),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  error: (e, _) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error loading forest: $e',
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCloud(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(height / 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }

  Widget _buildForestView(List<dynamic> trees, Size screenSize) {
    if (trees.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.park_outlined,
              size: 80,
              color: Colors.green.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              "Your forest is waiting to grow!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.green.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Complete your daily tasks to plant your first tree",
              style: TextStyle(
                fontSize: 14,
                color: Colors.green.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return _buildTreeLayout(trees, screenSize);
  }

  Widget _buildTreeLayout(List<dynamic> trees, Size screenSize) {
    Map<String, dynamic> uniqueSpeciesTrees = {};
    
    for (var tree in trees) {
      String speciesKey = tree.speciesId;
      if (!uniqueSpeciesTrees.containsKey(speciesKey) || 
          tree.stage > uniqueSpeciesTrees[speciesKey].stage) {
        uniqueSpeciesTrees[speciesKey] = tree;
      }
    }

    List<dynamic> displayTrees = uniqueSpeciesTrees.values.toList();
    
    // Sort by species order (species_1, species_2, species_3)
    displayTrees.sort((a, b) {
      int getSpeciesOrder(String speciesId) {
        switch (speciesId) {
          case 'species_1': return 1;
          case 'species_2': return 2;
          case 'species_3': return 3;
          default: return 999;
        }
      }
      return getSpeciesOrder(a.speciesId).compareTo(getSpeciesOrder(b.speciesId));
    });

    if (displayTrees.isEmpty) {
      return _buildEmptyForest();
    }

    // Calculate positions for unique species only
    final List<Offset> treePositions = _calculateTreePositions(displayTrees.length, screenSize);
    const double treeSize = 165;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(bottom: 50),
      child: SizedBox(
        width: _calculateForestWidth(displayTrees.length, screenSize),
        height: screenSize.height * 0.6,
        child: Stack(
          children: [
            ...List.generate(displayTrees.length, (index) {
              final tree = displayTrees[index];
              final position = treePositions[index];
              final painter = _getPainter(tree.speciesId, tree.stage);

              return Positioned(
                left: position.dx,
                top: position.dy,
                child: GestureDetector(
                  onTap: () => _showTreeInfo(tree),
                  child: Container(
                    width: treeSize,
                    height: treeSize * 1.2,
                    child: Stack(
                      children: [
                        // Tree shadow
                        Positioned(
                          bottom: 0,
                          left: treeSize * 0.2,
                          child: Container(
                            width: treeSize * 0.6,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        // Tree with growing animation
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeOutBack,
                          child: CustomPaint(
                            painter: painter,
                            size: Size(treeSize, treeSize * 1.2),
                          ),
                        ),
                        // Growth stage indicator with species info
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getSpeciesColor(tree.speciesId),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _getSpeciesName(tree.speciesId),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Stage ${tree.stage}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Growth progress indicator
                        Positioned(
                          bottom: -5,
                          left: 0,
                          right: 0,
                          child: _buildGrowthProgress(tree),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildGrowthProgress(dynamic tree) {
    int maxStages = _getMaxStages(tree.speciesId);
    double progress = tree.stage / maxStages;
    
    return Container(
      height: 4,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(2),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            color: _getSpeciesColor(tree.speciesId),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyForest() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.eco,
            size: 100,
            color: Colors.green.shade200,
          ),
          const SizedBox(height: 24),
          Text(
            "🌱 Start Your Forest Journey",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Complete your daily tasks to grow your first tree!\nEach species will grow at its own special spot.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.green.shade600,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  List<Offset> _calculateTreePositions(int uniqueSpeciesCount, Size screenSize) {
    const double baseY = 280; // Base line for trees
    const double spacingX = 160; // More spacing between different species
    const double startX = 60;
    const double yVariation = 40; // Height variation for visual interest
    
    return List.generate(uniqueSpeciesCount, (index) {
      double x = startX + (index * spacingX);
      double y = baseY + (index % 2 == 0 ? 0 : yVariation); // Alternate heights
      
      return Offset(x, y);
    });
  }

  double _calculateForestWidth(int uniqueSpeciesCount, Size screenSize) {
    const double spacingX = 160;
    const double startX = 60;
    const double endPadding = 80;
    
    if (uniqueSpeciesCount == 0) return screenSize.width;
    
    return startX + (uniqueSpeciesCount * spacingX) + endPadding;
  }

  Color _getSpeciesColor(String speciesId) {
    switch (speciesId) {
      case 'species_1':
        return const Color(0xFF4CAF50); // Green for oak-like
      case 'species_2':
        return const Color(0xFF2E7D32); // Dark green for pine-like
      case 'species_3':
        return const Color(0xFF00796B); // Teal for deciduous
      default:
        return const Color(0xFF4CAF50);
    }
  }

  String _getSpeciesName(String speciesId) {
    switch (speciesId) {
      case 'species_1':
        return 'Oak';
      case 'species_2':
        return 'Pine';
      case 'species_3':
        return 'Maple';
      default:
        return 'Tree';
    }
  }

  int _getMaxStages(String speciesId) {
    switch (speciesId) {
      case 'species_1':
        return 2;
      case 'species_2':
        return 3;
      case 'species_3':
        return 4;
      default:
        return 2;
    }
  }

  void _showTreeInfo(dynamic tree) {
    // Placeholder for tree information dialog
    print('Tree Info: ${tree.speciesId} - Stage ${tree.stage}');
  }

  CustomPainter _getPainter(String id, int stage) {
    switch (id) {
      case 'species_1':
        return Species1Painter(stage);
      case 'species_2':
        return Species2Painter(stage);
      case 'species_3':
        return Species3Painter(stage);
      default:
        return Species1Painter(stage);
    }
  }
}

// Custom painter for mountain background
class MountainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..isAntiAlias = true;

    // Draw multiple mountain layers for depth
    // Back mountains (lightest)
    paint.color = const Color(0xFFB0BEC5);
    Path backMountains = Path();
    backMountains.moveTo(0, size.height);
    backMountains.lineTo(0, size.height * 0.3);
    backMountains.lineTo(size.width * 0.2, size.height * 0.1);
    backMountains.lineTo(size.width * 0.4, size.height * 0.4);
    backMountains.lineTo(size.width * 0.6, size.height * 0.2);
    backMountains.lineTo(size.width * 0.8, size.height * 0.5);
    backMountains.lineTo(size.width, size.height * 0.3);
    backMountains.lineTo(size.width, size.height);
    backMountains.close();
    canvas.drawPath(backMountains, paint);

    // Middle mountains
    paint.color = const Color(0xFF90A4AE);
    Path middleMountains = Path();
    middleMountains.moveTo(0, size.height);
    middleMountains.lineTo(0, size.height * 0.6);
    middleMountains.lineTo(size.width * 0.15, size.height * 0.3);
    middleMountains.lineTo(size.width * 0.35, size.height * 0.7);
    middleMountains.lineTo(size.width * 0.55, size.height * 0.4);
    middleMountains.lineTo(size.width * 0.75, size.height * 0.8);
    middleMountains.lineTo(size.width, size.height * 0.6);
    middleMountains.lineTo(size.width, size.height);
    middleMountains.close();
    canvas.drawPath(middleMountains, paint);

    // Front mountains (darkest)
    paint.color = const Color(0xFF78909C);
    Path frontMountains = Path();
    frontMountains.moveTo(0, size.height);
    frontMountains.lineTo(0, size.height * 0.8);
    frontMountains.lineTo(size.width * 0.3, size.height * 0.5);
    frontMountains.lineTo(size.width * 0.7, size.height * 0.9);
    frontMountains.lineTo(size.width, size.height * 0.7);
    frontMountains.lineTo(size.width, size.height);
    frontMountains.close();
    canvas.drawPath(frontMountains, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Custom painter for grass texture
class GrassPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF7CB342)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Draw grass blades randomly across the ground
    for (int i = 0; i < 100; i++) {
      double x = (i * 15) % size.width;
      double baseY = size.height * 0.7 + ((i * 7) % 20);
      double height = 8 + ((i * 3) % 12);

      Path grassBlade = Path();
      grassBlade.moveTo(x, baseY);
      grassBlade.quadraticBezierTo(
        x + 2, baseY - height * 0.5,
        x + 1, baseY - height,
      );
      canvas.drawPath(grassBlade, paint);
    }

    // Add some flowers
    paint.style = PaintingStyle.fill;
    for (int i = 0; i < 15; i++) {
      double x = (i * 40 + 20) % size.width;
      double y = size.height * 0.8 + ((i * 5) % 15);
      
      // Flower colors
      List<Color> flowerColors = [
        const Color(0xFFFFEB3B), // Yellow
        const Color(0xFFE91E63), // Pink
        const Color(0xFF9C27B0), // Purple
        const Color(0xFFFF5722), // Orange
      ];
      
      paint.color = flowerColors[i % flowerColors.length];
      canvas.drawCircle(Offset(x, y), 3, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}