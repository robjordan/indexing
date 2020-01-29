{
    for (t in tags) {
	print "$2:" $2;
	print "t:" t;
	pos = index($2, t);
	print "pos:" pos;
	if (pos>0) {
	    print $2, "will index as", tags[t]
	}
    }
    tags[$2]=$3;
}

