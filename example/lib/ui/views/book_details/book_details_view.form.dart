// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:bookshelf/ui/views/book_details/book_details_validator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String InscriptionValueKey = 'inscription';
const String UsernameValueKey = 'username';
const String PasswordValueKey = 'password';

final Map<String, TextEditingController>
    _BookDetailsViewTextEditingControllers = {};

final Map<String, FocusNode> _BookDetailsViewFocusNodes = {};

final Map<String, String? Function(String?)?> _BookDetailsViewTextValidations =
    {
  InscriptionValueKey: BookDetailsValidator.validate,
  UsernameValueKey: null,
  PasswordValueKey: null,
};

mixin $BookDetailsView {
  TextEditingController get inscriptionController =>
      _getFormTextEditingController(InscriptionValueKey);
  TextEditingController get usernameController =>
      _getFormTextEditingController(UsernameValueKey);
  TextEditingController get passwordController =>
      _getFormTextEditingController(PasswordValueKey);

  FocusNode get inscriptionFocusNode => _getFormFocusNode(InscriptionValueKey);
  FocusNode get usernameFocusNode => _getFormFocusNode(UsernameValueKey);
  FocusNode get passwordFocusNode => _getFormFocusNode(PasswordValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_BookDetailsViewTextEditingControllers.containsKey(key)) {
      return _BookDetailsViewTextEditingControllers[key]!;
    }

    _BookDetailsViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _BookDetailsViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_BookDetailsViewFocusNodes.containsKey(key)) {
      return _BookDetailsViewFocusNodes[key]!;
    }
    _BookDetailsViewFocusNodes[key] = FocusNode();
    return _BookDetailsViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    inscriptionController.addListener(() => _updateFormData(model));
    usernameController.addListener(() => _updateFormData(model));
    passwordController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    inscriptionController.addListener(() => _updateFormData(model));
    usernameController.addListener(() => _updateFormData(model));
    passwordController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          InscriptionValueKey: inscriptionController.text,
          UsernameValueKey: usernameController.text,
          PasswordValueKey: passwordController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _BookDetailsViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _BookDetailsViewFocusNodes.values) {
      focusNode.dispose();
    }

    _BookDetailsViewTextEditingControllers.clear();
    _BookDetailsViewFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage => this
      .fieldsValidationMessages
      .values
      .any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get inscriptionValue =>
      this.formValueMap[InscriptionValueKey] as String?;
  String? get usernameValue => this.formValueMap[UsernameValueKey] as String?;
  String? get passwordValue => this.formValueMap[PasswordValueKey] as String?;

  set inscriptionValue(String? value) {
    this.setData(
      this.formValueMap..addAll({InscriptionValueKey: value}),
    );

    if (_BookDetailsViewTextEditingControllers.containsKey(
        InscriptionValueKey)) {
      _BookDetailsViewTextEditingControllers[InscriptionValueKey]?.text =
          value ?? '';
    }
  }

  set usernameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({UsernameValueKey: value}),
    );

    if (_BookDetailsViewTextEditingControllers.containsKey(UsernameValueKey)) {
      _BookDetailsViewTextEditingControllers[UsernameValueKey]?.text =
          value ?? '';
    }
  }

  set passwordValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PasswordValueKey: value}),
    );

    if (_BookDetailsViewTextEditingControllers.containsKey(PasswordValueKey)) {
      _BookDetailsViewTextEditingControllers[PasswordValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasInscription =>
      this.formValueMap.containsKey(InscriptionValueKey) &&
      (inscriptionValue?.isNotEmpty ?? false);
  bool get hasUsername =>
      this.formValueMap.containsKey(UsernameValueKey) &&
      (usernameValue?.isNotEmpty ?? false);
  bool get hasPassword =>
      this.formValueMap.containsKey(PasswordValueKey) &&
      (passwordValue?.isNotEmpty ?? false);

  bool get hasInscriptionValidationMessage =>
      this.fieldsValidationMessages[InscriptionValueKey]?.isNotEmpty ?? false;
  bool get hasUsernameValidationMessage =>
      this.fieldsValidationMessages[UsernameValueKey]?.isNotEmpty ?? false;
  bool get hasPasswordValidationMessage =>
      this.fieldsValidationMessages[PasswordValueKey]?.isNotEmpty ?? false;

  String? get inscriptionValidationMessage =>
      this.fieldsValidationMessages[InscriptionValueKey];
  String? get usernameValidationMessage =>
      this.fieldsValidationMessages[UsernameValueKey];
  String? get passwordValidationMessage =>
      this.fieldsValidationMessages[PasswordValueKey];
}

extension Methods on FormStateHelper {
  setInscriptionValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[InscriptionValueKey] = validationMessage;
  setUsernameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[UsernameValueKey] = validationMessage;
  setPasswordValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PasswordValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    inscriptionValue = '';
    usernameValue = '';
    passwordValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      InscriptionValueKey: getValidationMessage(InscriptionValueKey),
      UsernameValueKey: getValidationMessage(UsernameValueKey),
      PasswordValueKey: getValidationMessage(PasswordValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _BookDetailsViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _BookDetailsViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      InscriptionValueKey: getValidationMessage(InscriptionValueKey),
      UsernameValueKey: getValidationMessage(UsernameValueKey),
      PasswordValueKey: getValidationMessage(PasswordValueKey),
    });
