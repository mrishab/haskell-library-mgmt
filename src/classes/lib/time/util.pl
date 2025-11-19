% ============================================================================
% DATE AND TIME UTILITIES
% ============================================================================

% Format date as readable string (e.g., "05-JAN-2026")
format_date(date(Year, Month, Day), DateStr) :-
    month_name(Month, MonthName),
    (Day < 10 -> atom_concat('0', Day, DayStr) ; DayStr = Day),
    atom_concat(DayStr, '-', Temp1),
    atom_concat(Temp1, MonthName, Temp2),
    atom_concat(Temp2, '-', Temp3),
    atom_concat(Temp3, Year, DateStr).

month_name(1, 'JAN').
month_name(2, 'FEB').
month_name(3, 'MAR').
month_name(4, 'APR').
month_name(5, 'MAY').
month_name(6, 'JUN').
month_name(7, 'JUL').
month_name(8, 'AUG').
month_name(9, 'SEP').
month_name(10, 'OCT').
month_name(11, 'NOV').
month_name(12, 'DEC').

% Format time as readable string (e.g., "17:30")
format_time(time(Hour, Minute), TimeStr) :-
    (Hour < 10 -> atom_concat('0', Hour, HourStr) ; HourStr = Hour),
    (Minute < 10 -> atom_concat('0', Minute, MinStr) ; MinStr = Minute),
    atom_concat(HourStr, ':', Temp),
    atom_concat(Temp, MinStr, TimeStr).

% Check if two time ranges overlap
time_overlap(time(Start1H, Start1M), time(End1H, End1M), 
             time(Start2H, Start2M), time(End2H, End2M)) :-
    Start1Minutes is Start1H * 60 + Start1M,
    End1Minutes is End1H * 60 + End1M,
    Start2Minutes is Start2H * 60 + Start2M,
    End2Minutes is End2H * 60 + End2M,
    \+ (End1Minutes =< Start2Minutes ; End2Minutes =< Start1Minutes).


% ============================================================================
% TIME UTILITIES
% ============================================================================

% Get start time for a time atom
time_start(TimeAtom, StartTime) :-
    class_time(TimeAtom, StartTime, _).

% Get end time for a time atom
time_end(TimeAtom, EndTime) :-
    class_time(TimeAtom, _, EndTime).

% Get both start and end time for a time atom
time_range(TimeAtom, StartTime, EndTime) :-
    class_time(TimeAtom, StartTime, EndTime).

% Format time for display (e.g., "08:30" from time(8,30))
format_time_value(time(H, M), Formatted) :-
    (H < 10 -> atom_concat('0', H, HStr) ; atom_number(HStr, H)),
    (M < 10 -> atom_concat('0', M, MStr) ; atom_number(MStr, M)),
    atom_concat(HStr, ':', Temp),
    atom_concat(Temp, MStr, Formatted).

% Format time range for display
time_display(TimeAtom, Display) :-
    class_time(TimeAtom, StartTime, EndTime),
    format_time_value(StartTime, StartStr),
    format_time_value(EndTime, EndStr),
    atom_concat(StartStr, ' - ', Temp),
    atom_concat(Temp, EndStr, Display).

% Convert time to minutes since midnight
time_to_minutes(time(H, M), Minutes) :-
    Minutes is H * 60 + M.

% Convert minutes to time
minutes_to_time(Minutes, time(H, M)) :-
    H is Minutes // 60,
    M is Minutes mod 60.

% Calculate duration between two times in minutes
time_duration(time(H1, M1), time(H2, M2), Duration) :-
    time_to_minutes(time(H1, M1), Min1),
    time_to_minutes(time(H2, M2), Min2),
    Duration is Min2 - Min1.

% Check if a time is before another
time_before(time(H1, M1), time(H2, M2)) :-
    time_to_minutes(time(H1, M1), Min1),
    time_to_minutes(time(H2, M2), Min2),
    Min1 < Min2.

% Check if a time is after another
time_after(time(H1, M1), time(H2, M2)) :-
    time_before(time(H2, M2), time(H1, M1)).

% Compare two dates
date_before(date(Y1,M1,D1), date(Y2,M2,D2)) :-
    (Y1 < Y2 ; 
     (Y1 = Y2, M1 < M2) ; 
     (Y1 = Y2, M1 = M2, D1 < D2)).

date_after(Date1, Date2) :-
    date_before(Date2, Date1).

date_equals(date(Y,M,D), date(Y,M,D)).

% Get day of week name
day_name(monday, 'Monday').
day_name(tuesday, 'Tuesday').
day_name(wednesday, 'Wednesday').
day_name(thursday, 'Thursday').
day_name(friday, 'Friday').
day_name(saturday, 'Saturday').
day_name(sunday, 'Sunday').

% Check if day is a weekday
is_weekday(monday).
is_weekday(tuesday).
is_weekday(wednesday).
is_weekday(thursday).
is_weekday(friday).

% Check if day is a weekend
is_weekend(saturday).
is_weekend(sunday).