// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Item {

 String get id; String get ownerId;// Identity
 String get itemType; String? get country; String? get issuingAuthority; String? get denomination; double? get denominationNumeric; int? get yearStart; int? get yearEnd; String? get mintMark; String? get series; String? get variety; bool get isPublic;// Physical — coins
 String? get metal; double? get weightGrams; double? get diameterMm; String? get edgeType; String? get coinOrientation;// Physical — notes
 double? get noteWidthMm; double? get noteHeightMm;// Coin-specific
 String? get obverseDescription; String? get reverseDescription; String? get edgeDescription; String? get dieMarkers;// Note-specific
 String? get serialNumber; String? get serialBlock; String? get signatureCombination; String? get sealColor; String? get district; String? get plateNumberFront; String? get plateNumberBack; bool get isStarNote;// Condition
 String? get grade; double? get gradeNumeric; String? get gradingCompany; String? get certNumber; bool get isSlabbed; bool get detailsGrade; String? get detailsNote; List<String> get defects;// Certification
 String? get designation; String? get holderGeneration; int? get populationObverse; int? get populationReverse; String? get certVerificationUrl; String get submissionStatus;// Quantity
 String get quantityType; int get quantity; int get duplicateCount;// Notes
 String? get historicalContext; String? get attributionNotes; String? get provenance; List<String> get researchLinks; String? get internalNotes;// Timestamps
 DateTime? get createdAt; DateTime? get updatedAt;// Related data (loaded separately)
 List<CatalogReference> get catalogReferences; List<ItemImage> get images;
/// Create a copy of Item
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ItemCopyWith<Item> get copyWith => _$ItemCopyWithImpl<Item>(this as Item, _$identity);

  /// Serializes this Item to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Item&&(identical(other.id, id) || other.id == id)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.itemType, itemType) || other.itemType == itemType)&&(identical(other.country, country) || other.country == country)&&(identical(other.issuingAuthority, issuingAuthority) || other.issuingAuthority == issuingAuthority)&&(identical(other.denomination, denomination) || other.denomination == denomination)&&(identical(other.denominationNumeric, denominationNumeric) || other.denominationNumeric == denominationNumeric)&&(identical(other.yearStart, yearStart) || other.yearStart == yearStart)&&(identical(other.yearEnd, yearEnd) || other.yearEnd == yearEnd)&&(identical(other.mintMark, mintMark) || other.mintMark == mintMark)&&(identical(other.series, series) || other.series == series)&&(identical(other.variety, variety) || other.variety == variety)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.metal, metal) || other.metal == metal)&&(identical(other.weightGrams, weightGrams) || other.weightGrams == weightGrams)&&(identical(other.diameterMm, diameterMm) || other.diameterMm == diameterMm)&&(identical(other.edgeType, edgeType) || other.edgeType == edgeType)&&(identical(other.coinOrientation, coinOrientation) || other.coinOrientation == coinOrientation)&&(identical(other.noteWidthMm, noteWidthMm) || other.noteWidthMm == noteWidthMm)&&(identical(other.noteHeightMm, noteHeightMm) || other.noteHeightMm == noteHeightMm)&&(identical(other.obverseDescription, obverseDescription) || other.obverseDescription == obverseDescription)&&(identical(other.reverseDescription, reverseDescription) || other.reverseDescription == reverseDescription)&&(identical(other.edgeDescription, edgeDescription) || other.edgeDescription == edgeDescription)&&(identical(other.dieMarkers, dieMarkers) || other.dieMarkers == dieMarkers)&&(identical(other.serialNumber, serialNumber) || other.serialNumber == serialNumber)&&(identical(other.serialBlock, serialBlock) || other.serialBlock == serialBlock)&&(identical(other.signatureCombination, signatureCombination) || other.signatureCombination == signatureCombination)&&(identical(other.sealColor, sealColor) || other.sealColor == sealColor)&&(identical(other.district, district) || other.district == district)&&(identical(other.plateNumberFront, plateNumberFront) || other.plateNumberFront == plateNumberFront)&&(identical(other.plateNumberBack, plateNumberBack) || other.plateNumberBack == plateNumberBack)&&(identical(other.isStarNote, isStarNote) || other.isStarNote == isStarNote)&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.gradeNumeric, gradeNumeric) || other.gradeNumeric == gradeNumeric)&&(identical(other.gradingCompany, gradingCompany) || other.gradingCompany == gradingCompany)&&(identical(other.certNumber, certNumber) || other.certNumber == certNumber)&&(identical(other.isSlabbed, isSlabbed) || other.isSlabbed == isSlabbed)&&(identical(other.detailsGrade, detailsGrade) || other.detailsGrade == detailsGrade)&&(identical(other.detailsNote, detailsNote) || other.detailsNote == detailsNote)&&const DeepCollectionEquality().equals(other.defects, defects)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.holderGeneration, holderGeneration) || other.holderGeneration == holderGeneration)&&(identical(other.populationObverse, populationObverse) || other.populationObverse == populationObverse)&&(identical(other.populationReverse, populationReverse) || other.populationReverse == populationReverse)&&(identical(other.certVerificationUrl, certVerificationUrl) || other.certVerificationUrl == certVerificationUrl)&&(identical(other.submissionStatus, submissionStatus) || other.submissionStatus == submissionStatus)&&(identical(other.quantityType, quantityType) || other.quantityType == quantityType)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.duplicateCount, duplicateCount) || other.duplicateCount == duplicateCount)&&(identical(other.historicalContext, historicalContext) || other.historicalContext == historicalContext)&&(identical(other.attributionNotes, attributionNotes) || other.attributionNotes == attributionNotes)&&(identical(other.provenance, provenance) || other.provenance == provenance)&&const DeepCollectionEquality().equals(other.researchLinks, researchLinks)&&(identical(other.internalNotes, internalNotes) || other.internalNotes == internalNotes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.catalogReferences, catalogReferences)&&const DeepCollectionEquality().equals(other.images, images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,ownerId,itemType,country,issuingAuthority,denomination,denominationNumeric,yearStart,yearEnd,mintMark,series,variety,isPublic,metal,weightGrams,diameterMm,edgeType,coinOrientation,noteWidthMm,noteHeightMm,obverseDescription,reverseDescription,edgeDescription,dieMarkers,serialNumber,serialBlock,signatureCombination,sealColor,district,plateNumberFront,plateNumberBack,isStarNote,grade,gradeNumeric,gradingCompany,certNumber,isSlabbed,detailsGrade,detailsNote,const DeepCollectionEquality().hash(defects),designation,holderGeneration,populationObverse,populationReverse,certVerificationUrl,submissionStatus,quantityType,quantity,duplicateCount,historicalContext,attributionNotes,provenance,const DeepCollectionEquality().hash(researchLinks),internalNotes,createdAt,updatedAt,const DeepCollectionEquality().hash(catalogReferences),const DeepCollectionEquality().hash(images)]);

@override
String toString() {
  return 'Item(id: $id, ownerId: $ownerId, itemType: $itemType, country: $country, issuingAuthority: $issuingAuthority, denomination: $denomination, denominationNumeric: $denominationNumeric, yearStart: $yearStart, yearEnd: $yearEnd, mintMark: $mintMark, series: $series, variety: $variety, isPublic: $isPublic, metal: $metal, weightGrams: $weightGrams, diameterMm: $diameterMm, edgeType: $edgeType, coinOrientation: $coinOrientation, noteWidthMm: $noteWidthMm, noteHeightMm: $noteHeightMm, obverseDescription: $obverseDescription, reverseDescription: $reverseDescription, edgeDescription: $edgeDescription, dieMarkers: $dieMarkers, serialNumber: $serialNumber, serialBlock: $serialBlock, signatureCombination: $signatureCombination, sealColor: $sealColor, district: $district, plateNumberFront: $plateNumberFront, plateNumberBack: $plateNumberBack, isStarNote: $isStarNote, grade: $grade, gradeNumeric: $gradeNumeric, gradingCompany: $gradingCompany, certNumber: $certNumber, isSlabbed: $isSlabbed, detailsGrade: $detailsGrade, detailsNote: $detailsNote, defects: $defects, designation: $designation, holderGeneration: $holderGeneration, populationObverse: $populationObverse, populationReverse: $populationReverse, certVerificationUrl: $certVerificationUrl, submissionStatus: $submissionStatus, quantityType: $quantityType, quantity: $quantity, duplicateCount: $duplicateCount, historicalContext: $historicalContext, attributionNotes: $attributionNotes, provenance: $provenance, researchLinks: $researchLinks, internalNotes: $internalNotes, createdAt: $createdAt, updatedAt: $updatedAt, catalogReferences: $catalogReferences, images: $images)';
}


}

/// @nodoc
abstract mixin class $ItemCopyWith<$Res>  {
  factory $ItemCopyWith(Item value, $Res Function(Item) _then) = _$ItemCopyWithImpl;
@useResult
$Res call({
 String id, String ownerId, String itemType, String? country, String? issuingAuthority, String? denomination, double? denominationNumeric, int? yearStart, int? yearEnd, String? mintMark, String? series, String? variety, bool isPublic, String? metal, double? weightGrams, double? diameterMm, String? edgeType, String? coinOrientation, double? noteWidthMm, double? noteHeightMm, String? obverseDescription, String? reverseDescription, String? edgeDescription, String? dieMarkers, String? serialNumber, String? serialBlock, String? signatureCombination, String? sealColor, String? district, String? plateNumberFront, String? plateNumberBack, bool isStarNote, String? grade, double? gradeNumeric, String? gradingCompany, String? certNumber, bool isSlabbed, bool detailsGrade, String? detailsNote, List<String> defects, String? designation, String? holderGeneration, int? populationObverse, int? populationReverse, String? certVerificationUrl, String submissionStatus, String quantityType, int quantity, int duplicateCount, String? historicalContext, String? attributionNotes, String? provenance, List<String> researchLinks, String? internalNotes, DateTime? createdAt, DateTime? updatedAt, List<CatalogReference> catalogReferences, List<ItemImage> images
});




}
/// @nodoc
class _$ItemCopyWithImpl<$Res>
    implements $ItemCopyWith<$Res> {
  _$ItemCopyWithImpl(this._self, this._then);

  final Item _self;
  final $Res Function(Item) _then;

/// Create a copy of Item
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ownerId = null,Object? itemType = null,Object? country = freezed,Object? issuingAuthority = freezed,Object? denomination = freezed,Object? denominationNumeric = freezed,Object? yearStart = freezed,Object? yearEnd = freezed,Object? mintMark = freezed,Object? series = freezed,Object? variety = freezed,Object? isPublic = null,Object? metal = freezed,Object? weightGrams = freezed,Object? diameterMm = freezed,Object? edgeType = freezed,Object? coinOrientation = freezed,Object? noteWidthMm = freezed,Object? noteHeightMm = freezed,Object? obverseDescription = freezed,Object? reverseDescription = freezed,Object? edgeDescription = freezed,Object? dieMarkers = freezed,Object? serialNumber = freezed,Object? serialBlock = freezed,Object? signatureCombination = freezed,Object? sealColor = freezed,Object? district = freezed,Object? plateNumberFront = freezed,Object? plateNumberBack = freezed,Object? isStarNote = null,Object? grade = freezed,Object? gradeNumeric = freezed,Object? gradingCompany = freezed,Object? certNumber = freezed,Object? isSlabbed = null,Object? detailsGrade = null,Object? detailsNote = freezed,Object? defects = null,Object? designation = freezed,Object? holderGeneration = freezed,Object? populationObverse = freezed,Object? populationReverse = freezed,Object? certVerificationUrl = freezed,Object? submissionStatus = null,Object? quantityType = null,Object? quantity = null,Object? duplicateCount = null,Object? historicalContext = freezed,Object? attributionNotes = freezed,Object? provenance = freezed,Object? researchLinks = null,Object? internalNotes = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? catalogReferences = null,Object? images = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,itemType: null == itemType ? _self.itemType : itemType // ignore: cast_nullable_to_non_nullable
as String,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,issuingAuthority: freezed == issuingAuthority ? _self.issuingAuthority : issuingAuthority // ignore: cast_nullable_to_non_nullable
as String?,denomination: freezed == denomination ? _self.denomination : denomination // ignore: cast_nullable_to_non_nullable
as String?,denominationNumeric: freezed == denominationNumeric ? _self.denominationNumeric : denominationNumeric // ignore: cast_nullable_to_non_nullable
as double?,yearStart: freezed == yearStart ? _self.yearStart : yearStart // ignore: cast_nullable_to_non_nullable
as int?,yearEnd: freezed == yearEnd ? _self.yearEnd : yearEnd // ignore: cast_nullable_to_non_nullable
as int?,mintMark: freezed == mintMark ? _self.mintMark : mintMark // ignore: cast_nullable_to_non_nullable
as String?,series: freezed == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String?,variety: freezed == variety ? _self.variety : variety // ignore: cast_nullable_to_non_nullable
as String?,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,metal: freezed == metal ? _self.metal : metal // ignore: cast_nullable_to_non_nullable
as String?,weightGrams: freezed == weightGrams ? _self.weightGrams : weightGrams // ignore: cast_nullable_to_non_nullable
as double?,diameterMm: freezed == diameterMm ? _self.diameterMm : diameterMm // ignore: cast_nullable_to_non_nullable
as double?,edgeType: freezed == edgeType ? _self.edgeType : edgeType // ignore: cast_nullable_to_non_nullable
as String?,coinOrientation: freezed == coinOrientation ? _self.coinOrientation : coinOrientation // ignore: cast_nullable_to_non_nullable
as String?,noteWidthMm: freezed == noteWidthMm ? _self.noteWidthMm : noteWidthMm // ignore: cast_nullable_to_non_nullable
as double?,noteHeightMm: freezed == noteHeightMm ? _self.noteHeightMm : noteHeightMm // ignore: cast_nullable_to_non_nullable
as double?,obverseDescription: freezed == obverseDescription ? _self.obverseDescription : obverseDescription // ignore: cast_nullable_to_non_nullable
as String?,reverseDescription: freezed == reverseDescription ? _self.reverseDescription : reverseDescription // ignore: cast_nullable_to_non_nullable
as String?,edgeDescription: freezed == edgeDescription ? _self.edgeDescription : edgeDescription // ignore: cast_nullable_to_non_nullable
as String?,dieMarkers: freezed == dieMarkers ? _self.dieMarkers : dieMarkers // ignore: cast_nullable_to_non_nullable
as String?,serialNumber: freezed == serialNumber ? _self.serialNumber : serialNumber // ignore: cast_nullable_to_non_nullable
as String?,serialBlock: freezed == serialBlock ? _self.serialBlock : serialBlock // ignore: cast_nullable_to_non_nullable
as String?,signatureCombination: freezed == signatureCombination ? _self.signatureCombination : signatureCombination // ignore: cast_nullable_to_non_nullable
as String?,sealColor: freezed == sealColor ? _self.sealColor : sealColor // ignore: cast_nullable_to_non_nullable
as String?,district: freezed == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String?,plateNumberFront: freezed == plateNumberFront ? _self.plateNumberFront : plateNumberFront // ignore: cast_nullable_to_non_nullable
as String?,plateNumberBack: freezed == plateNumberBack ? _self.plateNumberBack : plateNumberBack // ignore: cast_nullable_to_non_nullable
as String?,isStarNote: null == isStarNote ? _self.isStarNote : isStarNote // ignore: cast_nullable_to_non_nullable
as bool,grade: freezed == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as String?,gradeNumeric: freezed == gradeNumeric ? _self.gradeNumeric : gradeNumeric // ignore: cast_nullable_to_non_nullable
as double?,gradingCompany: freezed == gradingCompany ? _self.gradingCompany : gradingCompany // ignore: cast_nullable_to_non_nullable
as String?,certNumber: freezed == certNumber ? _self.certNumber : certNumber // ignore: cast_nullable_to_non_nullable
as String?,isSlabbed: null == isSlabbed ? _self.isSlabbed : isSlabbed // ignore: cast_nullable_to_non_nullable
as bool,detailsGrade: null == detailsGrade ? _self.detailsGrade : detailsGrade // ignore: cast_nullable_to_non_nullable
as bool,detailsNote: freezed == detailsNote ? _self.detailsNote : detailsNote // ignore: cast_nullable_to_non_nullable
as String?,defects: null == defects ? _self.defects : defects // ignore: cast_nullable_to_non_nullable
as List<String>,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,holderGeneration: freezed == holderGeneration ? _self.holderGeneration : holderGeneration // ignore: cast_nullable_to_non_nullable
as String?,populationObverse: freezed == populationObverse ? _self.populationObverse : populationObverse // ignore: cast_nullable_to_non_nullable
as int?,populationReverse: freezed == populationReverse ? _self.populationReverse : populationReverse // ignore: cast_nullable_to_non_nullable
as int?,certVerificationUrl: freezed == certVerificationUrl ? _self.certVerificationUrl : certVerificationUrl // ignore: cast_nullable_to_non_nullable
as String?,submissionStatus: null == submissionStatus ? _self.submissionStatus : submissionStatus // ignore: cast_nullable_to_non_nullable
as String,quantityType: null == quantityType ? _self.quantityType : quantityType // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,duplicateCount: null == duplicateCount ? _self.duplicateCount : duplicateCount // ignore: cast_nullable_to_non_nullable
as int,historicalContext: freezed == historicalContext ? _self.historicalContext : historicalContext // ignore: cast_nullable_to_non_nullable
as String?,attributionNotes: freezed == attributionNotes ? _self.attributionNotes : attributionNotes // ignore: cast_nullable_to_non_nullable
as String?,provenance: freezed == provenance ? _self.provenance : provenance // ignore: cast_nullable_to_non_nullable
as String?,researchLinks: null == researchLinks ? _self.researchLinks : researchLinks // ignore: cast_nullable_to_non_nullable
as List<String>,internalNotes: freezed == internalNotes ? _self.internalNotes : internalNotes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,catalogReferences: null == catalogReferences ? _self.catalogReferences : catalogReferences // ignore: cast_nullable_to_non_nullable
as List<CatalogReference>,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<ItemImage>,
  ));
}

}


/// Adds pattern-matching-related methods to [Item].
extension ItemPatterns on Item {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Item value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Item() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Item value)  $default,){
final _that = this;
switch (_that) {
case _Item():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Item value)?  $default,){
final _that = this;
switch (_that) {
case _Item() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String ownerId,  String itemType,  String? country,  String? issuingAuthority,  String? denomination,  double? denominationNumeric,  int? yearStart,  int? yearEnd,  String? mintMark,  String? series,  String? variety,  bool isPublic,  String? metal,  double? weightGrams,  double? diameterMm,  String? edgeType,  String? coinOrientation,  double? noteWidthMm,  double? noteHeightMm,  String? obverseDescription,  String? reverseDescription,  String? edgeDescription,  String? dieMarkers,  String? serialNumber,  String? serialBlock,  String? signatureCombination,  String? sealColor,  String? district,  String? plateNumberFront,  String? plateNumberBack,  bool isStarNote,  String? grade,  double? gradeNumeric,  String? gradingCompany,  String? certNumber,  bool isSlabbed,  bool detailsGrade,  String? detailsNote,  List<String> defects,  String? designation,  String? holderGeneration,  int? populationObverse,  int? populationReverse,  String? certVerificationUrl,  String submissionStatus,  String quantityType,  int quantity,  int duplicateCount,  String? historicalContext,  String? attributionNotes,  String? provenance,  List<String> researchLinks,  String? internalNotes,  DateTime? createdAt,  DateTime? updatedAt,  List<CatalogReference> catalogReferences,  List<ItemImage> images)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Item() when $default != null:
return $default(_that.id,_that.ownerId,_that.itemType,_that.country,_that.issuingAuthority,_that.denomination,_that.denominationNumeric,_that.yearStart,_that.yearEnd,_that.mintMark,_that.series,_that.variety,_that.isPublic,_that.metal,_that.weightGrams,_that.diameterMm,_that.edgeType,_that.coinOrientation,_that.noteWidthMm,_that.noteHeightMm,_that.obverseDescription,_that.reverseDescription,_that.edgeDescription,_that.dieMarkers,_that.serialNumber,_that.serialBlock,_that.signatureCombination,_that.sealColor,_that.district,_that.plateNumberFront,_that.plateNumberBack,_that.isStarNote,_that.grade,_that.gradeNumeric,_that.gradingCompany,_that.certNumber,_that.isSlabbed,_that.detailsGrade,_that.detailsNote,_that.defects,_that.designation,_that.holderGeneration,_that.populationObverse,_that.populationReverse,_that.certVerificationUrl,_that.submissionStatus,_that.quantityType,_that.quantity,_that.duplicateCount,_that.historicalContext,_that.attributionNotes,_that.provenance,_that.researchLinks,_that.internalNotes,_that.createdAt,_that.updatedAt,_that.catalogReferences,_that.images);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String ownerId,  String itemType,  String? country,  String? issuingAuthority,  String? denomination,  double? denominationNumeric,  int? yearStart,  int? yearEnd,  String? mintMark,  String? series,  String? variety,  bool isPublic,  String? metal,  double? weightGrams,  double? diameterMm,  String? edgeType,  String? coinOrientation,  double? noteWidthMm,  double? noteHeightMm,  String? obverseDescription,  String? reverseDescription,  String? edgeDescription,  String? dieMarkers,  String? serialNumber,  String? serialBlock,  String? signatureCombination,  String? sealColor,  String? district,  String? plateNumberFront,  String? plateNumberBack,  bool isStarNote,  String? grade,  double? gradeNumeric,  String? gradingCompany,  String? certNumber,  bool isSlabbed,  bool detailsGrade,  String? detailsNote,  List<String> defects,  String? designation,  String? holderGeneration,  int? populationObverse,  int? populationReverse,  String? certVerificationUrl,  String submissionStatus,  String quantityType,  int quantity,  int duplicateCount,  String? historicalContext,  String? attributionNotes,  String? provenance,  List<String> researchLinks,  String? internalNotes,  DateTime? createdAt,  DateTime? updatedAt,  List<CatalogReference> catalogReferences,  List<ItemImage> images)  $default,) {final _that = this;
switch (_that) {
case _Item():
return $default(_that.id,_that.ownerId,_that.itemType,_that.country,_that.issuingAuthority,_that.denomination,_that.denominationNumeric,_that.yearStart,_that.yearEnd,_that.mintMark,_that.series,_that.variety,_that.isPublic,_that.metal,_that.weightGrams,_that.diameterMm,_that.edgeType,_that.coinOrientation,_that.noteWidthMm,_that.noteHeightMm,_that.obverseDescription,_that.reverseDescription,_that.edgeDescription,_that.dieMarkers,_that.serialNumber,_that.serialBlock,_that.signatureCombination,_that.sealColor,_that.district,_that.plateNumberFront,_that.plateNumberBack,_that.isStarNote,_that.grade,_that.gradeNumeric,_that.gradingCompany,_that.certNumber,_that.isSlabbed,_that.detailsGrade,_that.detailsNote,_that.defects,_that.designation,_that.holderGeneration,_that.populationObverse,_that.populationReverse,_that.certVerificationUrl,_that.submissionStatus,_that.quantityType,_that.quantity,_that.duplicateCount,_that.historicalContext,_that.attributionNotes,_that.provenance,_that.researchLinks,_that.internalNotes,_that.createdAt,_that.updatedAt,_that.catalogReferences,_that.images);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String ownerId,  String itemType,  String? country,  String? issuingAuthority,  String? denomination,  double? denominationNumeric,  int? yearStart,  int? yearEnd,  String? mintMark,  String? series,  String? variety,  bool isPublic,  String? metal,  double? weightGrams,  double? diameterMm,  String? edgeType,  String? coinOrientation,  double? noteWidthMm,  double? noteHeightMm,  String? obverseDescription,  String? reverseDescription,  String? edgeDescription,  String? dieMarkers,  String? serialNumber,  String? serialBlock,  String? signatureCombination,  String? sealColor,  String? district,  String? plateNumberFront,  String? plateNumberBack,  bool isStarNote,  String? grade,  double? gradeNumeric,  String? gradingCompany,  String? certNumber,  bool isSlabbed,  bool detailsGrade,  String? detailsNote,  List<String> defects,  String? designation,  String? holderGeneration,  int? populationObverse,  int? populationReverse,  String? certVerificationUrl,  String submissionStatus,  String quantityType,  int quantity,  int duplicateCount,  String? historicalContext,  String? attributionNotes,  String? provenance,  List<String> researchLinks,  String? internalNotes,  DateTime? createdAt,  DateTime? updatedAt,  List<CatalogReference> catalogReferences,  List<ItemImage> images)?  $default,) {final _that = this;
switch (_that) {
case _Item() when $default != null:
return $default(_that.id,_that.ownerId,_that.itemType,_that.country,_that.issuingAuthority,_that.denomination,_that.denominationNumeric,_that.yearStart,_that.yearEnd,_that.mintMark,_that.series,_that.variety,_that.isPublic,_that.metal,_that.weightGrams,_that.diameterMm,_that.edgeType,_that.coinOrientation,_that.noteWidthMm,_that.noteHeightMm,_that.obverseDescription,_that.reverseDescription,_that.edgeDescription,_that.dieMarkers,_that.serialNumber,_that.serialBlock,_that.signatureCombination,_that.sealColor,_that.district,_that.plateNumberFront,_that.plateNumberBack,_that.isStarNote,_that.grade,_that.gradeNumeric,_that.gradingCompany,_that.certNumber,_that.isSlabbed,_that.detailsGrade,_that.detailsNote,_that.defects,_that.designation,_that.holderGeneration,_that.populationObverse,_that.populationReverse,_that.certVerificationUrl,_that.submissionStatus,_that.quantityType,_that.quantity,_that.duplicateCount,_that.historicalContext,_that.attributionNotes,_that.provenance,_that.researchLinks,_that.internalNotes,_that.createdAt,_that.updatedAt,_that.catalogReferences,_that.images);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Item implements Item {
  const _Item({required this.id, required this.ownerId, this.itemType = 'coin', this.country, this.issuingAuthority, this.denomination, this.denominationNumeric, this.yearStart, this.yearEnd, this.mintMark, this.series, this.variety, this.isPublic = false, this.metal, this.weightGrams, this.diameterMm, this.edgeType, this.coinOrientation, this.noteWidthMm, this.noteHeightMm, this.obverseDescription, this.reverseDescription, this.edgeDescription, this.dieMarkers, this.serialNumber, this.serialBlock, this.signatureCombination, this.sealColor, this.district, this.plateNumberFront, this.plateNumberBack, this.isStarNote = false, this.grade, this.gradeNumeric, this.gradingCompany, this.certNumber, this.isSlabbed = false, this.detailsGrade = false, this.detailsNote, final  List<String> defects = const [], this.designation, this.holderGeneration, this.populationObverse, this.populationReverse, this.certVerificationUrl, this.submissionStatus = 'raw', this.quantityType = 'single', this.quantity = 1, this.duplicateCount = 0, this.historicalContext, this.attributionNotes, this.provenance, final  List<String> researchLinks = const [], this.internalNotes, this.createdAt, this.updatedAt, final  List<CatalogReference> catalogReferences = const [], final  List<ItemImage> images = const []}): _defects = defects,_researchLinks = researchLinks,_catalogReferences = catalogReferences,_images = images;
  factory _Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

@override final  String id;
@override final  String ownerId;
// Identity
@override@JsonKey() final  String itemType;
@override final  String? country;
@override final  String? issuingAuthority;
@override final  String? denomination;
@override final  double? denominationNumeric;
@override final  int? yearStart;
@override final  int? yearEnd;
@override final  String? mintMark;
@override final  String? series;
@override final  String? variety;
@override@JsonKey() final  bool isPublic;
// Physical — coins
@override final  String? metal;
@override final  double? weightGrams;
@override final  double? diameterMm;
@override final  String? edgeType;
@override final  String? coinOrientation;
// Physical — notes
@override final  double? noteWidthMm;
@override final  double? noteHeightMm;
// Coin-specific
@override final  String? obverseDescription;
@override final  String? reverseDescription;
@override final  String? edgeDescription;
@override final  String? dieMarkers;
// Note-specific
@override final  String? serialNumber;
@override final  String? serialBlock;
@override final  String? signatureCombination;
@override final  String? sealColor;
@override final  String? district;
@override final  String? plateNumberFront;
@override final  String? plateNumberBack;
@override@JsonKey() final  bool isStarNote;
// Condition
@override final  String? grade;
@override final  double? gradeNumeric;
@override final  String? gradingCompany;
@override final  String? certNumber;
@override@JsonKey() final  bool isSlabbed;
@override@JsonKey() final  bool detailsGrade;
@override final  String? detailsNote;
 final  List<String> _defects;
@override@JsonKey() List<String> get defects {
  if (_defects is EqualUnmodifiableListView) return _defects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_defects);
}

// Certification
@override final  String? designation;
@override final  String? holderGeneration;
@override final  int? populationObverse;
@override final  int? populationReverse;
@override final  String? certVerificationUrl;
@override@JsonKey() final  String submissionStatus;
// Quantity
@override@JsonKey() final  String quantityType;
@override@JsonKey() final  int quantity;
@override@JsonKey() final  int duplicateCount;
// Notes
@override final  String? historicalContext;
@override final  String? attributionNotes;
@override final  String? provenance;
 final  List<String> _researchLinks;
@override@JsonKey() List<String> get researchLinks {
  if (_researchLinks is EqualUnmodifiableListView) return _researchLinks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_researchLinks);
}

@override final  String? internalNotes;
// Timestamps
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
// Related data (loaded separately)
 final  List<CatalogReference> _catalogReferences;
// Related data (loaded separately)
@override@JsonKey() List<CatalogReference> get catalogReferences {
  if (_catalogReferences is EqualUnmodifiableListView) return _catalogReferences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_catalogReferences);
}

 final  List<ItemImage> _images;
@override@JsonKey() List<ItemImage> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}


/// Create a copy of Item
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ItemCopyWith<_Item> get copyWith => __$ItemCopyWithImpl<_Item>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Item&&(identical(other.id, id) || other.id == id)&&(identical(other.ownerId, ownerId) || other.ownerId == ownerId)&&(identical(other.itemType, itemType) || other.itemType == itemType)&&(identical(other.country, country) || other.country == country)&&(identical(other.issuingAuthority, issuingAuthority) || other.issuingAuthority == issuingAuthority)&&(identical(other.denomination, denomination) || other.denomination == denomination)&&(identical(other.denominationNumeric, denominationNumeric) || other.denominationNumeric == denominationNumeric)&&(identical(other.yearStart, yearStart) || other.yearStart == yearStart)&&(identical(other.yearEnd, yearEnd) || other.yearEnd == yearEnd)&&(identical(other.mintMark, mintMark) || other.mintMark == mintMark)&&(identical(other.series, series) || other.series == series)&&(identical(other.variety, variety) || other.variety == variety)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.metal, metal) || other.metal == metal)&&(identical(other.weightGrams, weightGrams) || other.weightGrams == weightGrams)&&(identical(other.diameterMm, diameterMm) || other.diameterMm == diameterMm)&&(identical(other.edgeType, edgeType) || other.edgeType == edgeType)&&(identical(other.coinOrientation, coinOrientation) || other.coinOrientation == coinOrientation)&&(identical(other.noteWidthMm, noteWidthMm) || other.noteWidthMm == noteWidthMm)&&(identical(other.noteHeightMm, noteHeightMm) || other.noteHeightMm == noteHeightMm)&&(identical(other.obverseDescription, obverseDescription) || other.obverseDescription == obverseDescription)&&(identical(other.reverseDescription, reverseDescription) || other.reverseDescription == reverseDescription)&&(identical(other.edgeDescription, edgeDescription) || other.edgeDescription == edgeDescription)&&(identical(other.dieMarkers, dieMarkers) || other.dieMarkers == dieMarkers)&&(identical(other.serialNumber, serialNumber) || other.serialNumber == serialNumber)&&(identical(other.serialBlock, serialBlock) || other.serialBlock == serialBlock)&&(identical(other.signatureCombination, signatureCombination) || other.signatureCombination == signatureCombination)&&(identical(other.sealColor, sealColor) || other.sealColor == sealColor)&&(identical(other.district, district) || other.district == district)&&(identical(other.plateNumberFront, plateNumberFront) || other.plateNumberFront == plateNumberFront)&&(identical(other.plateNumberBack, plateNumberBack) || other.plateNumberBack == plateNumberBack)&&(identical(other.isStarNote, isStarNote) || other.isStarNote == isStarNote)&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.gradeNumeric, gradeNumeric) || other.gradeNumeric == gradeNumeric)&&(identical(other.gradingCompany, gradingCompany) || other.gradingCompany == gradingCompany)&&(identical(other.certNumber, certNumber) || other.certNumber == certNumber)&&(identical(other.isSlabbed, isSlabbed) || other.isSlabbed == isSlabbed)&&(identical(other.detailsGrade, detailsGrade) || other.detailsGrade == detailsGrade)&&(identical(other.detailsNote, detailsNote) || other.detailsNote == detailsNote)&&const DeepCollectionEquality().equals(other._defects, _defects)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.holderGeneration, holderGeneration) || other.holderGeneration == holderGeneration)&&(identical(other.populationObverse, populationObverse) || other.populationObverse == populationObverse)&&(identical(other.populationReverse, populationReverse) || other.populationReverse == populationReverse)&&(identical(other.certVerificationUrl, certVerificationUrl) || other.certVerificationUrl == certVerificationUrl)&&(identical(other.submissionStatus, submissionStatus) || other.submissionStatus == submissionStatus)&&(identical(other.quantityType, quantityType) || other.quantityType == quantityType)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.duplicateCount, duplicateCount) || other.duplicateCount == duplicateCount)&&(identical(other.historicalContext, historicalContext) || other.historicalContext == historicalContext)&&(identical(other.attributionNotes, attributionNotes) || other.attributionNotes == attributionNotes)&&(identical(other.provenance, provenance) || other.provenance == provenance)&&const DeepCollectionEquality().equals(other._researchLinks, _researchLinks)&&(identical(other.internalNotes, internalNotes) || other.internalNotes == internalNotes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._catalogReferences, _catalogReferences)&&const DeepCollectionEquality().equals(other._images, _images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,ownerId,itemType,country,issuingAuthority,denomination,denominationNumeric,yearStart,yearEnd,mintMark,series,variety,isPublic,metal,weightGrams,diameterMm,edgeType,coinOrientation,noteWidthMm,noteHeightMm,obverseDescription,reverseDescription,edgeDescription,dieMarkers,serialNumber,serialBlock,signatureCombination,sealColor,district,plateNumberFront,plateNumberBack,isStarNote,grade,gradeNumeric,gradingCompany,certNumber,isSlabbed,detailsGrade,detailsNote,const DeepCollectionEquality().hash(_defects),designation,holderGeneration,populationObverse,populationReverse,certVerificationUrl,submissionStatus,quantityType,quantity,duplicateCount,historicalContext,attributionNotes,provenance,const DeepCollectionEquality().hash(_researchLinks),internalNotes,createdAt,updatedAt,const DeepCollectionEquality().hash(_catalogReferences),const DeepCollectionEquality().hash(_images)]);

@override
String toString() {
  return 'Item(id: $id, ownerId: $ownerId, itemType: $itemType, country: $country, issuingAuthority: $issuingAuthority, denomination: $denomination, denominationNumeric: $denominationNumeric, yearStart: $yearStart, yearEnd: $yearEnd, mintMark: $mintMark, series: $series, variety: $variety, isPublic: $isPublic, metal: $metal, weightGrams: $weightGrams, diameterMm: $diameterMm, edgeType: $edgeType, coinOrientation: $coinOrientation, noteWidthMm: $noteWidthMm, noteHeightMm: $noteHeightMm, obverseDescription: $obverseDescription, reverseDescription: $reverseDescription, edgeDescription: $edgeDescription, dieMarkers: $dieMarkers, serialNumber: $serialNumber, serialBlock: $serialBlock, signatureCombination: $signatureCombination, sealColor: $sealColor, district: $district, plateNumberFront: $plateNumberFront, plateNumberBack: $plateNumberBack, isStarNote: $isStarNote, grade: $grade, gradeNumeric: $gradeNumeric, gradingCompany: $gradingCompany, certNumber: $certNumber, isSlabbed: $isSlabbed, detailsGrade: $detailsGrade, detailsNote: $detailsNote, defects: $defects, designation: $designation, holderGeneration: $holderGeneration, populationObverse: $populationObverse, populationReverse: $populationReverse, certVerificationUrl: $certVerificationUrl, submissionStatus: $submissionStatus, quantityType: $quantityType, quantity: $quantity, duplicateCount: $duplicateCount, historicalContext: $historicalContext, attributionNotes: $attributionNotes, provenance: $provenance, researchLinks: $researchLinks, internalNotes: $internalNotes, createdAt: $createdAt, updatedAt: $updatedAt, catalogReferences: $catalogReferences, images: $images)';
}


}

/// @nodoc
abstract mixin class _$ItemCopyWith<$Res> implements $ItemCopyWith<$Res> {
  factory _$ItemCopyWith(_Item value, $Res Function(_Item) _then) = __$ItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String ownerId, String itemType, String? country, String? issuingAuthority, String? denomination, double? denominationNumeric, int? yearStart, int? yearEnd, String? mintMark, String? series, String? variety, bool isPublic, String? metal, double? weightGrams, double? diameterMm, String? edgeType, String? coinOrientation, double? noteWidthMm, double? noteHeightMm, String? obverseDescription, String? reverseDescription, String? edgeDescription, String? dieMarkers, String? serialNumber, String? serialBlock, String? signatureCombination, String? sealColor, String? district, String? plateNumberFront, String? plateNumberBack, bool isStarNote, String? grade, double? gradeNumeric, String? gradingCompany, String? certNumber, bool isSlabbed, bool detailsGrade, String? detailsNote, List<String> defects, String? designation, String? holderGeneration, int? populationObverse, int? populationReverse, String? certVerificationUrl, String submissionStatus, String quantityType, int quantity, int duplicateCount, String? historicalContext, String? attributionNotes, String? provenance, List<String> researchLinks, String? internalNotes, DateTime? createdAt, DateTime? updatedAt, List<CatalogReference> catalogReferences, List<ItemImage> images
});




}
/// @nodoc
class __$ItemCopyWithImpl<$Res>
    implements _$ItemCopyWith<$Res> {
  __$ItemCopyWithImpl(this._self, this._then);

  final _Item _self;
  final $Res Function(_Item) _then;

/// Create a copy of Item
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ownerId = null,Object? itemType = null,Object? country = freezed,Object? issuingAuthority = freezed,Object? denomination = freezed,Object? denominationNumeric = freezed,Object? yearStart = freezed,Object? yearEnd = freezed,Object? mintMark = freezed,Object? series = freezed,Object? variety = freezed,Object? isPublic = null,Object? metal = freezed,Object? weightGrams = freezed,Object? diameterMm = freezed,Object? edgeType = freezed,Object? coinOrientation = freezed,Object? noteWidthMm = freezed,Object? noteHeightMm = freezed,Object? obverseDescription = freezed,Object? reverseDescription = freezed,Object? edgeDescription = freezed,Object? dieMarkers = freezed,Object? serialNumber = freezed,Object? serialBlock = freezed,Object? signatureCombination = freezed,Object? sealColor = freezed,Object? district = freezed,Object? plateNumberFront = freezed,Object? plateNumberBack = freezed,Object? isStarNote = null,Object? grade = freezed,Object? gradeNumeric = freezed,Object? gradingCompany = freezed,Object? certNumber = freezed,Object? isSlabbed = null,Object? detailsGrade = null,Object? detailsNote = freezed,Object? defects = null,Object? designation = freezed,Object? holderGeneration = freezed,Object? populationObverse = freezed,Object? populationReverse = freezed,Object? certVerificationUrl = freezed,Object? submissionStatus = null,Object? quantityType = null,Object? quantity = null,Object? duplicateCount = null,Object? historicalContext = freezed,Object? attributionNotes = freezed,Object? provenance = freezed,Object? researchLinks = null,Object? internalNotes = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? catalogReferences = null,Object? images = null,}) {
  return _then(_Item(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ownerId: null == ownerId ? _self.ownerId : ownerId // ignore: cast_nullable_to_non_nullable
as String,itemType: null == itemType ? _self.itemType : itemType // ignore: cast_nullable_to_non_nullable
as String,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,issuingAuthority: freezed == issuingAuthority ? _self.issuingAuthority : issuingAuthority // ignore: cast_nullable_to_non_nullable
as String?,denomination: freezed == denomination ? _self.denomination : denomination // ignore: cast_nullable_to_non_nullable
as String?,denominationNumeric: freezed == denominationNumeric ? _self.denominationNumeric : denominationNumeric // ignore: cast_nullable_to_non_nullable
as double?,yearStart: freezed == yearStart ? _self.yearStart : yearStart // ignore: cast_nullable_to_non_nullable
as int?,yearEnd: freezed == yearEnd ? _self.yearEnd : yearEnd // ignore: cast_nullable_to_non_nullable
as int?,mintMark: freezed == mintMark ? _self.mintMark : mintMark // ignore: cast_nullable_to_non_nullable
as String?,series: freezed == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String?,variety: freezed == variety ? _self.variety : variety // ignore: cast_nullable_to_non_nullable
as String?,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,metal: freezed == metal ? _self.metal : metal // ignore: cast_nullable_to_non_nullable
as String?,weightGrams: freezed == weightGrams ? _self.weightGrams : weightGrams // ignore: cast_nullable_to_non_nullable
as double?,diameterMm: freezed == diameterMm ? _self.diameterMm : diameterMm // ignore: cast_nullable_to_non_nullable
as double?,edgeType: freezed == edgeType ? _self.edgeType : edgeType // ignore: cast_nullable_to_non_nullable
as String?,coinOrientation: freezed == coinOrientation ? _self.coinOrientation : coinOrientation // ignore: cast_nullable_to_non_nullable
as String?,noteWidthMm: freezed == noteWidthMm ? _self.noteWidthMm : noteWidthMm // ignore: cast_nullable_to_non_nullable
as double?,noteHeightMm: freezed == noteHeightMm ? _self.noteHeightMm : noteHeightMm // ignore: cast_nullable_to_non_nullable
as double?,obverseDescription: freezed == obverseDescription ? _self.obverseDescription : obverseDescription // ignore: cast_nullable_to_non_nullable
as String?,reverseDescription: freezed == reverseDescription ? _self.reverseDescription : reverseDescription // ignore: cast_nullable_to_non_nullable
as String?,edgeDescription: freezed == edgeDescription ? _self.edgeDescription : edgeDescription // ignore: cast_nullable_to_non_nullable
as String?,dieMarkers: freezed == dieMarkers ? _self.dieMarkers : dieMarkers // ignore: cast_nullable_to_non_nullable
as String?,serialNumber: freezed == serialNumber ? _self.serialNumber : serialNumber // ignore: cast_nullable_to_non_nullable
as String?,serialBlock: freezed == serialBlock ? _self.serialBlock : serialBlock // ignore: cast_nullable_to_non_nullable
as String?,signatureCombination: freezed == signatureCombination ? _self.signatureCombination : signatureCombination // ignore: cast_nullable_to_non_nullable
as String?,sealColor: freezed == sealColor ? _self.sealColor : sealColor // ignore: cast_nullable_to_non_nullable
as String?,district: freezed == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String?,plateNumberFront: freezed == plateNumberFront ? _self.plateNumberFront : plateNumberFront // ignore: cast_nullable_to_non_nullable
as String?,plateNumberBack: freezed == plateNumberBack ? _self.plateNumberBack : plateNumberBack // ignore: cast_nullable_to_non_nullable
as String?,isStarNote: null == isStarNote ? _self.isStarNote : isStarNote // ignore: cast_nullable_to_non_nullable
as bool,grade: freezed == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as String?,gradeNumeric: freezed == gradeNumeric ? _self.gradeNumeric : gradeNumeric // ignore: cast_nullable_to_non_nullable
as double?,gradingCompany: freezed == gradingCompany ? _self.gradingCompany : gradingCompany // ignore: cast_nullable_to_non_nullable
as String?,certNumber: freezed == certNumber ? _self.certNumber : certNumber // ignore: cast_nullable_to_non_nullable
as String?,isSlabbed: null == isSlabbed ? _self.isSlabbed : isSlabbed // ignore: cast_nullable_to_non_nullable
as bool,detailsGrade: null == detailsGrade ? _self.detailsGrade : detailsGrade // ignore: cast_nullable_to_non_nullable
as bool,detailsNote: freezed == detailsNote ? _self.detailsNote : detailsNote // ignore: cast_nullable_to_non_nullable
as String?,defects: null == defects ? _self._defects : defects // ignore: cast_nullable_to_non_nullable
as List<String>,designation: freezed == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as String?,holderGeneration: freezed == holderGeneration ? _self.holderGeneration : holderGeneration // ignore: cast_nullable_to_non_nullable
as String?,populationObverse: freezed == populationObverse ? _self.populationObverse : populationObverse // ignore: cast_nullable_to_non_nullable
as int?,populationReverse: freezed == populationReverse ? _self.populationReverse : populationReverse // ignore: cast_nullable_to_non_nullable
as int?,certVerificationUrl: freezed == certVerificationUrl ? _self.certVerificationUrl : certVerificationUrl // ignore: cast_nullable_to_non_nullable
as String?,submissionStatus: null == submissionStatus ? _self.submissionStatus : submissionStatus // ignore: cast_nullable_to_non_nullable
as String,quantityType: null == quantityType ? _self.quantityType : quantityType // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,duplicateCount: null == duplicateCount ? _self.duplicateCount : duplicateCount // ignore: cast_nullable_to_non_nullable
as int,historicalContext: freezed == historicalContext ? _self.historicalContext : historicalContext // ignore: cast_nullable_to_non_nullable
as String?,attributionNotes: freezed == attributionNotes ? _self.attributionNotes : attributionNotes // ignore: cast_nullable_to_non_nullable
as String?,provenance: freezed == provenance ? _self.provenance : provenance // ignore: cast_nullable_to_non_nullable
as String?,researchLinks: null == researchLinks ? _self._researchLinks : researchLinks // ignore: cast_nullable_to_non_nullable
as List<String>,internalNotes: freezed == internalNotes ? _self.internalNotes : internalNotes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,catalogReferences: null == catalogReferences ? _self._catalogReferences : catalogReferences // ignore: cast_nullable_to_non_nullable
as List<CatalogReference>,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<ItemImage>,
  ));
}


}

// dart format on
