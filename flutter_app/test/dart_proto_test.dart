import 'package:alan/alan.dart';
import 'package:flutter_app/proto/mars/export.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Counter increments smoke test', () async {
    // Create a wallet
    final networkInfo = NetworkInfo.fromSingleHost(
      bech32Hrp: 'cosmos',
      host: 'localhost',
    );

    final mnemonicString =
        'sausage will myself parrot upon ball behind give venue witness bar adult utility between lamp private vital more document happy claim shrimp demise ritual';
    final mnemonic = mnemonicString.split(' ');
    final wallet = Wallet.derive(mnemonic, networkInfo);

    // 3. Create and sign the transaction
    final message = MsgCreatePost(
      title: 'FIRST POST',
      body: 'This is my first post body',
      creator: wallet.bech32Address,
    );

    final signer = TxSigner.fromNetworkInfo(networkInfo);
    final tx = await signer.createAndSign(wallet, [message]);

    // 4. Broadcast the transaction
    final txSender = TxSender.fromNetworkInfo(networkInfo);
    final response = await txSender.broadcastTx(tx);

    // Check the result
    if (response.isSuccessful) {
      print('Tx sent successfully. Response: ${response}');
    } else {
      print('Tx errored: ${response}');
    }
  });
}