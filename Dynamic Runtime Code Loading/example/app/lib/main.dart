import 'package:app/loadable_module.dart';
import 'package:app/mockup/exceptions.dart';
import 'package:app/mockup/module_loader.dart';

void main(List<String> args) {
  List<String> paths = getModulePaths();

  for (var path in paths) {
    LoadableModule module;
    try {
      module = ModuleLoader.loadModule(path, "main");
    } on ModuleEntrypointAbsentException catch (e) {
      print(
          "Extension on path ${e.modulePath} doesn't implement entrypoint \"${e.entrypointName}\"");
      continue;
    } on ModuleCastException catch (e) {
      print(
          "Falied to load an extension for path ${e.modulePath}, skipping it!");
      continue;
    }
    print("Succesfully loaded an extension ${module.getName()}");
    print("Extension ${module.getName()} says:");
    print(module.getMessage());
  }
}

List<String> getModulePaths() {
  // Here we get all the modules to load
  // Probably from some directory

  // mockup
  return ["/path/to/some/module"];
}
