class BookmarkModel {
  final int? id;
  final String? title;
  final String? imdbId;
  final String? posterPath;
  final int? runtime;

 BookmarkModel({
   required this.id,
   required this.title,
   required this.imdbId,
   required this.posterPath,
    this.runtime,
 });

  // map --> Model Class
  factory BookmarkModel.fromMap(Map<String, dynamic> map) {
    return BookmarkModel(
      id: map['id'],
      title: map['title'],          // Fixing this key
      imdbId: map['imdbId'],        // Fixing this key
      posterPath: map['posterPath'],// Fixing this key
      runtime: map['runtime'],      // Fixing this key
    );
  }

// model class --> map
  Map<String, Object?> tomap() {
    return {'id': id, 'title': title, 'imdbId': imdbId, 'posterPath' : posterPath, 'runtime' : runtime};
  }
}
