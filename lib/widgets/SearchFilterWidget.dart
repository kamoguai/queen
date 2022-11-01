import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:queen/providers/SearchFilterWidgetProvider.dart';
import 'package:queen/widgets/BaseWidget.dart';

class SearchFilterWidget extends StatefulWidget {
  final Function? queryFunc;
  const SearchFilterWidget({Key? key, this.queryFunc}) : super(key: key);

  @override
  State<SearchFilterWidget> createState() => _SearchFilterWidgetState();
}

class _SearchFilterWidgetState extends State<SearchFilterWidget>
    with BaseWidget {
  ///textField controller
  TextEditingController textEditingController = TextEditingController();
  FocusNode textFocus = FocusNode();

  Map<String, dynamic> pickData = {};

  late SearchFilterWidgetProvider _provider;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchFilterWidgetProvider>(
          create: (_) => SearchFilterWidgetProvider(),
        )
      ],
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(builder: (BuildContext _context) {
      _provider = _context.watch<SearchFilterWidgetProvider>();
      return Container(
        child: searchTextField(),
      );
    });
  }

  ///搜尋bar
  Widget searchTextField() {
    Widget w;
    w = Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onSubmitted: (value) {
          _provider.inputText = value;
          widget.queryFunc!(value);
          print(_provider.inputText);
        },
        controller: textEditingController,
        focusNode: textFocus,
        decoration: InputDecoration(
          labelText: 'Search',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
              onPressed: () {
                cleanInput();
              },
              icon: const Icon(Icons.close)),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
        ),
      ),
    );
    return w;
  }

  void cleanInput() {
    textEditingController.clear();
  }
}
