class Doctor {
  String id;
  String name;
  String email;
  String phoneNumber;
  String imageUrl;
  String location;
  // String Certificates;
  // String Experience;
  String Special;
  String Price;
  // List<String>? monday;
  // List<String>? sturday;

  // List<String>? sunday;

  // List<String>? tuesday;

  // List<String>? wednesday;
  // List<String>? thursday;
  // List<String>? friday;

  Doctor(
      {required this.email,
      required this.id,
      required this.name,
      required this.phoneNumber,
      required this.imageUrl,
      required this.location,
      required this.Price,
      // required this.Certificates,
      required this.Special,
      // required this.friday,
      // required this.sturday,
      // required this.sunday,
      // required this.thursday,
      // required this.tuesday,
      // required this.monday,
      // required this.wednesday
      });

  factory Doctor.formJson(Map<String, dynamic> json) {
    return Doctor(
      email: json['email'],
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      imageUrl: json['imageUrl'] ?? '',
      location: json['location'],
      Price: json['Price '] ?? '',
      // Certificates: json['Certificates'],
      Special: json['Special'],
      // sturday: List<String>.from(json['sturday']).toList(),
      // sunday: List<String>.from(json['sunday']).toList() ,
      // monday: List<String>.from(json['monday']).toList() ,
      // friday: List<String>.from( json['friday']).toList(),
      // wednesday: List<String>.from(json['wednesday']).toList() ,
      // thursday: List<String>.from(json['thursday']).toList(),   
      // tuesday: List<String>.from(json['tuesday']).toList() 



    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "imageUrl": imageUrl,
      "location": location,
      "Price ": Price,
      // "Certificates": Certificates,
      "Special": Special,
      // "tuesday":tuesday==null?[]:tuesday!.map((e) => e.toString()),
    };
  }
}
