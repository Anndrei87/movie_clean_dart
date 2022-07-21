import 'package:dart_clean_movies/app/core/shared/widgets/buttons/enums/button_enums.dart';
import 'package:flutter/material.dart';

class MediumButton extends StatelessWidget {
  final Color? disabledColor;
  final bool enableButton;
  final double? iconSize;
  final bool enableIcon;
  final bool enableText;
  final IconLocation iconLocation;
  final String? text;
  final IconData? icon;
  final Color? iconColor;
  final TextStyle? textStyle;
  final Color? buttonColor;
  final GestureTapCallback onPressed;
  final double? borderRadius;

  const MediumButton({
    Key? key,
    this.iconSize,
    this.enableButton = true,
    this.disabledColor,
    this.enableText = true,
    this.enableIcon = false,
    this.text,
    this.icon,
    this.textStyle,
    this.buttonColor,
    this.iconColor,
    this.iconLocation = IconLocation.beforeText,
    this.borderRadius,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48, maxHeight: 48),
      child: _FilledButton(
        iconSize: iconSize,
        enableButton: enableButton,
        disabledColor: disabledColor,
        onPressed: onPressed,
        borderRadius: borderRadius,
        padding: const EdgeInsets.all(12),
        buttonColor: buttonColor,
        iconLocation: iconLocation,
        enableIcon: enableIcon,
        icon: icon,
        iconColor: iconColor,
        enableText: enableText,
        text: text,
        textStyle: textStyle,
      ),
    );
  }
}

class _FilledButton extends StatelessWidget {
  _FilledButton({
    required this.enableButton,
    required this.disabledColor,
    required this.onPressed,
    required this.buttonColor,
    required this.iconLocation,
    required this.enableIcon,
    required this.icon,
    required this.iconColor,
    required this.enableText,
    required this.text,
    this.iconSize,
    this.textStyle,
    this.padding,
    this.borderRadius,
  })  : assert(
            !(enableIcon == false && enableText == false),
            throw Exception(
                'As propriedades enableIcon e enableText não podem ser falsas ao mesmo tempo')),
        assert(
            enableIcon ? icon != null : true,
            throw Exception(
                'Um ícone deve ser apresentado caso a propriedade enableIcon estiver como verdadeira')),
        assert(
            enableText ? text != null : true,
            throw Exception(
                'Um texto deve ser apresentado caso a propriedade enableText estiver como verdadeira'));

  final GestureTapCallback onPressed;
  final Color? buttonColor;
  final IconLocation iconLocation;
  final bool enableIcon;
  final IconData? icon;
  final Color? iconColor;
  final bool enableText;
  final String? text;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final double? borderRadius;
  final Color? disabledColor;
  final bool enableButton;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: enableButton ? onPressed : null,
      color: buttonColor ?? Theme.of(context).highlightColor,
      disabledColor: disabledColor ??
          buttonColor?.withOpacity(0.5) ??
          Theme.of(context).primaryColor.withOpacity(0.5),
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 4)),
      padding: padding,
      minWidth: 0,
      child: IntrinsicWidth(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection: iconLocation == IconLocation.beforeText
              ? TextDirection.ltr
              : TextDirection.rtl,
          children: [
            if (enableIcon) ...[
              Icon(icon,
                  color: iconColor ?? Colors.white, size: iconSize ?? 22),
            ],
            if (enableIcon && enableText) ...[
              const VerticalDivider(color: Colors.transparent),
            ],
            if (enableText) ...[
              Text(
                text!,
                overflow: TextOverflow.ellipsis,
                style: textStyle ??
                    Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: Colors.white),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
