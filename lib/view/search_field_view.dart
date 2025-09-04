import 'package:acl/view/truck_log_detail_view.dart';
import 'package:acl/view/widgets/custom_loading.dart';
import 'package:acl/viewmodel/searchfield_view_model.dart';
import 'package:acl/model/truck_driver_record_model.dart';
import 'package:acl/res/components/app_color.dart';
import 'package:acl/view/widgets/custom_driver_widget.dart';
import 'package:acl/viewmodel/truck_logs_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SearchFieldView extends StatefulWidget {
  const SearchFieldView({Key? key}) : super(key: key);

  @override
  State<SearchFieldView> createState() => _SearchFieldViewState();
}

class _SearchFieldViewState extends State<SearchFieldView> {
  final TextEditingController searchByNumberController =
      TextEditingController();

  @override
  void dispose() {
    searchByNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildBody(searchProvider),
    );
  }

  // ------------------ APP BAR WITH SEARCH FIELD ------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(backgroundColor: Colors.white, title: _buildSearchField());
  }

  // ------------------ SEARCH TEXT FIELD ------------------
  Widget _buildSearchField() {
    return TextFormField(
      controller: searchByNumberController,
      onChanged: (value) => setState(() {}), // rebuild on input change
      decoration: InputDecoration(
        hintText: "Search Truck by Number",
        hintStyle: GoogleFonts.rethinkSans(color: AppColor.filletextdColor),
        filled: true,
        fillColor: const Color(0xffF6F6F6),
        prefixIcon: Icon(Icons.search, color: AppColor.filletextdColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.whiteColor.withValues(alpha: 0.2),
          ),
          borderRadius: BorderRadius.circular(22),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.whiteColor.withValues(alpha: 0.2),
          ),
          borderRadius: BorderRadius.circular(22),
        ),
      ),
    );
  }

  // ------------------ BODY ------------------
  Widget _buildBody(SearchViewModel searchProvider) {
    final searchText = searchByNumberController.text.trim();

    if (searchText.isEmpty) {
      return const Center(child: Text("Type truck number to search"));
    }

    return _buildSearchResults(searchProvider, searchText);
  }

  // ------------------ SEARCH RESULTS ------------------
  Widget _buildSearchResults(searchProvider, String text) {
    return StreamBuilder<List<TruckDriverRecordModel>>(
      stream: searchProvider.truckEntriesStream(
        searchText: searchByNumberController.text,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child:  CustomLoading(),
          );
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No truck entries found."));
        }

        final entries = snapshot.data!;
        return _buildTruckList(entries);
      },
    );
  }

  // ------------------ TRUCK LIST ------------------
  Widget _buildTruckList(List<TruckDriverRecordModel> entries) {
    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final truck = entries[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          child: CustomTruckEntryCardWidget(
            truckNumber: truck.truckNumber,
            status: truck.status,
            timeIn: truck.timeIn ?? DateTime.now(),
            driverName: truck.driverName,
            driverRole: truck.driverRole,
            onTimeOutPressed: () {},
            onViewLogsPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => TruckLogsViewModel(),
                    child: TruckLogDetailView(truckNumber: truck.truckNumber),
                  ),
                ),
              );
            },
            isActive: truck.isActive,
          ),
        );
      },
    );
  }
}
