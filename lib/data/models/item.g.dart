// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Item _$ItemFromJson(Map<String, dynamic> json) => _Item(
  id: json['id'] as String,
  ownerId: json['ownerId'] as String,
  itemType: json['itemType'] as String? ?? 'coin',
  country: json['country'] as String?,
  issuingAuthority: json['issuingAuthority'] as String?,
  denomination: json['denomination'] as String?,
  denominationNumeric: (json['denominationNumeric'] as num?)?.toDouble(),
  yearStart: (json['yearStart'] as num?)?.toInt(),
  yearEnd: (json['yearEnd'] as num?)?.toInt(),
  mintMark: json['mintMark'] as String?,
  series: json['series'] as String?,
  variety: json['variety'] as String?,
  isPublic: json['isPublic'] as bool? ?? false,
  metal: json['metal'] as String?,
  weightGrams: (json['weightGrams'] as num?)?.toDouble(),
  diameterMm: (json['diameterMm'] as num?)?.toDouble(),
  edgeType: json['edgeType'] as String?,
  coinOrientation: json['coinOrientation'] as String?,
  noteWidthMm: (json['noteWidthMm'] as num?)?.toDouble(),
  noteHeightMm: (json['noteHeightMm'] as num?)?.toDouble(),
  obverseDescription: json['obverseDescription'] as String?,
  reverseDescription: json['reverseDescription'] as String?,
  edgeDescription: json['edgeDescription'] as String?,
  dieMarkers: json['dieMarkers'] as String?,
  serialNumber: json['serialNumber'] as String?,
  serialBlock: json['serialBlock'] as String?,
  signatureCombination: json['signatureCombination'] as String?,
  sealColor: json['sealColor'] as String?,
  district: json['district'] as String?,
  plateNumberFront: json['plateNumberFront'] as String?,
  plateNumberBack: json['plateNumberBack'] as String?,
  isStarNote: json['isStarNote'] as bool? ?? false,
  grade: json['grade'] as String?,
  gradeNumeric: (json['gradeNumeric'] as num?)?.toDouble(),
  gradingCompany: json['gradingCompany'] as String?,
  certNumber: json['certNumber'] as String?,
  isSlabbed: json['isSlabbed'] as bool? ?? false,
  detailsGrade: json['detailsGrade'] as bool? ?? false,
  detailsNote: json['detailsNote'] as String?,
  defects:
      (json['defects'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  designation: json['designation'] as String?,
  holderGeneration: json['holderGeneration'] as String?,
  populationObverse: (json['populationObverse'] as num?)?.toInt(),
  populationReverse: (json['populationReverse'] as num?)?.toInt(),
  certVerificationUrl: json['certVerificationUrl'] as String?,
  submissionStatus: json['submissionStatus'] as String? ?? 'raw',
  quantityType: json['quantityType'] as String? ?? 'single',
  quantity: (json['quantity'] as num?)?.toInt() ?? 1,
  duplicateCount: (json['duplicateCount'] as num?)?.toInt() ?? 0,
  historicalContext: json['historicalContext'] as String?,
  attributionNotes: json['attributionNotes'] as String?,
  provenance: json['provenance'] as String?,
  researchLinks:
      (json['researchLinks'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  internalNotes: json['internalNotes'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  catalogReferences:
      (json['catalogReferences'] as List<dynamic>?)
          ?.map((e) => CatalogReference.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  images:
      (json['images'] as List<dynamic>?)
          ?.map((e) => ItemImage.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ItemToJson(_Item instance) => <String, dynamic>{
  'id': instance.id,
  'ownerId': instance.ownerId,
  'itemType': instance.itemType,
  'country': instance.country,
  'issuingAuthority': instance.issuingAuthority,
  'denomination': instance.denomination,
  'denominationNumeric': instance.denominationNumeric,
  'yearStart': instance.yearStart,
  'yearEnd': instance.yearEnd,
  'mintMark': instance.mintMark,
  'series': instance.series,
  'variety': instance.variety,
  'isPublic': instance.isPublic,
  'metal': instance.metal,
  'weightGrams': instance.weightGrams,
  'diameterMm': instance.diameterMm,
  'edgeType': instance.edgeType,
  'coinOrientation': instance.coinOrientation,
  'noteWidthMm': instance.noteWidthMm,
  'noteHeightMm': instance.noteHeightMm,
  'obverseDescription': instance.obverseDescription,
  'reverseDescription': instance.reverseDescription,
  'edgeDescription': instance.edgeDescription,
  'dieMarkers': instance.dieMarkers,
  'serialNumber': instance.serialNumber,
  'serialBlock': instance.serialBlock,
  'signatureCombination': instance.signatureCombination,
  'sealColor': instance.sealColor,
  'district': instance.district,
  'plateNumberFront': instance.plateNumberFront,
  'plateNumberBack': instance.plateNumberBack,
  'isStarNote': instance.isStarNote,
  'grade': instance.grade,
  'gradeNumeric': instance.gradeNumeric,
  'gradingCompany': instance.gradingCompany,
  'certNumber': instance.certNumber,
  'isSlabbed': instance.isSlabbed,
  'detailsGrade': instance.detailsGrade,
  'detailsNote': instance.detailsNote,
  'defects': instance.defects,
  'designation': instance.designation,
  'holderGeneration': instance.holderGeneration,
  'populationObverse': instance.populationObverse,
  'populationReverse': instance.populationReverse,
  'certVerificationUrl': instance.certVerificationUrl,
  'submissionStatus': instance.submissionStatus,
  'quantityType': instance.quantityType,
  'quantity': instance.quantity,
  'duplicateCount': instance.duplicateCount,
  'historicalContext': instance.historicalContext,
  'attributionNotes': instance.attributionNotes,
  'provenance': instance.provenance,
  'researchLinks': instance.researchLinks,
  'internalNotes': instance.internalNotes,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'catalogReferences': instance.catalogReferences,
  'images': instance.images,
};
