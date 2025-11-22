% Book Queries
% -----------------------------------------------------------

all_books(Books) :-
    findall(Title, (item(IID, _), has_property(IID, title, Title)), Books).

books_by_author(QueryAuthor, Books) :-
    string_lower(QueryAuthor, QueryLower),
    findall(Title, (
        has_property(IID, author, Author),
        string_lower(Author, AuthorLower),
        sub_string(AuthorLower, _, _, _, QueryLower),
        has_property(IID, title, Title)
    ), Books).

books_in_genre(QueryGenre, Books) :-
    string_lower(QueryGenre, QueryLower),
    findall(Title, (
        has_property(IID, genre, Genre),
        string_lower(Genre, GenreLower),
        sub_string(GenreLower, _, _, _, QueryLower),
        has_property(IID, title, Title)
    ), Books).

