import 'package:info_sphere/utils/imports.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  static const route = "SettingsScreen";

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SettingsViewModel>().isReadOnly = true;
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Dispose the FocusNode to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var view = context.read<SettingsViewModel>();
    return WillPopScope(
      onWillPop: () async {
        if (!view.isReadOnly) {
          view.name = await StoragePrefUtils.getName();
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          actions: [
            Consumer<SettingsViewModel>(builder: (context, view, child) {
              return view.isReadOnly
                  ? IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return LogOutExitAlert(
                              onYesTap: () async {
                                await view.logout();
                                exit(0);
                              },
                              onNoTap: () {
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.logout),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: surfaceColorLight,
                      ),
                      onPressed: view.name != null && (view.name?.length ?? 0) >= 3
                          ? () {
                              view.onSaveProfile();
                              context.hideKeyboard();
                            }
                          : null,
                      child: Text(
                        "Save",
                        style: context.textTheme.titleMedium?.copyWith(
                          color: textColorLight,
                        ),
                      ),
                    );
            }),
            const SizedBox(width: 8),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    Consumer<SettingsViewModel>(builder: (context, view, child) {
                      return TextFormField(
                        initialValue: view.name,
                        readOnly: view.isReadOnly,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
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
                          suffixIcon: view.isReadOnly
                              ? IconButton(
                                  onPressed: () {
                                    view.isReadOnly = false;
                                    _focusNode.requestFocus();
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.grey,
                                  ),
                                )
                              : null,
                        ),
                        maxLength: 20,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[A-Za-z ]+')),
                        ],
                        onChanged: (value) => view.name = value,
                        selectionControls: null,
                      );
                    }),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Divider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Card(
                                color: context.theme.cardColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.dark_mode_rounded,
                                    color: context.primaryColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Dark Mode',
                                style: context.textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                        ValueListenableBuilder<ThemeMode?>(
                          valueListenable: AppThemes().appThemeNotifier,
                          builder: (BuildContext context, value, Widget? child) {
                            print("Current Theme : $value");
                            return Switch.adaptive(
                              value: value == ThemeMode.dark,
                              onChanged: (bool isDarkMode) {
                                AppThemes().changeTheme(
                                  isDarkMode ? ThemeMode.dark : ThemeMode.light,
                                );
                              },
                              activeColor: context.theme.highlightColor,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Text('App Version : $appVersion'),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
