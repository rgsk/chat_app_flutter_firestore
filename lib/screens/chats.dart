import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:flutter/cupertino.dart';

class Chats extends StatelessWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chats').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Something went wrong'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text('Loading'),
          );
        }
        if (snapshot.hasData) {
          return CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                largeTitle: Text('Chats'),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  snapshot.data!.docs.map(
                    (document) {
                      final data = document.data()!;
                      return CupertinoListTile(
                        title: Text("$data['name']"),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
