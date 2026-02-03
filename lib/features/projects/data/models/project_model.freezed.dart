// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProjectModel {

 String get id; String get title; String? get subtitle; String get description; String get role; String get type;// Stored as string in Firestore
 DateTime get startDate; DateTime? get endDate; String get coverImage; List<String> get galleryImages; List<String> get technologies; List<String> get testingTypes; Map<String, dynamic>? get qaMetrics; Map<String, dynamic>? get starNarrative; Map<String, dynamic>? get testimonial; String? get mainUrl; Map<String, String> get links; int get orderIndex; bool get isPublished; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of ProjectModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectModelCopyWith<ProjectModel> get copyWith => _$ProjectModelCopyWithImpl<ProjectModel>(this as ProjectModel, _$identity);

  /// Serializes this ProjectModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.description, description) || other.description == description)&&(identical(other.role, role) || other.role == role)&&(identical(other.type, type) || other.type == type)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.coverImage, coverImage) || other.coverImage == coverImage)&&const DeepCollectionEquality().equals(other.galleryImages, galleryImages)&&const DeepCollectionEquality().equals(other.technologies, technologies)&&const DeepCollectionEquality().equals(other.testingTypes, testingTypes)&&const DeepCollectionEquality().equals(other.qaMetrics, qaMetrics)&&const DeepCollectionEquality().equals(other.starNarrative, starNarrative)&&const DeepCollectionEquality().equals(other.testimonial, testimonial)&&(identical(other.mainUrl, mainUrl) || other.mainUrl == mainUrl)&&const DeepCollectionEquality().equals(other.links, links)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&(identical(other.isPublished, isPublished) || other.isPublished == isPublished)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,subtitle,description,role,type,startDate,endDate,coverImage,const DeepCollectionEquality().hash(galleryImages),const DeepCollectionEquality().hash(technologies),const DeepCollectionEquality().hash(testingTypes),const DeepCollectionEquality().hash(qaMetrics),const DeepCollectionEquality().hash(starNarrative),const DeepCollectionEquality().hash(testimonial),mainUrl,const DeepCollectionEquality().hash(links),orderIndex,isPublished,createdAt,updatedAt]);

@override
String toString() {
  return 'ProjectModel(id: $id, title: $title, subtitle: $subtitle, description: $description, role: $role, type: $type, startDate: $startDate, endDate: $endDate, coverImage: $coverImage, galleryImages: $galleryImages, technologies: $technologies, testingTypes: $testingTypes, qaMetrics: $qaMetrics, starNarrative: $starNarrative, testimonial: $testimonial, mainUrl: $mainUrl, links: $links, orderIndex: $orderIndex, isPublished: $isPublished, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ProjectModelCopyWith<$Res>  {
  factory $ProjectModelCopyWith(ProjectModel value, $Res Function(ProjectModel) _then) = _$ProjectModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? subtitle, String description, String role, String type, DateTime startDate, DateTime? endDate, String coverImage, List<String> galleryImages, List<String> technologies, List<String> testingTypes, Map<String, dynamic>? qaMetrics, Map<String, dynamic>? starNarrative, Map<String, dynamic>? testimonial, String? mainUrl, Map<String, String> links, int orderIndex, bool isPublished, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$ProjectModelCopyWithImpl<$Res>
    implements $ProjectModelCopyWith<$Res> {
  _$ProjectModelCopyWithImpl(this._self, this._then);

  final ProjectModel _self;
  final $Res Function(ProjectModel) _then;

/// Create a copy of ProjectModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? subtitle = freezed,Object? description = null,Object? role = null,Object? type = null,Object? startDate = null,Object? endDate = freezed,Object? coverImage = null,Object? galleryImages = null,Object? technologies = null,Object? testingTypes = null,Object? qaMetrics = freezed,Object? starNarrative = freezed,Object? testimonial = freezed,Object? mainUrl = freezed,Object? links = null,Object? orderIndex = null,Object? isPublished = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,coverImage: null == coverImage ? _self.coverImage : coverImage // ignore: cast_nullable_to_non_nullable
as String,galleryImages: null == galleryImages ? _self.galleryImages : galleryImages // ignore: cast_nullable_to_non_nullable
as List<String>,technologies: null == technologies ? _self.technologies : technologies // ignore: cast_nullable_to_non_nullable
as List<String>,testingTypes: null == testingTypes ? _self.testingTypes : testingTypes // ignore: cast_nullable_to_non_nullable
as List<String>,qaMetrics: freezed == qaMetrics ? _self.qaMetrics : qaMetrics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,starNarrative: freezed == starNarrative ? _self.starNarrative : starNarrative // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,testimonial: freezed == testimonial ? _self.testimonial : testimonial // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,mainUrl: freezed == mainUrl ? _self.mainUrl : mainUrl // ignore: cast_nullable_to_non_nullable
as String?,links: null == links ? _self.links : links // ignore: cast_nullable_to_non_nullable
as Map<String, String>,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,isPublished: null == isPublished ? _self.isPublished : isPublished // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectModel].
extension ProjectModelPatterns on ProjectModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectModel value)  $default,){
final _that = this;
switch (_that) {
case _ProjectModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? subtitle,  String description,  String role,  String type,  DateTime startDate,  DateTime? endDate,  String coverImage,  List<String> galleryImages,  List<String> technologies,  List<String> testingTypes,  Map<String, dynamic>? qaMetrics,  Map<String, dynamic>? starNarrative,  Map<String, dynamic>? testimonial,  String? mainUrl,  Map<String, String> links,  int orderIndex,  bool isPublished,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectModel() when $default != null:
return $default(_that.id,_that.title,_that.subtitle,_that.description,_that.role,_that.type,_that.startDate,_that.endDate,_that.coverImage,_that.galleryImages,_that.technologies,_that.testingTypes,_that.qaMetrics,_that.starNarrative,_that.testimonial,_that.mainUrl,_that.links,_that.orderIndex,_that.isPublished,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? subtitle,  String description,  String role,  String type,  DateTime startDate,  DateTime? endDate,  String coverImage,  List<String> galleryImages,  List<String> technologies,  List<String> testingTypes,  Map<String, dynamic>? qaMetrics,  Map<String, dynamic>? starNarrative,  Map<String, dynamic>? testimonial,  String? mainUrl,  Map<String, String> links,  int orderIndex,  bool isPublished,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ProjectModel():
return $default(_that.id,_that.title,_that.subtitle,_that.description,_that.role,_that.type,_that.startDate,_that.endDate,_that.coverImage,_that.galleryImages,_that.technologies,_that.testingTypes,_that.qaMetrics,_that.starNarrative,_that.testimonial,_that.mainUrl,_that.links,_that.orderIndex,_that.isPublished,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? subtitle,  String description,  String role,  String type,  DateTime startDate,  DateTime? endDate,  String coverImage,  List<String> galleryImages,  List<String> technologies,  List<String> testingTypes,  Map<String, dynamic>? qaMetrics,  Map<String, dynamic>? starNarrative,  Map<String, dynamic>? testimonial,  String? mainUrl,  Map<String, String> links,  int orderIndex,  bool isPublished,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ProjectModel() when $default != null:
return $default(_that.id,_that.title,_that.subtitle,_that.description,_that.role,_that.type,_that.startDate,_that.endDate,_that.coverImage,_that.galleryImages,_that.technologies,_that.testingTypes,_that.qaMetrics,_that.starNarrative,_that.testimonial,_that.mainUrl,_that.links,_that.orderIndex,_that.isPublished,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProjectModel extends ProjectModel {
  const _ProjectModel({required this.id, required this.title, this.subtitle, required this.description, required this.role, required this.type, required this.startDate, this.endDate, required this.coverImage, final  List<String> galleryImages = const [], required final  List<String> technologies, final  List<String> testingTypes = const [], final  Map<String, dynamic>? qaMetrics, final  Map<String, dynamic>? starNarrative, final  Map<String, dynamic>? testimonial, this.mainUrl, final  Map<String, String> links = const {}, required this.orderIndex, this.isPublished = true, required this.createdAt, required this.updatedAt}): _galleryImages = galleryImages,_technologies = technologies,_testingTypes = testingTypes,_qaMetrics = qaMetrics,_starNarrative = starNarrative,_testimonial = testimonial,_links = links,super._();
  factory _ProjectModel.fromJson(Map<String, dynamic> json) => _$ProjectModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? subtitle;
@override final  String description;
@override final  String role;
@override final  String type;
// Stored as string in Firestore
@override final  DateTime startDate;
@override final  DateTime? endDate;
@override final  String coverImage;
 final  List<String> _galleryImages;
@override@JsonKey() List<String> get galleryImages {
  if (_galleryImages is EqualUnmodifiableListView) return _galleryImages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_galleryImages);
}

 final  List<String> _technologies;
@override List<String> get technologies {
  if (_technologies is EqualUnmodifiableListView) return _technologies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_technologies);
}

 final  List<String> _testingTypes;
@override@JsonKey() List<String> get testingTypes {
  if (_testingTypes is EqualUnmodifiableListView) return _testingTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_testingTypes);
}

 final  Map<String, dynamic>? _qaMetrics;
@override Map<String, dynamic>? get qaMetrics {
  final value = _qaMetrics;
  if (value == null) return null;
  if (_qaMetrics is EqualUnmodifiableMapView) return _qaMetrics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _starNarrative;
@override Map<String, dynamic>? get starNarrative {
  final value = _starNarrative;
  if (value == null) return null;
  if (_starNarrative is EqualUnmodifiableMapView) return _starNarrative;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic>? _testimonial;
@override Map<String, dynamic>? get testimonial {
  final value = _testimonial;
  if (value == null) return null;
  if (_testimonial is EqualUnmodifiableMapView) return _testimonial;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? mainUrl;
 final  Map<String, String> _links;
@override@JsonKey() Map<String, String> get links {
  if (_links is EqualUnmodifiableMapView) return _links;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_links);
}

@override final  int orderIndex;
@override@JsonKey() final  bool isPublished;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of ProjectModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectModelCopyWith<_ProjectModel> get copyWith => __$ProjectModelCopyWithImpl<_ProjectModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.description, description) || other.description == description)&&(identical(other.role, role) || other.role == role)&&(identical(other.type, type) || other.type == type)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.coverImage, coverImage) || other.coverImage == coverImage)&&const DeepCollectionEquality().equals(other._galleryImages, _galleryImages)&&const DeepCollectionEquality().equals(other._technologies, _technologies)&&const DeepCollectionEquality().equals(other._testingTypes, _testingTypes)&&const DeepCollectionEquality().equals(other._qaMetrics, _qaMetrics)&&const DeepCollectionEquality().equals(other._starNarrative, _starNarrative)&&const DeepCollectionEquality().equals(other._testimonial, _testimonial)&&(identical(other.mainUrl, mainUrl) || other.mainUrl == mainUrl)&&const DeepCollectionEquality().equals(other._links, _links)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&(identical(other.isPublished, isPublished) || other.isPublished == isPublished)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,subtitle,description,role,type,startDate,endDate,coverImage,const DeepCollectionEquality().hash(_galleryImages),const DeepCollectionEquality().hash(_technologies),const DeepCollectionEquality().hash(_testingTypes),const DeepCollectionEquality().hash(_qaMetrics),const DeepCollectionEquality().hash(_starNarrative),const DeepCollectionEquality().hash(_testimonial),mainUrl,const DeepCollectionEquality().hash(_links),orderIndex,isPublished,createdAt,updatedAt]);

@override
String toString() {
  return 'ProjectModel(id: $id, title: $title, subtitle: $subtitle, description: $description, role: $role, type: $type, startDate: $startDate, endDate: $endDate, coverImage: $coverImage, galleryImages: $galleryImages, technologies: $technologies, testingTypes: $testingTypes, qaMetrics: $qaMetrics, starNarrative: $starNarrative, testimonial: $testimonial, mainUrl: $mainUrl, links: $links, orderIndex: $orderIndex, isPublished: $isPublished, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ProjectModelCopyWith<$Res> implements $ProjectModelCopyWith<$Res> {
  factory _$ProjectModelCopyWith(_ProjectModel value, $Res Function(_ProjectModel) _then) = __$ProjectModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? subtitle, String description, String role, String type, DateTime startDate, DateTime? endDate, String coverImage, List<String> galleryImages, List<String> technologies, List<String> testingTypes, Map<String, dynamic>? qaMetrics, Map<String, dynamic>? starNarrative, Map<String, dynamic>? testimonial, String? mainUrl, Map<String, String> links, int orderIndex, bool isPublished, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$ProjectModelCopyWithImpl<$Res>
    implements _$ProjectModelCopyWith<$Res> {
  __$ProjectModelCopyWithImpl(this._self, this._then);

  final _ProjectModel _self;
  final $Res Function(_ProjectModel) _then;

/// Create a copy of ProjectModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? subtitle = freezed,Object? description = null,Object? role = null,Object? type = null,Object? startDate = null,Object? endDate = freezed,Object? coverImage = null,Object? galleryImages = null,Object? technologies = null,Object? testingTypes = null,Object? qaMetrics = freezed,Object? starNarrative = freezed,Object? testimonial = freezed,Object? mainUrl = freezed,Object? links = null,Object? orderIndex = null,Object? isPublished = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_ProjectModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,coverImage: null == coverImage ? _self.coverImage : coverImage // ignore: cast_nullable_to_non_nullable
as String,galleryImages: null == galleryImages ? _self._galleryImages : galleryImages // ignore: cast_nullable_to_non_nullable
as List<String>,technologies: null == technologies ? _self._technologies : technologies // ignore: cast_nullable_to_non_nullable
as List<String>,testingTypes: null == testingTypes ? _self._testingTypes : testingTypes // ignore: cast_nullable_to_non_nullable
as List<String>,qaMetrics: freezed == qaMetrics ? _self._qaMetrics : qaMetrics // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,starNarrative: freezed == starNarrative ? _self._starNarrative : starNarrative // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,testimonial: freezed == testimonial ? _self._testimonial : testimonial // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,mainUrl: freezed == mainUrl ? _self.mainUrl : mainUrl // ignore: cast_nullable_to_non_nullable
as String?,links: null == links ? _self._links : links // ignore: cast_nullable_to_non_nullable
as Map<String, String>,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,isPublished: null == isPublished ? _self.isPublished : isPublished // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
