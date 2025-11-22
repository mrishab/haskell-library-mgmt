% Loan Queries
% -----------------------------------------------------------

borrowed_by_member(MemberName, Books) :-
    member(MID, MemberName),
    findall(Title, (
        borrowed(MID, IID, _),
        has_property(IID, title, Title)
    ), Books).

available_books(Books) :-
    findall(Title, (
        item(IID, _),
        \+ borrowed(_, IID, _),
        has_property(IID, title, Title)
    ), Books).
