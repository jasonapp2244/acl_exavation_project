import 'package:acl/utils/routes/utils.dart';
import 'package:acl/view/widgets/custom_filter_dropdown.dart';
import 'package:acl/viewmodel/truck_driver_model_view.dart';
import 'package:acl/viewmodel/truck_log_detail_model_view.dart';
import 'package:acl/viewmodel/user_profile_model_view.dart';
import 'package:acl/model/truck_driver_record_model.dart';
import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/auth_button.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:acl/utils/routes/routes_name.dart';
import 'package:acl/view/add_truck_entery_view.dart';
import 'package:acl/view/truck_log_detail_view.dart';
import 'package:acl/view/widgets/custom_driver_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  _HomeviewState createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  String _selectedStatus = 'On Site';
  @override
  void initState() {
    super.initState();
    // Fetch user profile after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProfileModelView>(
        context,
        listen: false,
      ).fetchUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final truckProvider = Provider.of<TruckEntryViewModel>(
      context,
      listen: false,
    );
    Responsive.init(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: ListView(
          children: [
            Column(
              children: [
                _buildHeaderSection(context, truckProvider),

                _buildBottomSheet(context, truckProvider),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- HEADER SECTION ----------------
  Widget _buildHeaderSection(BuildContext context, truckProvider) {
    return Container(
      height: 370,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topRight,
          radius: 0.6,
          focalRadius: 0.1,
          colors: [Color(0xFF4EEED0), Color(0xFF111B19)],
        ),
      ),
      child: Padding(
        padding: Responsive.padding(left: 4, right: 4, top: 2),
        child: Consumer<UserProfileModelView>(
          builder: (context, profileController, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileRow(profileController),
                SizedBox(height: Responsive.h(1)),
                _buildSearchField(context),
                SizedBox(height: Responsive.h(1)),
                _buildTotalTrucksCard(truckProvider),
                SizedBox(height: Responsive.h(1)),
                _buildOnSiteDepartedRow(truckProvider),
                SizedBox(height: Responsive.h(1)),
                _buildAddTruckButton(context),
              ],
            );
          },
        ),
      ),
    );
  }

  // ---------------- PROFILE ROW ----------------
  Widget _buildProfileRow(UserProfileModelView profileController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/Ellipse 2@2x.png"),
            ),
            SizedBox(width: Responsive.w(2)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profileController.name.isNotEmpty
                      ? profileController.name
                      : "Loading...",
                  style: GoogleFonts.inter(
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  Utils().getCurrentDate(),
                  style: GoogleFonts.inter(
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // ---------------- SEARCH FIELD ----------------
  Widget _buildSearchField(BuildContext context) {
    return TextFormField(
      onTap: () => Navigator.pushNamed(context, RoutesName.search),
      decoration: InputDecoration(
        hintText: "Search Truck by Number",
        hintStyle: GoogleFonts.rethinkSans(color: AppColor.filletextdColor),
        filled: true,
        fillColor: AppColor.whiteColor.withValues(alpha: 0.2),
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

  // ---------------- TOTAL TRUCKS CARD ----------------
  Widget _buildTotalTrucksCard(TruckEntryViewModel truckProvider) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: AppColor.whiteColor.withValues(alpha: 0.2),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total Trucks",
            style: GoogleFonts.inter(
              fontSize: Responsive.textScaleFactor * 14,
              color: AppColor.whiteColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder<int>(
                stream: truckProvider.allActiveTrucksCount(),
                builder: (context, snapshot) {
                  return Text(
                    "${snapshot.data ?? 0}",
                    style: GoogleFonts.inter(
                      fontSize: Responsive.textScaleFactor * 36,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              SvgPicture.asset("assets/images/truck.svg"),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- ON-SITE AND DEPARTED TRUCKS ----------------
  Widget _buildOnSiteDepartedRow(TruckEntryViewModel truckProvider) {
    return Row(
      children: [
        _buildStatusCard(
          title: "Active Trucks On-Site",
          stream: truckProvider.activeOnSiteTrucksCount(),
        ),
        SizedBox(width: Responsive.w(1)),
        Expanded(
          child: _buildStatusCard(
            title: "Departed Trucks",
            stream: truckProvider.activeDepartedTrucksCount(),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusCard({
    required String title,
    required Stream<int> stream,
  }) {
    return Container(
      height: Responsive.h(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: AppColor.whiteColor.withValues(alpha: 0.2),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: Responsive.textScaleFactor * 12,
              color: AppColor.whiteColor,
            ),
          ),
          StreamBuilder<int>(
            stream: stream,
            builder: (context, snapshot) {
              return Text(
                "${snapshot.data ?? 0}",
                style: GoogleFonts.inter(
                  fontSize: Responsive.textScaleFactor * 36,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ---------------- ADD TRUCK BUTTON ----------------
  Widget _buildAddTruckButton(BuildContext context) {
    return AuthButton(
      buttonText: 'Add New Truck Entry',
      loading: false,
      onPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddTruckEnteryView()),
        );
      },
      prefixIcon: SvgPicture.asset("assets/icons/plus.svg"),
    );
  }

  // ---------------- BOTTOM SHEET ----------------
  Widget _buildBottomSheet(
    BuildContext context,
    TruckEntryViewModel truckProvider,
  ) {
    return Container(
      //height: MediaQuery.of(context).size.height * 0.35,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Active Trucks On-Site",
                  style: GoogleFonts.rethinkSans(
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.textScaleFactor * 14,
                  ),
                ),
                CustomFilterDropdown(
                  options: ["On Site", "Departed", "All View"],
                  initialValue: _selectedStatus,
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value;
                    });
                  },
                ),
              ],
            ),

            _buildActiveTrucksList(truckProvider, _selectedStatus),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveTrucksList(
    TruckEntryViewModel truckProvider,
    String selectedStatus,
  ) {
    return StreamBuilder<List<TruckDriverRecordModel>>(
      stream: truckProvider.truckEntriesStream(selectedStatus),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColor.whiteColor),
          );
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No truck entries found."));
        }

        final entries = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: entries.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final truck = entries[index];
            return CustomTruckEntryCardWidget(
              id: truck.id,
              truckNumber: truck.truckNumber,
              status: truck.status,
              timeIn: truck.timeIn,
              timeOut: truck.timeOut,
              driverName: truck.driverName,
              driverRole: truck.driverRole,
              onTimeOutPressed: () {},
              onViewLogsPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (context) => TruckLogDetailViewModel(),
                      child: TruckLogDetailView(truckNumber: truck.truckNumber),
                    ),
                  ),
                );
              },
              isActive: truck.isActive,
            );
          },
        );
      },
    );
  }
}
