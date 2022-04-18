import 'package:equatable/equatable.dart';

class ProgressBar extends Equatable {
  final int courseProgress;
  final int myProgress;

  const ProgressBar({this.courseProgress, this.myProgress});

  @override
  List<Object> get props => [
        courseProgress,
        myProgress,
      ];

  static ProgressBar fromJson(dynamic json) {
    final data = json['data'];
    return ProgressBar(
      courseProgress: data['course_progress'] as int,
      myProgress: data['my_progress'] as int,
    );
  }
}
