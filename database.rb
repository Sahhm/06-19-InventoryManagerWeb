#optional file that if required will have some club codes and locations populated into the tables.
#does not populate any actual inventory.

#only Lines 8, 10, 12 are necessary as they create the tables.






CONNECTION.execute("INSERT INTO  stores (location) VALUES ('Omaha');")
CONNECTION.execute("INSERT INTO  stores (location) VALUES ('Millard');")
CONNECTION.execute("INSERT INTO  stores (location) VALUES ('Lincoln');")
CONNECTION.execute("INSERT INTO  stores (location) VALUES ('Elkhorn');")


CONNECTION.execute(" INSERT INTO  clubcodes (clubid, clubtype, brand) VALUES ('TID', 'Driver', 'TITELIST');")
CONNECTION.execute(" INSERT INTO  clubcodes (clubid, clubtype, brand) VALUES ('TII', 'Irons', 'TITELIST');")
CONNECTION.execute(" INSERT INTO  clubcodes (clubid, clubtype, brand) VALUES ('TIW', 'Wedge', 'TITELIST');")
CONNECTION.execute(" INSERT INTO  clubcodes (clubid, clubtype, brand) VALUES ('TIP', 'Putter', 'TITELIST');")
CONNECTION.execute(" INSERT INTO  clubcodes (clubid, clubtype, brand) VALUES ('TAD', 'Driver', 'TAYLOR MADE');")
CONNECTION.execute(" INSERT INTO  clubcodes (clubid, clubtype, brand) VALUES ('TAI', 'Irons', 'TAYLOR MADE');")
CONNECTION.execute(" INSERT INTO  clubcodes (clubid, clubtype, brand) VALUES ('TAW', 'Wedge', 'TAYLOR MADE');")
CONNECTION.execute(" INSERT INTO  clubcodes (clubid, clubtype, brand) VALUES ('TAP', 'Putter', 'TAYLOR MADE');")
CONNECTION.execute(" INSERT INTO  clubcodes (clubid, clubtype, brand) VALUES ('CAD', 'Driver', 'CALLAWAY');")
CONNECTION.execute(" INSERT INTO  clubcodes (clubid, clubtype, brand) VALUES ('CAI', 'Irons', 'CALLAWAY');")
CONNECTION.execute(" INSERT INTO  clubcodes (clubid, clubtype, brand) VALUES ('CAW', 'Wedge', 'CALLAWAY');")
CONNECTION.execute(" INSERT INTO  clubcodes (clubid, clubtype, brand) VALUES ('CAP', 'Putter', 'CALLAWAY');")
CONNECTION.execute(" INSERT INTO  clubcodes (clubid, clubtype, brand) VALUES ('CLD', 'Driver', 'CLEVELAND');")
CONNECTION.execute(" INSERT INTO  clubcodes (clubid, clubtype, brand) VALUES ('CLI', 'Irons', 'CLEVELAND');")
CONNECTION.execute(" INSERT INTO  clubcodes (clubid, clubtype, brand) VALUES ('CLW', 'Wedge', 'CLEVELAND');")
CONNECTION.execute(" INSERT INTO  clubcodes (clubid, clubtype, brand) VALUES ('CLP', 'Putter', 'CLEVELAND');")
