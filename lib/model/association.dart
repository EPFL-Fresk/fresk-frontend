class Association {
  final int id;
  final String name;
  final String? description;
  final String? subtitle;
  final String? banner;
  final String? logo;
  final int? activeMembers;

  Association({
    required this.id,
    required this.name,
    this.description,
    this.subtitle,
    this.banner,
    this.logo,
    this.activeMembers,
  });

  factory Association.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'description': String? description,
        'subtitle': String? subtitle,
        'banner': String? banner,
        'logo': String? logo,
        'activeMembers': int? activeMembers,
      } =>
        Association(
          id: id,
          name: name,
          description: description,
          subtitle: subtitle,
          banner: banner,
          logo: logo,
          activeMembers: activeMembers,
        ),
      _ => throw Error(),
    };
  }
}
