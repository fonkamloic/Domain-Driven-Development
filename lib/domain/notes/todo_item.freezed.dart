// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'todo_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$TodoItemTearOff {
  const _$TodoItemTearOff();

// ignore: unused_element
  _TodoName call(
      {@required TodoName name, @required UniqueId id, @required bool done}) {
    return _TodoName(
      name: name,
      id: id,
      done: done,
    );
  }
}

// ignore: unused_element
const $TodoItem = _$TodoItemTearOff();

mixin _$TodoItem {
  TodoName get name;
  UniqueId get id;
  bool get done;

  $TodoItemCopyWith<TodoItem> get copyWith;
}

abstract class $TodoItemCopyWith<$Res> {
  factory $TodoItemCopyWith(TodoItem value, $Res Function(TodoItem) then) =
      _$TodoItemCopyWithImpl<$Res>;
  $Res call({TodoName name, UniqueId id, bool done});
}

class _$TodoItemCopyWithImpl<$Res> implements $TodoItemCopyWith<$Res> {
  _$TodoItemCopyWithImpl(this._value, this._then);

  final TodoItem _value;
  // ignore: unused_field
  final $Res Function(TodoItem) _then;

  @override
  $Res call({
    Object name = freezed,
    Object id = freezed,
    Object done = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed ? _value.name : name as TodoName,
      id: id == freezed ? _value.id : id as UniqueId,
      done: done == freezed ? _value.done : done as bool,
    ));
  }
}

abstract class _$TodoNameCopyWith<$Res> implements $TodoItemCopyWith<$Res> {
  factory _$TodoNameCopyWith(_TodoName value, $Res Function(_TodoName) then) =
      __$TodoNameCopyWithImpl<$Res>;
  @override
  $Res call({TodoName name, UniqueId id, bool done});
}

class __$TodoNameCopyWithImpl<$Res> extends _$TodoItemCopyWithImpl<$Res>
    implements _$TodoNameCopyWith<$Res> {
  __$TodoNameCopyWithImpl(_TodoName _value, $Res Function(_TodoName) _then)
      : super(_value, (v) => _then(v as _TodoName));

  @override
  _TodoName get _value => super._value as _TodoName;

  @override
  $Res call({
    Object name = freezed,
    Object id = freezed,
    Object done = freezed,
  }) {
    return _then(_TodoName(
      name: name == freezed ? _value.name : name as TodoName,
      id: id == freezed ? _value.id : id as UniqueId,
      done: done == freezed ? _value.done : done as bool,
    ));
  }
}

class _$_TodoName extends _TodoName with DiagnosticableTreeMixin {
  const _$_TodoName(
      {@required this.name, @required this.id, @required this.done})
      : assert(name != null),
        assert(id != null),
        assert(done != null),
        super._();

  @override
  final TodoName name;
  @override
  final UniqueId id;
  @override
  final bool done;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TodoItem(name: $name, id: $id, done: $done)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TodoItem'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('done', done));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TodoName &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.done, done) ||
                const DeepCollectionEquality().equals(other.done, done)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(done);

  @override
  _$TodoNameCopyWith<_TodoName> get copyWith =>
      __$TodoNameCopyWithImpl<_TodoName>(this, _$identity);
}

abstract class _TodoName extends TodoItem {
  const _TodoName._() : super._();
  const factory _TodoName(
      {@required TodoName name,
      @required UniqueId id,
      @required bool done}) = _$_TodoName;

  @override
  TodoName get name;
  @override
  UniqueId get id;
  @override
  bool get done;
  @override
  _$TodoNameCopyWith<_TodoName> get copyWith;
}
