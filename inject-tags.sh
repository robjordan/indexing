#! /bin/bash
# set -x 

usage() {                                      # Function: Print a help message.
  echo "Usage: $0 [ -v ]" 1>&2 
}

exit_abnormal() {                              # Function: Exit with error.
  usage
  exit 1
}

VERBOSE=0
while getopts "v" options; do
    case "${options}" in                         # 
        v)                                         # If the option is v,
            VERBOSE=1
            ;;
        *)
            exit_abnormal
            ;;
    esac
done

awk -F'|' -v verbose=$VERBOSE 'BEGIN {print "cat input.txt |"} 
    END {print "cat > output.txt"} 
    {
        if (verbose) {
            printf "sed \x27s/%s/<START:done %s>&<END>/g\x27 \x7c\n", $2, $3
        }
        else {
            printf "sed \x27s/%s/<START:done>&<END>/g\x27 \x7c\n", $2
        }
    }' < concordance.csv > transform.sh
