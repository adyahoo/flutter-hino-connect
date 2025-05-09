import 'package:equatable/equatable.dart';

class ListApiResponse<T> extends Equatable {
  final List<T> data;

  const ListApiResponse({
    required this.data,
  });

  factory ListApiResponse.fromJson(Map<String, dynamic> json, Function(Iterable json) create) {
    return ListApiResponse(
      data: create(json['data'] as Iterable),
    );
  }

  @override
  List<Object> get props => [data];
}

class ListPaginationApiResponse<T> extends Equatable {
  final List<T> data;
  final Links links;
  final Meta meta;

  const ListPaginationApiResponse({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory ListPaginationApiResponse.fromJson(Map<String, dynamic> json, Function(Iterable json) create) {
    return ListPaginationApiResponse(
      data: create(json['data'] as Iterable),
      links: Links.fromJson(json['links']),
      meta: Meta.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': this.data,
      'links': this.links.toJson(),
      'meta': this.meta.toJson(),
    };
  }

  ListPaginationApiResponse<T> copyWith({
    List<T>? data,
    Links? links,
    Meta? meta,
  }) {
    return ListPaginationApiResponse(
      data: data ?? this.data,
      links: links ?? this.links,
      meta: meta ?? this.meta,
    );
  }

  @override
  List<Object> get props => [data, links, meta];
}

class Links {
  final String first;
  final String last;
  final String? prev;
  final String next;

  const Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      first: json['first'],
      last: json['last'],
      prev: json['prev'],
      next: json['next'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first': this.first,
      'last': this.last,
      'prev': this.prev,
      'next': this.next,
    };
  }
}

class Meta {
  final int currentPage;
  final int from;
  final int lastPage;
  final String path;
  final int perPage;
  final int to;
  final int total;

  const Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      path: json['path'],
      perPage: json['per_page'],
      to: json['to'],
      total: json['total'],
    );
  }

  @override
  List<Object> get props => [
        currentPage,
        from,
        lastPage,
        path,
        perPage,
        to,
        total,
      ];

  Map<String, dynamic> toJson() {
    return {
      'current_page': this.currentPage,
      'from': this.from,
      'last_page': this.lastPage,
      'path': this.path,
      'per_page': this.perPage,
      'to': this.to,
      'total': this.total,
    };
  }
}
