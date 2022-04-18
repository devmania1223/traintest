import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Problem {
  int id;
  int questionId;
  String content;
  String media;
  int testId;
  int topicId;
  
  String choose1;
  String choose2;
  String choose3;
  String choose4;

  String result1;
  String result2;
  String result3;
  String result4;
  
  String comment;
  String commentMedia;

  bool answer1;
  bool answer2;
  bool answer3;
  bool answer4;

  Problem({
    this.id,
    this.questionId,
    this.content,
    this.media,
    this.testId,
    this.topicId,
    this.choose1,
    this.choose2,
    this.choose3,
    this.choose4,
    this.result1,
    this.result2,
    this.result3,
    this.result4,
    this.comment,
    this.commentMedia,
    this.answer1,
    this.answer2,
    this.answer3,
    this.answer4,
  });

  factory Problem.fromJson(Map<String, dynamic> json) => _$ProblemFromJson(json);

  Map<String, dynamic> toJson() => _$ProblemToJson(this);

  Problem copyWith({
  int id,
  int questionId,
  String content,
  String media,
  int testId,
  int topicId,
  String choose1,
  String choose2,
  String choose3,
  String choose4,
  String result1,
  String result2,
  String result3,
  String result4,
  String comment,
  String commentMedia,
  bool answer1,
  bool answer2,
  bool answer3,
  bool answer4,
  }) {
    return Problem(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      content: content ?? this.content,
      media: media ?? this.media,
      testId: testId ?? this.testId,
      topicId: topicId ?? this.topicId,
      choose1: choose1 ?? this.choose1,
      choose2: choose2 ?? this.choose2,
      choose3: choose3 ?? this.choose3,
      choose4: choose4 ?? this.choose4,
      result1: result1 ?? this.result1,
      result2: result2 ?? this.result2,
      result3: result3 ?? this.result3,
      result4: result4 ?? this.result4,
      comment: comment ?? this.comment,
      commentMedia: commentMedia ?? this.commentMedia,
      answer1: false,
      answer2: false,
      answer3: false,
      answer4: false,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Problem _$ProblemFromJson(Map<String, dynamic> json) {
  return Problem(
    id: json['id'] as int,
    questionId: json['question_id'] as int,
    content: json['content'] as String,
    media: json['media'] as String,
    testId: json['test_id'] as int,
    topicId: json['topic_id'] as int,
    choose1: json['choose1'] as String,
    choose2: json['choose2'] as String,
    choose3: json['choose3'] as String,
    choose4: json['choose4'] as String,
    result1: json['result1'] as String,
    result2: json['result2'] as String,
    result3: json['result3'] as String,
    result4: json['result4'] as String,
    comment: json['comment'] as String,
    commentMedia: json['comment_media'] as String,
  );
}

Map<String, dynamic> _$ProblemToJson(Problem instance) => <String, dynamic>{
      'id': instance.id,
      'question_id': instance.questionId,
      'content': instance.content,
      'media': instance.media,
      'test_id': instance.testId,
      'topic_id': instance.topicId,
      'choose1': instance.choose1,
      'choose2': instance.choose2,
      'choose3': instance.choose3,
      'choose4': instance.choose4,
      'result1': instance.result1,
      'result2': instance.result2,
      'result3': instance.result3,
      'result4': instance.result4,
      'comment': instance.comment,
      'comment_media': instance.commentMedia,
      'answer1': instance.answer1,
      'answer2': instance.answer2,
      'answer3': instance.answer3,
      'answer4': instance.answer4,
    };
