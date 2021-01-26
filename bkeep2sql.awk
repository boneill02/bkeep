#!/usr/bin/awk -f
# Converts bkeep(1) entries to a SQL script. It is recommended that
# you run it like so:
#  $ ./bkeep2sql.awk < ~/.config/library.tsv

{
	print "INSERT INTO books(title, author, description, isbn, tags), VALUES(" $1 ", " $2 ", " $3 ", " $4 ", " $5 ");"
}
