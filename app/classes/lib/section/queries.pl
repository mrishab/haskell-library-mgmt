% ============================================================================
% SECTION QUERIES
% ============================================================================
% Note: Most section predicates are defined in:
% - course/util.pl: course_sections/2
% - class/util.pl: is_online/1, is_hybrid/1, sections_on_campus/2, sections_on_day/2
% - schedule/util.pl: time_conflict/2

% Additional section helper predicate
is_inperson(CRN) :-
    class_section(_, CRN, _, _, _, _, face_to_face, _, _, _).
