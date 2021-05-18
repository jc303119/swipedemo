import 'package:flutter/material.dart';

class SwipePullToRefresh extends StatefulWidget {
  @override
  _SwipePullToRefreshState createState() => _SwipePullToRefreshState();
}

class _SwipePullToRefreshState extends State<SwipePullToRefresh> {
  List<String> friends = [];
  initState() {
    print('InitState is called');
    super.initState();
    initFriends();
  }

  initFriends() {
    print('InitFriend function is called');
    friends.add('Ram');
    friends.add('Shyam');
    friends.add('Amit');
    friends.add('Ramesh');
  }

  removeFriends(int index) {
    setState(() {
      friends.removeAt(index);
    });
  }

  int counter = 1;
  Future<Null> addNewFriends() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      friends.add('Jikmat $counter');
    });
    counter++;
    return null;
  }

  friendUndo(int index, String friendName) {
    setState(() {
      friends.insert(index, friendName);
    });
  }

  showMessage(ctx, index, friendName) {
    Scaffold.of(ctx).showSnackBar(SnackBar(
      content: Text('Friend $friendName deleted'),
      action: SnackBarAction(
        label: 'Undo this',
        onPressed: () {
          friendUndo(index, friendName);
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    print('Build is called.........');
    return Scaffold(
      appBar: AppBar(
        title: Text('Swipe and Pull to Refresh'),
      ),
      body: Container(
        child: RefreshIndicator(
          color: Colors.white,
          backgroundColor: Colors.blueAccent,
          onRefresh: addNewFriends,
          child: ListView.builder(
            itemCount: friends.length,
            itemBuilder: (context, index) {
              return Dismissible(
                background: Container(
                  color: Colors.orangeAccent,
                  padding: EdgeInsets.only(right: 30),
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.delete_forever,
                    size: 30,
                  ),
                ),
                key: Key(friends[index]),
                onDismissed: (arg) {
                  String currentFriendName = friends[index];
                  removeFriends(index);
                  showMessage(context, index, currentFriendName);
                },
                child: ListTile(
                  title: Text(
                    friends[index],
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
