
set input to items of (read POSIX file "/Users/apple/Documents/scripts/scripts/config.txt" using delimiters return)
set conf to text items of input
log conf