class QRDTO {
  String uid;
  String expiration;
  String? longitude;
  String? latitude;

  QRDTO({
    required this.uid,
    required this.expiration,
    this.longitude,
    this.latitude,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'handler': {
          'uuid': uid,
          'expires': expiration,
          'start_longitude': longitude,
          'start_latitude': latitude,
        }
      };
}
