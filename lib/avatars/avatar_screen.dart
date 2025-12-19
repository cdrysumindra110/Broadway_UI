import 'package:broadway_example_ui/avatars/avatar_model.dart';
import 'package:broadway_example_ui/avatars/avatar_service.dart';
import 'package:flutter/material.dart';

class AvatarScreen extends StatefulWidget {
  const AvatarScreen({super.key});

  @override
  State<AvatarScreen> createState() => _AvatarScreenState();
}

class _AvatarScreenState extends State<AvatarScreen> {
  List<AvatarModel> avatar = [];
  AvatarService service = AvatarService();
  @override
  void initState() {
    getEpisodes();
    super.initState();
  }

  Future<void> getEpisodes() async {
    final data = await service.GetAvatarEpisodes();
    setState(() {
      avatar = data;
    });
  }
  // {
  //       "id": 1,
  //       "Season": "1",
  //       "NumInSeason": "1",
  //       "Title": "'The Boy in the Iceberg'",
  //       "AnimatedBy": "JM Animation",
  //       "DirectedBy": "Dave Filoni",
  //       "WrittenBy": [
  //           "Michael Dante DiMartino",
  //           "Bryan Konietzko"
  //       ],
  //       "OriginalAirDate": "February 21, 2005",
  //       "ProductionCode ": "101"
  //   },

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Avatar Episodes")),
      body: Expanded(
        child: ListView.builder(
          itemCount: avatar.length,
          itemBuilder: (context, index) {
            final data = avatar[index];
            return Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.5),
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(data.title),
                  ),
                  Text("${data.id}"),
                  Text("Season:${data.season}"),
                  Text("NumInSeason:${data.numInSeason}"),

                  Text("Animated By:${data.animatedBy}"),
                  Text("Directed By:${data.directedBy}"),
                  Text("Written By:${data.writtenBy[0]}"),
                  Text("OriginalAirDate:${data.originalAirDate}"),
                  Text("ProductionCode:${data.productionCode}"),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
