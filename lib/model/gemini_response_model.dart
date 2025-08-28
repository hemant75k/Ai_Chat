class GeminiResponse {
  final List<Candidate> candidates;

  GeminiResponse({required this.candidates});

  factory GeminiResponse.fromJson(Map<String, dynamic> json) {
    return GeminiResponse(
      candidates: (json['candidates'] as List<dynamic>? ?? [])
          .map((candidateJson) => Candidate.fromJson(candidateJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'candidates': candidates.map((candidate) => candidate.toJson()).toList(),
    };
  }

  /// Helper method to get plain text response for UI
  String get firstText {
    if (candidates.isNotEmpty &&
        candidates.first.content.parts.isNotEmpty) {
      return candidates.first.content.parts.first.text;
    }
    return '';
  }
}

class Candidate {
  final Content content;
  final String? finishReason;
  final int index;

  Candidate({
    required this.content,
    this.finishReason,
    required this.index,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      content: Content.fromJson(json['content'] ?? {}),
      finishReason: json['finishReason'],
      index: json['index'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content.toJson(),
      'finishReason': finishReason,
      'index': index,
    };
  }
}

class Content {
  final List<Part> parts;
  final String? role;

  Content({required this.parts, this.role});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      parts: (json['parts'] as List<dynamic>? ?? [])
          .map((partJson) => Part.fromJson(partJson))
          .toList(),
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'parts': parts.map((part) => part.toJson()).toList(),
      'role': role,
    };
  }
}

class Part {
  final String text;

  Part({required this.text});

  factory Part.fromJson(Map<String, dynamic> json) {
    return Part(
      text: json['text'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
    };
  }
}
