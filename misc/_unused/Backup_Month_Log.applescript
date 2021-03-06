on run argv
	
	if script = class of argv then
		set today to (current date) - 2 * days
	else
		set today to (item 1 of argv)
	end if
	
	
	
	if 1 ≠ day of today then
		return false
	end if
	
	set yesterday to (today - 1 * days)
	
	
	
	set day_dd to day of yesterday
	if day_dd < 10 and day_dd > 0 then
		set day_dd to ("0" & day_dd)
	end if
	
	set month_mm to run script (POSIX file "/Users/IceHe/Documents/AppleScript/Lib/month2mm.applescript") with parameters {yesterday}
	set year_yyyy to year of yesterday
	set year_yy to (year_yyyy mod 100)
	
	set note_name to (year_yyyy & "/" & month_mm & " stu spo was") as string
	
	
	
	# 备份本月的所有时间日志笔记
	tell application "Evernote"
		set day_logs_this_month to find notes ("notebook:\"" & year_yyyy & "/" & month_mm & "\"")
		set enex_path to "/Users/IceHe/Documents/Enex/Backup/" & year_yyyy & "_" & month_mm & "_Day_Logs.enex"
		export day_logs_this_month to (POSIX file enex_path)
		
		# 备一份到桌面，以便操作
		set desktop_enex_path to "/Users/IceHe/Desktop/" & year_yyyy & "_" & month_mm & "_Day_Logs.enex"
		export day_logs_this_month to (POSIX file desktop_enex_path)
	end tell
	
end run