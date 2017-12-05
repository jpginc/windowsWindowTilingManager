arrayToString(theArray)
{   string := "{"
    for key, value in theArray
    {   if(A_index != 1)
        {   string .= ","
        }
        if key is number
        {   string .= key ":"
        } else if(IsObject(key))
        {   string .= arrayToString(key) ":"
        } else
        {   key := escapeSpecialChars(key)
            string .=  """" key """:" 
        }
        if value is number
        {   string .= value
        } else if (IsObject(value))
        {   string .= arrayToString(value)
        } else
        {   value := escapeSpecialChars(value)
            string .=  """" value """"
        }
    }
    return string "}"
}
escapeSpecialChars(theString, reverse := false)
{   unEscaped := ["""", "``", "`r", "`n", ",", "%", ";", "::", "`b", "`t", "`v", "`a", "`f"]
    escaped := ["""""", "````", "``r", "``n", "``,", "``%", "``;", "``::", "``b", "``t", "``v", "``a", "``f"]
    
    search := reverse ? escaped : unEscaped
    replace := reverse ? unEscaped : escaped
    
    for index, s in search
    {   StringReplace, theString, theString, % s, % replace[index], All
    }
    return theString
}

stringToArray(theString)
{   
    if(theString == "{}")
    {
        return {}
    }
    if(RegExMatch(theString, "\R") || instr(theString, "{") != 1 || instr(theString, "}", true, 0) != strlen(theString))
    {   return false
    }
    returnArray := object()
    start := 2
    Loop
    {   valueString := getNextValue(theString, start) 
        if(valueString == false)
        {   ;invalid value for key
            break
        }
        key := valueString[1]
        start := valueString[2]
        if(RegExMatch(theString, "\s*:", "", start) != start++)
        {   ;no ':' after key
            break
        }
        valueString := getNextValue(theString, start)
         if(valueString == false)
        {   ;invalid value for value
            break
        }
        value := valueString[1]
        start := valueString[2] 
        returnArray.insert(key, value)
        if(RegExMatch(theString, "\s*}", "", start) == start)
        {   ;closing brace indiacates end of the object
            return returnArray
        } else
        {   start := InStr(theString, ",", true, start)
            if(start == 0)
            {   ;no closing brace or comma before the next var
                break
            }
            start++
        }
    }
    return false
}
getNextValue(ByRef string, start)
{   if(RegExMatch(string, "\s*[+-]{0,1}[\d\.]", "", start) == start)
    {   ;it's a number
        start := RegExMatch(string, "[+-]{0,1}[\d\.]", "", start)
        end := regexmatch(string, "[^\d\.+-]", value, start)
        return [substr(string, start, end - start), end]
    }
    if(RegExMatch(string, "\s*""", "", start) == start)
    {   ;it is a string
        check := start := RegExMatch(string, """", "", start) + 1
        Loop
        {   ;find the next "
            end := InStr(string, """", true, check)
            ;check if the " found is actually an escaped " (ie "")
            if(end == instr(string, """""", true, check))
            {   ;indicates an escaped "
                check := end + 2
            } else
            {   break
            }
        }
        return [escapeSpecialChars(substr(string, start, end - start), reverse := true), end + 1]
    }
    if(RegExMatch(string, "\s*\{", "", start) == start)
    {   
        ;it is another object!
        if(RegExMatch(string, "}", "", start) == start +1)
        {
            ;the other object is an emtpy object
            return [{}, start + 2]
        }
        start := instr(string, "{", true, start)
        end := start + 1
        ;if we find an { then we need to find an additional }
        braceCount := 0
        ;braces within "'s are ignored
        ignoreBraces := false
        ;find the closing brace
        while(end := RegExMatch(string, "[""\{}]", found, end))
        {   if(found == """")
            {   ignoreBraces := ! ignoreBraces
            } else if(found == "{")
            {   braceCount++
            } else if(found == "}" && ignoreBraces == false)
            {   if(braceCount == 0)
                {   break
                }
                braceCount--
            }
            end++
        }
        if(end == 0)
        {   
            return false
        }
        ;MsgBox % substr(string, start, end - start + 1)
        value := stringToArray(substr(string, start, end - start + 1))
        if(value)
        {   return [value , end + 1 ]
        }
    }
    ;~ MsgBox didn't start with a good value
    return false
}