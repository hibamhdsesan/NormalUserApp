import 'package:get/get.dart';

import '../Accounts/View/enter_email.dart';
import 'questionModel.dart';



class QuestionController {
  final QuestionModel model;

  QuestionController(this.model);

  Future<void> submitAnswers(
      List<dynamic> selectedValues,
      DateTime? userBirthday,
      DateTime? motherBirthday,
      DateTime? fatherBirthday) async {
    // Prepare data to send
    Map<String, dynamic> data = {
      'birthDate': userBirthday?.toIso8601String(),
      'motherBirthDate': motherBirthday?.toIso8601String(),
      'fatherBirthDate': fatherBirthday?.toIso8601String(),
      'favoriteColor': selectedValues[0],
      'numberOfSisters': selectedValues[1],
      'numberOfBrothers': selectedValues[2],
      'numberOfMothersSister': selectedValues[3],
      'numberOfFathersSister': selectedValues[4],
      'numberOfMothersBrother': selectedValues[5],
      'numberOfFathersBrother': selectedValues[6],
      'favoriteHobby': selectedValues[7],
      'favoriteSport': selectedValues[8],
      'favoriteSeason': selectedValues[9],
      'favoriteBookType': selectedValues[10],
      'favoriteTravelCountry': selectedValues[11],
      'favoriteFood': selectedValues[12],
      'favoriteDrink': selectedValues[13],
      'favoriteDessert': selectedValues[14],
      'baccalaureateMark': selectedValues[15],
      'ninthGradeMark': selectedValues[16],
    };

    try {
      // Submit data using the model
      bool success = await QuestionModel.submitData(data);

      // Handle success/failure (e.g., show a message)
      if (success) {
        // Handle success scenario
        Get.to(() => enter_email());
        print('Data submitted successfully');
      } else {
        // Handle failure scenario
        print('Failed to submit data');
      }
    } catch (e) {
      // Print the error message
      print('Error occurred while submitting data: $e');
    }
  }
}
