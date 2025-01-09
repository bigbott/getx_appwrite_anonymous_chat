
import 'dart:math';

import 'package:get/get.dart';

class NameService extends GetxService {
   static putInstance() => Get.put(NameService(), permanent: true);

   var animals =  ['Bear', 'Deer','Cat', 'Dolphin', 'Elk', 
                    'Elephant', 'Hypo', 'Mouse', ];

   var adjectives = ['Lazy',  'Fast',  'Careful',  'White',  
                      'Black',  'Free',  'Openminded',  'Curious',  ];   

    final Random random  = Random();                  

   String  generateName() {
      return 
             adjectives[random.nextInt(adjectives.length)] + '_'
           + animals[random.nextInt(animals.length)] + '_'
             + random.nextInt(100).toString();

   }                                 
}