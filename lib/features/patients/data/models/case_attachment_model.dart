/// One row of `GET /clinics/patients/{p}/cases/{c}/attachments`.
///
/// The shape is parsed defensively because this endpoint has been seen
/// returning three different things: a bare media id string, a flat object,
/// and an object wrapping a nested `media_item`.
///
/// Only one of those shapes tells us the attachment row's own id, and that is
/// the only id `DELETE .../attachments/{id}` accepts - passing a media id
/// there returns 404 `models.Attachment` invalid. So [attachmentId] is kept
/// separate from [id] and left null when the payload cannot prove which is
/// which; the UI hides delete rather than offering one that fails.
class CaseAttachmentModel {
  const CaseAttachmentModel({
    required this.id,
    this.attachmentId,
    this.mediaId,
    this.url,
    this.name,
  });

  /// Whatever identifies this row well enough to render and de-duplicate it.
  /// May be a media id - do NOT send it to the DELETE route.
  final String id;

  /// The attachment row's own id, which is the only thing
  /// `DELETE .../attachments/{id}` accepts. Null when the payload was a bare
  /// id or a flat media object, because then nothing in it addresses the
  /// attachment row and a delete would 404 with `models.Attachment` invalid.
  final String? attachmentId;

  final String? mediaId;
  final String? url;
  final String? name;

  static String? _pick(Map<String, dynamic> json, List<String> keys) {
    for (final k in keys) {
      final v = json[k];
      if (v != null && v.toString().trim().isNotEmpty) return v.toString();
    }
    return null;
  }

  factory CaseAttachmentModel.fromJson(Map<String, dynamic> json) {
    final nested = json['media_item'] ?? json['media'] ?? json['file'];
    final media = nested is Map<String, dynamic> ? nested : const <String, dynamic>{};

    final explicitMediaId = _pick(json, ['media_item_id', 'media_id']);
    final mediaId = explicitMediaId ?? _pick(media, ['id']);
    final rowId = _pick(json, ['id']);
    final id = rowId ?? mediaId ?? '';

    // `json['id']` only addresses the attachment row when the payload also
    // carries the media somewhere else - nested, or as its own id field.
    // A flat media object has an `id` too, and sending that to DELETE is
    // what produces the 404. When we cannot tell, claim nothing.
    final identifiesRow = rowId != null &&
        (media.isNotEmpty || explicitMediaId != null) &&
        rowId != mediaId;

    return CaseAttachmentModel(
      id: id,
      attachmentId: identifiesRow ? rowId : null,
      mediaId: mediaId ?? id,
      // `view` is what the live API returns: a short-lived signed URL under
      // media_item. It carries no file extension, so nothing downstream can
      // infer the type from it - see CaseAttachment.canPreview.
      url: _pick(media, ['view', 'url', 'file_url', 'path', 'full_path']) ??
          _pick(json, ['view', 'url', 'file_url', 'path', 'full_path']),
      name: _pick(json, ['file_name', 'name', 'original_name', 'filename']) ??
          _pick(media, ['file_name', 'name', 'original_name', 'filename']),
    );
  }

  /// Tolerant parse of the `data` array. Bare strings are treated as ids so a
  /// legacy payload still renders instead of throwing.
  static List<CaseAttachmentModel> listFromJson(dynamic raw) {
    if (raw is! List) return const [];
    final out = <CaseAttachmentModel>[];
    for (final e in raw) {
      if (e is Map<String, dynamic>) {
        final parsed = CaseAttachmentModel.fromJson(e);
        if (parsed.id.isNotEmpty) out.add(parsed);
      } else if (e != null && e.toString().trim().isNotEmpty) {
        // A bare id string carries no attachment row id, so it stays
        // undeletable rather than 404ing.
        final id = e.toString();
        out.add(CaseAttachmentModel(id: id, mediaId: id));
      }
    }
    return out;
  }
}
