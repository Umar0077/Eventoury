import 'package:eventoury/mobile/home/frontend/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/payment/Success animation.json", height: 400),
          const SizedBox(height: 20,),
          Text("Payment Successful", style: Theme.of(context).textTheme.headlineSmall,),
          const SizedBox(height: 20,),
               TextButton(
                 onPressed: () {Get.off(() => HomeScreen());  },
                 child: Text("Back to Home", style: Theme.of(context).textTheme.labelLarge,)
               )
        ],
      ),
    );
  }
}
