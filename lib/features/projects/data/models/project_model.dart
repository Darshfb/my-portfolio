import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myprofile/features/projects/domain/entities/project.dart';
part 'project_model.freezed.dart';
part 'project_model.g.dart';

@freezed
abstract class ProjectModel with _$ProjectModel {
  const factory ProjectModel({
    required String id,
    required String title,
    String? subtitle,
    required String description,
    required String role,
    required String type, // Stored as string in Firestore
    required DateTime startDate,
    DateTime? endDate,
    required String coverImage,
    @Default([]) List<String> galleryImages,
    required List<String> technologies,
    @Default([]) List<String> testingTypes,
    Map<String, dynamic>? qaMetrics,
    Map<String, dynamic>? starNarrative,
    Map<String, dynamic>? testimonial,
    String? mainUrl,
    @Default({}) Map<String, String> links,
    required int orderIndex,
    @Default(true) bool isPublished,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ProjectModel;

  factory ProjectModel.fromJson(Map<String, dynamic> json) => _$ProjectModelFromJson(json);

  factory ProjectModel.fromEntity(Project project) => ProjectModel(
        id: project.id,
        title: project.title,
        subtitle: project.subtitle,
        description: project.description,
        role: project.role,
        type: project.type.name,
        startDate: project.startDate,
        endDate: project.endDate,
        coverImage: project.coverImage,
        galleryImages: project.galleryImages,
        technologies: project.technologies,
        testingTypes: project.testingTypes,
        qaMetrics: project.qaMetrics,
        starNarrative: project.starNarrative != null ? {
          'situation': project.starNarrative!.situation,
          'task': project.starNarrative!.task,
          'action': project.starNarrative!.action,
          'result': project.starNarrative!.result,
        } : null,
        testimonial: project.testimonial != null ? {
          'quote': project.testimonial!.quote,
          'author': project.testimonial!.author,
          'authorRole': project.testimonial!.authorRole,
        } : null,
        mainUrl: project.mainUrl,
        links: project.links,
        orderIndex: project.orderIndex,
        isPublished: project.isPublished,
        createdAt: project.createdAt,
        updatedAt: project.updatedAt,
      );

  const ProjectModel._();

  Project toEntity() => Project(
        id: id,
        title: title,
        subtitle: subtitle,
        description: description,
        role: role,
        type: ProjectType.values.firstWhere(
          (e) => e.name == type,
          orElse: () => ProjectType.flutter,
        ),
        startDate: startDate,
        endDate: endDate,
        coverImage: coverImage,
        galleryImages: galleryImages,
        technologies: technologies,
        testingTypes: testingTypes,
        qaMetrics: qaMetrics,
        starNarrative: starNarrative != null ? StarNarrative(
          situation: starNarrative!['situation'] ?? '',
          task: starNarrative!['task'] ?? '',
          action: starNarrative!['action'] ?? '',
          result: starNarrative!['result'] ?? '',
        ) : null,
        testimonial: testimonial != null ? Testimonial(
          quote: testimonial!['quote'] ?? '',
          author: testimonial!['author'] ?? '',
          authorRole: testimonial!['authorRole'],
        ) : null,
        mainUrl: mainUrl,
        links: links,
        orderIndex: orderIndex,
        isPublished: isPublished,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
