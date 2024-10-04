import 'package:flutter/material.dart';

class Discount extends StatefulWidget {
  const Discount({super.key});
  static final priceController = TextEditingController();
  static final discountController = TextEditingController();

  @override
  State<Discount> createState() => _DiscountState();
}

class _DiscountState extends State<Discount> {
  double finalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "D i s c o u n t i n g . . .",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 60,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // العنوان
                  const Text(
                    "Original Price",
                    style: TextStyle(fontSize: 25),
                  ),

                  const SizedBox(height: 15),
                  // الحقل لادخال البيانات
                  TextFormField(
                    controller: Discount.priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter the price here",
                      filled: true,
                      fillColor: Colors.grey[200],
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // العنوان
                  const Text(
                    "Discount Percentage",
                    style: TextStyle(fontSize: 25),
                  ),

                  const SizedBox(height: 15),
                  // الحقل لادخال البيانات
                  TextFormField(
                    controller: Discount.discountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter the percentage here",
                      filled: true,
                      fillColor: Colors.grey[200],
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              const Text(
                "Final Price",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 20),
              Container(
                height: 80,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade400, width: 2),
                ),
                child: Center(
                  child: Text(
                    finalPrice.toString(),
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ),
              const SizedBox(height: 70),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: MaterialButton(
                  color: Colors.grey[400],
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  onPressed: () {
                    setState(() {
                      double price =
                          double.parse(Discount.priceController.text);
                      double discount =
                          double.parse(Discount.discountController.text);

                      double semiFinalPrice = price * (discount / 100);
                      finalPrice = (price - semiFinalPrice);
                    });
                  },
                  child: const Text(
                    "Calculate",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
