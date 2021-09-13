import 'package:abwab_elkheir_dashboard/ViewModels/AuthenticationViewModel.dart';
import 'package:abwab_elkheir_dashboard/ViewModels/CasesViewModel.dart';
import 'package:abwab_elkheir_dashboard/Widgets/NavigationBarWidgets/Mobile/NavigationDrawer.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

import '../../Constants/ConstantColors.dart';
import 'package:arabic_numbers/arabic_numbers.dart';

class ViewCasesScreenMobile extends StatefulWidget {
  final deviceSize;

  const ViewCasesScreenMobile({Key key, this.deviceSize}) : super(key: key);
  @override
  _ViewCasesScreenMobileState createState() => _ViewCasesScreenMobileState();
}

class _ViewCasesScreenMobileState extends State<ViewCasesScreenMobile> {
  DateTimeRange dateTimeRange;
  ArabicNumbers arabicNumber = ArabicNumbers();
  CasesViewModel viewModel;
  CasesViewModel listener;
  AuthenticationViewModel auth;
  //CasesViewModel casesViewModel;
  bool isLoading = false;

  final _statusFocusNode = FocusNode();

  @override
  void initState() {
    //casesViewModel = Provider.of<CasesViewModel>(context, listen: false);
    auth = Provider.of<AuthenticationViewModel>(context, listen: false);
    // auth = Provider.of<AuthenticationViewModel>(context, listen: false);
    viewModel = Provider.of<CasesViewModel>(context, listen: false);
    Future.microtask(
      () async {
        viewModel.fetchCases(context, auth.accessToken);
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _statusFocusNode.dispose();
    super.dispose();
  }

  void selectCase(BuildContext context, String id) {
    context.vRouter.push("/editCase/$id");
  }

  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final deviceSize = widget.deviceSize;
    listener = Provider.of<CasesViewModel>(context, listen: true);
    return Scaffold(
      key: _key,
      drawer: NavigationDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ConstantColors.lightBlue,
        onPressed: () {
          context.vRouter.push("/addCase");
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(""),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt_rounded, color: Colors.white),
            onPressed: () {
              //_key.currentState.openDrawer();
              chooseFilter(context, viewModel);
            },
          ),
        ],
        backgroundColor: ConstantColors.lightBlue,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            _key.currentState.openDrawer();
          },
        ),
      ),
      body: RefreshIndicator(
        color: ConstantColors.lightBlue,
        onRefresh: () async {
          await viewModel.fetchCases(context, auth.accessToken);
        },
        child: listener.status == Status.loading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    ConstantColors.lightBlue,
                  ),
                ),
              )
            : listener.cases.isEmpty
                ? Center(
                    child: Text("لا يوجد حالات في الوقت الحالي"),
                  )
                : Container(
                    margin: EdgeInsets.only(top: 10),
                    child: ListView.builder(
                        itemCount: listener.cases.length,
                        itemBuilder: (ctx, index) {
                          return InkWell(
                            onTap: () =>
                                selectCase(ctx, listener.cases[index].id),
                            child: Container(
                              height: deviceSize.height * 0.22,
                              padding: EdgeInsets.all(5),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      // child: Image.network(
                                      //   listener.cases[index].images[0],
                                      //   height: deviceSize.height * 0.22,
                                      //   width: deviceSize.width * 0.4,
                                      //   fit: BoxFit.fill,
                                      // ),

                                      child: Container(
                                          height: deviceSize.height * 0.22,
                                          width: deviceSize.width * 0.4,
                                          // child: FadeInImage(
                                          //   placeholder:
                                          //       AssetImage("assets/placeholder.png"),
                                          //   image: NetworkImage(
                                          //     listener.cases[index].images[0],
                                          //   ),
                                          // ),
                                          child: new FadeInImage.assetNetwork(
                                            placeholder:
                                                "assets/placeholder.png",
                                            image:
                                                listener.cases[index].images[0],
                                            fit: BoxFit.cover,
                                          )),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: deviceSize.width * 0.5,
                                          margin: EdgeInsets.only(bottom: 15),
                                          padding: EdgeInsets.only(
                                              top: 5, bottom: 20, right: 15),
                                          child: Text(
                                            listener.cases[index].title,
                                            textAlign: TextAlign.right,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: ConstantColors.purple),
                                          ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(right: 20),
                                            child: Row(
                                              children: [
                                                Text('الحالة: ',
                                                    textAlign: TextAlign.right,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black)),
                                                Text(
                                                  '${viewModel.cases[index].status}',
                                                  textAlign: TextAlign.right,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: viewModel
                                                                  .cases[index]
                                                                  .status ==
                                                              'في البداية'
                                                          ? Colors.red
                                                          : viewModel
                                                                      .cases[
                                                                          index]
                                                                      .status ==
                                                                  'جاري التجميع'
                                                              ? Colors.orange
                                                              : viewModel
                                                                          .cases[
                                                                              index]
                                                                          .status ==
                                                                      'قارب على الانتهاء'
                                                                  ? Colors.green
                                                                  : Colors
                                                                      .green),
                                                ),
                                              ],
                                            )),
                                        Container(
                                            margin: EdgeInsets.only(right: 20),
                                            child: Text(
                                              'المبلغ: ${arabicNumber.convert(viewModel.cases[index].totalPrice)} جنيه',
                                              textAlign: TextAlign.right,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            ))
                                        // FittedBox(
                                        //   child: Container(
                                        //     width: deviceSize.width * 0.5,
                                        //     child: Text(
                                        //       '${listener.cases[index].donations}/${listener.cases[index].totalPrice} جنيه',
                                        //       textAlign: TextAlign.left,
                                        //     ),
                                        //   ),
                                        // ),
                                        // Container(
                                        //   width: deviceSize.width * 0.5,
                                        //   height: 10,
                                        //   padding: EdgeInsets.only(right: 15),
                                        //   child: Stack(
                                        //     children: <Widget>[
                                        //       Container(
                                        //         decoration: BoxDecoration(
                                        //           border: Border.all(
                                        //               color: Colors.grey,
                                        //               width: 1.0),
                                        //           color: Color.fromRGBO(
                                        //               220, 220, 220, 1),
                                        //           borderRadius:
                                        //               BorderRadius.circular(10),
                                        //         ),
                                        //       ),
                                        //       FractionallySizedBox(
                                        //         widthFactor: listener
                                        //                 .cases[index]
                                        //                 .donations /
                                        //             listener.cases[index]
                                        //                 .totalPrice,
                                        //         child: Container(
                                        //           decoration: BoxDecoration(
                                        //             color:
                                        //                 ConstantColors.purple,
                                        //             borderRadius:
                                        //                 BorderRadius.circular(
                                        //                     10),
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
      ),
    );
  }

  Future chooseFilter(BuildContext context, CasesViewModel viewModel) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              scrollable: true,
              content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: <Widget>[
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          alignment: Alignment.topRight,
                          child: Text('البداية:'),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          alignment: Alignment.topRight,
                          child: Text(
                            dateTimeRange == null
                                ? 'N/A'
                                : arabicNumber.convert(
                                    dateTimeRange.start.day.toString() +
                                        ' - ' +
                                        dateTimeRange.start.month.toString() +
                                        ' - ' +
                                        dateTimeRange.start.year.toString()),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          alignment: Alignment.topRight,
                          child: Text('النهاية:'),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          alignment: Alignment.topRight,
                          child: Text(
                            dateTimeRange == null
                                ? 'N/A'
                                : arabicNumber.convert(
                                    dateTimeRange.end.day.toString() +
                                        ' - ' +
                                        dateTimeRange.end.month.toString() +
                                        ' - ' +
                                        dateTimeRange.end.year.toString()),
                          ),
                        )
                      ],
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        primaryColor: ConstantColors.lightBlue,
                      ),
                      child: Builder(
                        builder: (context) => Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                          child: TextButton(
                            child: Text(
                              'اختر الفترة  الزمنية',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue),
                            ),
                            onPressed: () async {
                              dateTimeRange = await showDateRangePicker(
                                context: context,
                                firstDate: DateTime(
                                  2020,
                                ),
                                lastDate: DateTime.now(),
                                currentDate: DateTime.now(),
                                initialEntryMode: DatePickerEntryMode.calendar,
                                locale: Locale('ar'),
                                useRootNavigator: true,
                                textDirection: TextDirection.ltr,
                              );

                              setState(() {
                                viewModel.setStartDate(
                                    dateTimeRange.start.toString());
                                viewModel
                                    .setEndDate(dateTimeRange.end.toString());
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      alignment: Alignment.topRight,
                      child: Text('الحالة:'),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      width: 200,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(_statusFocusNode);
                            },
                            isExpanded: true,
                            elevation: 10,
                            hint: Text(" درجة الحالة"),
                            value: viewModel.getCasesStatus,
                            items: <DropdownMenuItem>[
                              DropdownMenuItem(
                                value: "فى البداية",
                                child: Text("فى البداية"),
                              ),
                              DropdownMenuItem(
                                value: "قارب على الانتهاء ",
                                child: Text("قارب على الانتهاء"),
                              ),
                              DropdownMenuItem(
                                value: "جاري التجميع ",
                                child: Text("جاري التجميع"),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                viewModel.setStatus(value);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: ElevatedButton(
                        child: Text('بحث'),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                ConstantColors.lightBlue)),
                        onPressed: () {
                          viewModel.fetchCases(context, auth.accessToken);
                        },
                      ),
                      color: ConstantColors.lightBlue,
                    ),
                  ])));
        });
  }
}
