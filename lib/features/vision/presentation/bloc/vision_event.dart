import 'package:equatable/equatable.dart';

enum VisionTask { describe, readText, identifyColor }

abstract class VisionEvent extends Equatable {
  const VisionEvent();

  @override
  List<Object> get props => [];
}

class CaptureImageRequested extends VisionEvent {
  final VisionTask task;

  const CaptureImageRequested(this.task);

  @override
  List<Object> get props => [task];
}
