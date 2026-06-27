import 'package:equatable/equatable.dart';

abstract class VisionEvent extends Equatable {
  const VisionEvent();

  @override
  List<Object> get props => [];
}

class CaptureImageRequested extends VisionEvent {}
