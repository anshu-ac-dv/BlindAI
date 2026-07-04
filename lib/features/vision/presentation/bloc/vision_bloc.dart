import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/services/ai_service.dart';
import 'vision_event.dart';
import 'vision_state.dart';

class VisionBloc extends Bloc<VisionEvent, VisionState> {
  final AIService aiService;
  final ImagePicker imagePicker;

  VisionBloc({
    required this.aiService,
    required this.imagePicker,
  }) : super(VisionInitial()) {
    on<CaptureImageRequested>((event, emit) async {
      emit(VisionLoading());
      
      try {
        final XFile? image = await imagePicker.pickImage(
          source: ImageSource.camera,
          imageQuality: 80,
        );

        if (image == null) {
          emit(VisionInitial());
          return;
        }

        final File imageFile = File(image.path);
        String result;

        switch (event.task) {
          case VisionTask.describe:
            result = await aiService.describeScene(imageFile);
            break;
          case VisionTask.readText:
            result = await aiService.readText(imageFile);
            break;
          case VisionTask.identifyColor:
            result = await aiService.identifyColor(imageFile);
            break;
        }
        
        emit(VisionSuccess(result));
      } catch (e) {
        emit(VisionError("Failed to process image: $e"));
      }
    });
  }
}
