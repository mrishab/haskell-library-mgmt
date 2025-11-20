
% Archives Collection
% -----------------------------------------------------------

:- discontiguous collection/2.
:- discontiguous file/2.
:- discontiguous item/2.
:- discontiguous child_of/2.
:- discontiguous has_property/3.
:- discontiguous has_description/2.

:- discontiguous subject/1.
:- discontiguous person/1.
:- discontiguous geographic/1.
:- discontiguous corporate_body/1.

% ============================================================
% VALIDATION RULES
% ============================================================

% Validate collection ID format (yyyy_mm)
valid_collection_id(ID) :-
    atom_string(ID, Str),
    sub_string(Str, 4, 1, 2, '_').

% Validate file ID format (yyyy_mm_nn)
valid_file_id(ID) :-
    atom_string(ID, Str),
    sub_string(Str, 4, 1, _, '_'),
    sub_string(Str, 7, 1, _, '_').

% Validate item ID format (yyyy_mm_nn_nnn)
valid_item_id(ID) :-
    atom_string(ID, Str),
    sub_string(Str, 4, 1, _, '_'),
    sub_string(Str, 7, 1, _, '_'),
    sub_string(Str, 10, 1, _, '_').

% Validate all collection IDs
validate_collections :-
    (forall(collection(CID, _), valid_collection_id(CID)) ->
        writeln('✓ All collection IDs are valid (yyyy_mm format)') ;
        writeln('✗ ERROR: Invalid collection ID format')).

% Validate all file IDs
validate_files :-
    (forall(file(FID, _), valid_file_id(FID)) ->
        writeln('✓ All file IDs are valid (yyyy_mm_nn format)') ;
        writeln('✗ ERROR: Invalid file ID format')).

% Validate all item IDs
validate_items :-
    (forall(item(IID, _), valid_item_id(IID)) ->
        writeln('✓ All item IDs are valid (yyyy_mm_nn_nnn format)') ;
        writeln('✗ ERROR: Invalid item ID format')).

% Validate file hierarchy (all files have collection parent)
validate_file_hierarchy :-
    (forall(file(FID, _), (child_of(FID, CID), collection(CID, _))) ->
        writeln('✓ All files have valid collection parents') ;
        writeln('✗ ERROR: File without valid collection parent')).

% Validate item hierarchy (all items have file parent)
validate_item_hierarchy :-
    (forall(item(IID, _), (child_of(IID, FID), file(FID, _))) ->
        writeln('✓ All items have valid file parents') ;
        writeln('✗ ERROR: Item without valid file parent')).

% Validate subject properties exist in thesaurus
validate_subjects :-
    (forall(has_property(_, subject, SubjName),
            subject(SubjName)) ->
        writeln('✓ All subject properties exist in thesaurus') ;
        writeln('✗ ERROR: Subject property not found in thesaurus')).

% Validate location properties exist in thesaurus
validate_locations :-
    (forall(has_property(_, location, LocName),
            geographic(LocName)) ->
        writeln('✓ All location properties exist in thesaurus') ;
        writeln('✗ ERROR: Location property not found in thesaurus')).

% Validate person properties exist in thesaurus
validate_persons :-
    (forall(has_property(_, agent, PersonName),
            person(PersonName)) ->
        writeln('✓ All agent properties exist in thesaurus') ;
        writeln('✗ ERROR: Agent property not found in thesaurus')).

% Validate corporate body properties exist in thesaurus
validate_corporate_bodies :-
    (forall(has_property(_, corporate_body, CorpName),
            corporate_body(CorpName)) ->
        writeln('✓ All corporate body properties exist in thesaurus') ;
        writeln('✗ ERROR: Corporate body property not found in thesaurus')).

% Run all validations
run_all_validations :-
    writeln(''),
    writeln('=== ARCHIVAL DATA VALIDATION ==='),
    writeln(''),
    validate_collections,
    validate_files,
    validate_items,
    validate_file_hierarchy,
    validate_item_hierarchy,
    validate_subjects,
    validate_locations,
    validate_persons,
    validate_corporate_bodies,
    writeln(''),
    writeln('=== VALIDATION COMPLETE ==='),
    writeln('').

