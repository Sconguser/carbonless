class QRDTO {
  String uuid;
  String expiration;
  String? longitude;
  String? latitude;
  QRDTO({
    required this.uuid,
    required this.expiration,
    this.longitude,
    this.latitude,
  });

  Map<String, dynamic> toJsonStart() => <String, dynamic>{
        'handler': {
          'uuid': uuid,
          'expires': expiration,
          'start_longitude': longitude,
          'start_latitude': latitude,
        }
      };
  Map<String, dynamic> toJsonEnd() => <String, dynamic>{
        'handler': {
          'uuid': uuid,
          'expires': expiration,
          'end_longitude': longitude,
          'end_latitude': latitude,
        }
      };
}
