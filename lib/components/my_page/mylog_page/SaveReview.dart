import 'package:flutter/material.dart';
import '../../../db/database_helper.dart';

class SaveReviewWidget extends StatefulWidget {
  final int movieId; // 追加: レビュー対象の映画のID

  SaveReviewWidget({required this.movieId}); // 追加: コンストラクタにパラメータを受け取る

  @override
  _SaveReviewWidgetState createState() => _SaveReviewWidgetState();
}

class _SaveReviewWidgetState extends State<SaveReviewWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  Map<String, dynamic>? _existingReview;

  @override
  void initState() {
    super.initState();

    // 既存のレコードがある場合、それに基づいて初期値を設定
    _loadExistingReview();
  }

  Future<void> _loadExistingReview() async {
    // 既存のレコードをデータベースから取得
    _existingReview = await DatabaseHelper.instance.getReviewByMovieId(widget.movieId);

    if (_existingReview != null) {
      // 既存のレコードがある場合、初期値としてセット
      _titleController.text = _existingReview?[DatabaseHelper.columnTitle] ?? '';
      _bodyController.text = _existingReview?[DatabaseHelper.columnText] ?? '';
    }
  }

  void _saveReview() async {
    String title = _titleController.text;
    String body = _bodyController.text;

    Map<String, dynamic> row = {
      DatabaseHelper.columnId: _existingReview?[DatabaseHelper.columnId] ?? null,
      DatabaseHelper.columnMovieId: widget.movieId,
      DatabaseHelper.columnTitle: title,
      DatabaseHelper.columnText: body,
      DatabaseHelper.columnUpdatedAt: DateTime.now().toString(),
      DatabaseHelper.columnCreatedAt: DateTime.now().toString(),
      DatabaseHelper.columnVersionNo: 1,
      DatabaseHelper.columnIsDeleted: 0,
    };

    // すでにレコードが存在する場合は更新、存在しない場合は追加
    if (_existingReview != null) {
      // 既存のレコードを更新
      await DatabaseHelper.instance.update(row);
    } else {
      // 新しいレコードを追加
      int newRowId = await DatabaseHelper.instance.insertReview(row);
      print('新しいレコードが追加されました。ID: $newRowId');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _titleController,
          decoration: InputDecoration(labelText: 'タイトル'),
        ),
        TextField(
          controller: _bodyController,
          decoration: InputDecoration(labelText: '内容'),
        ),
        ElevatedButton(
          onPressed: _saveReview,
          child: Text('保存'),
        ),
      ],
    );
  }
}
