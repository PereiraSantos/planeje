import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        title: Text('Politica de Privacidade', style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_rounded, color: Colors.black54, size: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text('''
Termos e Condições de Uso

Estes termos e condições aplicam-se ao aplicativo da planeje (aqui referido como "Aplicação") para dispositivos móveis que foi criado por (doravante referido como "Prestador de Serviços") como um serviço gratuito.

Após o download Ou utilizando o Aplicativo, você está automaticamente concordando com os seguintes termos. É fortemente aconselhado que Você Leia e entenda detalhadamente estes termos antes de usar o Aplicativo. Cópia não autorizada, modificação de O que é O aplicativo, qualquer parte do Aplicativo, ou nossas marcas registradas são estritamente proibidas. Qualquer tentativa de extrair o Fonte Código do Aplicativo, traduzir o Aplicativo para outros idiomas ou criar versões derivadas não são É permitido. Todas as marcas registradas, direitos autorais, direitos de banco de dados e outros direitos de propriedade intelectual relacionados ao Aplicativo Permanecendo o Propriedade do Prestador de Serviços.

O Provedor de Serviços é dedicado a garantir que o Aplicativo seja tão benéfico e eficiente o mais possível. Como tal, eles se reservam o direito de modificar o Aplicativo ou cobrar por sua Serviços a qualquer momento e por qualquer motivo. O Provedor de Serviços garante que quaisquer encargos para o Aplicativo ou seus serviços serão ser claramente Comunicado a você.

O Aplicativo armazena e processa os dados pessoais que você forneceu ao Serviço Provedor para fornecer o Serviço. É sua responsabilidade manter a segurança do seu telefone e Acesso a A aplicação. O Provedor de Serviços desaconselha fortemente o jailbreak ou o enraizamento do telefone, que envolve Remoção restrições de software e limitações impostas pelo sistema operacional oficial do seu dispositivo. Essas ações Poderia expor seu telefone para malware, vírus, programas maliciosos, comprometer os recursos de segurança do seu telefone e pode resultar em O que é Aplicação não está funcionando corretamente ou de forma alguma.

Por favor, note que o Aplicativo utiliza serviços de terceiros que têm seus próprios Termos e Condições. Abaixo estão os links para os Termos e Condições do Terceiro Serviço de saúde Fornecedores utilizados pelo Aplicativo:

    Google Play ( Serviços de Saúde


Por favor, esteja ciente de que o Provedor de Serviços não assume a responsabilidade por determinados aspectos. Algumas das funções de o Aplicativo requer uma conexão de internet ativa, que pode ser Wi-Fi ou fornecida pela sua rede móvel O fornecedor. O Provedor de Serviços não pode ser responsabilizado se o Aplicativo não funcionar em plena capacidade por falta de acesso ao Wi-Fi ou se você tiver esgotado sua permissão de dados.

Se você estiver usando o aplicativo fora de uma área de Wi-Fi, esteja ciente de que o seu provedor de rede móvel Termos de contrato ainda se aplicam. Consequentemente, você pode incorrer em cobranças de seu provedor de serviços móveis para uso de dados durante a conexão com o aplicativo ou outras cobranças de terceiros. Ao usar o aplicativo, você aceita responsabilidade por tais encargos, incluindo tarifas de dados de roaming se você usar o aplicativo fora do seu território nacional (ou seja, região ou país) sem desativar o roaming de dados. Se você não é o pagador da conta para o Dispositivo no qual você está usando o aplicativo, eles assumem que você obteve permissão da conta - O pagador.

Da mesma forma, o Provedor de Serviços nem sempre pode assumir a responsabilidade pelo seu uso do aplicativo. Para Por exemplo, é sua responsabilidade garantir que o seu dispositivo permaneça carregado. Se o seu dispositivo ficar sem Você não pode acessar o Serviço, o Provedor de Serviços não pode ser responsabilizado.

Em termos da responsabilidade do Provedor de Serviços pelo uso do aplicativo, é importante notar que Enquanto eles se esforçam para garantir que ele seja atualizado e preciso em todos os momentos, eles dependem de terceiros para fornecer informações para eles para que eles possam torná-los disponíveis para você. O Provedor de Serviços não aceita qualquer responsabilidade para qualquer perda, direta ou indireta, que você experimente como resultado de confiar inteiramente nesta funcionalidade de A aplicação.

O Provedor de Serviços pode querer atualizar o aplicativo em algum momento. O aplicativo está atualmente disponível como de acordo com os requisitos do sistema operacional (e para quaisquer sistemas adicionais que decidam estender o a disponibilidade do aplicativo para) pode mudar, e você precisará baixar as atualizações se quiser Continue usando a aplicação. O Prestador de Serviços não garante que sempre atualizará o aplicação para que seja relevante para si e/ou compatível com a versão específica do sistema operacional instalado no seu dispositivo. No entanto, você concorda em sempre aceitar atualizações no aplicativo quando oferecido a você. O Prestador de Serviços também pode deixar de fornecer o aplicativo e pode encerrar seu uso a qualquer momento. sem lhe fornecer aviso de rescisão. A menos que eles informem de outra forma, mediante qualquer rescisão, (a) os direitos e licenças concedidos a você nesses termos terminarão; (b) você deve deixar de usar o aplicativo, e (se necessário) exclua-o do seu dispositivo.

Alterações a estes Termos e Condições

O Provedor de Serviços pode atualizar periodicamente os seus Termos e Condições. Portanto, você é aconselhado a rever Esta página regularmente para quaisquer alterações. O Provedor de Serviços irá notificá-lo de quaisquer alterações, publicando o novo Termos e Condições nesta página.

Estes termos e condições são efetivos a partir de 2025-06-07

Fale Conosco

Se você tiver alguma dúvida ou sugestão sobre os Termos e Condições, não hesite em entrar em contato com a Prestador de serviços em santos-pereira46-hotmail.com.
'''),
        ),
      ),
    );
  }
}
