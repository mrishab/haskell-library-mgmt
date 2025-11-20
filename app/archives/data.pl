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

% Item 2: Paldi Remembered manuscript 2
item('2020_06_04_002', 'Paldi Remembered manuscript 2').
child_of('2020_06_04_002', '2020_06_04').

% Item 3: Paldi Remembered manuscript 3
item('2020_06_04_003', 'Paldi Remembered manuscript 3').
child_of('2020_06_04_003', '2020_06_04').

% Item 4: Wedding invitation for Nona and Narendra
item('2020_06_03_001', 'Wedding invitation for Nona and Narendra').
child_of('2020_06_03_001', '2020_06_03').

% Item 5: Wedding invitation for Harinder Kaur and Bobby Kandola
item('2020_06_03_002', 'Wedding invitation for marriage of Harinder Kaur and Bobby Kandola').
child_of('2020_06_03_002', '2020_06_03').

% Item 6: Wedding invitation for Dr. Sheila Manhas and others
item('2020_06_03_003', 'Wedding invitation for marriage of Dr. Sheila Manhas to Dr. Ravi Raj Parmer and Dr. Sharan Manhas to Dr. Neal Prakash').
child_of('2020_06_03_003', '2020_06_03').

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
has_property('2020_06_01_001', agent, 'Sanghera, Balwant').
has_property('2020_06_01_001', linked_agent, 'Chandra Bodalia').
has_property('2020_06_01_001', location, 'Bear Creek').
has_property('2020_06_01_001', location, 'Surrey').
has_property('2020_06_01_001', location, 'British Columbia').
has_property('2020_06_01_001', corporate_body, 'Punjabi Language Education Association').
has_property('2020_06_01_001', edtf_date_created, date(2004, 2, 22)).
has_property('2020_06_01_001', extent, '1 photograph : col. negative').
has_property('2020_06_01_001', resource_type, 'still image').
has_property('2020_06_01_001', language, 'English').
has_property('2020_06_01_001', rights, 'CC BY-NC-SA 4.0').
has_property('2020_06_01_001', file_name, '01_002.jpg').
has_property('2020_06_01_001', file_extension, 'jpg').

has_description('2020_06_01_001', 'Photograph of an unidentified woman addressing the audience at the International Mother Language Day event organized by the Punjabi Language Education Association (PLEA) on February 22, 2004, in Bear Creek, Surrey, British Columbia (B.C.). International Mother Language Day (IMLD) is observed globally on February 21, following UNESCO declaration on November 17, 1999, after advocacy led by Bangladesh and other nations. This day is celebrated worldwide to honor linguistic heritage and promote preservation of mother languages. The Punjabi Language Education Association (PLEA) is a community-based organization dedicated to raising awareness about challenges faced by the Punjabi language and advocating for its inclusion in British Columbia educational institutions. Since 2002, PLEA has organized annual IMLD celebrations, along with various events aimed at promoting Punjabi language and culture.').


