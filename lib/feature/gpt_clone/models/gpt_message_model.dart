class GptMessageModel {
  final String role;
  final String content;

  GptMessageModel({required this.role, required this.content});

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'content': content,
    };
  }

  factory GptMessageModel.fromMap(Map<String, dynamic> map) {
    return GptMessageModel(
      role: map['role'] as String,
      content: map['content'] as String,
    );
  }
}
