import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const AnimatedContainerDemoApp());
}

class AnimatedContainerDemoApp extends StatelessWidget {
  const AnimatedContainerDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Container Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C3483)),
        useMaterial3: true,
        fontFamily: 'sans-serif',
      ),
      home: const AnimatedContainerScreen(),
    );
  }
}

// ─────────────────────────────────────────────────────
// REAL-WORLD SCENARIO: Music Player
// The album art container animates when a track changes —
// it resizes, recolors, and reshapes, all with smooth
// transitions. No extra animation controllers needed.
// ─────────────────────────────────────────────────────

const List<Map<String, dynamic>> _tracks = [
  {
    'title': 'Midnight Drive',
    'artist': 'Luna Wave',
    'color': Color(0xFF1A1A2E),
    'accent': Color(0xFFE94560),
    'icon': Icons.nightlight_round,
    'size': 220.0,
    'radius': 16.0,
  },
  {
    'title': 'Summer Bloom',
    'artist': 'The Petals',
    'color': Color(0xFFFF6B35),
    'accent': Color(0xFFFFE66D),
    'icon': Icons.wb_sunny,
    'size': 260.0,
    'radius': 130.0, // circle
  },
  {
    'title': 'Deep Forest',
    'artist': 'Echo & Moss',
    'color': Color(0xFF1B4332),
    'accent': Color(0xFF95D5B2),
    'icon': Icons.forest,
    'size': 200.0,
    'radius': 8.0,
  },
  {
    'title': 'Neon City',
    'artist': 'Static Pulse',
    'color': Color(0xFF0D0221),
    'accent': Color(0xFF00F5FF),
    'icon': Icons.location_city,
    'size': 240.0,
    'radius': 40.0,
  },
];

class AnimatedContainerScreen extends StatefulWidget {
  const AnimatedContainerScreen({super.key});

  @override
  State<AnimatedContainerScreen> createState() =>
      _AnimatedContainerScreenState();
}

class _AnimatedContainerScreenState extends State<AnimatedContainerScreen> {
  int _trackIndex = 0;
  bool _isPlaying = false;

  // ── PROPERTY 1: duration ──────────────────────────────────────────────────
  // How long the transition animation takes.
  // Short = snappy, Long = slow and dreamy.
  final Duration _duration = const Duration(milliseconds: 600);

  // ── PROPERTY 2: decoration (color + borderRadius) ─────────────────────────
  // Sets the visual appearance of the container.
  // Both color and shape animate smoothly between states.

  // ── PROPERTY 3: width / height ────────────────────────────────────────────
  // The container animates its own size automatically.
  // No need to write any animation controller code.

  Map<String, dynamic> get _current => _tracks[_trackIndex];

  void _nextTrack() {
    setState(() {
      _trackIndex = (_trackIndex + 1) % _tracks.length;
      _isPlaying = true;
    });
  }

  void _prevTrack() {
    setState(() {
      _trackIndex = (_trackIndex - 1 + _tracks.length) % _tracks.length;
      _isPlaying = true;
    });
  }

  void _togglePlay() => setState(() => _isPlaying = !_isPlaying);

  @override
  Widget build(BuildContext context) {
    final track = _current;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Animated Container Demo',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'Music Player',
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ],
        ),
        toolbarHeight: 72,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [

            // ── ANIMATED CONTAINER — the star of the show ──
            Center(
              child: AnimatedContainer(
                // PROPERTY 3: width & height — animates size change
                width: track['size'] as double,
                height: track['size'] as double,

                // PROPERTY 1: duration — controls animation speed
                duration: _duration,

                // Built-in easing curve
                curve: Curves.easeInOut,

                // PROPERTY 2: decoration — animates color and shape
                decoration: BoxDecoration(
                  color: track['color'] as Color,
                  borderRadius: BorderRadius.circular(track['radius'] as double),
                  boxShadow: [
                    BoxShadow(
                      color: (track['accent'] as Color).withValues(alpha:0.5),
                      blurRadius: 40,
                      spreadRadius: 8,
                    ),
                  ],
                ),

                // Content inside the container
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedSwitcher(
                      duration: _duration,
                      child: Icon(
                        track['icon'] as IconData,
                        key: ValueKey(_trackIndex),
                        size: 64,
                        color: track['accent'] as Color,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (_isPlaying)
                      _SoundBars(color: track['accent'] as Color),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // ── TRACK INFO ──
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: Column(
                key: ValueKey(_trackIndex),
                children: [
                  Text(
                    track['title'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    track['artist'] as String,
                    style: const TextStyle(color: Colors.white54, fontSize: 15),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── PLAYBACK CONTROLS ──
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ControlButton(
                  icon: Icons.skip_previous_rounded,
                  onTap: _prevTrack,
                  color: Colors.white70,
                  size: 36,
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: _togglePlay,
                  child: AnimatedContainer(
                    duration: _duration,
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: track['accent'] as Color,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                _ControlButton(
                  icon: Icons.skip_next_rounded,
                  onTap: _nextTrack,
                  color: Colors.white70,
                  size: 36,
                ),
              ],
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ANIMATED SOUND BARS — purely decorative
// ─────────────────────────────────────────────
class _SoundBars extends StatefulWidget {
  final Color color;
  const _SoundBars({required this.color});

  @override
  State<_SoundBars> createState() => _SoundBarsState();
}

class _SoundBarsState extends State<_SoundBars>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  final _random = Random();
  late List<Animation<double>> _anims;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _anims = List.generate(
      5,
      (i) => Tween<double>(
        begin: 4,
        end: 20 + _random.nextDouble() * 16,
      ).animate(CurvedAnimation(
        parent: _ctrl,
        curve: Interval(i * 0.15, 0.6 + i * 0.08, curve: Curves.easeInOut),
      )),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: _anims.map((anim) {
          return Container(
            width: 4,
            height: anim.value,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// HELPER WIDGETS
// ─────────────────────────────────────────────

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;
  final double size;

  const _ControlButton({
    required this.icon,
    required this.onTap,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, color: color, size: size),
    );
  }
}

