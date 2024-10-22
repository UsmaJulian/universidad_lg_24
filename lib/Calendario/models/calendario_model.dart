// To parse this JSON data, do
//
//     final calendarioModel = calendarioModelFromJson(jsonString);

// ignore_for_file: inference_failure_on_untyped_parameter, avoid_dynamic_calls

import 'dart:convert';

CalendarioModel calendarioModelFromJson(String str) =>
    CalendarioModel.fromJson(json.decode(str) as Map<String, dynamic>);

String calendarioModelToJson(CalendarioModel data) =>
    json.encode(data.toJson());

class CalendarioModel {
  CalendarioModel({
    required this.response,
    required this.body,
  });

  factory CalendarioModel.fromJson(Map<String, dynamic> json) =>
      CalendarioModel(
        response: Response.fromJson(json['response'] as Map<String, dynamic>),
        body: Body.fromJson(json['body'] as Map<String, dynamic>),
      );
  Response response;
  Body body;

  Map<String, dynamic> toJson() => {
        'response': response.toJson(),
        'body': body.toJson(),
      };
}

class Body {
  Body({
    required this.events,
  });

  factory Body.fromJson(dynamic json) => Body(
        events: List<dynamic>.from(
          json['events'].map((x) => Event.fromJson(x as dynamic)) as Iterable,
        ),
      );
  dynamic events;

  Map<String, dynamic> toJson() => {
        'events': List<dynamic>.from(events.map((x) => x.toJson()) as Iterable),
      };
}

class Event {
  Event({
    required this.dateTimeRange,
    required this.eventData,
  });

  factory Event.fromJson(dynamic json) => Event(
        dateTimeRange: DateTimeRangeCalendar.fromJson(
          json['dateTimeRange'] as dynamic,
        ),
        eventData: EventData.fromJson(json['eventData'] as dynamic),
      );
  DateTimeRangeCalendar dateTimeRange;
  EventData eventData;

  dynamic toJson() => {
        'dateTimeRange': dateTimeRange.toJson(),
        'eventData': eventData.toJson(),
      };
}

class DateTimeRangeCalendar {
  DateTimeRangeCalendar({
    required this.start,
    required this.end,
  });

  factory DateTimeRangeCalendar.fromJson(dynamic json) => DateTimeRangeCalendar(
        start: json['start'].toString(),
        end: json['end'].toString(),
      );
  String start;
  String end;

  dynamic toJson() => {
        'start': start,
        'end': end,
      };
}

class EventData {
  EventData({
    required this.title,
    required this.color,
    required this.description,
  });

  factory EventData.fromJson(dynamic json) => EventData(
        title: json['title'].toString(),
        color: json['color'].toString(),
        description: json['description'].toString(),
      );
  String title;
  String color;
  String description;

  dynamic toJson() => {
        'title': title,
        'color': color,
        'description': description,
      };
}

class Response {
  Response({
    required this.type,
    required this.code,
    required this.message,
  });

  factory Response.fromJson(dynamic json) => Response(
        type: json['type'].toString(),
        code: int.parse(json['code'].toString()),
        message: json['message'].toString(),
      );
  String type;
  int code;
  String message;

  dynamic toJson() => {
        'type': type,
        'code': code,
        'message': message,
      };
}
