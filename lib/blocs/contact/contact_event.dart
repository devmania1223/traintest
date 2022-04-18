part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();
}


class ContactEmailChangedEvent extends ContactEvent {
  final String email;

  const ContactEmailChangedEvent({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class ContactSubmitEvent extends ContactEvent {
  // final String name;
  // final String email;
  final String subject;
  final String description;
  const ContactSubmitEvent(
    {
      // @required this.name,
      // @required this.email,
      @required this.subject,
      @required this.description
    }
  );
  @override
  List<Object> get props => [
      // name, 
      // email, 
      subject, 
      description
    ];

  @override
  String toString() {
    // return 'UpdateContactInfoEvent { name: $name, email: $email, subject: $subject, description: $description}';
    return 'UpdateContactInfoEvent { subject: $subject, description: $description}';
  }
}
