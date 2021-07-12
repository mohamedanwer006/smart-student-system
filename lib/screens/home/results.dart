import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triple_s_project/providers/auth.dart';
import '../../model/user.dart' as user;

class ResultsScreen extends StatefulWidget {
  final List<user.Table> table;
  const ResultsScreen({Key key, this.table}) : super(key: key);
  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  @override
  Widget build(BuildContext context) {
    final table = Provider.of<Auth>(context, listen: false).user.table;
    final selectedSubjects = Provider.of<Auth>(context).selectedSubjects.isEmpty
        ? table[0].subjects
        : Provider.of<Auth>(context).selectedSubjects;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
              Container(
                height: 32.0,
                color: Color(0xff90caf9),
              ),
              Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(15.0),
                          color: Color(0xff90caf9),
                          child: TopRow()),

                      // دي الايام الموجودة في جدول الطالب
                      Container(
                        height: 100,
                        padding: EdgeInsets.all(15.0),
                        color: Color(0xff90caf9),
                        child: DaysRow(
                          table: table,
                        ),
                      ),
                      Column(
                        // هنا بنعرض ليست المواد بناء علي اليوم
                          children: selectedSubjects
                              .map((e) => CardWidget(
                            subjects: e,
                          ))
                              .toList()),
                    ],
                  ))
            ])));
  }
}

class DaysRow extends StatefulWidget {
  final List<user.Table> table;
  DaysRow({Key key, this.table}) : super(key: key);
  @override
  _DaysRowState createState() => _DaysRowState();
}

class _DaysRowState extends State<DaysRow> {
  // selected day  index used to change day theme
  String selectedDayId;
  @override
  void initState() {
    super.initState();
    selectedDayId = widget.table[0].id;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: widget.table.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, i) => InkWell(
            onTap: () {
              setState(() {
                selectedDayId = widget.table[i].id;
              });
// هنا بنغير المواد بناء علي اليوم الي الطالب هيختارة
              Provider.of<Auth>(context, listen: false)
                  .changeSelectedSubjects(widget.table[i].subjects);
            },
            child: DateWidget(
              table: widget.table[i],
              // الشرط دا عشان لون الاختيار
              selected: selectedDayId == widget.table[i].id ? false : true,
            ),
          )),
    );
  }
}

class CardWidget extends StatelessWidget {
  final user.TableSubject subjects;
  const CardWidget({
    Key key,
    this.subjects,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LineGen(
              lines: [20.0, 40.0, 60.0, 10.0],
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Container(
              height: 100.0,
              decoration: BoxDecoration(
                color: Color(0xff90caf9),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 4.0),
                color: Color(0xfffcf9f5),
                padding: EdgeInsets.only(
                  left: 16.0,
                  top: 8.0,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 25.0,
                        child: Row(
                          children: <Widget>[
                            Text(subjects.lecTime,
                                style: TextStyle(
                                  color: Color(0xff0d47a1),
                                )),
                            VerticalDivider(),
                            Text(subjects.online,
                                style: TextStyle(
                                  color: Color(0xff0d47a1),
                                )),
                          ],
                        ),
                      ),
                      Text(
                        subjects.subject,
                        style: TextStyle(
                            color: Color(0xff0d47a1),
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        subjects.professor,
                        style: TextStyle(
                            color: Color(0xff0d47a1),
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LineGen extends StatelessWidget {
  final List lines;
  const LineGen({Key key, this.lines}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
            4,
                (index) => Container(
              height: 2.0,
              width: lines[index],
              color: Color(0xffd0d2d8),
              margin: EdgeInsets.symmetric(vertical: 14.0),
            )));
  }
}

class DateWidget extends StatefulWidget {
  // final index;
  final user.Table table;
  final bool selected;
  const DateWidget({Key key, this.table, this.selected}) : super(key: key);

  @override
  _DateWidgetState createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  user.Table table;
  @override
  void initState() {
    super.initState();
    table = widget.table;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        decoration: widget.selected
            ? null
            : BoxDecoration(
            color: Color(0xffa79abf),
            borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child:
        Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(
            table.dayId,
            style: TextStyle(
                color: widget.selected ? Color(0xff8e7def) : Colors.white),
          ),
          // Text(
          //   "",
          //   style: TextStyle(
          //       fontWeight:
          //           widget.selected ? FontWeight.normal : FontWeight.bold,
          //       color: widget.selected ? Color(0xff8e7def) : Colors.white),
          // ),
          Container(
            width: 4.0,
            height: 4.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.selected ? Color(0xff8e7def) : Colors.white,
            ),
          )
        ]));
  }
}

class TopRow extends StatelessWidget {
  const TopRow({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              "Daily",
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              "time table",
              style: TextStyle(
                  color: Color(0xffa79abf),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Spacer(),
      ],
    );
  }
}
