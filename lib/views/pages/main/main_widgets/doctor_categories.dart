import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DoctorCategories extends StatelessWidget {
  const DoctorCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SpecialtyCard(specialtyName: "القلبيه")
        ],
      ),
    );
  }
}

class SpecialtyCard extends StatelessWidget {
  final String specialtyName;
  const SpecialtyCard({super.key, required this.specialtyName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Card(
        child: Column(
          children: [
            Text(specialtyName),
            ElevatedButton(onPressed: (){}, child: Text(AppLocalizations.of(context)!.more))
          ],
        ),
      ) ,
    );
  }
}