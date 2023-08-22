import 'dart:ffi';

import 'package:booking_system/views/pages/doctor/widgets/doctor_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utilities/show_bottom_sheet.dart';
import '../auth_widgets.dart';

class DoctorSetupPage extends StatefulWidget {
  const DoctorSetupPage({super.key});

  @override
  State<DoctorSetupPage> createState() => DoctorSetupPageState();
}

class DoctorSetupPageState extends State<DoctorSetupPage> {
  int currentStep = 0;
  String speciality = "Orthopedic";
  final personalFormKey = GlobalKey<FormState>();
  final contactFormKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  List<Step> steps = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    steps = getSteps();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white.withOpacity(0.9),elevation: 0.0,
        // ),
        body: Container(
          padding: EdgeInsets.all(15.w),
          width: MediaQuery.of(context).size.width,
          child: Stepper(
              // stepIconBuilder: (int, stepState) {
              //   if (stepState == StepState.editing) {
              //     return Icon(Icons.edit);
              //   } else if (stepState == StepState.complete) {
              //     return Icon(Icons.compost_outlined);
              //   }
              // },
              controlsBuilder: (context, controlDetails) {
                return Container();
              },
              elevation: 0,
              margin: EdgeInsets.all(10.w),
              type: StepperType.horizontal,
              currentStep: currentStep,
              // onStepTapped: (value) {
              //   setState(() {
              //     currentStep = value;
              //   });
              // },
              // onStepCancel: () {
              //   currentStep == 0
              //       ? null
              //       : setState(() {
              //           currentStep -= 1;
              //         });
              // },
              // onStepContinue: () {
              //   final isLastStep = currentStep == getSteps().length - 1;
              //   if (isLastStep) {
              //     // do something in the last step
              //   } else {
              //     setState(() {
              //       currentStep += 1;
              //     });
              //   }
              // },
              steps: getSteps()),
        ),
      ),
    );
  }

  getSteps() {
    return [
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep == 0,
        title: Text(''),
        content: Form(
          key: personalFormKey,
          child: Column(children: [
            CustomStepTitle(title: "Personal Info"),
            CustomInput(
              fieldName: "first name",
              hint: 'first name',
              validator: (val) {
                if (val != null && val.isEmpty) {
                  return 'please enter your first name';
                }
                return null;
              },
              iconData: Icons.person,
            ),
            CustomInput(
              fieldName: "last name",
              hint: 'last name',
              validator: (val) {
                if (val != null && val.isEmpty) {
                  return 'please enter your first name';
                }
                return null;
              },
              iconData: Icons.person,
            ),
            CustomInput(
              fieldName: "Professional Statment",
              validator: (val) {
                if (val != null && val.isEmpty) {
                  return 'please enter your professional statment';
                }
                return null;
              },
              iconData: Icons.book_online,
              hint: "professional statement",
              maxLines: 5,
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: DropdownButtonFormField(
                  value: speciality,
                  decoration: InputDecoration(
                    hintText: "select your specialty",
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'please select your specialty';
                    } else {
                      return null;
                    }
                  },
                  hint: Text("Specialty"),
                  items: ["Orthopedic", "OBYG"]
                      .map((spec) => DropdownMenuItem(
                            value: spec,
                            child: Text(spec),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      speciality = value!;
                    });
                  }),
            ),

            // CustomInput(fieldName: 'Specialty', validator: (val){
            //   if (val != null && val.isEmpty){
            //     return "please enter your specialty";
            //   }else {
            //     return null;
            //   }
            // }, iconData: iconData, hint: hint)
            SizedBox(
              height: 15.h,
            ),
            ElevatedButton(
                onPressed: () {
                  if (personalFormKey.currentState!.validate()) {
                    setState(() {
                      currentStep += 1;
                    });
                  }
                },
                child: Text(
                  "Next",
                  style: TextStyle(fontSize: 15),
                ))
          ]),
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep == 1,
        title: Text(''),
        content: Form(
          key: contactFormKey,
          child: Column(children: [
            CustomStepTitle(title: "Contact Info"),
            CustomInput(
              fieldName: "Email Address",
              hint: 'Email Address',
              validator: (val) {
                if (val != null && val.isEmpty) {
                  return 'please enter your first name';
                } else if (!val!.contains("@")) {
                  return "please enter a valid email address";
                }
                return null;
              },
              iconData: Icons.email,
            ),
            CustomInput(
              obscureText: obscurePassword,
              suffixIcon:
                  obscurePassword ? Icons.visibility : Icons.visibility_off,
              suffixIconAction: () => setState(() {
                obscurePassword = !obscurePassword;
              }),
              fieldName: "password",
              hint: 'password',
              validator: (val) {
                if (val != null && val.isEmpty) {
                  return 'please enter your first name';
                } else if (val!.trim().length < 8) {
                  return "8 characters is required";
                }
                return null;
              },
              iconData: Icons.password,
            ),
            // confirm password
            CustomInput(
              obscureText: obscurePassword,
              suffixIcon:
                  obscurePassword ? Icons.visibility : Icons.visibility_off,
              suffixIconAction: () => setState(() {
                obscurePassword = !obscurePassword;
              }),
              fieldName: "Confirm password",
              hint: 'Confirm Password',
              validator: (val) {
                if (val != null && val.isEmpty) {
                  return 'please enter your password again';
                }
                return null;
              },
              iconData: Icons.password,
            ),
            CustomInput(
                fieldName: "Phone",
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "please enter your phone number";
                  } else if (!value!.startsWith("07")) {
                    return "Please enter a valid phone number";
                  } else if (value.length < 11) {
                    return "Phone should be 11 digits";
                  }
                  return null;
                },
                iconData: Icons.phone,
                hint: "Phone Number"),
            // CustomPhoneInput(),
            SizedBox(
              height: 20.h,
            ),
            CustomStepperActions(
                onNextAction: () {
                  if (contactFormKey.currentState!.validate()) {
                    onNext();
                  }
                },
                onBackAction: OnBack)
          ]),
        ),
      ),
      Step(
          isActive: currentStep == 2,
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          title: Text(""),
          content: Form(
              child: Column(
            children: [
              CustomStepTitle(title: "Clinic Information"),
              CustomInput(
                  fieldName: "Clinic Name",
                  validator: (val) {
                    if (val != null && val.isEmpty) {
                      return "Clinic Name is required";
                    } else {
                      return null;
                    }
                  },
                  iconData: Icons.abc,
                  hint: "Clinic name"),
              CustomInput(
                  fieldName: "Clinic Phone",
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Clinic Phone is required";
                    } else
                      return null;
                  },
                  iconData: Icons.phone,
                  hint: "enter the clinic's number"),
              CustomStepTitle(title: "Address"),
              CustomDropdownInput(
                  options: ["Baghdad", "Al basra", "Dialla"],
                  hint: "Governorate"),
              CustomInput(
                  fieldName: "City",
                  validator: (val) {
                    if (val != null && val.isEmpty) {
                      return "City is required";
                    } else {
                      return null;
                    }
                  },
                  iconData: Icons.place,
                  hint: "City"),

              SizedBox(
                height: 8,
              ),
              CustomInput(
                  fieldName: "Town",
                  validator: (val) {
                    if (val != null && val.isEmpty) {
                      return "Town is required";
                    } else {
                      return null;
                    }
                  },
                  iconData: Icons.place,
                  hint: "Town"),

              CustomInput(
                  fieldName: "Street Name",
                  validator: (val) {
                    if (val != null && val.isEmpty) {
                      return "Street Name is required";
                    } else {
                      return null;
                    }
                  },
                  iconData: Icons.place,
                  hint: "Street Name"),

              // Row(
              //   mainAxisSize : MainAxisSize.max,
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     Expanded(
              //       child: CustomInput(
              //           fieldName: "Town",
              //           validator: (val) {
              //             if (val != null && val.isEmpty) {
              //               return "Town is required";
              //             } else {
              //               return null;
              //             }
              //           },
              //           iconData: Icons.place,
              //           hint: "Town"),
              //     ),

              //     Expanded(
              //       child: CustomInput(
              //           fieldName: "Street Name",
              //           validator: (val) {
              //             if (val != null && val.isEmpty) {
              //               return "Street Name is required";
              //             } else {
              //               return null;
              //             }
              //           },
              //           iconData: Icons.place,
              //           hint: "Street Name"),
              //     )
              //   ],
              // ),
              SizedBox(
                height: 8,
              ),

              CustomStepperActions(
                onBackAction: OnBack,
                onNextAction: onNext,
              )
            ],
          ))),
      Step(
          // label: Text("Documents"),
          // subtitle: Text("Documents"),
          state: currentStep > 3 ? StepState.complete : StepState.indexed,
          isActive: currentStep == 3,
          title: Text(""),
          content: Column(
            children: [
              const CustomStepTitle(title: "Documnets"),
              // Text("Hello documents"),
              CustomDocumentUploaderCard(
                  onTap: () {}, documentName: "National Id"),
                  SizedBox(height: 8,),
                  CustomDocumentUploaderCard(
                  onTap: () {
                    showImagePickerBottomSheet(context);
                  }, documentName: "Doctor Id"),
                  // SizedBox(height: 8,),CustomDocumentUploaderCard(
                  // onTap: () {}, documentName: "National Id"),
                  SizedBox(height: 16,),
              CustomStepperActions(
                onBackAction: OnBack,
                onNextAction: onNext,
              )
            ],
          )),
    ];
  }

  onNext() {
    if (currentStep < steps.length - 1) {
      setState(() {
        currentStep += 1;
      });
    } else {
      // onLastStepAction();
      print("last step");
    }
  }

  OnBack() {
    currentStep == 0
        ? null
        : setState(() {
            currentStep -= 1;
          });
  }
}
