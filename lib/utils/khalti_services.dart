import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class KhaltiServices {
  static Future<String?> generatePidx(int amount) async {
    try {
      final response = await http.post(
        Uri.parse("https://dev.khalti.com/api/v2/epayment/initiate/"),
        headers: {
          "Authorization":
              "Key bb3991073ae3440a846ea939eaca52e1", // Use your Test Secret Key here
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "return_url":
              "https://example.com/", // Swap this out with your custom deep-link scheme later if needed
          "website_url": "https://example.com/",
          "amount":
              amount *
              100, // Khalti expects amounts in Paisa (Rs 1 = 100 Paisa)
          "purchase_order_id":
              "Order_${DateTime.now().millisecondsSinceEpoch}", // Generates unique IDs dynamically
          "purchase_order_name": "Test Product Checkout",
          "customer_info": {
            "name": "Shivam Test Flutter",
            "email": "test@test.com",
            "phone": "9800000000",
          },
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['pidx'];
      } else {
        log("Khalti Pidx Error Status: ${response.statusCode}");
        log("Khalti Response Body: ${response.body}");
        return null;
      }
    } catch (e) {
      log("Exception during pidx generation: $e");
      return null;
    }
  }
}
