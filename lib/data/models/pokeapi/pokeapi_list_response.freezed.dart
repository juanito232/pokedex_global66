// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pokeapi_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PokeApiListResponse {

 int get count; String? get next; String? get previous; List<PokeApiResult> get results;
/// Create a copy of PokeApiListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PokeApiListResponseCopyWith<PokeApiListResponse> get copyWith => _$PokeApiListResponseCopyWithImpl<PokeApiListResponse>(this as PokeApiListResponse, _$identity);

  /// Serializes this PokeApiListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PokeApiListResponse&&(identical(other.count, count) || other.count == count)&&(identical(other.next, next) || other.next == next)&&(identical(other.previous, previous) || other.previous == previous)&&const DeepCollectionEquality().equals(other.results, results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,next,previous,const DeepCollectionEquality().hash(results));

@override
String toString() {
  return 'PokeApiListResponse(count: $count, next: $next, previous: $previous, results: $results)';
}


}

/// @nodoc
abstract mixin class $PokeApiListResponseCopyWith<$Res>  {
  factory $PokeApiListResponseCopyWith(PokeApiListResponse value, $Res Function(PokeApiListResponse) _then) = _$PokeApiListResponseCopyWithImpl;
@useResult
$Res call({
 int count, String? next, String? previous, List<PokeApiResult> results
});




}
/// @nodoc
class _$PokeApiListResponseCopyWithImpl<$Res>
    implements $PokeApiListResponseCopyWith<$Res> {
  _$PokeApiListResponseCopyWithImpl(this._self, this._then);

  final PokeApiListResponse _self;
  final $Res Function(PokeApiListResponse) _then;

/// Create a copy of PokeApiListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? next = freezed,Object? previous = freezed,Object? results = null,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String?,previous: freezed == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as String?,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<PokeApiResult>,
  ));
}

}


/// Adds pattern-matching-related methods to [PokeApiListResponse].
extension PokeApiListResponsePatterns on PokeApiListResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PokeApiListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PokeApiListResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PokeApiListResponse value)  $default,){
final _that = this;
switch (_that) {
case _PokeApiListResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PokeApiListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PokeApiListResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  String? next,  String? previous,  List<PokeApiResult> results)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PokeApiListResponse() when $default != null:
return $default(_that.count,_that.next,_that.previous,_that.results);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  String? next,  String? previous,  List<PokeApiResult> results)  $default,) {final _that = this;
switch (_that) {
case _PokeApiListResponse():
return $default(_that.count,_that.next,_that.previous,_that.results);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  String? next,  String? previous,  List<PokeApiResult> results)?  $default,) {final _that = this;
switch (_that) {
case _PokeApiListResponse() when $default != null:
return $default(_that.count,_that.next,_that.previous,_that.results);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PokeApiListResponse implements PokeApiListResponse {
  const _PokeApiListResponse({required this.count, required this.next, required this.previous, required final  List<PokeApiResult> results}): _results = results;
  factory _PokeApiListResponse.fromJson(Map<String, dynamic> json) => _$PokeApiListResponseFromJson(json);

@override final  int count;
@override final  String? next;
@override final  String? previous;
 final  List<PokeApiResult> _results;
@override List<PokeApiResult> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}


/// Create a copy of PokeApiListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PokeApiListResponseCopyWith<_PokeApiListResponse> get copyWith => __$PokeApiListResponseCopyWithImpl<_PokeApiListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PokeApiListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PokeApiListResponse&&(identical(other.count, count) || other.count == count)&&(identical(other.next, next) || other.next == next)&&(identical(other.previous, previous) || other.previous == previous)&&const DeepCollectionEquality().equals(other._results, _results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,next,previous,const DeepCollectionEquality().hash(_results));

@override
String toString() {
  return 'PokeApiListResponse(count: $count, next: $next, previous: $previous, results: $results)';
}


}

/// @nodoc
abstract mixin class _$PokeApiListResponseCopyWith<$Res> implements $PokeApiListResponseCopyWith<$Res> {
  factory _$PokeApiListResponseCopyWith(_PokeApiListResponse value, $Res Function(_PokeApiListResponse) _then) = __$PokeApiListResponseCopyWithImpl;
@override @useResult
$Res call({
 int count, String? next, String? previous, List<PokeApiResult> results
});




}
/// @nodoc
class __$PokeApiListResponseCopyWithImpl<$Res>
    implements _$PokeApiListResponseCopyWith<$Res> {
  __$PokeApiListResponseCopyWithImpl(this._self, this._then);

  final _PokeApiListResponse _self;
  final $Res Function(_PokeApiListResponse) _then;

/// Create a copy of PokeApiListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? next = freezed,Object? previous = freezed,Object? results = null,}) {
  return _then(_PokeApiListResponse(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as String?,previous: freezed == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as String?,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<PokeApiResult>,
  ));
}


}


/// @nodoc
mixin _$PokeApiResult {

 String get name; String get url;
/// Create a copy of PokeApiResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PokeApiResultCopyWith<PokeApiResult> get copyWith => _$PokeApiResultCopyWithImpl<PokeApiResult>(this as PokeApiResult, _$identity);

  /// Serializes this PokeApiResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PokeApiResult&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,url);

@override
String toString() {
  return 'PokeApiResult(name: $name, url: $url)';
}


}

/// @nodoc
abstract mixin class $PokeApiResultCopyWith<$Res>  {
  factory $PokeApiResultCopyWith(PokeApiResult value, $Res Function(PokeApiResult) _then) = _$PokeApiResultCopyWithImpl;
@useResult
$Res call({
 String name, String url
});




}
/// @nodoc
class _$PokeApiResultCopyWithImpl<$Res>
    implements $PokeApiResultCopyWith<$Res> {
  _$PokeApiResultCopyWithImpl(this._self, this._then);

  final PokeApiResult _self;
  final $Res Function(PokeApiResult) _then;

/// Create a copy of PokeApiResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? url = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PokeApiResult].
extension PokeApiResultPatterns on PokeApiResult {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PokeApiResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PokeApiResult() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PokeApiResult value)  $default,){
final _that = this;
switch (_that) {
case _PokeApiResult():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PokeApiResult value)?  $default,){
final _that = this;
switch (_that) {
case _PokeApiResult() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PokeApiResult() when $default != null:
return $default(_that.name,_that.url);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String url)  $default,) {final _that = this;
switch (_that) {
case _PokeApiResult():
return $default(_that.name,_that.url);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String url)?  $default,) {final _that = this;
switch (_that) {
case _PokeApiResult() when $default != null:
return $default(_that.name,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PokeApiResult implements PokeApiResult {
  const _PokeApiResult({required this.name, required this.url});
  factory _PokeApiResult.fromJson(Map<String, dynamic> json) => _$PokeApiResultFromJson(json);

@override final  String name;
@override final  String url;

/// Create a copy of PokeApiResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PokeApiResultCopyWith<_PokeApiResult> get copyWith => __$PokeApiResultCopyWithImpl<_PokeApiResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PokeApiResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PokeApiResult&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,url);

@override
String toString() {
  return 'PokeApiResult(name: $name, url: $url)';
}


}

/// @nodoc
abstract mixin class _$PokeApiResultCopyWith<$Res> implements $PokeApiResultCopyWith<$Res> {
  factory _$PokeApiResultCopyWith(_PokeApiResult value, $Res Function(_PokeApiResult) _then) = __$PokeApiResultCopyWithImpl;
@override @useResult
$Res call({
 String name, String url
});




}
/// @nodoc
class __$PokeApiResultCopyWithImpl<$Res>
    implements _$PokeApiResultCopyWith<$Res> {
  __$PokeApiResultCopyWithImpl(this._self, this._then);

  final _PokeApiResult _self;
  final $Res Function(_PokeApiResult) _then;

/// Create a copy of PokeApiResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? url = null,}) {
  return _then(_PokeApiResult(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
