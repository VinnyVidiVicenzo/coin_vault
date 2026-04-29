import 'package:freezed_annotation/freezed_annotation.dart';

part 'valuation.freezed.dart';
part 'valuation.g.dart';

@freezed
sealed class Valuation with _$Valuation {
  const factory Valuation({
    String? id,
    required String itemId,
    required DateTime valuationDate,
    required double estimatedValue,
    @Default('USD') String currency,
    required String valueType,
    required String valueSource,
    String? confidence,
    String? notes,
    DateTime? createdAt,
  }) = _Valuation;

  factory Valuation.fromJson(Map<String, dynamic> json) =>
      _$ValuationFromJson(json);
}
