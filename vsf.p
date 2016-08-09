#!/bin/perl -w
#
# Split a Vice Snapshot File into separate files for each module.
#
# Gene Johannsen
#
# http://unusedino.de/ec64/technical/formats/vice_frz.html
#

use strict;

open( FH, "<", "quicksnap1.vsf") or die;
binmode(FH);

my $buf;

my $pattern = "a19C1C1a16";
my $sizeof = length pack( $pattern, ( ) );



read(FH, $buf, $sizeof);



my ($MAGIC, $VMAJOR, $VMINOR, $MACHINENAME) = unpack($pattern, $buf);

print "'$MAGIC': v$VMAJOR,$VMINOR\nmachine: '$MACHINENAME'\n";


$pattern = "a16C1C1I1";
$sizeof = length pack( $pattern, ( ) );
read(FH, $buf, $sizeof);
my ($MODULE, $MAJOR, $MINOR, $MODSIZE) = unpack($pattern, $buf);

print "Module: $MODULE v$MAJOR,$MINOR\nsize: $MODSIZE\n";

read(FH, $buf, $MODSIZE - $sizeof);

read(FH, $buf, $sizeof);
($MODULE, $MAJOR, $MINOR, $MODSIZE) = unpack($pattern, $buf);

print "Module: $MODULE v$MAJOR,$MINOR\nsize: $MODSIZE\n";

read(FH, $buf, $MODSIZE - $sizeof);

print "'$buf'";



#my @bytes = unpack("C*", $h);

#print "@bytes";


#while(<FH>){
#  print;
#  }