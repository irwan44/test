
import 'package:fine_stepper/fine_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../../componen/color.dart';
import '../../../data/data_endpoint/general_chackup.dart';
import '../../../data/endpoint.dart';
import 'card_general.dart';

class DetailTemaView extends StatefulWidget {
  const DetailTemaView({super.key});

  @override
  State<DetailTemaView> createState() => _DetailTemaViewState();
}

class _DetailTemaViewState extends State<DetailTemaView> {
  int index = 0;

  Widget iconExample() {
    return FineStepper.icon(
      onFinish: () => Future.delayed(const Duration(seconds: 2)),
      indicatorOptions: const IndicatorOptions(scrollable: true),
      steps: [
        StepItem.icon(builder: buildColumnStep),
        StepItem.icon(builder: buildStackStep),
        StepItem.icon(builder: buildFormStep),
        StepItem.icon(builder: buildTanggalAcaraStep),
        StepItem.icon(builder: buildGalleryStep),
        StepItem.icon(builder: buildUcapamStep),
        StepItem.icon(builder: buildStallTestStep),
      ],
    );
  }

  Widget linearExample() {
    return FineStepper.linear(
      onFinish: () => Future.delayed(const Duration(seconds: 2)),
      steps: [
        StepItem.linear(
          title: '',
          description: 'This is a desc',
          builder: buildColumnStep,
        ),
        StepItem.linear(
          title: '',
          builder: buildStackStep,
        ),
        StepItem.linear(
          title: '',
          builder: buildStackStep,
        ),
        StepItem.linear(
          title: '',
          builder: buildTanggalAcaraStep,
        ),
        StepItem.linear(
          title: '',
          builder: buildGalleryStep,
        ),
        StepItem.linear(
          title: '',
          builder: buildUcapamStep,
        ), StepItem.linear(
          title: '',
          builder: buildStallTestStep,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.amber,
          ).copyWith(
            background: Colors.white,
            onBackground: MyColors.appPrimaryColor,
            primary: MyColors.appPrimaryColor,
            onPrimary: Colors.white,
          ),
        ),
        home: Scaffold(
          body: Builder(
            builder: (context) {
              if (index == 0) {
                return iconExample();
              }
              return linearExample();
            },
          ),
        ),
        );
  }

  Widget buildColumnStep(BuildContext context) {
    String dropdownValue = 'Oke';
    return StepBuilder(
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Step ${FineStepper.of(context).stepIndex + 1}  '
                      'Mesin'
                      '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 17),
                ),
                FutureBuilder(
                  future: API.GeneralID(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      general_checkup? getDataAcc = snapshot.data as general_checkup?;
                      return Column(
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 475),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: getDataAcc?.data
                              ?.where((e) => e.subHeading == "Mesin")
                              ?.map((e) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: e.gcus?.map((gcus) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(gcus.gcu ?? ''), // Tampilkan gcu dari Gcus
                                            ),
                                            DropdownButton<String>(
                                              value: dropdownValue,
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  dropdownValue = newValue!; // perbarui nilai dropdownValue
                                                });
                                              },
                                              items: <String>['Oke', 'Not Oke']
                                                  .map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          ],
                                        ),
                                        // Tampilkan TextField jika dropdownValue adalah 'Not Oke'
                                        if (dropdownValue == 'Not Oke')
                                          TextField(
                                            decoration: InputDecoration(
                                              labelText: 'Keterangan', // Label untuk TextField
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                      ],
                                    );
                                  }).toList() ?? [],
                                ),
                              ],
                            );
                          })
                              ?.toList() ?? [],
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: Get.height - 250,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [],
                          ),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSheetBack() {
    return Container(
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.transparent,
        ),
        child: Column(
          children: [
            Column(
              children: [
                Text('Anda yakin ingin meninggalkan Pengisian Form Wdding ?',
                    textAlign: TextAlign.center),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    // Get.toNamed(Routes.HOME);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green),
                    child: const Center(
                      child: Text('Save sebagai Draf',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue),
                    child: const Center(
                      child: Text('Tetap di Sini',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget buildStackStep(BuildContext context) {
    return StepBuilder(
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Step ${FineStepper.of(context).stepIndex + 1}  '
                      'Brake'
                      '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 17),
                ),
                FutureBuilder(
                  future: API.GeneralID(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      general_checkup? getDataAcc = snapshot.data as general_checkup?;
                      return Column(
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 475),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: getDataAcc?.data
                              ?.where((e) => e.subHeading == "Brake")
                              ?.map((e) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('Step ${FineStepper.of(context).stepIndex + 1} - ${e.subHeading ?? ''}'),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: e.gcus?.map((gcus) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: Text(gcus.gcu ?? ''), // Tampilkan gcu dari Gcus
                                        ),
                                        DropdownButton<String>(
                                          value: 'Oke', // Nilai default dropdown
                                          onChanged: (String? newValue) {
                                            // Tambahkan logika untuk menangani perubahan nilai dropdown di sini
                                          },
                                          items: <String>['Oke', 'Not Oke'] // Opsi dropdown
                                              .map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    );
                                  }).toList() ?? [],
                                ),
                              ],
                            );
                          })
                              ?.toList() ?? [],
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: Get.height - 250,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [],
                          ),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFormStep(BuildContext context) {
    return StepBuilder(
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Step ${FineStepper.of(context).stepIndex + 1}  '
                      'Accel'
                      '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 17),
                ),
                FutureBuilder(
                  future: API.GeneralID(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      general_checkup? getDataAcc = snapshot.data as general_checkup?;
                      return Column(
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 475),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: getDataAcc?.data
                              ?.where((e) => e.subHeading == "Accel")
                              ?.map((e) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('Step ${FineStepper.of(context).stepIndex + 1} - ${e.subHeading ?? ''}'),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: e.gcus?.map((gcus) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: Text(gcus.gcu ?? ''), // Tampilkan gcu dari Gcus
                                        ),
                                        DropdownButton<String>(
                                          value: 'Oke', // Nilai default dropdown
                                          onChanged: (String? newValue) {
                                            // Tambahkan logika untuk menangani perubahan nilai dropdown di sini
                                          },
                                          items: <String>['Oke', 'Not Oke'] // Opsi dropdown
                                              .map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    );
                                  }).toList() ?? [],
                                ),
                              ],
                            );
                          })
                              ?.toList() ?? [],
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: Get.height - 250,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [],
                          ),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTanggalAcaraStep(BuildContext context) {
    return StepBuilder(
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Step ${FineStepper.of(context).stepIndex + 1}  '
                      'Interior'
                      '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 17),
                ),
                FutureBuilder(
                  future: API.GeneralID(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      general_checkup? getDataAcc = snapshot.data as general_checkup?;
                      return Column(
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 475),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: getDataAcc?.data
                              ?.where((e) => e.subHeading == "Interior")
                              ?.map((e) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('Step ${FineStepper.of(context).stepIndex + 1} - ${e.subHeading ?? ''}'),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: e.gcus?.map((gcus) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: Text(gcus.gcu ?? ''), // Tampilkan gcu dari Gcus
                                        ),
                                        DropdownButton<String>(
                                          value: 'Oke', // Nilai default dropdown
                                          onChanged: (String? newValue) {
                                            // Tambahkan logika untuk menangani perubahan nilai dropdown di sini
                                          },
                                          items: <String>['Oke', 'Not Oke'] // Opsi dropdown
                                              .map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    );
                                  }).toList() ?? [],
                                ),

                              ],
                            );
                          })
                              ?.toList() ?? [],
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: Get.height - 250,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [],
                          ),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildGalleryStep(BuildContext context) {
    return StepBuilder(
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Step ${FineStepper.of(context).stepIndex + 1}  '
                      'Exterior'
                      '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 17),
                ),
                FutureBuilder(
                  future: API.GeneralID(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      general_checkup? getDataAcc = snapshot.data as general_checkup?;
                      return Column(
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 475),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: getDataAcc?.data
                              ?.where((e) => e.subHeading == "Exterior")
                              ?.map((e) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('Step ${FineStepper.of(context).stepIndex + 1} - ${e.subHeading ?? ''}'),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: e.gcus?.map((gcus) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: Text(gcus.gcu ?? ''), // Tampilkan gcu dari Gcus
                                        ),
                                        DropdownButton<String>(
                                          value: 'Oke', // Nilai default dropdown
                                          onChanged: (String? newValue) {
                                            // Tambahkan logika untuk menangani perubahan nilai dropdown di sini
                                          },
                                          items: <String>['Oke', 'Not Oke'] // Opsi dropdown
                                              .map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    );
                                  }).toList() ?? [],
                                ),

                              ],
                            );
                          })
                              ?.toList() ?? [],
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: Get.height - 250,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [],
                          ),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUcapamStep(BuildContext context) {
    return StepBuilder(
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Step ${FineStepper.of(context).stepIndex + 1}  '
                      'Bawah Kendaraan'
                      '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 17),
                ),
                FutureBuilder(
                  future: API.GeneralID(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      general_checkup? getDataAcc = snapshot.data as general_checkup?;
                      return Column(
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 475),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: getDataAcc?.data
                              ?.where((e) => e.subHeading == "Bawah Kendaraan")
                              ?.map((e) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('Step ${FineStepper.of(context).stepIndex + 1} - ${e.subHeading ?? ''}'),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: e.gcus?.map((gcus) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: Text(gcus.gcu ?? ''), // Tampilkan gcu dari Gcus
                                        ),
                                        DropdownButton<String>(
                                          value: 'Oke', // Nilai default dropdown
                                          onChanged: (String? newValue) {
                                            // Tambahkan logika untuk menangani perubahan nilai dropdown di sini
                                          },
                                          items: <String>['Oke', 'Not Oke'] // Opsi dropdown
                                              .map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    );
                                  }).toList() ?? [],
                                ),

                              ],
                            );
                          })
                              ?.toList() ?? [],
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: Get.height - 250,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [],
                          ),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget buildStallTestStep(BuildContext context) {
    return StepBuilder(
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Step ${FineStepper.of(context).stepIndex + 1}  '
                      'Stall Test'
                      '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 17),
                ),
                FutureBuilder(
                  future: API.GeneralID(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      general_checkup? getDataAcc = snapshot.data as general_checkup?;
                      return Column(
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 475),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: getDataAcc?.data
                              ?.where((e) => e.subHeading == "Stall Test")
                              ?.map((e) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('Step ${FineStepper.of(context).stepIndex + 1} - ${e.subHeading ?? ''}'),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: e.gcus?.map((gcus) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: Text(gcus.gcu ?? ''), // Tampilkan gcu dari Gcus
                                        ),
                                        DropdownButton<String>(
                                          value: 'Oke', // Nilai default dropdown
                                          onChanged: (String? newValue) {
                                            // Tambahkan logika untuk menangani perubahan nilai dropdown di sini
                                          },
                                          items: <String>['Oke', 'Not Oke'] // Opsi dropdown
                                              .map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    );
                                  }).toList() ?? [],
                                ),

                              ],
                            );
                          })
                              ?.toList() ?? [],
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: Get.height - 250,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [],
                          ),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
