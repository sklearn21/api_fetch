import 'package:json_annotation/json_annotation.dart';

part 'txin.g.dart';

@JsonSerializable()
class TxinResponse {
  @JsonKey(name: "txnId")
  String txnId;
  TxinResponse(this.txnId);

  factory TxinResponse.fromJson(Map<String, dynamic> json) =>
      _$TxinResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TxinResponseToJson(this);
}
