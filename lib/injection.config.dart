// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:gas_station/core/hive_module.dart' as _i701;
import 'package:gas_station/data/todo_local_data_source.dart' as _i152;
import 'package:gas_station/data/todo_repository.dart' as _i434;
import 'package:gas_station/screens/bloc/todo_bloc.dart' as _i841;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_flutter/hive_flutter.dart' as _i986;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final hiveModule = _$HiveModule();
    await gh.factoryAsync<_i986.Box<dynamic>>(
      () => hiveModule.todoBox,
      instanceName: 'todoBox',
      preResolve: true,
    );
    gh.lazySingleton<_i152.TodoLocalDataSource>(
      () => _i152.TodoLocalDataSource(
        gh<_i986.Box<dynamic>>(instanceName: 'todoBox'),
      ),
    );
    gh.lazySingleton<_i434.TodoRepository>(
      () => _i434.TodoRepository(gh<_i152.TodoLocalDataSource>()),
    );
    gh.factory<_i841.TodoBloc>(
      () => _i841.TodoBloc(gh<_i434.TodoRepository>()),
    );
    return this;
  }
}

class _$HiveModule extends _i701.HiveModule {}
