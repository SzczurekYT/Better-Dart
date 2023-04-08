import 'package:app/loadable_module.dart';

/// An example implementation of a dynamically loaded module
/// It implements an interface [LoadableModule] declared by app developer
class ExampleModule implements LoadableModule {
  @override
  String getMessage() {
    return "Dart is cool!";
  }

  @override
  String getName() {
    return "Example module";
  }
}
