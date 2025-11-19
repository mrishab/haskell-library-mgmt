% ============================================================================
% PREREQUISITE DEFINITIONS
% ============================================================================
% prerequisite(CourseAtom, PrereqCourseAtom)
% Defines which courses are prerequisites for other courses

% COMP course prerequisites
prerequisite(comp_155, comp_150).
prerequisite(comp_230, comp_155).
prerequisite(comp_270, comp_230).

% BIO course prerequisites  
prerequisite(bio_320, bio_111).

% BIOC course prerequisites
prerequisite(bioc_320, bio_111).
prerequisite(bioc_320, chem_115).

% CHEM course prerequisites
prerequisite(chem_115, chem_113).

% MATH course prerequisites
prerequisite(math_121, math_120).
prerequisite(math_221, math_121).
