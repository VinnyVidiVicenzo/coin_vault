import 'package:freezed_annotation/freezed_annotation.dart';

part 'acquisition.freezed.dart';
part 'acquisition.g.dart';

@freezed
sealed class Acquisition with _$Acquisition {
  const factory Acquisition({
    String? id,
    required String itemId,
    DateTime? purchaseDate,
    String? sourceType,
    String? sellerName,
    String? sellerContact,
    String? lotNumber,
    double? purchasePrice,
    double? buyersPremium,
    double? shippingCost,
    double? taxPaid,
    double? otherFees,
    double? totalCost,
    @Default('USD') String currency,
    String? paymentMethod,
    @Default('known') String costBasisType,
    String? notes,
    DateTime? createdAt,
  }) = _Acquisition;

  factory Acquisition.fromJson(Map<String, dynamic> json) =>
      _$AcquisitionFromJson(json);
}
