import 'package:info_sphere/utils/imports.dart';

class RegisterNameScreen extends StatefulWidget {
  const RegisterNameScreen({super.key});
  static const route = "RegisterNameScreen";

  @override
  State<RegisterNameScreen> createState() => _RegisterNameScreenState();
}

class _RegisterNameScreenState extends State<RegisterNameScreen> {
  ValueNotifier<String?> name = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              Assets.doodle,
              color: context.theme.primaryColor,
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.4),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome,',
                    style: context.textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'We’re excited to have you!',
                    style: context.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Your name helps us personalize your experience.',
                    style: context.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: context.theme.hintColor),
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: context.theme.hintColor,
                        ),
                      ),
                    ),
                    maxLength: 20,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[A-Za-z ]+')),
                    ],
                    onChanged: (value) {
                      name.value = value;
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ValueListenableBuilder<String?>(
                          valueListenable: name,
                          builder: (context, value, child) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: context.theme.primaryColor,
                                foregroundColor: context.theme.canvasColor,
                              ),
                              onPressed: value != null && ((value.length) >= 3)
                                  ? () {
                                      StoragePrefUtils.setName(value);
                                      context.read<SettingsViewModel>().name = value;
                                      Navigator.pushReplacementNamed(
                                        context,
                                        HomeScreen.route,
                                      );
                                    }
                                  : null,
                              child: Text('Let\'s go', style: context.textTheme.titleMedium),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
