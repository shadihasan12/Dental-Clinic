import 'package:dental_clinic_app/core/api/api_consumer.dart';
import 'package:dental_clinic_app/features/profile/presentation/pages/support/data/models/support_model.dart';
import 'package:injectable/injectable.dart';

abstract class SupportRemoteDataSource {
  Future<List<SupportConversationModel>> getConversations();
  Future<SupportConversationModel> createConversation();
  Future<SupportConversationModel> sendMessage(
    String conversationId,
    String text,
  );
  Future<SupportConversationModel> getAutoReply(String conversationId);
}

@Injectable(as: SupportRemoteDataSource)
class SupportRemoteDataSourceImpl implements SupportRemoteDataSource {
  // ignore: unused_field
  final ApiConsumer _apiConsumer;

  SupportRemoteDataSourceImpl(this._apiConsumer);

  // In-memory mock store
  List<SupportConversationModel>? _cachedConversations;

  List<SupportConversationModel> _getMockConversations() {
    if (_cachedConversations != null) return _cachedConversations!;

    final now = DateTime.now();
    _cachedConversations = [
      SupportConversationModel(
        id: '1',
        subject: 'Cannot access my account',
        isRead: true,
        messages: [
          SupportMessageModel(
            id: 'm1',
            text:
                'Hello, I am unable to log in to my account. I keep getting an invalid credentials error.',
            timestamp:
                now.subtract(const Duration(days: 2, hours: 3)).toIso8601String(),
            isFromUser: true,
          ),
          SupportMessageModel(
            id: 'm2',
            text:
                'Hi! Thank you for reaching out. Could you please try resetting your password using the "Forgot Password" link on the login screen?',
            timestamp:
                now.subtract(const Duration(days: 2, hours: 2)).toIso8601String(),
            isFromUser: false,
          ),
          SupportMessageModel(
            id: 'm3',
            text: 'That worked! Thank you so much.',
            timestamp:
                now.subtract(const Duration(days: 2, hours: 1)).toIso8601String(),
            isFromUser: true,
          ),
          SupportMessageModel(
            id: 'm4',
            text: 'Great to hear! Let us know if you need anything else.',
            timestamp:
                now.subtract(const Duration(days: 2)).toIso8601String(),
            isFromUser: false,
          ),
        ],
      ),
      SupportConversationModel(
        id: '2',
        subject: 'Billing question about subscription',
        isRead: false,
        messages: [
          SupportMessageModel(
            id: 'm5',
            text:
                'Hi, I was charged twice this month for my subscription. Can you please look into this?',
            timestamp:
                now.subtract(const Duration(hours: 5)).toIso8601String(),
            isFromUser: true,
          ),
          SupportMessageModel(
            id: 'm6',
            text:
                'We are sorry to hear that. We are looking into this and will get back to you within 24 hours.',
            timestamp:
                now.subtract(const Duration(hours: 4)).toIso8601String(),
            isFromUser: false,
          ),
        ],
      ),
    ];
    return _cachedConversations!;
  }

  int _findConversationIndex(String id) {
    return _getMockConversations().indexWhere((c) => c.id == id);
  }

  @override
  Future<List<SupportConversationModel>> getConversations() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _getMockConversations();
  }

  @override
  Future<SupportConversationModel> createConversation() async {
    await Future.delayed(const Duration(milliseconds: 400));
    final newConvo = SupportConversationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      subject: 'New Conversation',
      messages: [],
      isRead: true,
    );
    _getMockConversations().insert(0, newConvo);
    return newConvo;
  }

  @override
  Future<SupportConversationModel> sendMessage(
    String conversationId,
    String text,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final index = _findConversationIndex(conversationId);
    if (index == -1) throw Exception('Conversation not found');

    final convo = _getMockConversations()[index];

    final newMessage = SupportMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      timestamp: DateTime.now().toIso8601String(),
      isFromUser: true,
    );

    // If first message, use it as the subject
    final updatedSubject = convo.messages.isEmpty
        ? (text.length > 40 ? '${text.substring(0, 40)}...' : text)
        : convo.subject;

    final updated = SupportConversationModel(
      id: convo.id,
      subject: updatedSubject,
      messages: [...convo.messages, newMessage],
      isRead: convo.isRead,
    );

    _getMockConversations()[index] = updated;
    return updated;
  }

  @override
  Future<SupportConversationModel> getAutoReply(
    String conversationId,
  ) async {
    // Simulate support response delay
    await Future.delayed(const Duration(milliseconds: 1500));

    final index = _findConversationIndex(conversationId);
    if (index == -1) throw Exception('Conversation not found');

    final convo = _getMockConversations()[index];

    final reply = SupportMessageModel(
      id: '${DateTime.now().millisecondsSinceEpoch}_reply',
      text:
          'Thank you for your message. Our support team has received your request and will respond shortly.',
      timestamp: DateTime.now().toIso8601String(),
      isFromUser: false,
    );

    final updated = SupportConversationModel(
      id: convo.id,
      subject: convo.subject,
      messages: [...convo.messages, reply],
      isRead: true,
    );

    _getMockConversations()[index] = updated;
    return updated;
  }
}
