import 'package:complete_advanced_flutter/app/di.dart';
import 'package:complete_advanced_flutter/domain/model/model.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_render_impl.dart';
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/values_manager.dart';
import 'package:complete_advanced_flutter/presentation/store_details/store_details_viewmodel.dart';
import 'package:flutter/material.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({super.key});

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final StoreDetailsViewModel _viewModel = instance<StoreDetailsViewModel>();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _viewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                context: context,
                contentScreenWidget: _getContentWidget(),
                retryActionFunction: _viewModel.start,
                resetFlowState: _viewModel.resetFlowState,
              ) ??
              Container();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        title: const Text(AppStrings.storeDetails),
        elevation: AppSize.s0,
        iconTheme: IconThemeData(
          //back button
          color: ColorManager.white,
        ),
        backgroundColor: ColorManager.primary,
        centerTitle: true,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        color: ColorManager.white,
        child: SingleChildScrollView(
          child: StreamBuilder<StoreDetails>(
            stream: _viewModel.outputStoreDetails,
            builder: (context, snapshot) {
              return _getItems(snapshot.data);
            },
          ),
        ),
      ),
    );
  }

  Widget _getItems(StoreDetails? storeDetails) {
    if (storeDetails == null) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getImage(storeDetails.image),
        _getSection(
          title: AppStrings.details,
          content: storeDetails.details,
        ),
        _getSection(
          title: AppStrings.services,
          content: storeDetails.services,
        ),
        _getSection(
          title: AppStrings.about,
          content: storeDetails.about,
        ),
      ],
    );
  }

  Widget _getImage(String imageUrl) {
    return Center(
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 250,
      ),
    );
  }

  Widget _getSection({required String title, required String content}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: AppPadding.p12,
            left: AppPadding.p12,
            right: AppPadding.p12,
            bottom: AppPadding.p2,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.left,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSize.s12),
          child: Text(
            content,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }

  @override
  dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
