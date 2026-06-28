import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String? displayName;

  const UserEntity({
    required this.uid,
    required this.email,
    this.displayName,
  });

  String get initials {
    final name = displayName ?? email.split('@').first;
    return name.isNotEmpty ? name[0].toUpperCase() : 'U';
  }

  String get firstName {
    if (displayName != null && displayName!.trim().isNotEmpty) {
      return displayName!.trim().split(' ').first;
    }
    final emailPrefix = email.split('@').first;
    if (emailPrefix.isEmpty) return 'Friend';
    return emailPrefix[0].toUpperCase() + emailPrefix.substring(1);
  }

  String get fullName => displayName ?? email.split('@').first;

  @override
  List<Object?> get props => [uid, email, displayName];
}
