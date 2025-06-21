import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        title: const Text('Privacidade de dados', style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black54, size: 22),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text('''
O planeje está comprometida com a privacidade e proteção dos dados pessoais de seus usuários. Coletamos informações como nome, e-mail e para melhoria na utilização do aplicação. 

Os dados são armazenados em ambiente seguro e não são compartilhados com terceiros sem o seu consentimento, exceto quando exigido por lei. Você tem o direito de acessar, corrigir, excluir e portar seus dados pessoais. 

Para exercer seus direitos ou tirar dúvidas, entre em contato com nosso Encarregado de Dados pelo e-mail santos-pereira@46hotmail.com." 
'''),
        ),
      ),
    );
  }
}
