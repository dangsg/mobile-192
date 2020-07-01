class ApiResultModel {
  int page;
  int totalResults;
  int totalPages;
  List<Results> results;

  ApiResultModel({this.page, this.totalResults, this.totalPages, this.results});

  ApiResultModel.fromJson(Map<String, dynamic> json) {

    if (json['listmovie'] != null) {
      results = new List<Results>();
      json['listmovie'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total_results'] = this.totalResults;
    data['total_pages'] = this.totalPages;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  String genreIds;
  String title;
  dynamic voteAverage;
  String overview;
  String releaseDate;

  Results(
      {this.popularity,
      this.voteCount,
      this.video,
      this.posterPath,
      this.id,
      this.adult,
      this.backdropPath,
      this.originalLanguage,
      this.originalTitle,
      this.genreIds,
      this.title,
      this.voteAverage,
      this.overview,
      this.releaseDate});

  Results.fromJson(Map<String, dynamic> json) {
    popularity = json['popularity'];
    voteCount = json['mean_rate'];
    video = json['video'];
    posterPath ="https://mymobileassigment.herokuapp.com/media/"+ json['movie_logo'].replaceAll(' ','%20');
    id = json['id'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre'];
    title = json['title'];
    voteAverage = json['mean_rate'];
    overview = json['story_line'];
    releaseDate = json['date_public'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['popularity'] = this.popularity;
    data['vote_count'] = this.voteCount;
    data['video'] = this.video;
    data['poster_path'] = this.posterPath;
    data['id'] = this.id;
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['genre_ids'] = this.genreIds;
    data['title'] = this.title;
    data['vote_average'] = this.voteAverage;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    return data;
  }
}
