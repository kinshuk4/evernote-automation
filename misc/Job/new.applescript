on run argv
	
	if script = class of argv then
		set today to (current date)
	else
		set today to (item 1 of argv)
	end if
	
	# TEST BEG
	(*
	set year of today to 2017
	set month of today to 1
	set day of today to 5
	*)
	#set today to today + 1 * days
	# TEST END
	
	
	
	set today_weekday to weekday of today
	
	if today_weekday ≤ Thursday then
		set prev_thursday to (today - ((today_weekday as integer) + 2) * days)
	else
		set prev_thursday to (today - ((today_weekday as integer) - 5) * days)
	end if
	
	set this_dd to day of prev_thursday
	if this_dd < 10 and this_dd > 0 then
		set this_dd to ("0" & this_dd)
	end if
	
	set this_mm to run script (POSIX file "/Users/IceHe/Documents/AppleScript/Lib/month2mm.applescript") with parameters {prev_thursday}
	set this_yyyy to year of prev_thursday
	set this_yy to (this_yyyy mod 100)
	
	
	
	set this_thursday to (prev_thursday + 7 * days)
	
	set next_dd to day of this_thursday
	if next_dd < 10 and next_dd > 0 then
		set next_dd to ("0" & next_dd)
	end if
	
	set next_mm to run script (POSIX file "/Users/IceHe/Documents/AppleScript/Lib/month2mm.applescript") with parameters {this_thursday}
	set next_yyyy to year of this_thursday
	set next_yy to (next_yyyy mod 100)
	
	
	
	set base_dir to "/Users/IceHe/Documents/MapiReports/"
	set report_name_tail to " 何志远周报.md"
	set cur_thursday_str to (this_yyyy & "-" & this_mm & "-" & this_dd) as string
	set report_name to cur_thursday_str & report_name_tail
	set report_path to base_dir & report_name
	
	
	
	############
	# New Job Report
	############
	
	if not (run script (POSIX file "/Users/IceHe/Documents/AppleScript/Lib/file_exists.applescript") with parameters {report_path}) then
		display alert "Report of Last Week Not Found: " & report_path giving up after 10
		return false
	end if
	
	set next_thursday_str to (next_yyyy & "-" & next_mm & "-" & next_dd) as string
	set next_report_name to (next_thursday_str & report_name_tail) as string
	set next_report_path to (base_dir & next_report_name)
	
	if run script (POSIX file "/Users/IceHe/Documents/AppleScript/Lib/file_exists.applescript") with parameters {next_report_path} then
		display alert "Report of This Week Exists: " & report_path giving up after 10
		return false
	end if
	
	do shell script ("cp \"" & report_path & "\" \"" & next_report_path & "\"")
	
	############
	# Mod Job Report
	############
	
	set cmd to "/usr/local/bin/python3 /Users/IceHe/Documents/Python/Mod_New_Job_Report.py \"" & next_report_path & "\" \"" & cur_thursday_str & "\" \"" & next_thursday_str & "\""
	set result to do shell script cmd
	
	if result is not "" then
		display alert result giving up after 10
		return false
	end if
	
	return true
	
end run