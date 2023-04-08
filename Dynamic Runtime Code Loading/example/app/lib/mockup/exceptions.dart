import 'dart:async';

class ModuleEntrypointAbsentException implements Exception {
  String modulePath;
  String entrypointName;
  ModuleEntrypointAbsentException(this.modulePath, this.entrypointName);

  @override
  String toString() {
    return "Failed to locate entrypoint $entrypointName for module $modulePath";
  }
}

class ModuleCastException implements Exception {
  String modulePath;
  String entrypointName;
  Type type;
  ModuleCastException(this.modulePath, this.entrypointName, this.type);

  @override
  String toString() {
    return "Moodule $modulePath entrypoint $entrypointName is not a $type.";
  }
}
