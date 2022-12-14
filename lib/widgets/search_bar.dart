import 'package:flutter/material.dart';

class CountryFormField extends StatefulWidget {
  const CountryFormField({Key? key}) : super(key: key);

  @override
  _CountryFormFieldState createState() => _CountryFormFieldState();
}

class _CountryFormFieldState extends State<CountryFormField> with TickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  GlobalKey globalKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    OverlayState? overlayState = Overlay.of(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      globalKey;
    });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlay();
        overlayState!.insert(_overlayEntry!);
      } else {
        _overlayEntry!.remove();
      }
    });
  }

  OverlayEntry _createOverlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    var size = renderBox.size;
    return OverlayEntry(
        builder: (context) => Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, size.height + 5.0),
                child: Material(
                  elevation: 5.0,
                  child: Column(
                    children: const [
                      ListTile(
                        title: Text('India'),
                      ),
                      ListTile(
                        title: Text('Australia'),
                      ),
                      ListTile(
                        title: Text('USA'),
                      ),
                      ListTile(
                        title: Text('Canada'),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormField(
        focusNode: _focusNode,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.next,
        // decoration: ,
      ),
    );
  }
}
