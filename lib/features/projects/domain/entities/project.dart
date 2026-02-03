import 'package:equatable/equatable.dart';

class StarNarrative extends Equatable {
  final String situation;
  final String task;
  final String action;
  final String result;

  const StarNarrative({
    required this.situation,
    required this.task,
    required this.action,
    required this.result,
  });

  @override
  List<Object?> get props => [situation, task, action, result];
}

class Testimonial extends Equatable {
  final String quote;
  final String author;
  final String? authorRole;

  const Testimonial({
    required this.quote,
    required this.author,
    this.authorRole,
  });

  @override
  List<Object?> get props => [quote, author, authorRole];
}

class Project extends Equatable {
  final String id;
  final String title;
  final String? subtitle;
  final String description; // Markdown supported
  final String role;
  final ProjectType type;
  
  // Date & Duration
  final DateTime startDate;
  final DateTime? endDate; // Null = Present
  
  // Media
  final String coverImage;
  final List<String> galleryImages;
  
  // Specialized
  final List<String> technologies;
  final List<String> testingTypes; // For QA/Hybrid
  final Map<String, dynamic>? qaMetrics; // e.g., {'passRate': 98.5, 'bugsFound': 15}

  // Pro-Level Storytelling
  final StarNarrative? starNarrative;
  final Testimonial? testimonial;
  
  // Links & Metadata
  final String? mainUrl;
  final Map<String, String> links; // Label -> URL
  final int orderIndex;
  final bool isPublished;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Project({
    required this.id,
    required this.title,
    this.subtitle,
    required this.description,
    required this.role,
    required this.type,
    required this.startDate,
    this.endDate,
    required this.coverImage,
    required this.galleryImages,
    required this.technologies,
    this.testingTypes = const [],
    this.qaMetrics,
    this.starNarrative,
    this.testimonial,
    this.mainUrl,
    this.links = const {},
    required this.orderIndex,
    this.isPublished = true,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        description,
        role,
        type,
        startDate,
        endDate,
        coverImage,
        galleryImages,
        technologies,
        testingTypes,
        qaMetrics,
        starNarrative,
        testimonial,
        mainUrl,
        links,
        orderIndex,
        isPublished,
        createdAt,
        updatedAt,
      ];
}

enum ProjectType { flutter, qa, other }
