class Track {
  String trackName;
  String albumName;
  String artistName;
  int trackId;
  int rating;
  int explicit;
  int hasLyrics;
  Track(
      {required this.trackName,
      required this.albumName,
      required this.artistName,
      required this.trackId,
      required this.rating,
      required this.explicit,
        required this.hasLyrics});

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
        trackName: json['track_name'],
        trackId: json['track_id'],
        albumName: json["album_name"],
        artistName: json["artist_name"],
        rating: json["track_rating"],
        explicit: json["explicit"],
      hasLyrics: json["has_lyrics"],
    );
  }
}
