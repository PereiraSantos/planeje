import 'package:flutter/material.dart';

abstract class StatusFactory<StatelessWidget> {
  Widget build(BuildContext context);
}

class Start implements StatusFactory {
  const Start();

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.only(right: 10), child: Icon(Icons.check, color: Colors.grey, size: 18));
  }
}

class Loading implements StatusFactory {
  const Loading();

  @override
  Widget build(BuildContext context) {
    return Container(width: 30, height: 20, padding: EdgeInsets.only(right: 10), child: CircularProgressIndicator(strokeWidth: 1));
  }
}

class Concluded implements StatusFactory {
  const Concluded();

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.only(right: 10), child: Icon(Icons.check, color: Colors.green, size: 18));
  }
}

class Erro implements StatusFactory {
  const Erro();

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.only(right: 10), child: Icon(Icons.error, color: Colors.red, size: 18));
  }
}
