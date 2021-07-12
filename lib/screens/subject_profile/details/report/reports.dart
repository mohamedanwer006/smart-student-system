import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triple_s_project/helprs/constant.dart';

enum UploadStatus { success, fail, loading }

class Reports extends StatefulWidget {
  static const routeName = 'reports';

  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Reports> {
  var helper = Constant.helper;
  String fileName;
  bool _dialogIsOpen = false;
  String msg;
  UploadStatus uploadStatus = UploadStatus.loading;
  List<String> list = [];

  getDb() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> _list = [];
    if (sharedPreferences.containsKey('pdf')) {
      _list = await sharedPreferences.getStringList('pdf');
      setState(() {
        list = _list;
      });
    } else {
      await sharedPreferences.setStringList('pdf', _list);
      setState(() {
        list = _list;
      });
    }
  }

  @override
  void initState() {
    getDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(
          'Reports',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: list.isNotEmpty ? list.length : 0,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
              elevation: 4.0,
              color: Theme.of(context).primaryColor,
              margin: EdgeInsets.all(15.0),
              child: Center(
                child: ListTile(
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  leading: CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    child: Text(
                      'PDF',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text("${list[index]}",
                      textAlign: TextAlign.center,
                      style:
                      new TextStyle(fontSize: 20.0, fontFamily: 'Satisfy')),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'upload file',
        onPressed: uploadReport,
      ),
    );
  }

  void uploadReport() async {
    String filePath;
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      filePath = result.files.single.path;
      setState(() {
        fileName = result.files.single.name;
      });
    } else {
      // User canceled the picker
      throw Exception("can't get file now");
    }
    _dialogIsOpen = true;
    showPro();
    if (filePath != null) {
      var resSatuts = await helper.uploadAssignment(
          subjectId: '5',
          assignmentId: '1',
          professorId: '1',
          filePath: filePath);
      if (resSatuts == 200) {
        adTodb(fileName);
        close();
        print(resSatuts);
        uploadStatus = UploadStatus.success;
      }
    } else {
      close();
      uploadStatus = UploadStatus.fail;
      print('Somthing go wrong!!!!');
    }
  }

  showPro() {
    return showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 35.0,
                  height: 35.0,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlue,
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    top: 8.0,
                    bottom: 8.0,
                  ),
                  child: Text(
                    uploadStatus == UploadStatus.loading
                        ? 'upload$fileName'
                        : uploadStatus == UploadStatus.success
                        ? '$fileName uploaded'
                        : 'falil to upload $fileName try again',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  top: 8.0,
                  bottom: 8.0,
                ),
                child: Container())
          ],
        ),
      ),
    );
  }

  void close() {
    if (_dialogIsOpen) {
      Navigator.pop(context);
      _dialogIsOpen = false;
    }
  }

//todo: use a database
  adTodb(String fileName) async {
    List<String> _list = [];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    ;
    if (sharedPreferences.containsKey('pdf')) {
      _list = await sharedPreferences.getStringList('pdf');
      _list.add(fileName);
      await sharedPreferences.setStringList('pdf', _list);
      setState(() {
        list = _list;
      });
    } else {
      _list.add(fileName);
      await sharedPreferences.setStringList('pdf', _list);
      setState(() {
        list = _list;
      });
    }
  }
}
