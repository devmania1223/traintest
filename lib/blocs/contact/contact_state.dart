part of 'contact_bloc.dart';

@immutable
class ContactState {

  final bool isEmailValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  const ContactState(
    {
      @required this.isEmailValid,
      @required this.isSubmitting,
      @required this.isSuccess,
      @required this.isFailure,
    }
  );

  factory ContactState.empty() {
    return ContactState(
      isEmailValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory ContactState.loading() {
    return ContactState(
      isEmailValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory ContactState.failure() {
    return ContactState(
      isEmailValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory ContactState.success() {
    return ContactState(
      isEmailValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  ContactState update({
    bool isEmailValid,
  }){
    return copyWith(
      isEmailValid: isEmailValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  ContactState copyWith(
    {
      bool isEmailValid,
      bool isSubmitting,
      bool isSuccess,
      bool isFailure,
    }
  ){
    return ContactState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString(){
    return '''ContactState {
      isEmailValid: $isEmailValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }

}
