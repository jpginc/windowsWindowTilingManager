class DefaultLayoutManagerClass
{
	__new()
	{
		return this
	}
	
	getSizeAndPositions(arrayOfWindows)
	{
		;arrays are actually associative objects...i need the real number of items in this array
		numberOfWindows := 0
		for key, val in arrayOfWindows 
		{
			numberOfWindows := A_Index
		}
		if(numberOfWindows == 0)
		{
			return []
		} else if(numberOfWindows == 1)
		{
			return [new PositionObjectClass(A_ScreenHeight, A_ScreenWidth, x:=0, y:=0)]
		} else if(numberOfWindows == 2)
		{
			return  [new PositionObjectClass(A_ScreenHeight, A_ScreenWidth / 2, x:=0, y:=0)
					, new PositionObjectClass(A_ScreenHeight, A_ScreenWidth / 2, x:=A_ScreenWidth/2, y:=0)]
		} else 
		{
			main := [new PositionObjectClass(A_ScreenHeight, A_ScreenWidth / 2, x:=0, y:=0)
					, new PositionObjectClass(A_ScreenHeight / 2, A_ScreenWidth / 2, x:=A_ScreenWidth/2, y:=0)]
			
			return this.getRemainingPositions(main, numberOfWindows)
		}
	}
	
	getRemainingPositions(positions, numberOfWindows)
	{
		height := (A_ScreenHeight / 2) / (numberOfWindows - 2)
		loop, % numberOfWindows -2
		{
			positions.push(new PositionObjectClass(height, A_ScreenWidth / 2, x:=A_ScreenWidth/2, (A_screenHeight / 2) + (height * (A_Index - 1))))
		}
		return positions
	}
}