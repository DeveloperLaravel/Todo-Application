import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_state.freezed.dart';

@freezed
class TodoState with _$TodoState {
  const factory TodoState({
    @Default([]) List<String> todos,
    int? editingIndex,
  }) = _TodoState;
}
