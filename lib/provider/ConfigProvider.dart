import 'package:m_health_app/provider/HomeProvider/HomeProvider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ConfigProvider {
  static final List<SingleChildWidget> _providers = [
    ChangeNotifierProvider(
      create: (_) => HomeProvider(),
    ),
  ];
  static get providers => _providers;
}
