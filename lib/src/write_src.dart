import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WritePage extends StatefulWidget {
  const WritePage({Key? key}) : super(key: key);

  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  final _title = TextEditingController();
  final _content = TextEditingController();

  Future<void> saveData(String title, String content) async {
    var db = FirebaseFirestore.instance.collection('memo');
    db.add({"title": title, "content": content, "time": Timestamp.now()});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('메모'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
          leading: IconButton(
              onPressed: () {
                if (_title.text == '' && _content.text == '') {
                  Navigator.of(context).pop();
                  return;
                }

                saveData(_title.text, _content.text);
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back)),
          backgroundColor: Colors.grey[900],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 8, left: 16.0, right: 16.0, bottom: 8),
            child: Column(
              children: [
                TextField(
                  controller: _title,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                      hintText: '제목',
                      hintStyle:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                  cursorColor: Colors.black,
                ),
                TextField(
                  controller: _content,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                      hintText: '여기에 적으세요..',
                      hintStyle: TextStyle(
                        fontSize: 15,
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusColor: Colors.black),
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                  cursorColor: Colors.black,
                  minLines: null,
                  maxLines: null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
