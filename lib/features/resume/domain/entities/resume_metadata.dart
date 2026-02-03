
import 'package:equatable/equatable.dart';

class ResumeMetadata extends Equatable {
  final String cvUrl;
  final DateTime lastUpdated;

  const ResumeMetadata({
    required this.cvUrl,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [cvUrl, lastUpdated];
}
