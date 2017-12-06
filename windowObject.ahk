class WindowObjectClass
{
	__new(stringThatWillWorkWithWinExist)
	{
		this.hwnd := WinExist(stringThatWillWorkWithWinExist)
		return this
	}
	
	stillExists()
	{
		return winExist("ahk_id " this.hwnd)
	}
	
	move(x, y, width, height)
	{
		WinMove, % "ahk_id " this.hwnd, , % x, % y, % width, % height
		return this
	}
}