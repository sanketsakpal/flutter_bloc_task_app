// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final String description;
  final String uuid;
  final String date;
  bool? isDone;
  bool? isDelete;
  bool? isFavorite;
  Task({
    required this.title,
    required this.description,
    required this.uuid,
    required this.date,
    this.isDone,
    this.isDelete,
    this.isFavorite,
  }) {
    isDone = isDone ?? false;
    isDelete = isDelete ?? false;
    isFavorite = isFavorite ?? false;
  }

  Task copyWith({
    String? title,
    String? uuid,
    String? date,
    String? description,
    String? id,
    bool? isDone,
    bool? isDelete,
    bool? isFavorite,
  }) {
    return Task(
      title: title ?? this.title,
      uuid: uuid ?? this.uuid,
      date: date ?? this.date,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      isDelete: isDelete ?? this.isDelete,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'uuid': uuid,
      'date': date,
      'description': description,
      'isDone': isDone,
      'isDelete': isDelete,
      'isFavorite': isFavorite,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] as String,
      uuid: map['uuid'] as String,
      date: map['date'] as String,
      description: map['description'] as String,
      isDone: map['isDone'] != null ? map['isDone'] as bool : null,
      isDelete: map['isDelete'] != null ? map['isDelete'] as bool : null,
      isFavorite: map['isFavorite'] != null ? map['isFavorite'] as bool : null,
    );
  }

  @override
  List<Object?> get props =>
      [title, date, uuid, description, isDone, isDelete, isFavorite];
}
