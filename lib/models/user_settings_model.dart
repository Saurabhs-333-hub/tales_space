class UserSettingsModel{
  String userId;
  String subscriberType;
  bool? isSubscriber;
  List<dynamic>? upi_ids;

//<editor-fold desc="Data Methods">
  UserSettingsModel({
    required this.userId,
    required this.subscriberType,
    this.isSubscriber,
    this.upi_ids,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserSettingsModel &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          subscriberType == other.subscriberType &&
          isSubscriber == other.isSubscriber &&
          upi_ids == other.upi_ids);

  @override
  int get hashCode =>
      userId.hashCode ^
      subscriberType.hashCode ^
      isSubscriber.hashCode ^
      upi_ids.hashCode;

  @override
  String toString() {
    return 'UserSettingsModel{' +
        ' userId: $userId,' +
        ' subscriberType: $subscriberType,' +
        ' isSubscriber: $isSubscriber,' +
        ' upi_ids: $upi_ids,' +
        '}';
  }

  UserSettingsModel copyWith({
    String? userId,
    String? subscriberType,
    bool? isSubscriber,
    List<dynamic>? upi_ids,
  }) {
    return UserSettingsModel(
      userId: userId ?? this.userId,
      subscriberType: subscriberType ?? this.subscriberType,
      isSubscriber: isSubscriber ?? this.isSubscriber,
      upi_ids: upi_ids ?? this.upi_ids,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': this.userId,
      'subscriberType': this.subscriberType,
      'isSubscriber': this.isSubscriber,
      'upi_ids': this.upi_ids,
    };
  }

  factory UserSettingsModel.fromMap(Map<String, dynamic> map) {
    return UserSettingsModel(
      userId: map['userId'] as String,
      subscriberType: map['subscriberType'] as String,
      isSubscriber: map['isSubscriber'] as bool,
      upi_ids: map['upi_ids'] as List<dynamic>,
    );
  }

//</editor-fold>
}