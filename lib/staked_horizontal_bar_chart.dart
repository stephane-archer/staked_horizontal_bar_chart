library staked_horizontal_bar_chart;

import 'package:flutter/material.dart';

class StakedHorizontalBarChart extends StatelessWidget {
  final List<StakedHorizontalBarChartData> _data;
  final double _gap;

  const StakedHorizontalBarChart({
    super.key,
    required List<StakedHorizontalBarChartData> data,
    double gap = .02,
  })  : _gap = gap,
        _data = data;

  List<Color> get _processedColors {
    return _data.fold(
        <Color>[],
        (List<Color> l, d) => [
              ...l,
              d._color,
              d._color,
              Colors.transparent,
              Colors.transparent,
            ])
      ..removeLast()
      ..removeLast();
  }

  List<double> get _processedStops {
    double totalGapsWith = _gap * (_data.length - 1);
    double totalData = _data.fold(0, (a, b) => a + b._units);
    return _data.fold(<double>[0.0], (List<double> l, d) {
      l.add(l.last + d._units * (1 - totalGapsWith) / totalData);
      l.add(l.last);
      l.add(l.last + _gap);
      l.add(l.last);
      return l;
    })
      ..removeLast()
      ..removeLast()
      ..removeLast();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(500),
        ),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: _processedStops,
          colors: _processedColors,
        ),
      ),
    );
  }
}

class StakedHorizontalBarChartData {
  final double _units;
  final Color _color;

  StakedHorizontalBarChartData({required double units, required Color color})
      : _color = color,
        _units = units;
}
