class UserSavedCoffees {
  final List<String> savedCoffees;

  UserSavedCoffees({required this.savedCoffees});

  Map<String, dynamic> toJson() {
    return {
      'cofees': savedCoffees,
    };
  }
}
