/// Represents a file attachment.
///
/// This class is used to represent a file that's attached to a chat message.
/// It includes information about the file such as its URL, name, extension,
/// mime type, and size.
class Attachment {
  /// The URL of the file.
  String fileUrl;

  /// The name of the file.
  String fileName;

  /// The extension of the file.
  String fileExtension;

  /// The MIME type of the file.
  String fileMimeType;

  /// The size of the file in bytes.
  int? fileSize;

  /// Constructs a new [Attachment] instance.
  ///
  /// It requires a [fileUrl], [fileName], [fileExtension], [fileMimeType],
  /// and optionally a [fileSize].
  Attachment(
    this.fileUrl,
    this.fileName,
    this.fileExtension,
    this.fileMimeType,
    this.fileSize,
  );

  /// Creates a new [Attachment] instance from a map.
  factory Attachment.fromMap(dynamic map) {
    if (map == null) {
      throw ArgumentError('The type of attachment map is null');
    }
    return Attachment(
      map['fileUrl'],
      map['fileName'],
      map['fileExtension'],
      map['fileMimeType'],
      map['fileSize'],
    );
  }
}
