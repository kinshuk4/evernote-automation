display alert ¬
	"Go to Sleep !" message ¬
	"Bye" as warning ¬
	buttons {"😠"} ¬
	default button 1 ¬
	giving up after 3

tell application "System Events"
	shut down
end tell