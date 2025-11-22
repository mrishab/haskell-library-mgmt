% Member Queries
% -----------------------------------------------------------

all_members(Members) :-
    findall(Name, member(_, Name), Members).
