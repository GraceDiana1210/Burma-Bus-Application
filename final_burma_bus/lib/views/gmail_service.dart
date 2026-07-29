import 'dart:convert';
import 'dart:io';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/gmail/v1.dart';

class GmailService {
  final _scopes = [GmailApi.gmailSendScope];

  /// Authenticate the user and obtain an AuthClient.
  Future<AuthClient> authenticate() async {
    final credentials = File('assets/credentials.json'); // Ensure credentials.json is in assets folder.
    final jsonCredentials = json.decode(await credentials.readAsString());

    final clientId = ClientId(
      jsonCredentials['installed']['client_id'],
      jsonCredentials['installed']['client_secret'],
    );

    return clientViaUserConsent(clientId, _scopes, (url) {
      print('Please visit the following URL to authenticate: $url');
    });
  }

  /// Send an email via Gmail API.
  Future<void> sendEmail({
    required AuthClient authClient,
    required String recipient,
    required String subject,
    required String body,
  }) async {
    final gmailApi = GmailApi(authClient);

    final message = '''
From: your_email@gmail.com
To: $recipient
Subject: $subject

$body
''';

    final base64Email = base64Encode(utf8.encode(message));
    final rawMessage = Message()
      ..raw = base64Email.replaceAll('+', '-').replaceAll('/', '_').replaceAll('=', '');

    try {
      await gmailApi.users.messages.send(rawMessage, 'me');
      print('Email sent successfully');
    } catch (e) {
      print('Failed to send email: $e');
      throw 'Email sending failed: $e';
    }
  }
}
