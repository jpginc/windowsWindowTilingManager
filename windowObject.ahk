class WindowObjectClass
{
	__new(stringThatWillWorkWithWinExist)
	{
		this.hwnd := WinExist(stringThatWillWorkWithWinExist)
		this.friendlyHwnd := "ahk_id " this.hwnd
		this._populateStats()
		return this
	}
	
	stillExists()
	{
		return winExist(this.friendlyHwnd)
	}
	
	move(x, y, width, height)
	{
		WinMove, % this.friendlyHwnd, , % x, % y, % width, % height
		return this
	}
	
	_populateStats()
	{
		if(! this.stillExists())
		{
			return false
		}
		WinGetPos, x, y, width, height, % this.friendlyHwnd
		WinGetText, text, % this.friendlyHwnd
		WinGetTitle, title, % this.friendlyHwnd
		WinGet, processId, PID, % this.friendlyHwnd
		WinGet, processName, ProcessName, % this.friendlyHwnd
		WinGet, minMaxState, MinMax, % this.friendlyHwnd
		
		this.x := x
		this.y := y
		this.width := width
		this.height := height
		this.text := Text
		this.title := title
		this.processId := processId
		this.processName := ProcessName
		this.minMaxState := MinMax
		return this
	}
}