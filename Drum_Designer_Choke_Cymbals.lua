--[[
Choke Cymbals for UVI Drum Designer
v1.00 - 2020/05/09
by Nelson MALLÉUS - inouï samples
www.inouisamples.com
]]

CymA = OnOffButton{"CymA", displayName="Cymbal 1",  x = 100, y = 15}
CymB = OnOffButton{"CymB", displayName="Cymbal 2",  x = 230, y = 15}
CymC = OnOffButton{"CymC", displayName="Cymbal 3",  x = 360, y = 15}
CymD = OnOffButton{"CymD", displayName="Cymbal 4",  x = 490, y = 15}

local FadeTime = 10
local NewNote = 1
local FirstNote = 1
local LastLayer = 0
local idLastChokedA
local idLastChokedB

function onNote(e)
	postEvent(e)
	if e.layer == 5 and (CymA.value)	
	or e.layer == 6 and (CymB.value)
	or e.layer == 7 and (CymC.value)
	or e.layer == 8 and (CymD.value)
	then
		if NewNote == 0 then
			fadeout(idLastChokedA, FadeTime, true)
	    	releaseVoice(idLastChokedA)
			fadeout(idLastChokedB, FadeTime, true)
    		releaseVoice(idLastChokedB)
		end
		if FirstNote == 1 then
			FirstNote = 0
			NewNote = 0
		end
		NewNote = NewNote + 1
		LastLayer = e.layer
    	if NewNote == 1 then
    		idLastChokedA = postEvent(e)
    	else
    		idLastChokedB = postEvent(e)
    		NewNote = 0
		end
	end
end

function onRelease(e)
	postEvent(e)
end