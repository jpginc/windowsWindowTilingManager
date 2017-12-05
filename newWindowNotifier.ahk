
class NewWindowNotifierClass
{
	static shellHookSetup := false
	callbacks := []
	
	__new()
	{
		return this.__setupShellhook()
	}
	
	registerListener(callback)
	{
		this.callbacks.Insert(callback)
	}

	__setupShellhook()
	{
		
		if(! this.shellHookSetup) 
		{
			this.shellHookSetup := true
			Gui +LastFound
			hWnd := WinExist()
			DllCall( "RegisterShellHookWindow", UInt,hWnd )
			MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
			OnMessage( MsgNum, func("NewWindowNotifierClass.newWindowCallback").bind(this))
		}
		return this
	}
	
	notifyListeners(ahkWindowId)
	{
		for index, callback in this.callbacks
		{
			callback.call(ahkWindowId)
		}
		return this
	}
	
	newWindowCallback(wParam, lParam)
	{
		HSHELL_WINDOWCREATED := 1
		if (wParam == HSHELL_WINDOWCREATED)
		{
			funcObj := func("NewWindowNotifierClass.notifyListeners").bind(this, ahkWindowId := lParam) 
			setTimer % funcObj,  -1
		}
		return this
	}
}
