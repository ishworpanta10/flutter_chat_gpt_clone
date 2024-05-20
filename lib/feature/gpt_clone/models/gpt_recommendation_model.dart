class GptRecommendationModel {
  final String title;
  final String subTitle;

  GptRecommendationModel({required this.title, required this.subTitle});
}

final recommendationList = [
  GptRecommendationModel(title: 'Create a content calendar', subTitle: 'for a TikTok account'),
  GptRecommendationModel(title: 'Plan a mental health day', subTitle: 'to help me relax'),
  GptRecommendationModel(title: 'Write a short story', subTitle: 'tailored to my favorite genre'),
  GptRecommendationModel(title: 'Make me a person webpage', subTitle: 'after asking me three questions'),
  GptRecommendationModel(title: 'Write a blog post', subTitle: 'about the benefits of meditation'),
];
