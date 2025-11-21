% ============================================================================
% CLASS TIME DEFINITIONS
% ============================================================================
% class_time(TimeAtom, StartTime, EndTime)
% Defines reusable time slots for class schedules


% Morning slots (8:30 - 12:20)
class_time(morning_0830_1120, time(8,30), time(11,20)).
class_time(morning_0830_1220, time(8,30), time(12,20)).

% Afternoon slots (11:30 - 17:20)
class_time(afternoon_1130_1420, time(11,30), time(14,20)).
class_time(afternoon_1300_1650, time(13,0), time(16,50)).
class_time(afternoon_1430_1720, time(14,30), time(17,20)).

% Evening slots (17:30 - 21:50)
class_time(evening_1730_2120, time(17,30), time(21,20)).
class_time(evening_1900_2150, time(19,0), time(21,50)).
