import 'package:counter_app/counter_note.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  GlobalKey<FormState> formState = GlobalKey();

  // محصل العداد
  int counter = 0;

  // الوصول لمحتوى صندوق النص
  TextEditingController textController = TextEditingController();

  // يختبر لو الصندوق فاضي؟
  @override
  void initState() {
    getCurrentData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                // العنوان
                const Text(
                  "Counter",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),

                // العداد
                Container(
                  height: 80,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade400, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      counter.toString(),
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                // الزراير
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //- النقصان
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: MaterialButton(
                        onPressed: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          if (counter > 0) {
                            setState(() {
                              counter--;
                              prefs.setInt("counter", counter);
                            });
                          }
                        },
                        color: Colors.grey[400],
                        elevation: 0,
                        splashColor: Colors.redAccent,
                        padding: const EdgeInsets.all(20),
                        child: const Icon(Icons.remove),
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),

                    //+ الزيادة
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: MaterialButton(
                        onPressed: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          if (counter >= 0) {
                            setState(() {
                              counter++;
                              prefs.setInt("counter", counter);
                            });
                          }
                        },
                        color: Colors.grey[400],
                        elevation: 0,
                        splashColor: Colors.greenAccent,
                        padding: const EdgeInsets.all(20),
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                // تصفير العداد
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: MaterialButton(
                    onPressed: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      setState(() {
                        counter = 0;
                        prefs.setInt("counter", counter);
                      });
                    },
                    color: Colors.grey[400],
                    elevation: 0,
                    splashColor: Colors.yellow,
                    padding: const EdgeInsets.all(15),
                    child: const Text(
                      "Reset",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),

                // اضافة ملاحظات
                Column(
                  children: [
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 40.0, bottom: 10),
                          child: Text(
                            "Notes",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40),
                      child: CounterTextField(
                        textController: textController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // حفظ الملاحظة
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: MaterialButton(
                          onPressed: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString("Notes", textController.text);

                            // يظهر نجاح عملية الحفظ
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 1),
                                backgroundColor: Colors.green,
                                content: Text(
                                  "Saved successfully!",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          },
                          color: Colors.grey[400],
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 50),
                          child: const Text(
                            "save",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getCurrentData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getInt("counter") ?? 0;
      textController.text = prefs.getString("Notes") ?? "";
    });
  }
}
