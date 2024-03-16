import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('حول موقن'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      'assets/muqin.png',
                      height: 200,
                      width: 200,
                    )),
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    '''
موقن هو تطبيق رائد في عالم قراءة الكتب العربية، حيث يعتمد على تقنيات الذكاء الاصطناعي المتطورة لتقديم تجربة فريدة لمحبي القراءة. يوفر موقن إمكانية تلخيص الكتب بدقة وعرض صور توضيحية للمحتويات، مما يجعل عملية الفهم والاستيعاب أسرع وأكثر فعالية. كما يتيح التطبيق خاصية الاستماع إلى الكتب، مما يجعله مثاليًا للأشخاص الذين يفضلون تعدد المهام أو لديهم قيود زمنية.
            
وراء هذا التطبيق جهود مبدعة من قبل فريق متميز يقوده محمد الشيخ، سليمان الدخيّل، عبد الرحمن المالكي، سليمان صالح، وأمجد الهاشم. هؤلاء الأفراد جمعوا خبراتهم ومهاراتهم لتطوير منصة تلبي احتياجات عشاق الكتب وتساعد على نشر المعرفة وتحفيز القراءة باللغة العربية. موقن ليس مجرد تطبيق، بل هو بوابة لعالم الكتب، حيث يمكن للمستخدمين استكشاف، قراءة، والاستمتاع بالمحتوى الثري بطريقة مبتكرة وملهمة.''',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
