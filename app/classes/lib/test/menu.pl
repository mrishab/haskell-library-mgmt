% ============================================================================
% RUN TESTS
% ============================================================================

run_tests :-
    writeln(''),
    writeln('Running system tests...'),
    writeln(''),
    % Get the source file directory and construct path to test file
    source_file(run_tests, ThisFile),
    file_directory_name(ThisFile, TestDir),
    file_directory_name(TestDir, LibDir),
    file_directory_name(LibDir, AppClassesDir),
    file_directory_name(AppClassesDir, AppDir),
    file_directory_name(AppDir, RootDir),
    atom_concat(RootDir, '/test/classes/test.pl', TestFile),
    consult(TestFile),
    run_all_tests.
