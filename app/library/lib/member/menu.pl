% Member Menu
% -----------------------------------------------------------

member_menu :-
    writeln(''),
    writeln('--- Member Queries ---'),
    writeln('1. List all members'),
    writeln('2. Back to Main Menu'),
    write('Enter choice: '),
    read(Choice),
    process_member_choice(Choice).

process_member_choice(1) :-
    all_members(Members),
    print_member_list(Members),
    member_menu.

process_member_choice(2) :- !.

process_member_choice(_) :-
    writeln('Invalid choice.'),
    member_menu.
