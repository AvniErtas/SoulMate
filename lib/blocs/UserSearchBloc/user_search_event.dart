class UserSearchEvent {
  final String query;

  const UserSearchEvent(this.query);

  @override
  String toString() => 'UserSearchEvent { query: $query }';
}