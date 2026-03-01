class SupportEndpoints {
  SupportEndpoints._();

  static const String conversations = '/support/conversations';
  static String conversation(String id) => '/support/conversations/$id';
  static String sendMessage(String conversationId) =>
      '/support/conversations/$conversationId/messages';
}
