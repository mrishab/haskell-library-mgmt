% ============================================================================
% SECTION UTILITIES
% ============================================================================

% Get section campus from section atom
section_campus(SectionAtom, Campus) :-
    section(SectionAtom, Campus, _).

% Get section index from section atom
section_index(SectionAtom, Index) :-
    section(SectionAtom, _, Index).

% Format section for display (e.g., "AB1" from ab1)
section_display(SectionAtom, Display) :-
    section(SectionAtom, Campus, Index),
    upcase_atom(Campus, CampusUpper),
    atom_concat(CampusUpper, Index, Display).

% Get all sections for a specific campus
sections_for_campus(Campus, Sections) :-
    findall(SectionAtom, section(SectionAtom, Campus, _), Sections).

% Get all sections with a specific index
sections_with_index(Index, Sections) :-
    findall(SectionAtom, section(SectionAtom, _, Index), Sections).

% Check if section is online
is_online_section(SectionAtom) :-
    section(SectionAtom, on, _).

% Check if section is at a physical campus
is_physical_section(SectionAtom) :-
    section(SectionAtom, Campus, _),
    Campus \= on.

% Get all online sections
all_online_sections(Sections) :-
    findall(SectionAtom, section(SectionAtom, on, _), Sections).

% Get all physical sections
all_physical_sections(Sections) :-
    findall(SectionAtom, 
            (section(SectionAtom, Campus, _), Campus \= on), 
            Sections).

% Get max section index for a campus
max_section_index(Campus, MaxIndex) :-
    findall(Index, section(_, Campus, Index), Indices),
    max_list(Indices, MaxIndex).

% Helper for max_list
max_list([X], X).
max_list([H|T], Max) :-
    max_list(T, TMax),
    (H > TMax -> Max = H ; Max = TMax).
