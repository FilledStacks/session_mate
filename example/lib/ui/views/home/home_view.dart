import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'home_view.desktop.dart';
import 'home_view.form.dart';
import 'home_view.tablet.dart';
import 'home_view.mobile.dart';
import 'home_viewmodel.dart';

@FormView(fields: [
  FormTextField(
    name: 'email',
  ),
  FormDropdownField(
    name: 'httpClient',
    items: [
      StaticDropdownItem(
        title: 'http',
        value: 'http',
      ),
      StaticDropdownItem(
        title: 'dio',
        value: 'dio',
      ),
    ],
  ),
])
class HomeView extends StackedView<HomeViewModel> with $HomeView {
  const HomeView({super.key});

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return ScreenTypeLayout.builder(
      mobile: (_) => const HomeViewMobile(),
      tablet: (_) => const HomeViewTablet(),
      desktop: (_) => const HomeViewDesktop(),
    );
  }

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    super.onViewModelReady(viewModel);
    syncFormWithViewModel(viewModel);
    viewModel.setupHttpClient();
  }

  @override
  void onDispose(HomeViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
