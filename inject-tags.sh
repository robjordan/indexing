awk 'BEGIN {print "cat input.txt |"} END {print "cat > output.txt"} {print "sed \x27s/" $0 "/<START:done>&<END>/g\x27 \|"}' < markup.txt > transform.sh
