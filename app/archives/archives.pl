
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
    (forall(has_property(_, linked_agent, PersonName),
            person(PersonName)) ->
        writeln('✓ All linked_agent properties exist in thesaurus') ;
        writeln('✗ ERROR: linked_agent property not found in thesaurus')).

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
    has_property(ItemID, linked_agent, PersonName),
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

% ============================================================
% FUZZY MATCHING & STRING SIMILARITY
% ============================================================

% Levenshtein distance with memoization
:- table levenshtein/3.

levenshtein([], L, N) :- length(L, N).
levenshtein(L, [], N) :- length(L, N).

levenshtein([H|T1], [H|T2], D) :-
    levenshtein(T1, T2, D).

levenshtein([H1|T1], [H2|T2], D) :-
    H1 \= H2,
    levenshtein(T1, T2, D1),
    levenshtein([H1|T1], T2, D2),
    levenshtein(T1, [H2|T2], D3),
    D is 1 + min(D1, min(D2, D3)).

% String distance helper
string_distance(S1, S2, Distance) :-
    string_chars(S1, L1),
    string_chars(S2, L2),
    levenshtein(L1, L2, Distance).

% Normalize a string (lowercase, no extra spaces)
normalize_string(Input, Normalized) :-
    string_lower(Input, Lower),
    split_string(Lower, " \t\n", " \t\n", Parts),
    atomics_to_string(Parts, " ", Normalized).

% Check if two strings are similar (substring OR small edit distance)
similar_string(Query, Target) :-
    similar_string(Query, Target, 2).

similar_string(Query, Target, _Threshold) :-
    normalize_string(Query, QueryNorm),
    normalize_string(Target, TargetNorm),
    sub_string(TargetNorm, _, _, _, QueryNorm), !.

similar_string(Query, Target, Threshold) :-
    normalize_string(Query, QueryNorm),
    normalize_string(Target, TargetNorm),
    string_distance(QueryNorm, TargetNorm, Distance),
    Distance =< Threshold.

% ============================================================
% NAME NORMALIZATION & MATCHING
% ============================================================

% Common titles to strip when comparing names
common_title("dr").
common_title("dr.").
common_title("mr").
common_title("mr.").
common_title("ms").
common_title("ms.").
common_title("mrs").
common_title("mrs.").
common_title("prof").
common_title("prof.").
common_title("professor").

% Normalize a person's name (remove titles, lowercase, trim)
normalize_name(Input, Normalized) :-
    normalize_string(Input, Lower),
    split_string(Lower, " ", " ", Parts),
    exclude(is_title, Parts, FilteredParts),
    atomics_to_string(FilteredParts, " ", Normalized).

is_title(Part) :-
    common_title(Part).

% Extract name components (handle "Last, First" and "First Last" formats)
name_components(Name, Components) :-
    normalize_name(Name, Normalized),
    (   sub_string(Normalized, Before, 1, After, ",")
    ->  sub_string(Normalized, 0, Before, _, LastName),
        AfterComma is Before + 1,
        sub_string(Normalized, AfterComma, After, 0, FirstName),
        normalize_string(FirstName, FirstNorm),
        normalize_string(LastName, LastNorm),
        split_string(FirstNorm, " ", " ", FirstParts),
        split_string(LastNorm, " ", " ", LastParts),
        append(FirstParts, LastParts, Components)
    ;   split_string(Normalized, " ", " ", Components)
    ).

% Check if two names likely refer to the same person
similar_name(Name1, Name2) :-
    similar_name(Name1, Name2, 2).

similar_name(Name1, Name2, Threshold) :-
    name_components(Name1, Parts1),
    name_components(Name2, Parts2),
    names_match(Parts1, Parts2, Threshold).

% Names match if they share significant components
names_match(Parts1, Parts2, Threshold) :-
    % Check if all parts of the shorter name appear in the longer name
    (   length(Parts1, L1), length(Parts2, L2), L1 =< L2
    ->  Shorter = Parts1, Longer = Parts2
    ;   Shorter = Parts2, Longer = Parts1
    ),
    Shorter \= [],
    all_parts_match(Shorter, Longer, Threshold).

% Helper: check that each part in list 1 has a matching part in list 2
all_parts_match([], _, _).
all_parts_match([Part|Rest], Longer, Threshold) :-
    member(LongPart, Longer),
    similar_string(Part, LongPart, Threshold),
    all_parts_match(Rest, Longer, Threshold).

% Find all name variations in the database that match a query
find_name_variations(QueryName, Variations) :-
    findall(
        Name,
        (person(Name), similar_name(QueryName, Name)),
        AllMatches
    ),
    sort(AllMatches, Variations).

% Find items by person with fuzzy name matching
item_by_similar_person(ItemID, QueryName) :-
    has_property(ItemID, linked_agent, ActualName),
    person(ActualName),
    similar_name(QueryName, ActualName).

% Suggest name consolidation (find all variations and group them)
suggest_name_consolidation(Results) :-
    findall(Person, person(Person), AllPersons),
    find_clusters(AllPersons, [], Results).

find_clusters([], Clusters, Clusters).
find_clusters([Person|Rest], Acc, Results) :-
    (   member(cluster(_, Members), Acc),
        member(Person, Members)
    ->  find_clusters(Rest, Acc, Results)
    ;   findall(Other, 
                (member(Other, Rest), similar_name(Person, Other)),
                AllSimilars),
        sort(AllSimilars, Similars),
        (   Similars = []
        ->  find_clusters(Rest, Acc, Results)
        ;   sort([Person|Similars], UniqueMembers),
            NewCluster = cluster(Person, UniqueMembers),
            find_clusters(Rest, [NewCluster|Acc], Results)
        )
    ).

% ============================================================
% FUZZY SEARCH PREDICATES
% ============================================================

% Find items in similar locations (fuzzy)
item_in_similar_location(ItemID, QueryLocation) :-
    has_property(ItemID, location, ActualLocation),
    geographic(ActualLocation),
    similar_string(QueryLocation, ActualLocation).

item_in_similar_location(ItemID, QueryLocation, Threshold) :-
    has_property(ItemID, location, ActualLocation),
    geographic(ActualLocation),
    similar_string(QueryLocation, ActualLocation, Threshold).

% Find items about similar subjects (fuzzy)
item_about_similar_subject(ItemID, QuerySubject) :-
    has_property(ItemID, subject, ActualSubject),
    subject(ActualSubject),
    similar_string(QuerySubject, ActualSubject).

item_about_similar_subject(ItemID, QuerySubject, Threshold) :-
    has_property(ItemID, subject, ActualSubject),
    subject(ActualSubject),
    similar_string(QuerySubject, ActualSubject, Threshold).

% Find items by similar organization (fuzzy)
item_by_similar_organization(ItemID, QueryOrg) :-
    has_property(ItemID, corporate_body, ActualOrg),
    corporate_body(ActualOrg),
    similar_string(QueryOrg, ActualOrg).

% Combined fuzzy query: subject AND location
item_about_similar_subject_in_similar_location(ItemID, QuerySubject, QueryLocation) :-
    has_property(ItemID, subject, ActualSubject),
    has_property(ItemID, location, ActualLocation),
    subject(ActualSubject),
    geographic(ActualLocation),
    similar_string(QuerySubject, ActualSubject),
    similar_string(QueryLocation, ActualLocation).

% Best match ranking for locations
find_best_location_matches(Query, Results) :-
    findall(
        match(Distance, Location, ItemID),
        (
            has_property(ItemID, location, Location),
            geographic(Location),
            normalize_string(Query, QueryNorm),
            normalize_string(Location, LocNorm),
            string_distance(QueryNorm, LocNorm, Distance),
            Distance =< 3
        ),
        Matches
    ),
    sort(Matches, Results).

