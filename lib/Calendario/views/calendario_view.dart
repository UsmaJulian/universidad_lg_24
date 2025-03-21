// ignore_for_file: unused_element

import 'dart:developer';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kalender/kalender.dart';
import 'package:universidad_lg_24/Calendario/models/calendario_model.dart';
import 'package:universidad_lg_24/Calendario/services/calendario_services.dart';
import 'package:universidad_lg_24/Cursos/views/new_cursos_view.dart';
import 'package:universidad_lg_24/Noticias/views/noticias_view.dart';
import 'package:universidad_lg_24/Reels/views/reels_view.dart';
import 'package:universidad_lg_24/constants.dart';
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

  // Actualización de controladores según el ejemplo
  final calendarController = CalendarController<Event>();
  final eventsController = EventsController<Event>();

  late DateTime now;
  late DateTimeRange displayRange;
  late List<ViewConfiguration> viewConfigurations;
  late ViewConfiguration viewConfiguration;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    displayRange = DateTimeRange(
      start: now.subtract(const Duration(days: 363)),
      end: now.add(const Duration(days: 365)),
    );
    viewConfigurations = <ViewConfiguration>[
      MultiDayViewConfiguration.week(
        displayRange: displayRange,
      ),
      MultiDayViewConfiguration.singleDay(displayRange: displayRange),
      MultiDayViewConfiguration.workWeek(displayRange: displayRange),
      MultiDayViewConfiguration.custom(
        numberOfDays: 3,
        displayRange: displayRange,
      ),
      MonthViewConfiguration.singleMonth(),
      MultiDayViewConfiguration.freeScroll(
        displayRange: displayRange,
        numberOfDays: 4,
        name: 'Free Scroll (WIP)',
      ),
    ];
    viewConfiguration = viewConfigurations[0];

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
      final events = data!.body.events as List;
      for (var i = 0; i < events.length; i++) {
        final eventData = data!.body.events[i];
        // Se asume que las cadenas de fecha tienen el formato "año,mes,día"
        final startParts = eventData.dateTimeRange.start.split(',');
        final endParts = eventData.dateTimeRange.end.split(',');
        final startDate = DateTime(
          int.parse(startParts[0].toString()),
          int.parse(startParts[1].toString()),
          int.parse(startParts[2].toString()),
        );
        // Se replica la lógica original que añade +8 días al día final
        final endDate = DateTime(
          int.parse(endParts[0].toString()),
          int.parse(endParts[1].toString()),
          int.parse(endParts[2].toString()) + 8,
        );
        eventsController.addEvent(
          CalendarEvent<Event>(
            dateTimeRange: DateTimeRange(start: startDate, end: endDate),
            data: Event(
              title: eventData.eventData.title.toString(),
              color: Color(int.parse(eventData.eventData.color.toString())),
              description: eventData.eventData.description.toString(),
            ),
          ),
        );
      }
      setState(() {});
    });
  }

  CalendarEvent<Event> _onCreateEvent(CalendarEvent<Event> event) {
    return CalendarEvent<Event>(
      dateTimeRange: event.dateTimeRange,
      data: Event(
        title: 'New Event',
        color: const Color(0xFFFD312E),
      ),
    );
  }

  Future<void> _onEventCreated(CalendarEvent<Event> event) async {
    eventsController.addEvent(event);
    calendarController.deselectEvent();
  }

  Future<void> _onEventTapped(
    CalendarEvent<Event> event,
    RenderBox renderBox,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(event.data?.title ?? 'New Event'),
          content: Text(event.data?.description ?? 'No description'),
          actions: [
            if (event.data!.title.contains('Noticia'))
              ButtonMain(
                text: 'Ver Noticia',
                onPress: NoticiasView(user: widget.user),
                routeName: '/news/${event.data!.title}',
              ),
            if (event.data!.title.contains('Reel'))
              ButtonMain(
                text: 'Ver Reel',
                onPress: ReelsView(user: widget.user),
                routeName: '/reels/${event.data!.title}',
              ),
            if (event.data!.title.contains('Curso'))
              ButtonMain(
                text: 'Ver Curso',
                onPress: NewCursosView(user: widget.user),
                routeName: '/courses/${event.data!.title}',
              ),
          ],
        );
      },
    );
  }

  // Se define un método para crear los TileComponents similar al ejemplo
  TileComponents<Event> tileComponents({bool body = true}) {
    return TileComponents<Event>(
      tileBuilder: (event, tileRange) {
        log('Event: ${event.data?.color}');
        return Container(
          margin:
              body ? EdgeInsets.zero : const EdgeInsets.symmetric(vertical: 1),
          decoration: BoxDecoration(
            color: event.data?.color ?? Colors.blue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: AutoSizeText(
              event.data?.title ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
      dropTargetTile: (event) => DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(80),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      feedbackTileBuilder: (event, dropTargetWidgetSize) => AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: dropTargetWidgetSize.width * 0.8,
        height: dropTargetWidgetSize.height,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer.withAlpha(100),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      tileWhenDraggingBuilder: (event) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer.withAlpha(80),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      dragAnchorStrategy: pointerDragAnchorStrategy,
    );
  }

  Widget _calendarToolbar() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: ValueListenableBuilder<DateTimeRange>(
              valueListenable: calendarController.visibleDateTimeRange,
              builder: (context, value, child) {
                final year = value.start.year;
                final month = value.start.monthNameEnglish;
                return FilledButton.tonal(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(160, kMinInteractiveDimension),
                  ),
                  child: Text('$month $year'),
                );
              },
            ),
          ),
          if (!Platform.isAndroid && !Platform.isIOS)
            IconButton.filledTonal(
              onPressed: calendarController.animateToPreviousPage,
              icon: const Icon(Icons.chevron_left),
            ),
          if (!Platform.isAndroid && !Platform.isIOS)
            IconButton.filledTonal(
              onPressed: calendarController.animateToNextPage,
              icon: const Icon(Icons.chevron_right),
            ),
          IconButton.filledTonal(
            onPressed: () => calendarController.animateToDate(DateTime.now()),
            icon: const Icon(Icons.today),
          ),
          SizedBox(
            width: 120,
            child: DropdownMenu<ViewConfiguration>(
              dropdownMenuEntries: viewConfigurations
                  .map((e) => DropdownMenuEntry(value: e, label: e.name))
                  .toList(),
              initialSelection: viewConfiguration,
              onSelected: (value) {
                if (value == null) return;
                setState(() => viewConfiguration = value);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(user: widget.user),
        endDrawer: DrawerMenu(
          user: widget.user,
          isHome: true,
        ),
        bottomNavigationBar: const CustomBottomAppBar(),
        backgroundColor: const Color(0xffF6F3EB),
        body: CalendarView<Event>(
          eventsController: eventsController,
          calendarController: calendarController,
          viewConfiguration: viewConfiguration,
          callbacks: CalendarCallbacks<Event>(
            onEventTapped: (event, renderBox) async =>
                _onEventTapped(event, renderBox),
            // onEventCreate: _onCreateEvent,
            // onEventCreated: (event) async => _onEventCreated(event),
          ),
          components: CalendarComponents(
            multiDayComponents: MultiDayComponents(),
            multiDayComponentStyles: MultiDayComponentStyles(),
            monthComponents: MonthComponents(),
            monthComponentStyles: MonthComponentStyles(),
          ),
          header: Material(
            color: bgColor,
            surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
            elevation: 2,
            child: Column(
              children: [
                // _calendarToolbar(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Calendario de contenido',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                CalendarHeader<Event>(
                  multiDayTileComponents: tileComponents(body: false),
                ),
              ],
            ),
          ),
          body: CalendarBody<Event>(
            multiDayTileComponents: tileComponents(),
            monthTileComponents: tileComponents(body: false),
            multiDayBodyConfiguration: MultiDayBodyConfiguration(),
            monthBodyConfiguration: MultiDayHeaderConfiguration(),
          ),
        ),
      ),
    );
  }
}

class Event {
  Event({
    required this.title,
    this.description,
    this.color,
  });

  final String title;
  final String? description;
  final Color? color;
}
