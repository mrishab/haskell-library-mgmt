:- consult('app/archives/thesaurus/subjects.pl').
:- consult('app/archives/thesaurus/person.pl').
:- consult('app/archives/thesaurus/geographic.pl').
:- consult('app/archives/thesaurus/corporate_body.pl').
:- consult('app/archives/archives.pl').
:- consult('app/archives/data.pl').
:- consult('app/classes.pl').
:- consult('app/library.pl').

library_demo(Result) :-
	% All currently available book titles
	findall(Title, (available(BID), book(BID, Title, _, _, _)), Available),
	% Books borrowed by Bob Smith
	findall(BookTitle, borrowed_by('Bob Smith', BookTitle), BorrowedByBob),
	Result = demo{available:Available, bob_borrowed:BorrowedByBob}.

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

main :-
    writeln('=== LIBRARY DEMO ==='),
    library_demo(R),
    R = demo{available:Available, bob_borrowed:BorrowedByBob},
    writeln('Available Books:'), writeln(Available), nl,
    writeln('Books Borrowed by Bob Smith:'), writeln(BorrowedByBob), nl, nl,
    
    % writeln('=== ARCHIVAL THESAURUS DEMO ==='),
    % archival_demo(AR),
    % AR = archival_demo{items_by_language_subject:LangItems, items_in_surrey:SurreyItems, items_by_plea:PleaItems},
    % writeln('Items by Language Subject:'), writeln(LangItems), nl,
    % writeln('Items Located in Surrey:'), writeln(SurreyItems), nl,
    % writeln('Items Associated with PLEA:'), writeln(PleaItems), nl, nl,
    
    writeln('=== ARCHIVAL DERIVED RELATIONSHIPS DEMO ==='),
    archival_demo_derived(IR),
    IR = derived{items_in_collection:ItemsInColl, language_education_in_surrey:LangSurrey, plea_in_surrey:PleaSurrey, items_by_sanghera:SangheraItems, total_items_in_collection:Total},
    writeln('Items in Joan Mayo Fonds Collection:'), writeln(ItemsInColl), nl,
    writeln('Items about Language Education located in Surrey:'), writeln(LangSurrey), nl,
    writeln('Items by PLEA in Surrey:'), writeln(PleaSurrey), nl,
    writeln('Items created by Balwant Sanghera:'), writeln(SangheraItems), nl,
    writeln('Total items in collection:'), writeln(Total).