
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

valid_collection_id(ID) :-
    atom_string(ID, Str),
    sub_string(Str, 4, 1, 2, '_').

valid_file_id(ID) :-
    atom_string(ID, Str),
    sub_string(Str, 4, 1, _, '_'),
    sub_string(Str, 7, 1, _, '_').

valid_item_id(ID) :-
    atom_string(ID, Str),
    sub_string(Str, 4, 1, _, '_'),
    sub_string(Str, 7, 1, _, '_'),
    sub_string(Str, 10, 1, _, '_').

validate_collections :-
    (forall(collection(CID, _), valid_collection_id(CID)) ->
        writeln('✓ All collection IDs are valid (yyyy_mm format)') ;
        writeln('✗ ERROR: Invalid collection ID format')).

validate_files :-
    (forall(file(FID, _), valid_file_id(FID)) ->
        writeln('✓ All file IDs are valid (yyyy_mm_nn format)') ;
        writeln('✗ ERROR: Invalid file ID format')).

validate_items :-
    (forall(item(IID, _), valid_item_id(IID)) ->
        writeln('✓ All item IDs are valid (yyyy_mm_nn_nnn format)') ;
        writeln('✗ ERROR: Invalid item ID format')).

validate_file_hierarchy :-
    (forall(file(FID, _), (child_of(FID, CID), collection(CID, _))) ->
        writeln('✓ All files have valid collection parents') ;
        writeln('✗ ERROR: File without valid collection parent')).

validate_item_hierarchy :-
    (forall(item(IID, _), (child_of(IID, FID), file(FID, _))) ->
        writeln('✓ All items have valid file parents') ;
        writeln('✗ ERROR: Item without valid file parent')).

validate_subjects :-
    (forall(has_property(_, subject, SubjName),
            subject(SubjName)) ->
        writeln('✓ All subject properties exist in thesaurus') ;
        writeln('✗ ERROR: Subject property not found in thesaurus')).

validate_locations :-
    (forall(has_property(_, location, LocName),
            geographic(LocName)) ->
        writeln('✓ All location properties exist in thesaurus') ;
        writeln('✗ ERROR: Location property not found in thesaurus')).

validate_persons :-
    (forall(has_property(_, agent, PersonName),
            person(PersonName)) ->
        writeln('✓ All agent properties exist in thesaurus') ;
        writeln('✗ ERROR: Agent property not found in thesaurus')).

validate_corporate_bodies :-
    (forall(has_property(_, corporate_body, CorpName),
            corporate_body(CorpName)) ->
        writeln('✓ All corporate body properties exist in thesaurus') ;
        writeln('✗ ERROR: Corporate body property not found in thesaurus')).

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

% ============================================================
% DERIVED RELATIONSHIPS (Rules derived from facts)
% ============================================================

item_in_collection(ItemID, CollectionID) :-
    item(ItemID, _),
    child_of(ItemID, FileID),
    child_of(FileID, CollectionID),
    collection(CollectionID, _).

item_about_subject_in_location(ItemID, SubjectName, LocationName) :-
    has_property(ItemID, subject, SubjectName),
    has_property(ItemID, location, LocationName),
    subject(SubjectName),
    geographic(LocationName).

item_by_organization_at_location(ItemID, OrgName, LocationName) :-
    has_property(ItemID, corporate_body, OrgName),
    has_property(ItemID, location, LocationName),
    corporate_body(OrgName),
    geographic(LocationName).

item_created_by_person(ItemID, PersonName) :-
    has_property(ItemID, agent, PersonName),
    person(PersonName).

file_contains_item(FileID, ItemID) :-
    file(FileID, _),
    child_of(ItemID, FileID),
    item(ItemID, _).

collection_has_item_count(CollectionID, Count) :-
    collection(CollectionID, _),
    findall(ItemID, item_in_collection(ItemID, CollectionID), Items),
    length(Items, Count).

subject_appears_in_item(SubjectName, ItemID) :-
    has_property(ItemID, subject, SubjectName),
    subject(SubjectName).

material_in_location(ItemID, LocationName) :-
    has_property(ItemID, location, LocationName),
    geographic(LocationName).

organization_involved_items(OrgName, ItemID) :-
    has_property(ItemID, corporate_body, OrgName),
    corporate_body(OrgName).

