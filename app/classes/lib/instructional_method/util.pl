% ============================================================================
% INSTRUCTIONAL METHOD UTILITIES
% ============================================================================

% Check if method is in-person
is_in_person_method(face_to_face).

% Check if method is online
is_online_method(online_sync).
is_online_method(online_async).

% Check if method is hybrid/blended
is_hybrid_method(blended).
is_hybrid_method(hybrid).

% Get method display name
method_display_name(face_to_face, 'Face-to-Face').
method_display_name(online_sync, 'Online Synchronous').
method_display_name(online_async, 'Online Asynchronous').
method_display_name(blended, 'Blended').
method_display_name(hybrid, 'Hybrid').

% Check if method requires physical presence
requires_physical_presence(face_to_face).
requires_physical_presence(blended).
requires_physical_presence(hybrid).
