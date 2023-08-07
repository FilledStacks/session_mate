import 'package:example/ui/common/app_colors.dart';
import 'package:example/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_view.form.dart';
import 'home_viewmodel.dart';

class HomeViewDesktop extends StackedView<HomeViewModel> {
  const HomeViewDesktop({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                verticalSpaceLarge,
                Column(
                  children: [
                    const Text(
                      'Hello, MATE!',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    verticalSpaceSmall,
                    const Text(
                      'Lets make some calls to the api while network inspector monitors them.',
                      style: TextStyle(fontSize: 15),
                    ),
                    verticalSpaceMedium,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Http Client:'),
                        const SizedBox(width: 15),
                        DropdownButton<String>(
                          key: const ValueKey('dropdownField'),
                          value: viewModel.httpClientValue,
                          onChanged: (value) {
                            viewModel.setHttpClient(value!);
                          },
                          items: HttpClientValueToTitleMap.keys
                              .map(
                                (value) => DropdownMenuItem<String>(
                                  key: ValueKey('$value key'),
                                  value: value,
                                  child: Text(
                                    HttpClientValueToTitleMap[value]!,
                                  ),
                                ),
                              )
                              .toList(),
                        )
                      ],
                    ),
                    verticalSpaceMedium,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          color: kcDarkGreyColor,
                          onPressed: viewModel.getResources,
                          child: const Text(
                            'Fetch Resources',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        MaterialButton(
                          color: kcDarkGreyColor,
                          onPressed: viewModel.getCharacters,
                          child: const Text(
                            'Fetch Characters',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        MaterialButton(
                          color: kcDarkGreyColor,
                          onPressed: viewModel.getLocations,
                          child: const Text(
                            'Fetch Locations',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        MaterialButton(
                          color: kcDarkGreyColor,
                          onPressed: viewModel.getEpisodes,
                          child: const Text(
                            'Fetch Episodes',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    verticalSpaceLarge,
                    Text(viewModel.feedback),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
