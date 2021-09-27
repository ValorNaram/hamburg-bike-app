import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trufi_core/blocs/home_page_cubit.dart';
import 'package:trufi_core/models/trufi_place.dart';

import 'custom_buttons.dart';
import 'default_location_form_field.dart';

class BAFormFieldsPortrait extends StatelessWidget {
  const BAFormFieldsPortrait({
    Key key,
    @required this.onSaveFrom,
    @required this.onSaveTo,
    @required this.onSwap,
    @required this.onReset,
    this.padding = EdgeInsets.zero,
    this.spaceBetween = 0,
    this.showTitle = true,
    this.isValidateForm = false,
  }) : super(key: key);

  final void Function(TrufiLocation) onSaveFrom;
  final void Function(TrufiLocation) onSaveTo;
  final void Function() onSwap;
  final void Function() onReset;
  final EdgeInsetsGeometry padding;
  final double spaceBetween;
  final bool showTitle;
  final bool isValidateForm;

  @override
  Widget build(BuildContext context) {
    final homePageState = context.read<HomePageCubit>().state;
    final islanguageCodeEn =
        Localizations.localeOf(context).languageCode == "en";
    return Column(
      children: [
        Container(
          padding: padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              DefaultLocationFormField(
                isOrigin: true,
                onSaved: onSaveFrom,
                hintText: islanguageCodeEn ? "Your start" : "Dein Start",
                textLeadingImage: null,
                value: homePageState.fromPlace,
                showTitle: showTitle,
                trailing: homePageState.isPlacesDefined
                    ? ResetButton(onReset: onReset)
                    : null,
                isValid: !isValidateForm || homePageState.fromPlace != null,
              ),
              SizedBox(
                height: spaceBetween,
              ),
              DefaultLocationFormField(
                isOrigin: false,
                onSaved: onSaveTo,
                hintText: islanguageCodeEn ? "Your destination" : "Dein Ziel",
                textLeadingImage: null,
                trailing: homePageState.toPlace != null &&
                        homePageState.fromPlace != null
                    ? SwapButton(
                        orientation: Orientation.portrait,
                        onSwap: onSwap,
                      )
                    : null,
                value: homePageState.toPlace,
                showTitle: showTitle,
                isValid: !isValidateForm || homePageState.toPlace != null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
