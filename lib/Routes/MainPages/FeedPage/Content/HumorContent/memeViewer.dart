import 'dart:math';

import 'package:diamond_notched_fab/diamond_notched_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:photo_view/photo_view.dart';
import 'package:socialmedia/Routes/UIElements/DesignElements.dart';

class MemeViewer extends StatefulWidget {
  @override
  _MemeViewerState createState() => _MemeViewerState();
}

class _MemeViewerState extends State<MemeViewer> {
  bool enableRotation = false;
  IconData downloadStatus = Icons.file_download;
  @override
  Widget build(BuildContext context) {
    Map receivedData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.rotate_90_degrees_ccw),
            onPressed: () {
              enableRotation = !enableRotation;
              setState(() {});
            },
          ),
        ],
      ),
      body: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: PhotoView(
            loadingBuilder: (context, chunk) {
              return CircularProgressIndicator(
                backgroundColor: Colors.white,
              );
            },
            imageProvider: NetworkImage(receivedData["meme"]),
            enableRotation: enableRotation,
          ),
        ),
      ),
      floatingActionButton: DiamondNotchedFab(
        backgroundColor: DesignElements.fabBG,
        child: Icon(
          downloadStatus,
          color: DesignElements.fabIcons,
        ),
        onPressed: () async {
          try {
            // Saved with this method.
            var imageId =
                await ImageDownloader.downloadImage(receivedData["meme"]);
            if (imageId == null) {
              return;
            }

            // Below is a method of obtaining saved image information.
            var fileName = await ImageDownloader.findName(imageId);
            var size = await ImageDownloader.findByteSize(imageId);
            var mimeType = await ImageDownloader.findMimeType(imageId);
            var path = await ImageDownloader.findPath(imageId);
            await ImageDownloader.open(path);
          } on PlatformException catch (error) {
            print(error);
          }
          downloadStatus = Icons.download_done_outlined;
          setState(() {});
        },
      ),
    );
  }
}
