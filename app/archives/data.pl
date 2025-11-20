% ============================================================
% COLLECTIONS
% ============================================================

collection('2020_06', 'Joan Mayo Fonds').

% ============================================================
% FILES/SERIES
% ============================================================

file('2020_06_04', 'Series 4: Manuscripts').
child_of('2020_06_04', '2020_06').

file('2020_06_03', 'Series 5: Correspondence and obituaries').
child_of('2020_06_03', '2020_06').

file('2020_06_01', 'testFile').
child_of('2020_06_01', '2020_06').

% ============================================================
% ITEMS
% ============================================================

% Item 1: Paldi Remembered manuscript 1
item('2020_06_04_001', 'Paldi Remembered manuscript 1').
child_of('2020_06_04_001', '2020_06_04').

% Properties for item 2020_06_04_001
has_property('2020_06_04_001', title, 'Paldi Remembered manuscript 1').
has_property('2020_06_04_001', subject, 'Memoir').
has_property('2020_06_04_001', location, 'Paldi').
has_property('2020_06_04_001', resource_type, 'text').
has_property('2020_06_04_001', edtf_date_created, date(1984, 1, 1)).
has_property('2020_06_04_001', extent, '1 manuscript : 12 pages').

% Item 2: Paldi Remembered manuscript 2
item('2020_06_04_002', 'Paldi Remembered manuscript 2').
child_of('2020_06_04_002', '2020_06_04').

% Properties for item 2020_06_04_002
has_property('2020_06_04_002', title, 'Paldi Remembered manuscript 2').
has_property('2020_06_04_002', subject, 'Manuscripts').
has_property('2020_06_04_002', location, 'Paldi').
has_property('2020_06_04_002', resource_type, 'text').
has_property('2020_06_04_002', edtf_date_created, date(1985, 6, 15)).
has_property('2020_06_04_002', extent, '1 manuscript : 8 pages').

% Item 3: Paldi Remembered manuscript 3
item('2020_06_04_003', 'Paldi Remembered manuscript 3').
child_of('2020_06_04_003', '2020_06_04').

% Properties for item 2020_06_04_003
has_property('2020_06_04_003', title, 'Paldi Remembered manuscript 3').
has_property('2020_06_04_003', subject, 'Drafts').
has_property('2020_06_04_003', location, 'Paldi').
has_property('2020_06_04_003', resource_type, 'text').
has_property('2020_06_04_003', edtf_date_created, date(1986, 3, 1)).
has_property('2020_06_04_003', extent, '1 manuscript : 5 pages').

% Item 4: Wedding invitation for Nona and Narendra
item('2020_06_03_001', 'Wedding invitation for Nona and Narendra').
child_of('2020_06_03_001', '2020_06_03').

% Properties for item 2020_06_03_001
has_property('2020_06_03_001', title, 'Wedding invitation for Nona and Narendra').
has_property('2020_06_03_001', subject, 'Ephemera').
has_property('2020_06_03_001', linked_agent, 'Nona').
has_property('2020_06_03_001', location, 'Surrey').
has_property('2020_06_03_001', resource_type, 'ephemera').
has_property('2020_06_03_001', edtf_date_created, date(1991, 9, 12)).

% Item 5: Wedding invitation for Harinder Kaur and Bobby Kandola
item('2020_06_03_002', 'Wedding invitation for marriage of Harinder Kaur and Bobby Kandola').
child_of('2020_06_03_002', '2020_06_03').

% Properties for item 2020_06_03_002
has_property('2020_06_03_002', title, 'Wedding invitation for marriage of Harinder Kaur and Bobby Kandola').
has_property('2020_06_03_002', subject, 'Ephemera').
has_property('2020_06_03_002', linked_agent, 'Harinder Kaur').
has_property('2020_06_03_002', location, 'Surrey').
has_property('2020_06_03_002', resource_type, 'ephemera').
has_property('2020_06_03_002', edtf_date_created, date(1995, 6, 21)).

% Item 6: Wedding invitation for Dr. Sheila Manhas and others
item('2020_06_03_003', 'Wedding invitation for marriage of Dr. Sheila Manhas to Dr. Ravi Raj Parmer and Dr. Sharan Manhas to Dr. Neal Prakash').
child_of('2020_06_03_003', '2020_06_03').

% Properties for item 2020_06_03_003
has_property('2020_06_03_003', title, 'Wedding invitation for marriage of Dr. Sheila Manhas to Dr. Ravi Raj Parmer and Dr. Sharan Manhas to Dr. Neal Prakash').
has_property('2020_06_03_003', subject, 'Ephemera').
has_property('2020_06_03_003', linked_agent, 'Dr. Sheila Manhas').
has_property('2020_06_03_003', location, 'Surrey').
has_property('2020_06_03_003', resource_type, 'ephemera').
has_property('2020_06_03_003', edtf_date_created, date(1992, 11, 8)).

% ============================================================
% ITEM METADATA & PROPERTIES
% ============================================================

% Example item with full metadata integration (2020_06_01_001)
item('2020_06_01_001', 'test item 1').
child_of('2020_06_01_001', '2020_06_01').

% Properties for item 2020_06_01_001
has_property('2020_06_01_001', title, 'test item 1').
has_property('2020_06_01_001', subject, 'Events').
has_property('2020_06_01_001', subject, 'Language Education').
has_property('2020_06_01_001', subject, 'Speeches, Addresses, etc., Canadian').
has_property('2020_06_01_001', subject, 'International Mother Language Day').
has_property('2020_06_01_001', subject, 'Sanghera, Balwant').
has_property('2020_06_01_001', linked_agent, 'Chandra Bodalia').
has_property('2020_06_01_001', location, 'Surrey').
has_property('2020_06_01_001', corporate_body, 'Punjabi Language Education Association').
has_property('2020_06_01_001', edtf_date_created, date(2004, 2, 22)).
has_property('2020_06_01_001', extent, '1 photograph : col. negative').
has_property('2020_06_01_001', resource_type, 'still image').
has_property('2020_06_01_001', language, 'English').
has_property('2020_06_01_001', description, 'Photograph of an unidentified woman addressing the audience at the International Mother Language Day event organized by the Punjabi Language Education Association (PLEA) on February 22, 2004, in Bear Creek, Surrey, British Columbia (B.C.). International Mother Language Day (IMLD) is observed globally on February 21, following UNESCO declaration on November 17, 1999, after advocacy led by Bangladesh and other nations. This day is celebrated worldwide to honor linguistic heritage and promote preservation of mother languages. The Punjabi Language Education Association (PLEA) is a community-based organization dedicated to raising awareness about challenges faced by the Punjabi language and advocating for its inclusion in British Columbia educational institutions. Since 2002, PLEA has organized annual IMLD celebrations, along with various events aimed at promoting Punjabi language and culture.').


