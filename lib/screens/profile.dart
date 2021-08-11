import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nepali_food_recipes/components/number_string_container.dart';
import 'package:nepali_food_recipes/components/user.dart';
import 'package:nepali_food_recipes/constants.dart';
import 'package:nepali_food_recipes/providers/auth.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  final QueryDocumentSnapshot? snapshot;
  Profile([this.snapshot]);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    print(widget.snapshot);
    return SafeArea(
      child: Scaffold(
        body: Consumer<AuthProvider>(builder: (context, authProvider, child) {
          return StreamBuilder<DocumentSnapshot>(
              stream: fireStore
                  .collection('users')
                  .doc(authProvider.auth.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                print(snapshot.runtimeType);
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  );
                else {
                  var data = snapshot.data!;

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Info(
                          imageURL: authProvider.auth.currentUser!.photoURL!,
                          email: authProvider.auth.currentUser!.email!,
                          name: authProvider.auth.currentUser!.displayName!,
                        ),
                        kFixedSizedBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            numberStringContainer(data['recipes'], 'Recipes'),
                            numberStringContainer(
                                data['following'], 'following'),
                            numberStringContainer(
                                data['followers'], 'followers'),
                          ],
                        )
                      ],
                    ),
                  );
                }
              });
        }),
      ),
    );
  }
}
