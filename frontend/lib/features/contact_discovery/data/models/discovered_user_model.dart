
class DiscoveredUserModel {
  final int id;
  final String username;
  final String? phoneNumber;

  DiscoveredUserModel({
    required this.id,
    required this.username,
    this.phoneNumber
  });

  factory DiscoveredUserModel.fromJson(Map<String, dynamic> json){
    return DiscoveredUserModel(
      id: json['id'] as int, 
      username: json['username'] as String,
      phoneNumber: json['phoneNumber'] as String?
      );
  }

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'username': username,
      'phoneNumber': phoneNumber,
    };
  }
}