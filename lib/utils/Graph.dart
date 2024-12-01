import "dart:math";

import "package:flutter/material.dart";

class Graph {
  Map<int, int> edges;
  List<Widget> nodes;
  Point<double> widgetSize;
  double radius;

  late Map<int, int> _depths;
  late Map<int, List<int>> _depthLevel;
  late List<Cluster> _clusters;

  Cluster _computeCluster(int node) {
    List<Cluster> children = edges.keys.fold(
      [],
      (l, i) {
        if (edges[i]! == node) l.add(_computeCluster(i));
        return l;
      },
    );
    return Cluster(children, nodes[node], widgetSize);
  }

  int _computeClusterDepth(int acc, Cluster cluster) {
    if (cluster.children.isEmpty) return acc;
    return cluster.children
        .map((c) => _computeClusterDepth(acc + 1, c))
        .fold(0, (a, i) => max(a, i));
  }

  List<Transform> layout() {
    _clusters = [];
    List<Transform> transforms = [];

    for (int i = 0; i < _depthLevel[0]!.length; i++) {
      Cluster c = _computeCluster(_depthLevel[0]![i]);
      c.depth = _computeClusterDepth(0, c);
      _clusters.add(c);
    }

    double maxD = _clusters.fold(0, (a, c) => max(a, c.depth)) + 0.5;

    for (int i = 0; i < _clusters.length; i++) {
      double alpha = 2 * pi * i / _clusters.length;
      Point<double> p = Point(
        radius * (maxD * maxD) * cos(alpha),
        radius * (maxD * maxD) * sin(alpha),
      );

      _clusters[i].center = p;
    }

    for (Cluster c in _clusters) {
      transforms.insertAll(0, c.layout(radius));
    }

    return transforms;
  }

  Graph(this.nodes, this.edges, this.radius, this.widgetSize) {
    _depths = {};
    _depthLevel = {};
    _computeDepths();
    _depths.forEach((n, i) {
      if (_depthLevel.containsKey(i)) {
        _depthLevel[i]!.add(n);
      } else {
        _depthLevel.putIfAbsent(i, () => [n]);
      }
    });
  }

  void _computeDepths() {
    for (int i = 0; i < nodes.length; i++) {
      _computeDepth(i);
    }
  }

  int _computeDepth(int i) {
    if (_depths.containsKey(i)) return _depths[i]!;
    if (!edges.containsKey(i)) {
      _depths.putIfAbsent(i, () => 0);
      return 0;
    }
    int d = 1 + _computeDepth(edges[i]!);
    _depths.putIfAbsent(i, () => d);
    return d;
  }
}

class Cluster {
  late List<Cluster> children;
  late int depth;
  late Point<double> center;
  late Widget node;
  late Point<double> widgetSize;

  Cluster(this.children, this.node, this.widgetSize);

  List<Transform> layout(double radius) {
    for (int i = 0; i < children.length; i++) {
      double alpha = 2 * pi * i / children.length;
      Point<double> p = Point(
        center.x + radius * (depth * depth) * cos(alpha),
        center.y + radius * (depth * depth) * sin(alpha),
      );

      children[i].center = p;
      children[i].depth = depth - 1;
    }

    List<Transform> transforms = children.map((c) => c.layout(radius)).fold(
      [],
      (l, e) {
        l.insertAll(0, e);
        return l;
      },
    );

    transforms.add(
      Transform.translate(
        offset:
            Offset(center.x - widgetSize.x / 2, center.y - widgetSize.y / 2),
        child: node,
      ),
    );

    return transforms;
  }
}
