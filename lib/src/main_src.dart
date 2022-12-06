import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/src/write_src.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('메모'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
        leading: const Icon(Icons.menu),
        backgroundColor: Colors.grey[900],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const WritePage();
          }));
        },
        backgroundColor: Colors.grey[900],
        child: const Icon(Icons.add),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('memo').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoading();
          }

          if (snapshot.data!.docs.isEmpty) {
            return _buildNoMemo();
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var content = snapshot.data!.docs[index]['content'].toString();
                var title = snapshot.data!.docs[index]['title'].toString();

                return _buildMemo(title, content);
              });
        });
  }

  Widget _buildNoMemo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(
            child: Text(
          '메모가 하나도',
          style: TextStyle(
            fontSize: 30,
          ),
        )),
        Center(
            child: Text(
          '없습니다',
          style: TextStyle(
            fontSize: 30,
          ),
        )),
        SizedBox(
          height: 50,
        ),
        Center(
            child: Text(
          '여기를 탭해서',
          style: TextStyle(
            fontSize: 30,
          ),
        )),
        Center(
            child: Text(
          '메모를 만드세요',
          style: TextStyle(
            fontSize: 30,
          ),
        ))
      ],
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: Colors.black,
      ),
    );
  }

  Widget _buildMemo(String title, String content) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          leading: const Icon(Icons.filter),
          subtitle: Text(content),
        ),
        const Divider(),
      ],
    );
  }
}
