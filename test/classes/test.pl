% ============================================================================
% UFV Course Management System - Test Queries (Refactored)
% ============================================================================
% This file contains comprehensive test queries to validate the knowledge
% base and reasoning system using the new data structures.
% ============================================================================

:- consult('../../app/classes/queries.pl').

% ============================================================================
% TEST SECTION 1: BASIC COURSE QUERIES
% ============================================================================

test_basic_queries :-
    writeln('========================================'),
    writeln('TEST 1: BASIC COURSE QUERIES'),
    writeln('========================================'),
    writeln(''),
    
    writeln('1.1 Testing courses_in_faculty/2 - Finding courses by faculty:'),
    courses_in_faculty(comp, CompCourses),
    list_length(CompCourses, CompCount),
    format('  Found ~w COMP courses~n', [CompCount]),
    courses_in_faculty(bio, BioCourses),
    list_length(BioCourses, BioCount),
    format('  Found ~w BIO courses~n', [BioCount]),
    writeln(''),
    
    writeln('1.2 Testing course_level/2 - Finding course levels:'),
    course_level(comp_150, Level1),
    format('  COMP 150 is level ~w (expected: 1)~n', [Level1]),
    course_level(bio_320, Level2),
    format('  BIO 320 is level ~w (expected: 3)~n', [Level2]),
    course_level(agri_124, Level3),
    format('  AGRI 124 is level ~w (expected: 1)~n', [Level3]),
    writeln(''),
    
    writeln('1.3 Testing course atoms - Checking course data:'),
    (course(comp_150, _, _, Name150, Credits150, _) ->
        format('  COMP 150: ~w (~w credits)~n', [Name150, Credits150]) ;
        writeln('  Failed to find COMP 150')),
    writeln(''),
    
    writeln('1.4 Testing course_display_code/2:'),
    course_display_code(comp_150, Code150),
    format('  comp_150 displays as: ~w~n', [Code150]),
    writeln('').

% ============================================================================
% TEST SECTION 2: PREREQUISITE REASONING
% ============================================================================

test_prerequisites :-
    writeln('========================================'),
    writeln('TEST 2: PREREQUISITE REASONING'),
    writeln('========================================'),
    writeln(''),
    
    writeln('2.1 Testing direct_prerequisites/2:'),
    direct_prerequisites(comp_155, Prereqs155),
    format('  Direct prerequisites for COMP 155: ~w~n', [Prereqs155]),
    direct_prerequisites(bio_320, Prereqs320),
    format('  Direct prerequisites for BIO 320: ~w~n', [Prereqs320]),
    writeln(''),
    
    writeln('2.2 Testing all_prerequisites/2 - Recursive prerequisite chains:'),
    all_prerequisites(comp_230, AllPrereqs230),
    format('  All prerequisites for COMP 230: ~w~n', [AllPrereqs230]),
    writeln(''),
    
    writeln('2.3 Testing has_prerequisites/1:'),
    (has_prerequisites(comp_150) ->
        writeln('  COMP 150 has prerequisites') ;
        writeln('  COMP 150 has no prerequisites')),
    (has_prerequisites(comp_155) ->
        writeln('  ✓ COMP 155 has prerequisites') ;
        writeln('  ✗ COMP 155 has no prerequisites')),
    writeln(''),
    
    writeln('2.4 Testing can_take_course/2 - Course eligibility:'),
    (can_take_course(comp_155, [comp_150]) ->
        writeln('  ✓ Can take COMP 155 with COMP 150 completed') ;
        writeln('  ✗ Cannot take COMP 155 with COMP 150 completed')),
    (can_take_course(comp_230, [comp_155]) ->
        writeln('  ✓ Can take COMP 230 with COMP 155 completed') ;
        writeln('  ✗ Cannot take COMP 230 with COMP 155 completed')),
    writeln('').

% ============================================================================
% TEST SECTION 3: INSTRUCTOR QUERIES
% ============================================================================

test_instructors :-
    writeln('========================================'),
    writeln('TEST 3: INSTRUCTOR QUERIES'),
    writeln('========================================'),
    writeln(''),
    
    writeln('3.1 Testing instructor_full_name/2:'),
    instructor_full_name(inst_eshghi, FarshadName),
    format('  inst_eshghi: ~w~n', [FarshadName]),
    instructor_full_name(inst_maranda, CherylName),
    format('  inst_maranda: ~w~n', [CherylName]),
    writeln(''),
    
    writeln('3.2 Testing courses_taught_by/2:'),
    courses_taught_by(inst_eshghi, FarshadCourses),
    format('  Farshad Eshghi teaches: ~w~n', [FarshadCourses]),
    writeln(''),
    
    writeln('3.3 Testing instructor_section_count/2:'),
    instructor_section_count(inst_hossain, ZiaulLoad),
    format('  Ziaul Hossain teaches ~w sections~n', [ZiaulLoad]),
    instructor_section_count(inst_bodnar, ChrisLoad),
    format('  Chris Bodnar teaches ~w sections~n', [ChrisLoad]),
    writeln(''),
    
    writeln('3.4 Testing instructors_for_course/2:'),
    instructors_for_course(comp_150, Comp150Instructors),
    format('  COMP 150 instructors: ~w~n', [Comp150Instructors]),
    writeln(''),
    
    writeln('3.5 Testing team_taught_sections/1:'),
    team_taught_sections(TeamTaught),
    format('  Team-taught sections: ~w~n', [TeamTaught]),
    writeln('').

% ============================================================================
% TEST SECTION 4: SECTION AND SCHEDULE QUERIES
% ============================================================================

test_sections :-
    writeln('========================================'),
    writeln('TEST 4: SECTION AND SCHEDULE QUERIES'),
    writeln('========================================'),
    writeln(''),
    
    writeln('4.1 Testing course_sections/2:'),
    course_sections(comp_150, Comp150Sections),
    list_length(Comp150Sections, Comp150Count),
    format('  COMP 150 has ~w sections~n', [Comp150Count]),
    writeln(''),
    
    writeln('4.2 Testing is_online/1:'),
    (is_online(10085) ->
        writeln('  ✓ CRN 10085 is online') ;
        writeln('  ✗ CRN 10085 is not online')),
    (is_online(10481) ->
        writeln('  ✗ CRN 10481 is online (should be in-person)') ;
        writeln('  ✓ CRN 10481 is not online')),
    writeln(''),
    
    writeln('4.3 Testing is_hybrid/1:'),
    (is_hybrid(10477) ->
        writeln('  ✓ CRN 10477 is hybrid') ;
        writeln('  ✗ CRN 10477 is not hybrid')),
    writeln(''),
    
    writeln('4.4 Testing sections_on_campus/2:'),
    sections_on_campus(ab, AbSections),
    list_length(AbSections, AbCount),
    format('  Abbotsford campus has ~w sections~n', [AbCount]),
    sections_on_campus(on, OnSections),
    list_length(OnSections, OnCount),
    format('  Online sections: ~w~n', [OnCount]),
    writeln(''),
    
    writeln('4.5 Testing sections_on_day/2:'),
    sections_on_day(tuesday, TuesdaySections),
    list_length(TuesdaySections, TuesdayCount),
    format('  Sections meeting on Tuesday: ~w~n', [TuesdayCount]),
    writeln('').

% ============================================================================
% TEST SECTION 5: ROOM AND FACILITY QUERIES
% ============================================================================

test_rooms :-
    writeln('========================================'),
    writeln('TEST 5: ROOM AND FACILITY QUERIES'),
    writeln('========================================'),
    writeln(''),
    
    writeln('5.1 Testing rooms_on_floor/2:'),
    rooms_on_floor(2, Floor2Rooms),
    format('  Rooms on floor 2: ~w~n', [Floor2Rooms]),
    writeln(''),
    
    writeln('5.2 Testing rooms_in_building/2:'),
    rooms_in_building('ABD', ABDRooms),
    format('  Rooms in ABD building: ~w~n', [ABDRooms]),
    writeln(''),
    
    writeln('5.3 Testing sections_in_room/3:'),
    sections_in_room('ABD', 204, Sections204),
    list_length(Sections204, Count204),
    format('  ABD 204 hosts ~w class sessions~n', [Count204]),
    writeln('').

% ============================================================================
% TEST SECTION 6: ADVANCED QUERIES
% ============================================================================

test_advanced :-
    writeln('========================================'),
    writeln('TEST 6: ADVANCED QUERIES'),
    writeln('========================================'),
    writeln(''),
    
    writeln('6.1 Testing popular_courses/1:'),
    popular_courses(Popular),
    format('  Popular courses (multiple sections): ~w~n', [Popular]),
    writeln(''),
    
    writeln('6.2 Testing total_course_capacity/2:'),
    total_course_capacity(comp_150, Capacity150),
    format('  Total capacity for COMP 150: ~w students~n', [Capacity150]),
    writeln(''),
    
    writeln('6.3 Testing time_conflict/2:'),
    (time_conflict(10481, 10482) ->
        format('  CRN 10481 and 10482 have time conflict~n') ;
        format('  CRN 10481 and 10482 have no conflict~n')),
    writeln(''),
    
    writeln('6.4 Testing compatible_sections/2:'),
    (compatible_sections(10481, 10487) ->
        writeln('  ✓ CRN 10481 and 10487 are compatible') ;
        writeln('  ✗ CRN 10481 and 10487 conflict')),
    writeln('').

% ============================================================================
% TEST SECTION 7: COURSE PLANNING
% ============================================================================

test_planning :-
    writeln('========================================'),
    writeln('TEST 7: COURSE PLANNING'),
    writeln('========================================'),
    writeln(''),
    
    writeln('7.1 Testing courses_at_level/2:'),
    courses_at_level(1, Level1Courses),
    list_length(Level1Courses, Level1Count),
    format('  Found ~w first-year courses~n', [Level1Count]),
    writeln(''),
    
    writeln('7.2 Testing find_corequisites/2:'),
    find_corequisites(aded_365, CoreqsADED365),
    format('  ADED 365 corequisites: ~w~n', [CoreqsADED365]),
    writeln(''),
    
    writeln('7.3 Testing prerequisite chains for COMP courses:'),
    writeln('  Building prerequisite chain: COMP 230 → COMP 155 → COMP 150'),
    (prerequisite(comp_230, comp_155) ->
        writeln('  ✓ COMP 230 requires COMP 155') ; 
        writeln('  ✗ Prerequisite not found')),
    (prerequisite(comp_155, comp_150) ->
        writeln('  ✓ COMP 155 requires COMP 150') ; 
        writeln('  ✗ Prerequisite not found')),
    writeln('').

% ============================================================================
% TEST SECTION 8: REPORTING FUNCTIONS
% ============================================================================

test_reports :-
    writeln('========================================'),
    writeln('TEST 8: REPORTING FUNCTIONS'),
    writeln('========================================'),
    writeln(''),
    
    writeln('8.1 Generating course offering report for COMP 150:'),
    course_offering_report(comp_150, Report),
    writeln(Report),
    writeln(''),
    
    writeln('8.2 Generating instructor schedule for inst_eshghi:'),
    instructor_schedule(inst_eshghi, Schedule),
    writeln(Schedule),
    writeln('').

% ============================================================================
% TEST SECTION 9: CONSTRAINT SATISFACTION
% ============================================================================

test_constraints :-
    writeln('========================================'),
    writeln('TEST 9: CONSTRAINT SATISFACTION'),
    writeln('========================================'),
    writeln(''),
    
    writeln('9.1 Testing schedule building (no time conflicts):'),
    writeln('  Attempting to build schedule with CRNs: 10481, 10487, 10491'),
    build_schedule([10481, 10487, 10491], Schedule1),
    format('  Valid schedule: ~w~n', [Schedule1]),
    writeln(''),
    
    writeln('9.2 Testing instructor assignment with load limits:'),
    assign_instructors([comp150_ab1, comp150_ab2, comp155_ab2], 
                      ['Instructor A', 'Instructor B', 'Instructor C'], 
                      2, Assignments),
    format('  Instructor assignments (max 2 sections each): ~w~n', [Assignments]),
    writeln('').

% ============================================================================
% TEST SECTION 10: CROSS-LISTED COURSES AND EQUIVALENCIES
% ============================================================================

test_cross_listed :-
    writeln('========================================'),
    writeln('TEST 10: CROSS-LISTED COURSES'),
    writeln('========================================'),
    writeln(''),
    
    writeln('10.1 Finding courses offered by the same number across faculties:'),
    course(bio_320, bio, 320, BioName, _, _),
    course(bioc_320, bioc, 320, BiocName, _, _),
    format('  BIO 320: ~w~n', [BioName]),
    format('  BIOC 320: ~w~n', [BiocName]),
    writeln('  (These are cross-listed as equivalent courses)'),
    writeln('').

% ============================================================================
% MASTER TEST RUNNER
% ============================================================================

run_all_tests :-
    writeln(''),
    writeln('╔════════════════════════════════════════════════════════════╗'),
    writeln('║   UFV COURSE MANAGEMENT SYSTEM - COMPREHENSIVE TESTS      ║'),
    writeln('╚════════════════════════════════════════════════════════════╝'),
    writeln(''),
    
    test_basic_queries,
    test_prerequisites,
    test_instructors,
    test_sections,
    test_rooms,
    test_advanced,
    test_planning,
    test_reports,
    test_constraints,
    test_cross_listed,
    
    writeln(''),
    writeln('╔════════════════════════════════════════════════════════════╗'),
    writeln('║              ALL TESTS COMPLETED SUCCESSFULLY              ║'),
    writeln('╚════════════════════════════════════════════════════════════╝'),
    writeln('').

% ============================================================================
% INTERACTIVE QUERY EXAMPLES
% ============================================================================

% Example queries that can be run interactively:
/*

% Find all Computer Science courses:
?- courses_in_faculty(comp, Courses).

% Check what prerequisites COMP 230 requires:
?- direct_prerequisites(comp, 230, Prereqs).

% Find all courses taught by a specific instructor:
?- courses_by_instructor('Farshad Eshghi', Courses).

% Find all sections on Tuesday:
?- sections_on_day(tuesday, Sections).

% Check if two sections have time conflicts:
?- time_conflict(10481, 10482).

% Find all online sections:
?- class_section(CRN, CourseAtom, Section, Instructor, on, _, _, _, _).

% Get total enrollment capacity for a course:
?- total_course_capacity(comp, 150, Capacity).

% Find courses with 4.0 credits:
?- courses_with_credits(4.0, Courses).

% Check course levels:
?- course_level(comp, 150, Level).

% Find all rooms in a building:
?- rooms_in_building('ABD', Rooms).

% Generate a course report:
?- course_offering_report(comp, 150).

% Generate an instructor schedule:
?- instructor_schedule('Farshad Eshghi').

% Find popular courses (multiple sections):
?- popular_courses(Courses).

% Check if student can take a course (with prerequisites completed):
?- can_take_course(comp, 155, [[comp, 150]]).

% Find all prerequisites recursively:
?- all_prerequisites(comp, 230, AllPrereqs).

% Find entry-level courses (no prerequisites):
?- entry_level_courses(comp, Courses).

% Find compatible sections (no time conflicts):
?- compatible_sections(10481, 10487).

% Build a valid schedule:
?- build_schedule([10481, 10487, 10491], Schedule).

*/

% ============================================================================
% DEMO QUERIES
% ============================================================================

demo :-
    writeln(''),
    writeln('╔════════════════════════════════════════════════════════════╗'),
    writeln('║        UFV COURSE MANAGEMENT SYSTEM - DEMO QUERIES         ║'),
    writeln('╚════════════════════════════════════════════════════════════╝'),
    writeln(''),
    
    writeln('DEMO 1: Find all COMP 150 sections and their instructors'),
    writeln('Query: course_sections(comp, 150, Sections)'),
    course_sections(comp, 150, DemoSections),
    writeln(DemoSections),
    writeln(''),
    
    writeln('DEMO 2: Check prerequisite chain for COMP 230'),
    writeln('Query: all_prerequisites(comp, 230, Prereqs)'),
    all_prerequisites(comp, 230, DemoPrereqs),
    writeln(DemoPrereqs),
    writeln(''),
    
    writeln('DEMO 3: Find all courses taught by Javad Hadian'),
    writeln('Query: courses_by_instructor(\'Javad Hadian\', Courses)'),
    courses_by_instructor('Javad Hadian', DemoCourses),
    writeln(DemoCourses),
    writeln(''),
    
    writeln('DEMO 4: Check which sections meet on Thursday'),
    writeln('Query: sections_on_day(thursday, Sections)'),
    sections_on_day(thursday, DemoThursday),
    list_length(DemoThursday, ThursdayCount),
    format('Found ~w sections meeting on Thursday~n', [ThursdayCount]),
    writeln(''),
    
    writeln('DEMO 5: Find online sections'),
    writeln('Query: is_online_section(CRN)'),
    findall(CRN, is_online_section(CRN), OnlineCRNs),
    list_length(OnlineCRNs, OnlineCount),
    format('Found ~w online sections~n', [OnlineCount]),
    writeln('').
