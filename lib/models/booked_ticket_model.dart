class BookedTicket {
  final String username;
  final String movie;
  final int ticketsCount;

  const BookedTicket({
    required this.username,
    required this.movie,
    required this.ticketsCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'movie': movie,
      'ticketsCount':ticketsCount
    };
  }
}