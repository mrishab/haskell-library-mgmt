% ============================================================================
% ROOM DEFINITIONS
% ============================================================================
% room(RoomAtom, Building, RoomNumber, Campus, Floor)
% Defines classroom locations with unique identifiers


room(abd_204, 'ABD', 204, ab, 2).
room(abd_226, 'ABD', 226, ab, 2).
room(abd_242, 'ABD', 242, ab, 2).
room(aba_302, 'ABA', 302, ab, 3).
room(abc_1015, 'ABC', 1015, ab, 1).
room(abk_167, 'ABK', 167, ab, 1).
room(cepa_1316, 'CEPA', 1316, ce, 1).
room(cepa_2105, 'CEPA', 2105, ce, 2).
room(cepv_107, 'CEPV', 107, ce, 1).

% Special room for online classes
room(online, none, none, on, none).
