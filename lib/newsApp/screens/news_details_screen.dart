
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewDetailsScreen extends StatefulWidget {
  String newImage, newsTitle, newsdate, author, descripton, content, source;

    NewDetailsScreen(
      {super.key,
      required this.newImage,
      required this.newsTitle,
      required this.newsdate,
      required this.author,
      required this.descripton,
      required this.content,
      required this.source});

  @override
  State<NewDetailsScreen> createState() => _NewDetailsScreenState();
}

class _NewDetailsScreenState extends State<NewDetailsScreen> {
  final format = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    DateTime dateTime = DateTime.parse(widget.newsdate);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      body: Stack(
        children: [
            Container(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(40)
      ),
                child: CachedNetworkImage(
                  imageUrl: widget.newImage,
                  fit: BoxFit.cover,
                  placeholder: (context, url)=>const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          Container(
            height: height*.7,
            margin: EdgeInsets.only(top: height*.3),
            padding: const EdgeInsets.only(top: 20,right: 20,left: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(40)
              ),
            ),
            child: ListView(
              children: [
                Text(widget.newsTitle,style: GoogleFonts.poppins(
                  fontSize:20,color:Colors.black,fontWeight:FontWeight.w700,
                ),),
                SizedBox(height: height*.02,),
                Row(
                  children: [
                    Expanded(
                      child: Text(widget.source,style: GoogleFonts.poppins(
                        fontSize:13,color:Colors.black,fontWeight:FontWeight.w700,
                      ),),
                    ),
                    Text(format.format(dateTime),style: GoogleFonts.poppins(
                      fontSize:12,color:Colors.black,fontWeight:FontWeight.w700,
                    ),),
                  ],
                ),
                SizedBox(height: height*.03,),
                Text(widget.descripton,style: GoogleFonts.poppins(
                  fontSize:15,color:Colors.black,fontWeight:FontWeight.w500,
                ),),

              ],
            ),
          )
        ],
      ),
    );
  }
}
