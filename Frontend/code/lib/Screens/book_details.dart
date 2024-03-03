import 'package:flutter/material.dart';
import 'package:muqin/Screens/audio_player.dart';
import 'package:muqin/Screens/pdf_viewr.dart';
import 'package:google_fonts/google_fonts.dart';

class BookDetails extends StatelessWidget {
  const BookDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "مجنون ليلى",
            style: GoogleFonts.vazirmatn(
                textStyle: const TextStyle(
                    color: Color.fromRGBO(77, 80, 108, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const PDFViewer()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).buttonTheme.colorScheme!.primary,
                        elevation: 10),
                    child: Text(
                      "اقرأ الكتاب كاملا",
                      style: TextStyle(
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .inversePrimary),
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const PDFViewer()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).buttonTheme.colorScheme!.primary,
                        elevation: 10),
                    child: Text(
                      "اقرأ الملخص",
                      style: TextStyle(
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .inversePrimary),
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) => Player()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).buttonTheme.colorScheme!.primary,
                        elevation: 10),
                    icon: const Icon(Icons.audiotrack)),
              ],
            ),
          ),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            Stack(
              children: [
                Align(
                  child: Container(
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(23, 27, 54, 1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Color.fromRGBO(23, 27, 54, 1.000),
                            strokeAlign: BorderSide.strokeAlignInside,
                            width: 10)),
                    clipBehavior: Clip.hardEdge,
                    child: Image(
                      image: AssetImage("assets/AhmedShawqi.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
            Container(
              child: SmallCard(
                title: 'المؤلف',
                content: 'أحمد شوقي',
                image: AssetImage("assets/ahmadimage.jpg"),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "عن الكتاب:",
                        style: GoogleFonts.vazirmatn(
                            textStyle: TextStyle(
                                color: Color.fromRGBO(77, 80, 108, 1),
                                fontSize: 24)),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    Text(
                      "«مجنون ليلى» هو قيس بن الملوح، من بطون هوازن، وأحد كبار الشعراء الذين عاشوا في القرن الأول الهجري إبان الحكم الأموي، ويعد قيس من المتيَّمين الذين سالت ألسنتهم بالشعر قولًا في الحب والغزل، وسمي بمجنون ليلى لهيامه بها وعشقه لها، ذلك العشق الذي فاق كل الحدود، حتى أصبح مثالًا للعاشقين، ورغم هذا الحب، فقد رفض أهل ليلى أن يزوجوها له، فهام على وجهه ينشد الشعر ويتنقل بين البلاد، حتى مات كمدًا، فأي أُنْس له في الحياة وقد استوحشت، وأي طمأنينة له في نفسه وقد صارت قلقه، وأي حب ينشده في الدنيا بعد حب ليلى! وقد تناولَت هذه المسرحية الشعرية لأمير الشعراء أحمد شوقي، تلك المأساة الدرامية تناولًا متميزًا ورائعًا.",
                      style: GoogleFonts.vazirmatn(
                          color: Color.fromRGBO(109, 110, 121, 1),
                          fontSize: 16),
                      textDirection: TextDirection.rtl,
                    ),
                  ]),
            ),
          ],
        ));
  }
}

class SmallCard extends StatelessWidget {
  final String title;
  final String content;
  final AssetImage image;
  SmallCard({required this.title, required this.content, required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3, // Set the elevation (shadow) of the card
      child: Container(
        padding: EdgeInsets.all(16),
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 8),
                Text(content,
                    style: TextStyle(fontSize: 16),
                    textDirection: TextDirection.rtl),
              ],
            ),
            SizedBox(width: 16),
            ClipOval(
              child: Container(
                width: 50,
                height: 50,
                child: Image(
                  image: image,
                  fit: BoxFit
                      .cover, // BoxFit to cover the entire circular container
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
