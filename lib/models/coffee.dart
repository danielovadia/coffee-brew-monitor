class Coffee {
  int? id;
  String? name;
  String? brewery;

  Coffee({this.name, this.brewery});

  Coffee.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    brewery = json['brewery'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['brewery'] = brewery;
    return data;
  }
}
