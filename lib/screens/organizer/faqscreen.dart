import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../utils/unitls.dart';
import 'answerfaq.dart';

class FAQscreen extends StatefulWidget {
  FAQscreen({super.key, required this.id});
  String id;
  @override
  State<FAQscreen> createState() => _FAQscreenState();
}

class _FAQscreenState extends State<FAQscreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backGoundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
          mini: true,
          onPressed: () {
            Navigator.pop(context);
          },
          // focusColor: AppColors.focusColor,
          backgroundColor: AppColors.focusColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: height * 0.9,
            width: width,
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('events')
                    .doc(widget.id)
                    .collection('questions')
                    .snapshots(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.focusColor,
                          ),
                        )
                      : ListView.builder(
                          itemCount: snapshot.data!.docs.length + 1,
                          itemBuilder: ((context, index) {
                            return index == 0
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Text(
                                        "FAQ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xfffefefe),
                                          fontSize: width * 0.06,
                                          fontFamily: "Urbanist",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: width * 0.85,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Top Questions",
                                                style: TextStyle(
                                                  color: Color(0xfffefefe),
                                                  fontSize: 16,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : MaterialButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AnswerFAQs(
                                                    eventId: widget.id,
                                                    question: snapshot
                                                        .data!.docs[index - 1]
                                                        .get('question'),
                                                    id: snapshot.data!
                                                        .docs[index - 1].id,
                                                  )),
                                          (route) => true);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          // horizontal: width * 0.1,
                                          vertical: 10),
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 500),
                                        height: height * 0.15,
                                        width: width * 0.8,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Color(0xff434343),
                                                width: 1.5)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.02),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot.data!
                                                            .docs[index - 1]
                                                        ['question'],
                                                    style: TextStyle(
                                                      color: Color(0xfffefefe),
                                                      fontSize: 14,
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * 0.75,
                                              child: AnimatedTextKit(
                                                displayFullTextOnTap: true,
                                                isRepeatingAnimation: false,
                                                animatedTexts: [
                                                  TyperAnimatedText(
                                                      snapshot.data!
                                                              .docs[index - 1]
                                                          ['description'],
                                                      textStyle: TextStyle(
                                                          color: AppColors
                                                              .focusColor))
                                                ],
                                                onTap: () {
                                                  print("Tap Event");
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                          }),
                        );
                }),
          ),
          // Container(
          //   width: width * 0.8,
          //   height: 56,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(8),
          //     color: Colors.white,
          //   ),
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(8),
          //     child: MaterialButton(
          //       onPressed: () {
          //         Navigator.pushAndRemoveUntil(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => AddFAQ(
          //                       id: widget.id,
          //                     )),
          //             (route) => true);
          //       },
          //       child: Center(
          //         child: Text(
          //           "Ask Other Question",
          //           textAlign: TextAlign.center,
          //           style: TextStyle(
          //             color: Colors.black,
          //             fontSize: width * 0.04,
          //             fontFamily: "Urbanist",
          //             fontWeight: FontWeight.w600,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
