part of 'i_use_case.dart';

abstract class IRecentSearchUseCase {
  Future<List<SearchResult>> getRecentSearch();
  Future<void> addRecentSearch(SearchResult data);
  Future<void> removeRecentSearch(SearchResult data);
}