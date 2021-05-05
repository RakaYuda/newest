import 'package:flutter/material.dart';

class LargeNewsCard extends StatelessWidget {
  final String title;
  final String urlImage;

  LargeNewsCard({required this.title, required this.urlImage});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              urlImage,
              width: double.infinity,
              height: 160,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
