import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kalender/kalender.dart';
import 'package:universidad_lg_24/Calendario/models/calendario_model.dart';
import 'package:universidad_lg_24/Calendario/services/calendario_services.dart';
import 'package:universidad_lg_24/Cursos/views/new_cursos_view.dart';
import 'package:universidad_lg_24/Noticias/views/noticias_view.dart';
import 'package:universidad_lg_24/Reels/views/reels_view.dart';

import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/bottom_app_bar_global.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class CalendarioView extends StatefulWidget {
  const CalendarioView({required this.user, super.key});
  final User user;

  @override
  State<CalendarioView> createState() => _CalendarioViewState();
}

class _CalendarioViewState extends State<CalendarioView> {
  CalendarioModel? data;
  final CalendarController<Event> controller = CalendarController(
    calendarDateTimeRange: DateTimeRange(
      start: DateTime(DateTime.now().year - 1),
      end: DateTime(DateTime.now().year + 1),
    ),
  );
  final CalendarEventsController<Event> eventController =
      CalendarEventsController<Event>();

  late ViewConfiguration currentConfiguration = viewConfigurations[0];
  List<ViewConfiguration> viewConfigurations = [
    // CustomMultiDayConfiguration(
    //   name: 'Day',
    //   numberOfDays: 1,
    //   startHour: 6,
    //   endHour: 18,
    // ),
    // CustomMultiDayConfiguration(
    //   name: 'Custom',
    //   numberOfDays: 1,
    // ),

    // WeekConfiguration(),
    // WorkWeekConfiguration(),
    MonthConfiguration(),
    // ScheduleConfiguration(),
    MultiWeekConfiguration(
      numberOfWeeks: 3,
    ),
  ];

  @override
  void initState() {
    super.initState();
    // final now = DateTime.now();
    // eventController.addEvents([
    //   CalendarEvent(
    //     dateTimeRange: DateTimeRange(
    //       start: DateTime(2024, 7, 2),
    //       end: DateTime(2024, 7, 4),
    //     ),
    //     eventData: Event(
    //       title: 'Nueva Noticia',
    //       color: blackColor,
    //       description: 'Nueva noticia de la universidad LG.',
    //     ),
    //   ),
    //   CalendarEvent(
    //     dateTimeRange: DateTimeRange(
    //       start: DateTime(2024, 7, 19),
    //       end: DateTime(2024, 7, 22),
    //     ),
    //     eventData: Event(
    //       title: 'Nuevo reel',
    //       color: vioColor,
    //       description: 'Diviértete con nuestro videos.',
    //     ),
    //   ),
    //   CalendarEvent(
    //     dateTimeRange: DateTimeRange(
    //       start: DateTime(2024, 8),
    //       end: DateTime(2024, 8, 3),
    //     ),
    //     eventData: Event(
    //       title: 'Nuevo juego',
    //       color: mainColor,
    //       description: 'Juega con nosotros.',
    //     ),
    //   ),
    // ]);
    _getDataCalendario();
  }

  Future<void> _getDataCalendario() async {
    await IsCalendarioService()
        .getCalendarioService(
      uid: widget.user.userId,
      token: widget.user.token,
    )
        .then((value) {
      data = value;
      for (var i = 0; i < data!.body.events.length; i++) {
        final startYear = data!.body.events[i].dateTimeRange.start.substring(
          0,
          data!.body.events[i].dateTimeRange.start.indexOf(','),
        );
        final startMonth = data!.body.events[i].dateTimeRange.start.substring(
          data!.body.events[i].dateTimeRange.start.indexOf(',') + 1,
          data!.body.events[i].dateTimeRange.start.lastIndexOf(','),
        );
        final startDay = data!.body.events[i].dateTimeRange.start.substring(
          data!.body.events[i].dateTimeRange.start.lastIndexOf(',') + 1,
        );
        final endYear = data!.body.events[i].dateTimeRange.end.substring(
          0,
          data!.body.events[i].dateTimeRange.end.indexOf(','),
        );
        final endMonth = data!.body.events[i].dateTimeRange.end.substring(
          data!.body.events[i].dateTimeRange.end.indexOf(',') + 1,
          data!.body.events[i].dateTimeRange.end.lastIndexOf(','),
        );
        final endDay = data!.body.events[i].dateTimeRange.end.substring(
          data!.body.events[i].dateTimeRange.end.lastIndexOf(',') + 1,
        );
        eventController.addEvent(
          CalendarEvent(
            dateTimeRange: DateTimeRange(
              start: DateTime(
                int.parse(startYear),
                int.parse(startMonth),
                int.parse(startDay),
              ),
              end: DateTime(
                int.parse(endYear),
                int.parse(endMonth),
                int.parse(endDay) + 1,
              ),
            ),
            eventData: Event(
              title: data!.body.events[i].eventData.title,
              color: Colors.red,
              description: data!.body.events[i].eventData.description,
            ),
          ),
        );

        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final calendar = CalendarView<Event>(
      controller: controller,
      eventsController: eventController,
      viewConfiguration: currentConfiguration,
      tileBuilder: _tileBuilder,
      multiDayTileBuilder: _multiDayTileBuilder,
      scheduleTileBuilder: _scheduleTileBuilder,
      // components: CalendarComponents(
      //     // calendarHeaderBuilder: _calendarHeader,
      //     ),
      eventHandlers: CalendarEventHandlers(
        onEventTapped: _onEventTapped,
        // onEventChanged: _onEventChanged,
        // onCreateEvent: _onCreateEvent,
        // onEventCreated: _onEventCreated,
      ),
    );

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        backgroundColor: const Color(0xffF6F3EB),
        appBar: CustomAppBar(),
        endDrawer: DrawerMenu(
          user: widget.user,
          isHome: true, // Indica que el DrawerMenuLeft se está utilizando
          // en la pantalla de inicio.
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 94, bottom: 96),
          child: Column(
            children: [
              const SizedBox(
                width: 260,
                child: Center(
                  child: Text(
                    'Calendario de contenido',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    right: 25,
                    left: 25,
                    bottom: 10,
                  ),
                  child: calendar,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CustomBottomAppBar(),
      ),
    );
  }

  CalendarEvent<Event> _onCreateEvent(DateTimeRange dateTimeRange) {
    print('evento 3');
    return CalendarEvent(
      dateTimeRange: dateTimeRange,
      eventData: Event(
        title: 'New Event',
        color: Colors.red,
      ),
    );
  }

  Future<void> _onEventCreated(CalendarEvent<Event> event) async {
    print('evento 4');
    // Add the event to the events controller.
    eventController.addEvent(event);

    // Deselect the event.
    eventController.deselectEvent();
  }

  Future<void> _onEventTapped(
    CalendarEvent<Event> event,
  ) async {
    print('evento 1: ${event.eventData?.title}');
    // if (isMobile) {
    //   eventController.selectedEvent == event
    //       ? eventController.deselectEvent()
    //       : eventController.selectEvent(event);
    // }
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(event.eventData?.title ?? 'New Event'),
          content: Text(event.eventData?.description ?? 'No description'),
          actions: [
            ///Validación según el titulo
            if (event.eventData!.title.contains('Noticia'))
              ButtonMain(
                text: 'Ver Noticia',
                onPress: NoticiasView(
                  user: widget.user,
                ),
              ),
            if (event.eventData!.title.contains('Reel'))
              ButtonMain(
                text: 'Ver Reel',
                onPress: ReelsView(
                  user: widget.user,
                ),
              ),
            if (event.eventData!.title.contains('Curso'))
              ButtonMain(
                text: 'Ver Curso',
                onPress: NewCursosView(
                  user: widget.user,
                ),
              ),
          ],
        );
      },
    );
  }

  Future<void> _onEventChanged(
    DateTimeRange initialDateTimeRange,
    CalendarEvent<Event> event,
  ) async {
    print('evento 2');
    if (isMobile) {
      eventController.deselectEvent();
    }
  }

  Widget _tileBuilder(
    CalendarEvent<Event> event,
    TileConfiguration configuration,
  ) {
    final color = event.eventData?.color ?? Colors.blue;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.zero,
      elevation: configuration.tileType == TileType.ghost ? 0 : 8,
      color: configuration.tileType != TileType.ghost
          ? color
          : color.withAlpha(100),
      child: Center(
        child: configuration.tileType != TileType.ghost
            ? Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  event.eventData?.title ?? 'New Event',
                  style: const TextStyle(color: Colors.white),
                ),
              )
            : null,
      ),
    );
  }

  Widget _multiDayTileBuilder(
    CalendarEvent<Event> event,
    MultiDayTileConfiguration configuration,
  ) {
    final color = event.eventData?.color ?? Colors.blue;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
      elevation: configuration.tileType == TileType.selected ? 8 : 0,
      color: configuration.tileType == TileType.ghost
          ? color.withAlpha(100)
          : color,
      child: Center(
        child: configuration.tileType != TileType.ghost
            ? Text(
                event.eventData?.title ?? 'New Event',
                style: const TextStyle(color: Colors.white, fontSize: 11),
              )
            : null,
      ),
    );
  }

  Widget _scheduleTileBuilder(CalendarEvent<Event> event, DateTime date) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: event.eventData?.color ?? Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(event.eventData?.title ?? 'New Event'),
    );
  }

  Widget _calendarHeader(DateTimeRange dateTimeRange) {
    return Row(
      children: [
        DropdownMenu(
          onSelected: (value) {
            if (value == null) return;
            setState(() {
              currentConfiguration = value;
            });
          },
          initialSelection: currentConfiguration,
          dropdownMenuEntries: viewConfigurations
              .map((e) => DropdownMenuEntry(value: e, label: e.name))
              .toList(),
        ),
        IconButton.filledTonal(
          onPressed: controller.animateToPreviousPage,
          icon: const Icon(Icons.navigate_before_rounded),
        ),
        IconButton.filledTonal(
          onPressed: controller.animateToNextPage,
          icon: const Icon(Icons.navigate_next_rounded),
        ),
        IconButton.filledTonal(
          onPressed: () {
            controller.animateToDate(DateTime.now());
          },
          icon: const Icon(Icons.today),
        ),
      ],
    );
  }

  bool get isMobile {
    return kIsWeb ? false : Platform.isAndroid || Platform.isIOS;
  }
}

class Event {
  Event({
    required this.title,
    this.description,
    this.color,
  });

  /// The title of the [Event].
  final String title;

  /// The description of the [Event].
  final String? description;

  /// The color of the [Event] tile.
  final Color? color;
}
