import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var numOfHourController = TextEditingController();
  var hourlyRateController = TextEditingController();
  var regularPay = "0.0";
  var overtimePay = "0.0";
  var totalPay = "0.0";
  var tax = "0.0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pay Calculator"),
        ),
        body: Center(
          child: Container(
            width: 320,
            child: Column(
              children: [
                const SizedBox(
                  height: 21,
                ),
                const Text(
                  "Enter details below to get pay report.",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 31,
                ),
                TextField(
                  controller: numOfHourController,
                  decoration: const InputDecoration(
                      label: Text("Number of hours"),
                      prefixIcon: Icon(Icons.timelapse)),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 21,
                ),
                TextField(
                  controller: hourlyRateController,
                  decoration: const InputDecoration(
                      label: Text("Hourly rate"),
                      prefixIcon: Icon(Icons.money)),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                    width: 150.0,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        var numOfHours = numOfHourController.text.toString();
                        var hourlyRate = hourlyRateController.text.toString();
                        if (numOfHours == "" || hourlyRate == "") {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text("Error"),
                                    content: const Text("Fields cannot be empty!"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Ok"))
                                    ],
                                  ));
                        } else {
                          debugPrint("Hello there");
                          calculateReport(double.parse(numOfHours),
                              double.parse(hourlyRate));
                          setState(() {
                            regularPay = "\$$regularPay";
                            overtimePay = "\$$overtimePay";
                            totalPay = "\$$totalPay";
                            tax = "\$$tax";
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 10,
                          backgroundColor: Colors.pink,
                          textStyle: const TextStyle(fontSize: 20)),
                      child: const Text("Calculate"),
                    )),
                const SizedBox(
                  height: 31,
                ),
                const Text(
                  "REPORT",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black54),
                ),
                const Divider(
                  color: Colors.black12,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 300,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        "Regular Pay: $regularPay",
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Overtime Pay: $overtimePay",
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Total Pay: $totalPay",
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Tax: $tax",
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 120,
                ),
                const Divider(
                  color: Colors.black12,
                ),
                const Text(
                  "Author: Himanshu",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black54),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Student ID: 301296001",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black54),
                ),
              ],
            ),
          ),
        ));
  }

  void calculateReport(double noh, double hr) {
    if (noh <= 40) {
      totalPay = (noh * hr).toString();
      regularPay = totalPay;
      tax = (double.parse(regularPay) * 0.18).toString();
    } else if (noh > 40) {
      overtimePay = ((noh - 40) * hr * 1.5).toString();
      regularPay = (40 * hr).toString();
      totalPay =
          (double.parse(overtimePay) + double.parse(regularPay)).toString();
      tax = (double.parse(totalPay) * 0.18).toString();
    }
    numOfHourController.text = "";
    hourlyRateController.text = "";
  }
}
