import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/Complaint/complaint_add_edit_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/utils/general_utils.dart';

class MyDigitalSignature extends BaseStatefulWidget {
  static const routeName = '/MyDigitalSignature';

  @override
  _MyDigitalSignatureState createState() => _MyDigitalSignatureState();
}

class _MyDigitalSignatureState extends BaseState<MyDigitalSignature>
    with BasicScreen, WidgetsBindingObserver {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
    exportPenColor: Colors.black,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print('Value changed'));
  }

  @override
  Widget buildBody(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Builder(
          builder: (BuildContext context1) => Scaffold(
            body: Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  height: 75,
                  child: const Center(
                    child: Text(
                      'Draw Your Signature Below',
                      style: TextStyle(
                          color: colorPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Divider(
                  height: 2,
                ),
                //SIGNATURE CANVAS
                Expanded(
                  flex: 15,
                  child: Container(
                    child: Signature(
                      controller: _controller,
                      // height: 300,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                //OK AND CLEAR BUTTONS

                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.black),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        //SHOW EXPORTED IMAGE IN NEW ROUTE
                        IconButton(
                          icon: const Icon(Icons.check),
                          color: Colors.white,
                          onPressed: () async {
                            if (_controller.isNotEmpty) {
                              final Uint8List data =
                                  await _controller.toPngBytes();
                              if (data != null) {
                                //  Navigator.pop(data);
                                Navigator.of(context).pop(data);
                                /*await Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) {
                                      return Scaffold(
                                        appBar: AppBar(),
                                        body: Center(
                                          child: Container(
                                            color: Colors.grey[300],
                                            child: Image.memory(data),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );*/
                              } else {
                                showCommonDialogWithSingleOption(
                                    context, "Signature Is Required !",
                                    onTapOfPositiveButton: () {
                                  Navigator.of(context).pop();
                                });
                              }
                            } else {
                              showCommonDialogWithSingleOption(
                                  context, "Signature Is Required !",
                                  onTapOfPositiveButton: () {
                                Navigator.of(context).pop();
                              });
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.undo),
                          color: Colors.white,
                          onPressed: () {
                            setState(() => _controller.undo());
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.redo),
                          color: Colors.white,
                          onPressed: () {
                            setState(() => _controller.redo());
                          },
                        ),
                        //CLEAR CANVAS
                        IconButton(
                          icon: const Icon(Icons.clear),
                          color: Colors.white,
                          onPressed: () {
                            setState(() => _controller.clear());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                /* Container(
                  height: 300,
                  child: const Center(
                    child: Text('Big container to test scrolling issues'),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, ComplaintAddEditScreen.routeName, clearAllStack: true);
  }
}
