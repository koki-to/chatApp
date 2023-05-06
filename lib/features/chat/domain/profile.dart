import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../configs/date_time_converter.dart';
part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
class Profile with _$Profile {
  const factory Profile({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'created_at')
    @DateTimeConverter()
        required DateTime createdAt,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
