import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class ResponseDialog extends StatelessWidget {
  static const double _borderRadius = 2;

  final String _headline;
  final String _body;
  final String _copyableText;

  const ResponseDialog({Key key, @required headline, body, copyableText})
      : _headline = headline,
        _body = body,
        _copyableText = copyableText,
        super(key: key);

  bool notNull(Object o) => o != null;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        _headline,
        textAlign: TextAlign.center,
      ),
      contentPadding: EdgeInsets.zero,
      content: Container(
        margin: EdgeInsets.all(UiHelper.card_margin),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _body != null ? Text(_body) : null,
            SizedBox(height: UiHelper.standard_padding),
            _copyableText != null
                ? _CopyableText(copyableText: _copyableText)
                : null,
          ].where(notNull).toList(),
        ),
      ),
    );
  }
}

class _CopyableText extends StatelessWidget {
  static const double _textBackgroundPadding = UiHelper.standard_padding / 2;
  static final Color _textBackgroundColor = Colors.grey[300];

  final String _copyableText;

  const _CopyableText({Key key, @required copyableText})
      : _copyableText = copyableText,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.end,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(_textBackgroundPadding),
          child: SelectableText(_copyableText),
          decoration: new BoxDecoration(
              color: _textBackgroundColor,
              borderRadius: BorderRadius.all(
                  const Radius.circular(ResponseDialog._borderRadius))),
        ),
        IconButton(
          icon: Icon(Icons.content_copy),
          onPressed: () =>
              Clipboard.setData(ClipboardData(text: _copyableText)),
        )
      ],
    );
  }
}
