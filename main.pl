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

% Query 1: Find all items by subject with titles
archival_demo_by_subject(SubjectLabel, Items) :-
	findall(Title, (has_property(ItemID, subject, SubjectLabel), item(ItemID, Title)), Items).

% Query 2: Find all items in a geographic location with titles
archival_demo_by_location(LocationLabel, Items) :-
	findall(Title, (has_property(ItemID, location, LocationLabel), item(ItemID, Title)), Items).

% Query 3: Find all items associated with a corporate body with titles
archival_demo_by_organization(OrgLabel, Items) :-
	findall(Title, (has_property(ItemID, corporate_body, OrgLabel), item(ItemID, Title)), Items).

% Query 4: Get full item record with all metadata
archival_demo_full_record(ItemID, Record) :-
	item(ItemID, Title),
	findall(Subj, has_property(ItemID, subject, Subj), Subjects),
	findall(Agent, has_property(ItemID, agent, Agent), Agents),
	findall(Loc, has_property(ItemID, location, Loc), Locations),
	has_description(ItemID, Description),
	Record = record{
		item_id: ItemID,
		title: Title,
		subjects: Subjects,
		agents: Agents,
		locations: Locations,
		description: Description
	}.

% Combined archival demo
archival_demo(Result) :-
	% Items by subject: Language Education
	archival_demo_by_subject('Language Education', LanguageItems),
	% Items by location: Surrey
	archival_demo_by_location('Surrey', SurreyItems),
	% Items by organization: PLEA
	archival_demo_by_organization('Punjabi Language Education Association', PleaItems),
	Result = archival_demo{
		items_by_language_subject: LanguageItems,
		items_in_surrey: SurreyItems,
		items_by_plea: PleaItems
	}.

main :-
    writeln('=== LIBRARY DEMO ==='),
    library_demo(R),
    pretty_print(R),
    nl, nl,
    writeln('=== ARCHIVAL THESAURUS DEMO ==='),
    archival_demo(AR),
    pretty_print_archival(AR).

pretty_print(demo{available:Available, bob_borrowed:BorrowedByBob}) :-
    writeln('=== LIBRARY DEMO RESULTS ==='),
    nl,
    writeln('Available Books:'),
    writeln(Available),
    nl,
    writeln('Books Borrowed by Bob Smith:'),
    writeln(BorrowedByBob).

pretty_print_archival(archival_demo{items_by_language_subject:LangItems, items_in_surrey:SurreyItems, items_by_plea:PleaItems}) :-
    writeln('Items by Language Subject:'),
    writeln(LangItems),
    nl,
    writeln('Items Located in Surrey:'),
    writeln(SurreyItems),
    nl,
    writeln('Items Associated with PLEA:'),
    writeln(PleaItems).