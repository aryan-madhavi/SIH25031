import 'package:civic_reporter/Web/Core/Constants/contants.dart';
import 'package:flutter/material.dart';

class RecentReportsCard extends StatefulWidget {
  const RecentReportsCard({super.key});

  @override
  State<RecentReportsCard> createState() => _RecentReportsCardState();
}

class _RecentReportsCardState extends State<RecentReportsCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Title(color: Colors.black, child: Text("Recent Reports")),
              TextButton(
                onPressed: () {
                  setState(() {
                    // ConstantsofSideBar.pageno = 1; 
                    // TODO: not working find some thing elsse
                  });
                },
                child: Text("View All"),
              ),
            ],
          ),
          // TODO: Dynamic Card Listing from Constants
        ],
      ),
    );
  }
}
