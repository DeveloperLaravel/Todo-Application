import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@module
abstract class HiveModule {
  @preResolve
  @Named('todoBox')
  Future<Box> get todoBox async {
    await Hive.initFlutter();
    return await Hive.openBox('todoBox');
  }
}
