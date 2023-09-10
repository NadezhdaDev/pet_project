import 'package:freezed_annotation/freezed_annotation.dart';
part 'project.freezed.dart';

@unfreezed
class Project with _$Project {
  factory Project({
    required String uuid,
    String? imagePath,
  }) = _Project;
}
