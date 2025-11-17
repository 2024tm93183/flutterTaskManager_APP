void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Parse().initialize(
    'YOUR_APP_ID',
    'https://parseapi.back4app.com',
    clientKey: 'YOUR_CLIENT_KEY',
    autoSendSessionId: true,
  );
  runApp(MyApp());
}

