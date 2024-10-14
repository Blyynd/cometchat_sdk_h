/// Represents application settings.
///
/// Contains settings related to the subscription, roles, region, hosts and socket connections.
class AppSettings {
  /// Type of the application subscription.
  final String? subscriptionType;

  /// List of roles in the application.
  final List<String>? roles;

  /// Region of the application.
  final String? region;

  /// Hostname for the admin server.
  final String? adminHost;

  /// Hostname for the client server.
  final String? clientHost;

  /// Flag to establish socket connection automatically.
  final bool? autoEstablishSocketConnection;

  /// Builds the `AppSettings` from the builder.
  ///
  /// This is a private constructor, only accessible by the builder.
  AppSettings._builder(AppSettingsBuilder builder)
      : subscriptionType = builder.subscriptionType,
        roles = builder.roles,
        region = builder.region,
        adminHost = builder.adminHost,
        clientHost = builder.clientHost,
        autoEstablishSocketConnection = builder.autoEstablishSocketConnection;
}

/// Builder class for `AppSettings`.
///
/// Allows step-by-step creation of an `AppSettings` object.
class AppSettingsBuilder {
  /// Type of the application subscription.
  String? subscriptionType;

  /// List of roles in the application.
  List<String>? roles;

  /// Region of the application.
  String? region;

  /// Hostname for the admin server.
  String? adminHost;

  /// Hostname for the client server.
  String? clientHost;

  /// Flag to establish socket connection automatically, set to true by default.
  bool autoEstablishSocketConnection = true;

  /// Default constructor for `AppSettingsBuilder`.
  AppSettingsBuilder();

  /// Builds and returns an `AppSettings` object.
  AppSettings build() {
    return AppSettings._builder(this);
  }
}
