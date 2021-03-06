import 'package:flutter/material.dart';
import 'package:inapos/model/history_model.dart';
import 'package:inapos/model/install_model.dart';
import 'package:inapos/model/light_pipe_model.dart';
import 'package:inapos/model/pm_model.dart';
import 'package:inapos/model/recieve_model.dart';
import 'package:inapos/model/station_model.dart';
import 'package:inapos/model/status_model.dart';
import 'package:inapos/model/stock_output_detail.dart';
import 'package:inapos/utility/mystyle.dart';

Future<void> normalDialog(BuildContext context, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(
        message,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(fontSize: 15, color: Colors.red),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Future<void> normalDialogReport(BuildContext context, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(
        message,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(fontSize: 15, color: Colors.red),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Future<void> detailStationDialog(
    BuildContext context, StationModel stationModel) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      titlePadding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      title: Mystyle().showTitleCustom('???????????? : ${stationModel.branchName}'),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Mystyle().sarabunTitle(' ???????????????????????? : '),
                Mystyle().sarabunBody('${stationModel.branchCode}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Mystyle().sarabunTitle(' ??????????????????????????????????????? : '),
                Mystyle().sarabunBody('${stationModel.branchInstallDate}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Mystyle().sarabunTitle(' ????????????????????? : '),
                Mystyle().sarabunBody('${stationModel.branchAddress}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Mystyle().sarabunTitle(' ???????????????????????? : '),
                Mystyle().sarabunBody('${stationModel.branchTel}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Mystyle().sarabunTitle(' ??????????????? : '),
                Mystyle().sarabunBody('${stationModel.branchLatlong}')
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(fontSize: 15, color: Colors.red),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Future<void> detailWorkDialog(
    BuildContext context, HistoryModel historyModel) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      titlePadding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      title: Mystyle().showTitleCustom('${historyModel.branchName}'),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('???????????????????????? : '),
                Mystyle().sarabunBody('${historyModel.branchCode}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('??????????????????????????????????????? : '),
                Mystyle().sarabunBody('${historyModel.branchInstallDate}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('????????????????????????????????? : '),
                Mystyle().sarabunBody('${historyModel.repairOrderno}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('Work ESS : '),
                Mystyle().sarabunBody('${historyModel.repairWorkess}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('PT Ticket : '),
                Mystyle().sarabunBody('${historyModel.repairTicketpt}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('??????????????????????????????????????? : '),
                Mystyle().sarabunBody('${historyModel.repairOpen}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('???????????????????????????????????? : '),
                Mystyle().sarabunBody('${historyModel.repairClose}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('?????????????????????????????? : '),
                Mystyle().sarabunBody('${historyModel.repairStatus}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('?????????????????????????????????????????? : '),
                Mystyle().sarabunBody('${historyModel.repairDevice}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('Serial No : '),
                Mystyle().sarabunBody('${historyModel.repairSerialDevice}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('?????????????????????????????? : '),
                Mystyle().sarabunBody('${historyModel.repairDetail}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('?????????????????? : '),
                Mystyle().sarabunBody('${historyModel.repairWarranty}')
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(fontSize: 15, color: Colors.red),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Future<void> detailRecieveDialog(
    BuildContext context, RecieveModel recieveModel) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      titlePadding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      title: Mystyle().showTitleCustom('${recieveModel.recId}'),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('????????? Invoice : '),
                Mystyle().sarabunBody('${recieveModel.recInv}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('????????????????????? : '),
                Mystyle().sarabunBody('${recieveModel.stockMaterial}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('??????????????? : '),
                Mystyle().sarabunBody('${recieveModel.recTotal}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('???????????????????????????????????? : '),
                Mystyle().sarabunBody('${recieveModel.recDate}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('?????????????????? : '),
                Mystyle().sarabunBody('${recieveModel.empName}')
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(fontSize: 15, color: Colors.red),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Future<void> installDialog(
    BuildContext context, InstallModel installModel) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      titlePadding: EdgeInsets.symmetric(
        horizontal: 50,
      ),
      title: Mystyle().showTitleCustom2('${installModel.installRef}'),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.blue.shade400,
                  width: 3,
                ),
              ),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Mystyle().sarabunTitle('?????????????????????????????? : ')),
                        Mystyle().sarabunBody('${installModel.teamInstall}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Mystyle().sarabunTitle('??????????????????????????????????????? : ')),
                        Mystyle().sarabunBody('${installModel.dateInstall}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1, child: Mystyle().sarabunTitle('???????????? : ')),
                        Mystyle().sarabunBody('${installModel.branchName}')
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('???????????????????????????????????????????????????????????? : '),
              ],
            ),
            Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue.shade400,
                    width: 3,
                  )),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle().sarabunTitle('??????????????? FCC : ')),
                        Mystyle().sarabunBody('${installModel.totalFcc}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle()
                                .sarabunTitle('?????????????????????????????????????????????????????? : ')),
                        Mystyle().sarabunBody('${installModel.pumpConnection}')
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('??????????????????????????????????????????????????? : '),
              ],
            ),
            Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue.shade400,
                    width: 3,
                  )),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle().sarabunTitle('??????????????? LL : ')),
                        Mystyle().sarabunBody('${installModel.totalLl}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle().sarabunTitle('??????????????? LR : ')),
                        Mystyle().sarabunBody('${installModel.totalLr}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle().sarabunTitle('??????????????? EYS : ')),
                        Mystyle().sarabunBody('${installModel.totalEys}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle().sarabunTitle('??????????????? EYK : ')),
                        Mystyle().sarabunBody('${installModel.totalEyk}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle().sarabunTitle('??????????????? UNION : ')),
                        Mystyle().sarabunBody('${installModel.totalUnion}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle()
                                .sarabunTitle('??????????????? ?????????????????????+???????????????????????? : ')),
                        Mystyle()
                            .sarabunBody('${installModel.totalRubberblock}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child:
                                Mystyle().sarabunTitle('??????????????? ?????????????????????????????? : ')),
                        Mystyle().sarabunBody('${installModel.totalClamp}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle().sarabunTitle('??????????????? ????????? C : ')),
                        Mystyle().sarabunBody('${installModel.totalC}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle().sarabunTitle('??????????????? ?????????????????? : ')),
                        Mystyle().sarabunBody('${installModel.totalCompound}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle().sarabunTitle('??????????????? ????????????????????? : ')),
                        Mystyle().sarabunBody('${installModel.totalFiber}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle()
                                .sarabunTitle('??????????????? ????????????????????????????????????????????? : ')),
                        Mystyle().sarabunBody('${installModel.totalBrass}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle().sarabunTitle('??????????????? PG11 : ')),
                        Mystyle().sarabunBody('${installModel.totalPg11}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('?????????????????????????????????????????? : '),
              ],
            ),
            Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue.shade400,
                    width: 3,
                  )),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Mystyle().sarabunTitle('?????????????????????????????????????????????????????? POS'),
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Mystyle().sarabunTitle('??????????????????????????????????????? : ')),
                        Mystyle().sarabunBody('${installModel.detail1Pos}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1, child: Mystyle().sarabunTitle('S/N : ')),
                        Mystyle().sarabunBody('${installModel.detail2Pos}')
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue.shade400,
                    width: 3,
                  )),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Mystyle().sarabunTitle('??????????????????????????????'),
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Mystyle().sarabunTitle('??????????????????????????????????????? : ')),
                        Mystyle().sarabunBody('${installModel.detail1Printer}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1, child: Mystyle().sarabunTitle('S/N : ')),
                        Mystyle().sarabunBody('${installModel.detail2Printer}')
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue.shade400,
                    width: 3,
                  )),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Mystyle().sarabunTitle('?????????????????? + ???????????????????????????'),
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Mystyle().sarabunTitle('??????????????????????????????????????? : ')),
                        Mystyle().sarabunBody('${installModel.detail1Keyboard}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1, child: Mystyle().sarabunTitle('S/N : ')),
                        Mystyle().sarabunBody('${installModel.detail2Keyboard}')
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue.shade400,
                    width: 3,
                  )),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Mystyle().sarabunTitle('?????????????????????????????????????????? UPS'),
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Mystyle().sarabunTitle('??????????????????????????????????????? : ')),
                        Mystyle().sarabunBody('${installModel.detail1UPS}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1, child: Mystyle().sarabunTitle('S/N : ')),
                        Mystyle().sarabunBody('${installModel.detail2UPS}')
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue.shade400,
                    width: 3,
                  )),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Mystyle().sarabunTitle('????????????????????????????????????????????? Scanner'),
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Mystyle().sarabunTitle('??????????????????????????????????????? : ')),
                        Mystyle().sarabunBody('${installModel.detail1Scanner}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1, child: Mystyle().sarabunTitle('S/N : ')),
                        Mystyle().sarabunBody('${installModel.detail2Scanner}')
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue.shade400,
                    width: 3,
                  )),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Mystyle().sarabunTitle('??????????????? Surge Protector'),
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Mystyle().sarabunTitle('??????????????????????????????????????? : ')),
                        Mystyle().sarabunBody('${installModel.detail1Surge}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1, child: Mystyle().sarabunTitle('S/N : ')),
                        Mystyle().sarabunBody('${installModel.detail2Surge}')
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue.shade400,
                    width: 3,
                  )),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Mystyle().sarabunTitle('AP'),
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Mystyle().sarabunTitle('??????????????????????????????????????? : ')),
                        Mystyle().sarabunBody('${installModel.detail1AP}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1, child: Mystyle().sarabunTitle('S/N : ')),
                        Mystyle().sarabunBody('${installModel.detail2AP}')
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue.shade400,
                    width: 3,
                  )),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Mystyle().sarabunTitle('P2P SLAVE'),
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Mystyle().sarabunTitle('??????????????????????????????????????? : ')),
                        Mystyle().sarabunBody('${installModel.detail1SLAVE}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1, child: Mystyle().sarabunTitle('S/N : ')),
                        Mystyle().sarabunBody('${installModel.detail2SLAVE}')
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue.shade400,
                    width: 3,
                  )),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Mystyle().sarabunTitle('P2P MASTER'),
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Mystyle().sarabunTitle('??????????????????????????????????????? : ')),
                        Mystyle().sarabunBody('${installModel.detail1Master}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1, child: Mystyle().sarabunTitle('S/N : ')),
                        Mystyle().sarabunBody('${installModel.detail2Master}')
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(fontSize: 15, color: Colors.red),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Future<void> pmDialog(BuildContext context, PMmodel pMmodel) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      titlePadding: EdgeInsets.symmetric(
        horizontal: 50,
      ),
      title: Mystyle().showTitleCustom2('${pMmodel.pmRef}'),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.blue.shade400,
                  width: 3,
                ),
              ),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Mystyle().sarabunTitle('?????????????????????????????? : ')),
                        Mystyle().sarabunBody('${pMmodel.teamInstall}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Mystyle().sarabunTitle('???????????????????????? PM : ')),
                        Mystyle().sarabunBody('${pMmodel.datePm}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1, child: Mystyle().sarabunTitle('???????????? : ')),
                        Mystyle().sarabunBody('${pMmodel.branchName}')
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle()
                    .sarabunTitle('????????????????????????????????????????????????????????????????????????????????????????????????????????? S/N : '),
              ],
            ),
            Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue.shade400,
                    width: 3,
                  )),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle().sarabunTitle('??????????????? FCC : ')),
                        Mystyle().sarabunBody('${pMmodel.totalFcc}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child:
                                Mystyle().sarabunTitle('??????????????? POWER 5 V : ')),
                        Mystyle().sarabunBody('${pMmodel.totalPower5v}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child:
                                Mystyle().sarabunTitle('??????????????? POWER 12 V : ')),
                        Mystyle().sarabunBody('${pMmodel.totalPower12v}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle()
                                .sarabunTitle('??????????????? Current Loop : ')),
                        Mystyle().sarabunBody('${pMmodel.totalCurlentloop}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle()
                                .sarabunTitle('??????????????? ???????????????????????? 2 ???. : ')),
                        Mystyle().sarabunBody('${pMmodel.totalAttenna2m}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle()
                                .sarabunTitle('??????????????? ???????????????????????? 3 ???. : ')),
                        Mystyle().sarabunBody('${pMmodel.totalAttenna3m}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle().sarabunTitle('??????????????? ????????? EDC : ')),
                        Mystyle().sarabunBody('${pMmodel.totalEdc}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child:
                                Mystyle().sarabunTitle('??????????????? ??????????????????????????? : ')),
                        Mystyle().sarabunBody('${pMmodel.totalScanner}')
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle()
                    .sarabunTitle('???????????????????????????????????????????????????????????????????????????????????????????????? S/N : '),
              ],
            ),
            Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue.shade400,
                    width: 3,
                  )),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Mystyle().sarabunTitle('?????????????????????????????????????????????????????? POS'),
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Mystyle().sarabunTitle('??????????????????????????????????????? : ')),
                        Mystyle().sarabunBody('${pMmodel.detail1Pos}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1, child: Mystyle().sarabunTitle('S/N : ')),
                        Mystyle().sarabunBody('${pMmodel.detail2Pos}')
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue.shade400,
                    width: 3,
                  )),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Mystyle().sarabunTitle('??????????????????????????????'),
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Mystyle().sarabunTitle('??????????????????????????????????????? : ')),
                        Mystyle().sarabunBody('${pMmodel.detail1Printer}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1, child: Mystyle().sarabunTitle('S/N : ')),
                        Mystyle().sarabunBody('${pMmodel.detail2Printer}')
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue.shade400,
                    width: 3,
                  )),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Mystyle().sarabunTitle('?????????????????? + ???????????????????????????'),
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Mystyle().sarabunTitle('??????????????????????????????????????? : ')),
                        Mystyle().sarabunBody('${pMmodel.detail1Keyboard}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1, child: Mystyle().sarabunTitle('S/N : ')),
                        Mystyle().sarabunBody('${pMmodel.detail2Keyboard}')
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue.shade400,
                    width: 3,
                  )),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Mystyle().sarabunTitle('?????????????????????????????????????????? UPS'),
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Mystyle().sarabunTitle('??????????????????????????????????????? : ')),
                        Mystyle().sarabunBody('${pMmodel.detail1UPS}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1, child: Mystyle().sarabunTitle('S/N : ')),
                        Mystyle().sarabunBody('${pMmodel.detail2UPS}')
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue.shade400,
                    width: 3,
                  )),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Mystyle().sarabunTitle('??????????????? Surge Protector'),
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Mystyle().sarabunTitle('??????????????????????????????????????? : ')),
                        Mystyle().sarabunBody('${pMmodel.detail1Surge}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1, child: Mystyle().sarabunTitle('S/N : ')),
                        Mystyle().sarabunBody('${pMmodel.detail2Surge}')
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue.shade400,
                    width: 3,
                  )),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Mystyle().sarabunTitle('AP'),
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Mystyle().sarabunTitle('??????????????????????????????????????? : ')),
                        Mystyle().sarabunBody('${pMmodel.detail1AP}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1, child: Mystyle().sarabunTitle('S/N : ')),
                        Mystyle().sarabunBody('${pMmodel.detail2AP}')
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue.shade400,
                    width: 3,
                  )),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Mystyle().sarabunTitle('P2P SLAVE'),
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Mystyle().sarabunTitle('??????????????????????????????????????? : ')),
                        Mystyle().sarabunBody('${pMmodel.detail1SLAVE}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1, child: Mystyle().sarabunTitle('S/N : ')),
                        Mystyle().sarabunBody('${pMmodel.detail2SLAVE}')
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue.shade400,
                    width: 3,
                  )),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Mystyle().sarabunTitle('P2P MASTER'),
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Mystyle().sarabunTitle('??????????????????????????????????????? : ')),
                        Mystyle().sarabunBody('${pMmodel.detail1Master}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1, child: Mystyle().sarabunTitle('S/N : ')),
                        Mystyle().sarabunBody('${pMmodel.detail2Master}')
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(fontSize: 15, color: Colors.red),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Future<void> installPipeDialog(
    BuildContext context, LightpipeModel lightpipeModel) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      titlePadding: EdgeInsets.symmetric(
        horizontal: 50,
      ),
      title: Mystyle().showTitleCustom2('${lightpipeModel.installRef}'),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.blue.shade400,
                  width: 3,
                ),
              ),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Mystyle().sarabunTitle('?????????????????????????????? : ')),
                        Mystyle().sarabunBody('${lightpipeModel.teamInstall}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Mystyle().sarabunTitle('??????????????????????????????????????? : ')),
                        Mystyle().sarabunBody('${lightpipeModel.dateInstall}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 1, child: Mystyle().sarabunTitle('???????????? : ')),
                        Mystyle().sarabunBody('${lightpipeModel.branchName}')
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('???????????????????????????????????????????????????????????? : '),
              ],
            ),
            Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue.shade400,
                    width: 3,
                  )),
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle().sarabunTitle('??????????????? LL : ')),
                        Mystyle().sarabunBody('${lightpipeModel.totalLl}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle().sarabunTitle('??????????????? LR : ')),
                        Mystyle().sarabunBody('${lightpipeModel.totalLr}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle().sarabunTitle('??????????????? EYS : ')),
                        Mystyle().sarabunBody('${lightpipeModel.totalEys}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle().sarabunTitle('??????????????? EYK : ')),
                        Mystyle().sarabunBody('${lightpipeModel.totalEyk}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle().sarabunTitle('??????????????? UNION : ')),
                        Mystyle().sarabunBody('${lightpipeModel.totalUnion}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle()
                                .sarabunTitle('??????????????? ?????????????????????+???????????????????????? : ')),
                        Mystyle()
                            .sarabunBody('${lightpipeModel.totalRubberblock}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child:
                                Mystyle().sarabunTitle('??????????????? ?????????????????????????????? : ')),
                        Mystyle().sarabunBody('${lightpipeModel.totalClamp}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle().sarabunTitle('??????????????? ????????? C : ')),
                        Mystyle().sarabunBody('${lightpipeModel.totalC}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle().sarabunTitle('??????????????? ?????????????????? : ')),
                        Mystyle().sarabunBody('${lightpipeModel.totalCompound}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle().sarabunTitle('??????????????? ????????????????????? : ')),
                        Mystyle().sarabunBody('${lightpipeModel.totalFiber}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle()
                                .sarabunTitle('??????????????? ????????????????????????????????????????????? : ')),
                        Mystyle().sarabunBody('${lightpipeModel.totalBrass}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Mystyle().sarabunTitle('??????????????? PG11 : ')),
                        Mystyle().sarabunBody('${lightpipeModel.totalPg11}')
                      ],
                    ),
                    Mystyle().mySizeBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(fontSize: 15, color: Colors.red),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Future<void> detailOutputDialog(
    BuildContext context, StockOutputDetail stockOutputDetail) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      titlePadding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      title: Mystyle().showTitleCustom('${stockOutputDetail.inv}'),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    flex: 1, child: Mystyle().sarabunTitle('?????????????????????????????? : ')),
                Mystyle().sarabunBody('${stockOutputDetail.teaminsTall}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    flex: 1, child: Mystyle().sarabunTitle('???????????????????????????????????? : ')),
                Mystyle().sarabunBody('${stockOutputDetail.dATEdetail}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    flex: 1, child: Mystyle().sarabunTitle('?????????????????????????????? : ')),
                Mystyle().sarabunBody('${stockOutputDetail.empName}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(flex: 2, child: Mystyle().sarabunTitle('POS : ')),
                Mystyle().sarabunBody('${stockOutputDetail.pOS}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(flex: 2, child: Mystyle().sarabunTitle('Printer : ')),
                Mystyle().sarabunBody('${stockOutputDetail.printer}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    flex: 2, child: Mystyle().sarabunTitle('KeyboardMouse : ')),
                Mystyle().sarabunBody('${stockOutputDetail.keyboardMouse}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(flex: 2, child: Mystyle().sarabunTitle('Scanner : ')),
                Mystyle().sarabunBody('${stockOutputDetail.scanner}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(flex: 2, child: Mystyle().sarabunTitle('Ups : ')),
                Mystyle().sarabunBody('${stockOutputDetail.ups}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(flex: 2, child: Mystyle().sarabunTitle('????????? EDC : ')),
                Mystyle().sarabunBody('${stockOutputDetail.eDCCable}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    flex: 2, child: Mystyle().sarabunTitle('?????????????????? 1 ???????????? : ')),
                Mystyle().sarabunBody('${stockOutputDetail.lan1m}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    flex: 2, child: Mystyle().sarabunTitle('?????????????????????????????? : ')),
                Mystyle().sarabunBody('${stockOutputDetail.stainlesssteelpole}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    flex: 2,
                    child: Mystyle().sarabunTitle('???????????????????????? 2 ???????????? : ')),
                Mystyle().sarabunBody('${stockOutputDetail.attenna2m}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    flex: 2,
                    child: Mystyle().sarabunTitle('???????????????????????? 3 ???????????? : ')),
                Mystyle().sarabunBody('${stockOutputDetail.attenna3m}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(flex: 2, child: Mystyle().sarabunTitle('PG 11 : ')),
                Mystyle().sarabunBody('${stockOutputDetail.pg11}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    flex: 2, child: Mystyle().sarabunTitle('??????????????? Surge : ')),
                Mystyle().sarabunBody('${stockOutputDetail.suargeGuard}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    flex: 2,
                    child: Mystyle().sarabunTitle('???????????????????????????????????????????????? : ')),
                Mystyle().sarabunBody('${stockOutputDetail.paperPrint}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(flex: 2, child: Mystyle().sarabunTitle('FCC : ')),
                Mystyle().sarabunBody('${stockOutputDetail.fCC}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    flex: 2, child: Mystyle().sarabunTitle('Power FCC : ')),
                Mystyle().sarabunBody('${stockOutputDetail.powerFcc}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    flex: 2,
                    child: Mystyle().sarabunTitle('Power Curlent Loop : ')),
                Mystyle().sarabunBody('${stockOutputDetail.powerCL}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    flex: 2, child: Mystyle().sarabunTitle('Current Loop : ')),
                Mystyle().sarabunBody('${stockOutputDetail.lOOP}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(flex: 2, child: Mystyle().sarabunTitle('TP-LINK : ')),
                Mystyle().sarabunBody('${stockOutputDetail.p2P}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    flex: 2, child: Mystyle().sarabunTitle('????????? Kios POS : ')),
                Mystyle().sarabunBody('${stockOutputDetail.kiosPos}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    flex: 2,
                    child: Mystyle().sarabunTitle('????????? Kios Fleet : ')),
                Mystyle().sarabunBody('${stockOutputDetail.kiosFleet}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    flex: 2,
                    child: Mystyle().sarabunTitle('????????????????????????????????? Fleet : ')),
                Mystyle().sarabunBody('${stockOutputDetail.miniPc}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    flex: 2, child: Mystyle().sarabunTitle('??????????????? Fleet : ')),
                Mystyle().sarabunBody('${stockOutputDetail.fTD}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    flex: 2, child: Mystyle().sarabunTitle('Keypad Fleet : ')),
                Mystyle().sarabunBody('${stockOutputDetail.pad}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    flex: 2, child: Mystyle().sarabunTitle('Scanner Fleet : ')),
                Mystyle().sarabunBody('${stockOutputDetail.flScanner}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    flex: 2,
                    child: Mystyle().sarabunTitle('Switch Hub 8 port : ')),
                Mystyle().sarabunBody('${stockOutputDetail.hub8}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    flex: 2,
                    child: Mystyle().sarabunTitle('Switch Hub 16 port : ')),
                Mystyle().sarabunBody('${stockOutputDetail.hub16}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    flex: 2, child: Mystyle().sarabunTitle('?????? Ordering : ')),
                Mystyle().sarabunBody('${stockOutputDetail.ordering}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(flex: 2, child: Mystyle().sarabunTitle('LL : ')),
                Mystyle().sarabunBody('${stockOutputDetail.lL}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(flex: 2, child: Mystyle().sarabunTitle('LR : ')),
                Mystyle().sarabunBody('${stockOutputDetail.lR}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(flex: 2, child: Mystyle().sarabunTitle('EYS : ')),
                Mystyle().sarabunBody('${stockOutputDetail.eYS}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(flex: 2, child: Mystyle().sarabunTitle('EYK : ')),
                Mystyle().sarabunBody('${stockOutputDetail.eYK}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(flex: 2, child: Mystyle().sarabunTitle('Union : ')),
                Mystyle().sarabunBody('${stockOutputDetail.uion}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(flex: 2, child: Mystyle().sarabunTitle('???????????????????????? : ')),
                Mystyle().sarabunBody('${stockOutputDetail.rubberBlock}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(flex: 2, child: Mystyle().sarabunTitle('????????????????????? : ')),
                Mystyle().sarabunBody('${stockOutputDetail.socket}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(flex: 2, child: Mystyle().sarabunTitle('????????? : ')),
                Mystyle().sarabunBody('${stockOutputDetail.puk}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                    flex: 2, child: Mystyle().sarabunTitle('?????????????????????????????? : ')),
                Mystyle().sarabunBody('${stockOutputDetail.clamp}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(flex: 2, child: Mystyle().sarabunTitle('????????? C : ')),
                Mystyle().sarabunBody('${stockOutputDetail.c}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(flex: 2, child: Mystyle().sarabunTitle('Compound : ')),
                Mystyle().sarabunBody('${stockOutputDetail.compound}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(flex: 2, child: Mystyle().sarabunTitle('Fiber : ')),
                Mystyle().sarabunBody('${stockOutputDetail.fiber}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Expanded(flex: 2, child: Mystyle().sarabunTitle('ALLOY : ')),
                Mystyle().sarabunBody('${stockOutputDetail.aLLOY}')
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(fontSize: 15, color: Colors.red),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Future<void> detailStatus(BuildContext context, StatusModel statusModel) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      elevation: 20,
      // titlePadding: EdgeInsets.only(left: 100),
      // titlePadding: EdgeInsets.symmetric(
      //   horizontal: 30,
      //   vertical: 20,
      // ),
      title: Text(
        '???????????? : ${statusModel.branchName}',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Sarabun',
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade800),
      ),
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('????????????????????????????????? : '),
                Mystyle().sarabunBody('${statusModel.repairOrderno}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('???????????????????????????????????? : '),
                Mystyle().sarabunBody('${statusModel.repairEmp}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('Work ESS : '),
                Mystyle().sarabunBody('${statusModel.repairWorkess}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('PT Ticket : '),
                Mystyle().sarabunBody('${statusModel.repairTicketpt}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('??????????????????????????????????????? : '),
                Mystyle().sarabunBody('${statusModel.repairOpen}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('???????????????????????????????????? : '),
                Mystyle().sarabunBody('${statusModel.repairClose}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('?????????????????????????????? : '),
                Mystyle().sarabunBody('${statusModel.repairStatus}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('?????????????????????????????????????????? : '),
                Mystyle().sarabunBody('${statusModel.repairDevice}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('Serial No : '),
                Mystyle().sarabunBody('${statusModel.repairSerialDevice}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('?????????????????????????????? : '),
                Mystyle().sarabunBody('${statusModel.repairDetail}')
              ],
            ),
            Mystyle().mySizeBox(),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Mystyle().sarabunTitle('?????????????????? : '),
                Mystyle().sarabunBody('${statusModel.repairWarranty}')
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(fontSize: 15, color: Colors.red),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
