library ripple_button;

import 'package:flutter/material.dart';

enum IconPosition {
  Left,
  Right,
  Top,
  Bottom
}

class RippleButton extends StatelessWidget
{
  final VoidCallback onTap;
  final Color color;
  final Color disabledColor;
  final double elevation;
  final double borderRadius;
  final Widget child;
  final String text;
  final TextStyle textStyle;
  final Widget icon;
  final double width;
  final double height;
  final Color splashColor;
  final String tooltip;
  final IconPosition iconPosition;

  const RippleButton({Key key,
    this.onTap,
    this.color,
    this.disabledColor = const Color.fromRGBO(0x99, 0x99, 0x99, 1.0),
    this.elevation = 5,
    this.borderRadius = 0,
    this.child,
    this.text,
    this.textStyle,
    this.icon,
    this.iconPosition = IconPosition.Left,
    this.splashColor = Colors.white,
    this.tooltip,
    this.width,
    this.height}): assert(!(child != null && (text != null || icon != null))),
                   assert(!(child != null && (width != null || height != null))),
                   assert(textStyle == null || text != null),
                   super(key: key);

  @override
  Widget build(BuildContext context)
  {
    final childContent = child ?? _createChild(context);
    final materialWidget = _createMaterial(context, childContent);

    return tooltip == null ? materialWidget : Tooltip(message: tooltip, child: materialWidget);
  }

  Material _createMaterial(BuildContext context, Widget childContent)
  {
    return Material(
      elevation: elevation,
      type: MaterialType.button,
      borderRadius: BorderRadius.circular(borderRadius),
      color: (this.onTap == null && color != Colors.transparent) ? this.disabledColor : (color ?? Theme.of(context).primaryColor),
      child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onTap,
          splashColor: splashColor,
          child: childContent
      ),
    );
  }

  Widget _createChild(BuildContext context)
  {
    return Container(
      width: width ?? MediaQuery.of(context).size.width - 32,
      height: height ?? 48,
      child: _createChildFlexContainer(_createFlexChildren(context)),
    );
  }

  Flex _createChildFlexContainer(List<Widget> children) {
    return iconPosition == IconPosition.Left || iconPosition == IconPosition.Right ?
                          Row(
                            children: children,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ) :
                          Column(
                            children: children,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          );
  }

  List<Widget> _createFlexChildren(BuildContext context) {
    if (iconPosition == IconPosition.Right || iconPosition == IconPosition.Bottom) {
      return <Widget>[
        if (icon == null || text != null) _createTextChild(context),
        if (icon != null && text != null) SizedBox(width: 20),
        if (icon != null) icon,
      ];
    } else {
      return <Widget>[
        if (icon != null) icon,
        if (icon != null && text != null) SizedBox(width: 20),
        if (icon == null || text != null) _createTextChild(context),
      ];
    }
  }

  Widget _createTextChild(BuildContext context)
  {
    final isDisabled = onTap == null;

    return Flexible(child:
      Text(
        text,
        overflow: TextOverflow.fade,
        softWrap: false,
        textAlign: icon == null ? TextAlign.center : TextAlign.left,
        style: textStyle ?? TextStyle(
          color: (color == Colors.transparent && isDisabled) ? this.disabledColor : isDisabled ? Colors.white30: Colors.white,
          fontWeight: FontWeight.w600,
          letterSpacing: 2,
        ),
      ),
    );
  }
}
