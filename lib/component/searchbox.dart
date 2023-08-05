import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  _SearchField createState() => _SearchField();
}

class _SearchField extends State<SearchField> {
  final FocusNode _focusnode = FocusNode();
  late OverlayEntry _overlay;
  final TextEditingController _txtcontroller = TextEditingController();

  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _focusnode.addListener(() {
      if (_focusnode.hasFocus) {
        // print("focus");

        _overlay = _createOverlayEntry();
        //final overlay = Overlay.of(context);
        Overlay.of(context)?.insert(_overlay);
      } else {
        if (_overlay?.mounted ?? false) {
          _overlay?.remove();
        }
        // _overlay.remove();
        // _overlay.dispose();
      }
    });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderbox = context.findRenderObject() as RenderBox;
    var size = renderbox.size;
    var offset = renderbox.localToGlobal(Offset.zero);

    return OverlayEntry(
        builder: (context) => Positioned(
            width: size.width,
            left: offset.dx,
            top: offset.dy + size.height + 5.0,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0.0, size.height + 5.0),
              child: Material(
                elevation: 4.9,
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      title: Text("India"),
                      onTap: () {
                        this._txtcontroller.text = "India";
                        _focusnode.nextFocus();
                      },
                    ),
                    ListTile(
                      title: Text("USA"),
                      onTap: () {
                        this._txtcontroller.text = "USA";
                        // _overlay.remove();
                        _focusnode.nextFocus();
                      },
                    ),
                    ListTile(
                      title: Text("UK"),
                      onTap: () {
                        this._txtcontroller.text = "UK";
                        //_overlay.remove();
                        _focusnode.nextFocus();
                      },
                    ),
                  ],
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormField(
        focusNode: _focusnode,
        controller: _txtcontroller,
        decoration: const InputDecoration(labelText: 'Country'),
      ),
    );
  }
}
