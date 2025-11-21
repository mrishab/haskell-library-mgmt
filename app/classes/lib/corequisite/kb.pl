% ============================================================================
% COREQUISITE DEFINITIONS
% ============================================================================
% corequisite(CourseAtom, CoreqCourseAtom)
% Defines which courses must be taken concurrently

% ADED course corequisites
corequisite(aded_365, aded_366).
corequisite(aded_366, aded_365).

% BIOC course corequisites  
corequisite(bioc_320, bioc_320lab).
corequisite(bioc_320lab, bioc_320).

% CHEM course corequisites
corequisite(chem_113, chem_113lab).
corequisite(chem_113lab, chem_113).
