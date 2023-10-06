import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthhero/src/screen/helper/firebase_helper.dart';

class GridViewScreen extends StatefulWidget {
  const GridViewScreen({super.key});

  @override
  State<GridViewScreen> createState() => _GridViewScreenState();
}

class _GridViewScreenState extends State<GridViewScreen> {
  List images = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 100),
      child: StreamBuilder(
          stream: usersRef
              .doc(firebaseAuth.currentUser?.email)
              .collection('media')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: snapshot.data?.docs[index]['img']),
                  );
                },
                itemCount: snapshot.data?.docs.length,
              );
            }
          }),

      // GridView.builder(
      //   itemCount: data.length,
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
      //   itemBuilder: (BuildContext context, int index) {
      //     return Card(
      //       child: GridTile(
      //         footer: Text(data[index]['name']),
      //         child: Text(data[index]
      //             ['image']), //just for testing, will fill with image later
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
