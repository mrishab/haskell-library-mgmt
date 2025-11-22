% ============================================================================
% ARCHIVES MANAGEMENT SYSTEM - Demo Application
% ============================================================================

:- consult('thesaurus/subjects.pl').
:- consult('thesaurus/person.pl').
:- consult('thesaurus/geographic.pl').
:- consult('thesaurus/corporate_body.pl').
:- consult('archives.pl').
:- consult('data.pl').


% -----------------------------------------------------------
% ARCHIVAL THESAURUS DEMO QUERIES
% -----------------------------------------------------------

archival_demo_derived(Result) :-
	findall(ItemID, item_in_collection(ItemID, '2020_06'), ItemsInCollection),
	findall(Item, item_about_subject_in_location(Item, 'Language Education', 'Surrey'), SubjLocItems),
	findall(Item, item_by_organization_at_location(Item, 'Punjabi Language Education Association', 'Surrey'), OrgLocItems),
	findall(Item, item_created_by_person(Item, 'Sanghera, Balwant'), PersonItems),
	collection_has_item_count('2020_06', TotalItems),
	Result = derived{
		items_in_collection: ItemsInCollection,
		language_education_in_surrey: SubjLocItems,
		plea_in_surrey: OrgLocItems,
		items_by_sanghera: PersonItems,
		total_items_in_collection: TotalItems
	}.

% ============================================================================
% MAIN ENTRY POINT
% ============================================================================

archives_main :-
    writeln(''),
    writeln('╔════════════════════════════════════════════════════════════╗'),
    writeln('║        ARCHIVES MANAGEMENT SYSTEM - DEMO                   ║'),
    writeln('╚════════════════════════════════════════════════════════════╝'),
    writeln(''),
    writeln('This is a demo application for the Archives Management System.'),
    writeln(''),
    demo,
    writeln(''),
    writeln('Demo completed. Returning to main menu...').

demo :-
    writeln('=== ARCHIVAL DERIVED RELATIONSHIPS DEMO ==='),
    writeln(''),
    archival_demo_derived(IR),
    IR = derived{items_in_collection:ItemsInColl, language_education_in_surrey:LangSurrey, plea_in_surrey:PleaSurrey, items_by_sanghera:SangheraItems, total_items_in_collection:Total},
    writeln('Items in Joan Mayo Fonds Collection:'),
    print_archive_list(ItemsInColl),
    writeln(''),
    writeln('Items about Language Education located in Surrey:'),
    print_archive_list(LangSurrey),
    writeln(''),
    writeln('Items by PLEA in Surrey:'),
    print_archive_list(PleaSurrey),
    writeln(''),
    writeln('Items created by Balwant Sanghera:'),
    print_archive_list(SangheraItems),
    writeln(''),
    format('Total items in collection: ~w~n', [Total]),
    writeln(''),
    writeln(''),
    fuzzy_search_demo.

% Helper to print a list
print_archive_list([]).
print_archive_list([H|T]) :-
    format('  - ~w~n', [H]),
    print_archive_list(T).

% -----------------------------------------------------------
% FUZZY SEARCH DEMONSTRATION
% -----------------------------------------------------------

fuzzy_search_demo :-
    writeln('=== FUZZY SEARCH DEMONSTRATIONS ==='),
    writeln(''),
    demo_location_fuzzy_search,
    writeln(''),
    demo_subject_fuzzy_search,
    writeln(''),
    demo_person_name_fuzzy_search,
    writeln(''),
    demo_organization_fuzzy_search,
    writeln(''),
    demo_combined_fuzzy_search,
    writeln(''),
    demo_best_match_ranking,
    writeln(''),
    demo_name_consolidation.

% -----------------------------------------------------------
% EXAMPLE 1: Fuzzy Location Search
% -----------------------------------------------------------
% Demonstrates finding items even with typos or variations in location names

demo_location_fuzzy_search :-
    writeln('--- Example 1: Fuzzy Location Search ---'),
    writeln('Query: Find items in "Surry" (intentional typo for Surrey)'),
    writeln(''),
    findall(ItemID, item_in_similar_location(ItemID, 'Surry'), Results1),
    format('Found ~w items matching "Surry":~n', [Results1]),
    print_archive_list(Results1),
    writeln(''),
    writeln('Query: Find items in "Paldi" with stricter threshold'),
    findall(ItemID, item_in_similar_location(ItemID, 'Paldi', 1), Results2),
    format('Found ~w items:~n', [Results2]),
    print_archive_list(Results2).

% -----------------------------------------------------------
% EXAMPLE 2: Fuzzy Subject Search
% -----------------------------------------------------------
% Demonstrates finding items by subject with approximate matching

demo_subject_fuzzy_search :-
    writeln('--- Example 2: Fuzzy Subject Search ---'),
    writeln('Query: Find items about "Language Educaton" (missing "i")'),
    writeln(''),
    findall(ItemID, item_about_similar_subject(ItemID, 'Language Educaton'), Results1),
    format('Found ~w items:~n', [Results1]),
    print_archive_list(Results1),
    writeln(''),
    writeln('Query: Find items about "memoir" (case insensitive)'),
    findall(ItemID, item_about_similar_subject(ItemID, 'memoir'), Results2),
    format('Found ~w items:~n', [Results2]),
    print_archive_list(Results2).

% -----------------------------------------------------------
% EXAMPLE 3: Fuzzy Person Name Search
% -----------------------------------------------------------
% Demonstrates intelligent name matching with different formats

demo_person_name_fuzzy_search :-
    writeln('--- Example 3: Fuzzy Person Name Search ---'),
    writeln('Query: Find items by "Sanghera" (partial name)'),
    writeln(''),
    findall(ItemID, item_by_similar_person(ItemID, 'Sanghera'), Results1),
    format('Found ~w items:~n', [Results1]),
    print_archive_list(Results1),
    writeln(''),
    writeln('Query: Find name variations for "Balwant Sanghera"'),
    find_name_variations('Balwant Sanghera', Variations),
    writeln('Name variations found:'),
    print_archive_list(Variations).

% -----------------------------------------------------------
% EXAMPLE 4: Fuzzy Organization Search
% -----------------------------------------------------------
% Demonstrates finding items by organization with typos

demo_organization_fuzzy_search :-
    writeln('--- Example 4: Fuzzy Organization Search ---'),
    writeln('Query: Find items by "Punjabi Language Educaton Assoc" (abbreviated)'),
    writeln(''),
    findall(ItemID, item_by_similar_organization(ItemID, 'Punjabi Language Educaton Assoc'), Results),
    format('Found ~w items:~n', [Results]),
    print_archive_list(Results).

% -----------------------------------------------------------
% EXAMPLE 5: Combined Fuzzy Search
% -----------------------------------------------------------
% Demonstrates searching multiple criteria with fuzzy matching

demo_combined_fuzzy_search :-
    writeln('--- Example 5: Combined Fuzzy Search ---'),
    writeln('Query: Items about "Language Educaton" in "Surry"'),
    writeln('(Both with intentional typos)'),
    writeln(''),
    findall(
        ItemID,
        item_about_similar_subject_in_similar_location(ItemID, 'Language Educaton', 'Surry'),
        Results
    ),
    format('Found ~w items:~n', [Results]),
    print_archive_list(Results).

% -----------------------------------------------------------
% EXAMPLE 6: Best Match Ranking
% -----------------------------------------------------------
% Demonstrates ranking search results by similarity score

demo_best_match_ranking :-
    writeln('--- Example 6: Best Match Ranking by Distance ---'),
    writeln('Query: Find best matches for "Surrrey" (extra r)'),
    writeln(''),
    find_best_location_matches('Surrrey', Matches),
    writeln('Results ranked by edit distance:'),
    print_ranked_matches(Matches).

print_ranked_matches([]).
print_ranked_matches([match(Distance, Location, ItemID)|Rest]) :-
    format('  Distance ~w: ~w in ~w~n', [Distance, ItemID, Location]),
    print_ranked_matches(Rest).

% -----------------------------------------------------------
% EXAMPLE 7: Name Consolidation Suggestions
% -----------------------------------------------------------
% Demonstrates finding potential duplicate person entries

demo_name_consolidation :-
    writeln('--- Example 7: Name Consolidation Analysis ---'),
    writeln('Analyzing person names for potential duplicates...'),
    writeln(''),
    suggest_name_consolidation(Clusters),
    (   Clusters = []
    ->  writeln('No potential duplicate names found.')
    ;   (   writeln('Potential duplicate person entries:'),
            print_name_clusters(Clusters)
        )
    ).

print_name_clusters([]).
print_name_clusters([cluster(Primary, Members)|Rest]) :-
    format('Cluster (representative: ~w):~n', [Primary]),
    print_archive_list(Members),
    writeln(''),
    print_name_clusters(Rest).

% -----------------------------------------------------------
% ADDITIONAL FUZZY SEARCH EXAMPLES
% -----------------------------------------------------------

% Example: String distance calculation
demo_string_distance(String1, String2) :-
    string_distance(String1, String2, Distance),
    format('Edit distance between "~w" and "~w": ~w~n', [String1, String2, Distance]).

% Example: Test similarity threshold
test_similarity(Query, Target, Threshold) :-
    (   similar_string(Query, Target, Threshold)
    ->  format('"~w" is similar to "~w" (threshold: ~w)~n', [Query, Target, Threshold])
    ;   format('"~w" is NOT similar to "~w" (threshold: ~w)~n', [Query, Target, Threshold])
    ).

% Example: Name format testing
test_name_formats :-
    writeln('=== Name Format Comparison ==='),
    writeln(''),
    writeln('Testing: "Sanghera, Balwant" vs "Balwant Sanghera"'),
    (   similar_name('Sanghera, Balwant', 'Balwant Sanghera')
    ->  writeln('✓ Names recognized as equivalent')
    ;   writeln('✗ Names NOT recognized as equivalent')
    ),
    writeln(''),
    writeln('Testing: "Dr. John Smith" vs "Smith, John"'),
    (   similar_name('Dr. John Smith', 'Smith, John')
    ->  writeln('✓ Names recognized as equivalent')
    ;   writeln('✗ Names NOT recognized as equivalent')
    ).

% Interactive fuzzy search example
fuzzy_search_location(Query) :-
    writeln(''),
    format('Fuzzy searching locations for: "~w"~n', [Query]),
    writeln(''),
    findall(
        result(ItemID, Location, Distance),
        (
            has_property(ItemID, location, Location),
            normalize_string(Query, QueryNorm),
            normalize_string(Location, LocNorm),
            string_distance(QueryNorm, LocNorm, Distance),
            Distance =< 3
        ),
        Results
    ),
    (   Results = []
    ->  writeln('No matches found.')
    ;   (   writeln('Results:'),
            print_fuzzy_results(Results)
        )
    ).

print_fuzzy_results([]).
print_fuzzy_results([result(ItemID, Location, Distance)|Rest]) :-
    format('  ~w (location: ~w, distance: ~w)~n', [ItemID, Location, Distance]),
    print_fuzzy_results(Rest).

% ============================================================================
% INITIALIZATION
% ============================================================================

:- writeln('Archives Management System loaded successfully!').
