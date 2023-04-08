import 'package:app/mockup/exceptions.dart';
import 'dart:ffi';

import 'package:example_module/example_module.dart';

/// This is mockup class, that should be shipped by dart, and provide a functionality to dynamically load dart modules (code)
/// It's meant to work similarly to [DynamicLibrary], but for Dart instad of C
class ModuleLoader {
  /// Basically [DynamicLibrary.open] but for Dart
  /// Here we should:
  /// 1. Load the dynamic module
  /// Modules should have user (dev) defined entrypoints
  /// Entrypoint is a named piece of information that tells thart what class it should load
  /// 2. Get the class by entrypoint name, if entrypoint is absent throw an [ModuleEntrypointAbsentException]
  /// 3. Try to cast the class to M
  /// 3a. If it's M return it.
  /// 3b. If int's not throw a [ModuleCastException]
  static M loadModule<M>(String path, String entrypoint) {
    // Mockup body
    return ExampleModule() as M;
  }
}
