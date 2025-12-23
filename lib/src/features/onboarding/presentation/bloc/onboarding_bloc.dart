import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sme_fin/src/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:sme_fin/src/features/onboarding/domain/use_cases/get_saved_onboarding_data.dart';
import 'package:sme_fin/src/features/onboarding/domain/use_cases/save_onboarding_data.dart';
import 'package:sme_fin/src/features/onboarding/domain/use_cases/submit_onboarding_data.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final GetSavedOnboardingData getSavedOnboardingData;
  final SaveOnboardingData saveOnboardingData;
  final SubmitOnboardingData submitOnboardingData;
  final OnboardingRepository repository;

  OnboardingBloc({
    required this.getSavedOnboardingData,
    required this.saveOnboardingData,
    required this.submitOnboardingData,
    required this.repository,
  }) : super(OnboardingInitial()) {
    on<LoadSavedDataEvent>(_onLoadSavedData);
    on<SendVerificationCodeEvent>(_onSendVerificationCode);
    on<VerifyCodeEvent>(_onVerifyCode);
    on<UpdateOnboardingDataEvent>(_onUpdateOnboardingData);
    on<SubmitOnboardingDataEvent>(_onSubmitOnboardingData);
    on<ClearOnboardingDataEvent>(_onClearOnboardingData);
  }

  Future<void> _onLoadSavedData(
    LoadSavedDataEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(OnboardingLoading());
    final result = await getSavedOnboardingData();
    result.fold(
      (failure) => emit(OnboardingError(failure.message)),
      (data) => emit(OnboardingDataLoaded(data)),
    );
  }

  Future<void> _onSendVerificationCode(
    SendVerificationCodeEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(OnboardingLoading());
    final result = await repository.sendVerificationCode(event.email);
    result.fold(
      (failure) => emit(OnboardingError(failure.message)),
      (_) => emit(VerificationCodeSent(event.email)),
    );
  }

  Future<void> _onVerifyCode(
    VerifyCodeEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(OnboardingLoading());
    final result = await repository.verifyCode(event.email, event.code);
    result.fold(
      (failure) => emit(OnboardingError(failure.message)),
      (_) => emit(CodeVerified(event.email)),
    );
  }

  Future<void> _onUpdateOnboardingData(
    UpdateOnboardingDataEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    final result = await saveOnboardingData(event.data);
    result.fold(
      (failure) => emit(OnboardingError(failure.message)),
      (_) => emit(OnboardingDataSaved(event.data)),
    );
  }

  Future<void> _onSubmitOnboardingData(
    SubmitOnboardingDataEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(OnboardingLoading());
    final result = await submitOnboardingData(event.data);
    result.fold(
      (failure) => emit(OnboardingError(failure.message)),
      (_) => emit(OnboardingSubmissionSuccess()),
    );
  }

  Future<void> _onClearOnboardingData(
    ClearOnboardingDataEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    final result = await repository.clearOnboardingData();
    result.fold(
      (failure) => emit(OnboardingError(failure.message)),
      (_) => emit(OnboardingInitial()),
    );
  }
}
