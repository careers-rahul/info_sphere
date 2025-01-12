import 'package:info_sphere/utils/imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const route = "SplashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      await AppThemes().getPreferences();
      var name = await StoragePrefUtils.getName();
      if (mounted) {
        if (name != null) {
          context.read<SettingsViewModel>().name = name;
          Navigator.pushReplacementNamed(
            context,
            HomeScreen.route,
          );
        } else {
          Navigator.pushReplacementNamed(
            context,
            RegisterNameScreen.route,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColorLight,
      body: Stack(
        children: [
          Image.asset(
            Assets.doodle,
            color: primaryColorLight,
            fit: BoxFit.cover,
            opacity: const AlwaysStoppedAnimation(0.4),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.asset(
                    Assets.logo,
                    fit: BoxFit.cover,
                    opacity: const AlwaysStoppedAnimation(0.4),
                  ),
                ),
                Text(
                  'Info Sphere',
                  style: context.theme.textTheme.displaySmall?.copyWith(
                    wordSpacing: 4,
                    color: textColorLight,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Explore the Sphere of News Today!',
                  style: context.textTheme.titleLarge?.copyWith(
                    color: textColorLight,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
