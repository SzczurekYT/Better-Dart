# Example
This is a mockup example on how dynamic code loading could look like. I have no idea if it's possible to implement it like this, but it would be really neat if it was doable.
# How it works
We have two dart projects. Our app and a module that will be loaded by it.
From now on I will refer to the project's that are meant to be dynamically loaded by the app as modules.
My mockup uses the concept of entrypoints.
First the app defines an entrypoint in it's [pubscpec.yaml](https://github.com/SzczurekYT/Better-Dart/blob/e3c09df3392332301c8a35a7450f34a739056da2/Dynamic%20Runtime%20Code%20Loading/example/app/pubspec.yaml)
Entrypoint has a name and an interface assigned to it.
```yaml
# This probably needs a better name
entrydef:
  # Here we define an entrypoint called "main"
  # and assing it the LoadableModule interface
  # We specify the class' name after two colons since file can contain more then one class.
  # There might be a better syntax then this, subject to change.
  main: 'package:app/loadable_module.dart::LoadableModule'
```
In this example the LoadableModule interface looks like this.
```dart
abstract class LoadableModule {

  String getName();
  String getMessage();
  
}
```
This interface will be implemented in loadable modules.
In our example module project we depend on the app, to access the LoadableModule interface.
In it's [pubscpec.yaml](https://github.com/SzczurekYT/Better-Dart/blob/e3c09df3392332301c8a35a7450f34a739056da2/Dynamic%20Runtime%20Code%20Loading/example/module/pubspec.yaml) we also define that the entrypoint "main" is implemented in a class called "ExampleModule" located at 'package:example_module/example_module.dart'
```yaml
dependencies:
  app:
    path: ../app
    
entrypoints:
  # :: syntax subject to change
  main: 'package:example_module/example_module.dart::ExampleModule'
  ```
and the ExampleModule looks like that:
```dart
import 'package:app/loadable_module.dart';

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
```
Now the module project is redy. It shoud be compiled to a file or some format of archive to contain neede files.
The entrypoint data should be contained in it and transformed to work in compiled enviroment (is this possible to do?).

Now we have our module ready to be loaded.
Back in our app we can do something like this.
```dart
import 'package:app/loadable_module.dart';
import 'package:app/mockup/exceptions.dart';
import 'package:app/mockup/module_loader.dart';

void main(List<String> args) {
  // Get the module files to load, probably from some directory or something like that.
  List<String> paths = getModulePaths();

  for (var path in paths) {
    LoadableModule module;
    try {
      // Try to load the module using dart provided ModuleLoader class, just like with DynamicLibrary from dart:ffi
      module = ModuleLoader.loadModule(path, "main");
    } on ModuleEntrypointAbsentException catch (e) {
      // The entrypoint main isn't implemented by this module.
      print(
          "Extension on path ${e.modulePath} doesn't implement entrypoint \"${e.entrypointName}\"");
      continue;
    } on ModuleCastException catch (e) {
      // The class at entrypoint "main" doesn't implement the LoadableModule inteface.
      print(
          "Falied to load an extension for path ${e.modulePath}, skipping it!");
      continue;
    }
    // Here we get the name and message from the module
    // They are simple string but this should work with any data type, including widgets and functions
    print("Succesfully loaded an extension ${module.getName()}"); // Succesfully loaded an extension Example module
    print("Extension ${module.getName()} says:"); // Extension Example module says:
    print(module.getMessage()); // Dart is cool!
  }
}
```

Here we go, we have w nice system for loading code dynamically!
Now the real question is: is this even possible?
I hope so.
Feel free to explore the code yourself, especially [ModuleLoader](https://github.com/SzczurekYT/Better-Dart/blob/d0e732c40da49dd0d25a3d4cd28659299d0e785e/Dynamic%20Runtime%20Code%20Loading/example/app/lib/mockup/module_loader.dart) for some additional details.
