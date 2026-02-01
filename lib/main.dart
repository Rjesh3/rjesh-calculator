// Main application file for Rjesh Calculator
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:math_expressions/math_expressions.dart';

// Entry point
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Google Mobile Ads SDK
  await MobileAds.instance.initialize();
  // Run app
  runApp(const RjeshCalculatorApp());
}

/// Root widget with Provider for app state
class RjeshCalculatorApp extends StatelessWidget {
  const RjeshCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CalculatorModel()..loadFromDisk(),
      child: Consumer<CalculatorModel>(builder: (context, model, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Rjesh Calculator',
          theme: ThemeData.light(useMaterial3: true).copyWith(
            scaffoldBackgroundColor: Colors.black,
            brightness: Brightness.dark,
            colorScheme: const ColorScheme.dark()
                .copyWith(primary: Colors.deepPurpleAccent),
            textTheme: ThemeData.dark().textTheme,
          ),
          home: const CalculatorHome(),
        );
      }),
    );
  }
}

/// Calculator application state and logic
class CalculatorModel extends ChangeNotifier {
  String _input = '';
  String _result = '0';
  double _memory = 0.0;
  final List<String> _history = [];

  // Ad counters
  int calculationCount = 0;

  // Expose read-only
  String get input => _input;
  String get result => _result;
  double get memory => _memory;
  List<String> get history => List.unmodifiable(_history.reversed);

  // (no placeholder getters)

  // Append a character/button press
  void add(String value) {
    if (value == 'AC') return allClear();
    if (value == 'C') return clearEntry();
    if (value == '⌫') return backspace();

    _input += value;
    _computeImmediate();
    notifyListeners();
  }

  // Clear last entry (C)
  void clearEntry() {
    _input = '';
    _result = '0';
    notifyListeners();
  }

  // All clear
  void allClear() {
    _input = '';
    _result = '0';
    notifyListeners();
  }

  // Backspace
  void backspace() {
    if (_input.isNotEmpty) {
      _input = _input.substring(0, _input.length - 1);
      _computeImmediate();
      notifyListeners();
    }
  }

  // Memory functions
  void memoryAdd() {
    final val = double.tryParse(_result) ?? 0.0;
    _memory += val;
    notifyListeners();
  }

  void memorySub() {
    final val = double.tryParse(_result) ?? 0.0;
    _memory -= val;
    notifyListeners();
  }

  void memoryRecall() {
    _input = _memory.toString();
    _computeImmediate();
    notifyListeners();
  }

  void memoryClear() {
    _memory = 0.0;
    notifyListeners();
  }

  // Toggle sign of current input
  void toggleSign() {
    if (_input.isEmpty) return;
    if (_input.startsWith('-')) {
      _input = _input.substring(1);
    } else {
      _input = '-$_input';
    }
    _computeImmediate();
    notifyListeners();
  }

  // Evaluate and push to history
  void evaluateFinal() {
    _computeImmediate();
    _pushHistory('$_input = $_result');
    calculationCount++;
    notifyListeners();
  }

  // Save history, keep last 10
  void _pushHistory(String item) {
    _history.add(item);
    if (_history.length > 10) _history.removeAt(0);
    _saveToDisk();
  }

  // Immediate calculation as user types
  void _computeImmediate() {
    if (_input.isEmpty) {
      _result = '0';
      return;
    }

    try {
      final expr = _prepareExpression(_input);
      final parser = ShuntingYardParser();
      final parsed = parser.parse(expr);
      final cm = ContextModel();
      final eval = parsed.evaluate(EvaluationType.REAL, cm);
      _result = (eval is double && eval.isFinite) ? _format(eval) : eval.toString();
    } catch (_) {
      _result = 'Err';
    }
  }

  // Convert display-friendly expression into one parsable by math_expressions
  String _prepareExpression(String s) {
    var out = s.replaceAll('×', '*').replaceAll('÷', '/');
    // Replace percent like 50% -> (50/100)
    out = out.replaceAllMapped(RegExp(r"(\d+(?:\.\d+)?)%"), (m) => '(${m[1]}/100)');
    // Replace × and ÷ already handled
    return out;
  }

  String _format(num v) {
    if (v % 1 == 0) return v.toInt().toString();
    return v.toString();
  }

  // Persistence
  Future<void> loadFromDisk() async {
    final prefs = await SharedPreferences.getInstance();
    _history.clear();
    final saved = prefs.getStringList('history') ?? [];
    _history.addAll(saved);
    _memory = prefs.getDouble('memory') ?? 0.0;
    notifyListeners();
  }

  Future<void> _saveToDisk() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('history', _history);
    await prefs.setDouble('memory', _memory);
  }
}

// Use EvaluationType from math_expressions package

/// Main screen for calculator UI
class CalculatorHome extends StatefulWidget {
  const CalculatorHome({super.key});

  @override
  State<CalculatorHome> createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> with TickerProviderStateMixin {
  late BannerAd _bannerAd;
  bool _bannerLoaded = false;
  InterstitialAd? _interstitialAd;
  late AnimationController _logoAnimController;

  // Ad unit ids from the PRD
  static const String bannerUnitId = 'ca-app-pub-4817192341505713/5285435780';
  static const String interstitialUnitId = 'ca-app-pub-4817192341505713/9648526086';

  // no placeholder provider getter

  @override
  void initState() {
    super.initState();
    // Logo fade-in & scale animation controller
    _logoAnimController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _logoAnimController.forward();
    _loadBanner();
    _loadInterstitial();
  }

  void _loadBanner() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: bannerUnitId,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() => _bannerLoaded = true);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    );
    _bannerAd.load();
  }

  void _loadInterstitial() {
    InterstitialAd.load(
      adUnitId: interstitialUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialAd = null;
        },
      ),
    );
  }

  void _maybeShowInterstitial(CalculatorModel model) {
    // Show after every 5 calculations (example)
    if (model.calculationCount > 0 && model.calculationCount % 5 == 0 && _interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd = null;
      _loadInterstitial();
    }
  }

  @override
  void dispose() {
    _logoAnimController.dispose();
    _bannerAd.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CalculatorModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade900, Colors.indigo.shade900],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              // ===== ANIMATED LOGO SECTION =====
              // Prominent logo display with fade-in & scale animation
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                    CurvedAnimation(parent: _logoAnimController, curve: Curves.elasticOut),
                  ),
                  child: FadeTransition(
                    opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(parent: _logoAnimController, curve: Curves.easeIn),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 120,
                        width: 120,
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) => Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade700,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Center(
                            child: Text('Logo', style: TextStyle(color: Colors.white, fontSize: 14)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // ===== APP TITLE & HISTORY BUTTON =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Rjesh Calculator',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.history, color: Colors.white),
                      onPressed: () async {
                        final model = Provider.of<CalculatorModel>(context, listen: false);
                        // Show interstitial occasionally
                        _maybeShowInterstitial(model);
                        await showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.black87,
                            builder: (_) {
                              return _buildHistorySheet(model);
                            });
                      },
                    )
                  ],
                ),
              ),

              // Display
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: Text(
                              model.input.isEmpty ? '0' : model.input,
                              key: ValueKey(model.input),
                              style: const TextStyle(fontSize: 28, color: Colors.white70),
                            ),
                          ),
                          const SizedBox(height: 8),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            child: Text(
                              model.result,
                              key: ValueKey(model.result),
                              style: const TextStyle(fontSize: 44, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Buttons grid
                    _buildButtons(model),
                  ],
                ),
              ),

              // Banner Ad
              if (_bannerLoaded)
                SizedBox(
                  height: _bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistorySheet(CalculatorModel model) {
    return Container(
      height: 360,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('History', style: TextStyle(color: Colors.white, fontSize: 18)),
          const SizedBox(height: 8),
          Expanded(
            child: model.history.isEmpty
                ? const Center(child: Text('No history', style: TextStyle(color: Colors.white54)))
                : ListView.builder(
                    itemCount: model.history.length,
                    itemBuilder: (_, i) {
                      final item = model.history[i];
                      return ListTile(
                        title: Text(item, style: const TextStyle(color: Colors.white70)),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close', style: TextStyle(color: Colors.white)),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildButtons(CalculatorModel model) {
    final buttons = [
      ['AC', 'C', '⌫', '÷'],
      ['7', '8', '9', '×'],
      ['4', '5', '6', '-'],
      ['1', '2', '3', '+'],
      ['±', '0', '.', '='],
    ];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(0, 0, 0, 0.25),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: buttons.map((row) {
          return Row(
            children: row.map((b) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Material(
                    color: _buttonColor(b),
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        _onButtonPress(b, model);
                      },
                      child: Container(
                        height: 64,
                        alignment: Alignment.center,
                        child: Text(
                          b,
                          style: const TextStyle(fontSize: 22, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }

  Color _buttonColor(String b) {
    if (b == 'AC' || b == 'C' || b == '⌫') return Colors.red.shade700;
    if (b == '+' || b == '-' || b == '×' || b == '÷' || b == '=') return Colors.deepPurpleAccent;
    return Colors.grey.shade900;
  }

  void _onButtonPress(String b, CalculatorModel model) {
    if (b == '=') {
      model.evaluateFinal();
      _maybeShowInterstitial(model);
      return;
    }

    if (b == '±') {
      model.toggleSign();
      return;
    }

    model.add(b);
  }
}

// End of file - real Ad classes are provided by `google_mobile_ads` package


