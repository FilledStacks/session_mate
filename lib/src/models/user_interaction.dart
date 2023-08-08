import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:session_mate/src/enums/interaction_type.dart';
import 'package:session_mate/src/widgets/interaction_recorder/interaction_recorder_viewmodel.dart';

part 'user_interaction.freezed.dart';
part 'user_interaction.g.dart';

@freezed
class UserInteraction with _$UserInteraction {
  factory UserInteraction({
    required TapPosition position,
    required InteractionType type,
    String? inputData,
  }) = _UserInteraction;

  factory UserInteraction.fromJson(Map<String, dynamic> json) =>
      _$UserInteractionFromJson(json);
}
