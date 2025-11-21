% ============================================================================
% CLASS TIMES UTILITIES
% ============================================================================

% Get start time for a time atom
class_time_start(TimeAtom, StartTime) :-
    class_time(TimeAtom, StartTime, _).

% Get end time for a time atom
class_time_end(TimeAtom, EndTime) :-
    class_time(TimeAtom, _, EndTime).

% Get both start and end time for a time atom
class_time_range(TimeAtom, StartTime, EndTime) :-
    class_time(TimeAtom, StartTime, EndTime).

% Check if two time slots overlap
% Note: time_overlap/4 is defined in lib/time/util.pl
time_slots_overlap(TimeAtom1, TimeAtom2) :-
    class_time(TimeAtom1, Start1, End1),
    class_time(TimeAtom2, Start2, End2),
    time_overlap(Start1, End1, Start2, End2).

% Get duration in minutes for a time slot
class_time_duration(TimeAtom, Duration) :-
    class_time(TimeAtom, time(H1, M1), time(H2, M2)),
    Duration is (H2 * 60 + M2) - (H1 * 60 + M1).

% Check if time is morning (before 12:00)
is_morning_time(TimeAtom) :-
    class_time(TimeAtom, time(H, _), _),
    H < 12.

% Check if time is afternoon (12:00 - 17:00)
is_afternoon_time(TimeAtom) :-
    class_time(TimeAtom, time(H, _), _),
    H >= 12,
    H < 17.

% Check if time is evening (17:00 or later)
is_evening_time(TimeAtom) :-
    class_time(TimeAtom, time(H, _), _),
    H >= 17.
