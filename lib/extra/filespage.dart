import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class Filespage extends StatefulWidget {
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;
  const Filespage({  required this.files,required this.onOpenedFile});

  @override
  State<Filespage> createState() => _FilespageState();
}

class _FilespageState extends State<Filespage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Files"),
        centerTitle: true,
      ),
      body: Center(
        child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8
            ),itemCount: widget.files.length ,
            itemBuilder: (context, index){
              final file = widget.files[index];

              return buildFile(file);

            }),
      ),
    );
  }
  Widget buildFile(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb/1024;
    final fileSize = mb >=1 ?  '${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(file.size)} KB';
    final extension = file.extension ?? 'none';
    final color = getColor(extension);

    return InkWell(
      onTap: ()=> OpenFile.open(file.path!),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration:  BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '.$extension',style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
              ),
            ),
            ),
            SizedBox(height: 8,),
            Text(file.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis),),
            Text(fileSize,style: TextStyle(fontSize: 16),)
          ],
        ),
      ),
    );
  }
  Color getColor(String extension) {
    if (extension == 'pdf') {
      return Colors.red;
    } else if (extension == 'doc' || extension == 'docx') {
      return Colors.blue;
    } else {
      return Colors.grey;
    }
  }
}
