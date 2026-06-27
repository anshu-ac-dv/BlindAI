import 'package:equatable/equatable.dart';

abstract class VisionState extends Equatable {
  const VisionState();
  
  @override
  List<Object?> get props => [];
}

class VisionInitial extends VisionState {}

class VisionLoading extends VisionState {}

class VisionSuccess extends VisionState {
  final String result;
  const VisionSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class VisionError extends VisionState {
  final String message;
  const VisionError(this.message);

  @override
  List<Object> get props => [message];
}
