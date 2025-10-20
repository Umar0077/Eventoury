import 'dart:async';

class ReviewsService {
  Future<Map<String, dynamic>> fetchSummary() async {
    await Future.delayed(const Duration(milliseconds: 250));
    return {
      'average': 4.7,
      'count': 3,
      'distribution': {5: 2, 4: 0, 3: 1, 2: 0, 1: 0},
    };
  }

  Future<List<Map<String, dynamic>>> fetchReviews() async {
    await Future.delayed(const Duration(milliseconds: 250));
    return [
      {
        'id': '1245',
        'name': 'Mahaz Noor',
        'timeAgo': '44 days ago',
        'rating': 5,
        'text': 'Great trip to Hunza! Highly recommended.'
      },
      {
        'id': '1244',
        'name': 'Ali Khan',
        'timeAgo': '60 days ago',
        'rating': 4,
        'text': 'Well organized, but could improve accommodations.'
      },
      {
        'id': '1243',
        'name': 'Sara Ahmed',
        'timeAgo': '75 days ago',
        'rating': 5,
        'text': 'Exceptional service and friendly guides.'
      },
    ];
  }
}
