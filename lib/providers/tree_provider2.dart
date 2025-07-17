import 'package:flutter/material.dart';

import '../models/tree_node_model.dart';


import 'package:flutter/material.dart';
import '../models/tree_node_model.dart';
import 'base_providers.dart'; // Import BaseProvider

abstract class TreeProvider2 extends BaseProvider {
  Future<void> performTraversal2(TreeNode node, {required bool isBFS});

  Future<void> visitNode(TreeNode node);
  Future<void> backtrackNode(TreeNode node);
  Future<void> completeNode(TreeNode node);

  void resetTree();
}