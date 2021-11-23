
log=$1

grep -i error $1 | 
grep -v "Werror=" |
grep -v "errors.o" | 
grep -v "error-codes.o"


