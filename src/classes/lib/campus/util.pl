% ============================================================================
% CAMPUS UTILITIES
% ============================================================================

% Get campus full name
campus_full_name(ab, 'Abbotsford Campus').
campus_full_name(ce, 'CEP Campus').
campus_full_name(ch, 'Chilliwack Campus').
campus_full_name(on, 'Online').
campus_full_name(pr, 'Hope Campus').
campus_full_name(is, 'India Campus').

% Check if campus is physical (not online)
is_physical_campus(Campus) :-
    campus(Campus),
    Campus \= on.

% Check if campus is online
is_online_campus(on).
