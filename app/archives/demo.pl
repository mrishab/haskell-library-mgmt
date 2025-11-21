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
    format('Total items in collection: ~w~n', [Total]).

% Helper to print a list
print_archive_list([]).
print_archive_list([H|T]) :-
    format('  - ~w~n', [H]),
    print_archive_list(T).

% ============================================================================
% INITIALIZATION
% ============================================================================

:- writeln('Archives Management System loaded successfully!').