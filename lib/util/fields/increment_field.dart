import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IncrementField extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int initialValue;
  final Widget? icon;
  final void Function(int) onChanged;

  const IncrementField({
    super.key,
    this.minValue = 1,
    this.initialValue = 1,
    this.maxValue = 10,
    this.icon,
    required this.onChanged,
  });

  @override
  State<IncrementField> createState() => _IncrementFieldState();
}

class _IncrementFieldState extends State<IncrementField> {
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                tooltip: S.of(context).remove,
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: _value <= widget.minValue
                    ? null
                    : () {
                        _value -= 1;
                        widget.onChanged(_value);
                      },
              ),
            ),
          ),
          Row(
            children: <Widget>[
              if (widget.icon != null) ...<Widget>[
                widget.icon!,
                const SizedBox(width: 4),
              ],
              Text(_value.toString()),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                tooltip: S.of(context).add,
                icon: const Icon(Icons.add_circle_outline),
                onPressed: _value >= widget.maxValue
                    ? null
                    : () {
                        _value += 1;
                        widget.onChanged(_value);
                      },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
