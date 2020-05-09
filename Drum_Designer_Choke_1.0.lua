--[[
Choke Groups for UVI Drum Designer
v1.00 - 2020/05/09
by Nelson MALLÉUS - inouï samples
www.inouisamples.com
]]

BassDrum = OnOffButton{"BassDrum", displayName="Bass Drum",  x = 100}
SnareDrumA = OnOffButton{"SnareDrumA", displayName="Snare Drum1 ",  x = 230}
SnareDrumB = OnOffButton{"SnareDrumB", displayName="Snare Drum 2",  x = 360}
Clap = OnOffButton{"Clap", displayName="Clap",  x = 490}
CymA = OnOffButton{"CymA", displayName="Cymbal 1",  x = 100, y = 30}
CymB = OnOffButton{"CymB", displayName="Cymbal 2",  x = 230, y = 30}
CymC = OnOffButton{"CymC", displayName="Cymbal 3",  x = 360, y = 30}
CymD = OnOffButton{"CymD", displayName="Cymbal 4",  x = 490, y = 30}

local FadeTime = 10
local FirstNote = 0
local NewNote = 0
local LastLayer = 0
local idLastChokedA
local idLastChokedB
local idLastChokedC
local idLastChokedD
local idLastChokedE

function onNote(e)
	postEvent(e)
	if e.layer == 1 and (BassDrum.value)			-- 3
	or e.layer == 2 and (SnareDrumA.value)	-- 5
	or e.layer == 3 and (SnareDrumB.value)	-- 5
	or e.layer == 4 and (Clap.value)					-- 4
	or e.layer == 5 and (CymA.value)				-- 2
	or e.layer == 6 and (CymB.value)				-- 2
	or e.layer == 7 and (CymC.value)				-- 2
	or e.layer == 8 and (CymD.value)				-- 2
	then
		if FirstNote == 10 then
			if LastLayer == 5 or LastLayer == 6 or LastLayer == 7 or LastLayer == 8 then 
				NewNote = NewNote + 1
				if NewNote == 1 then
					fadeout(idLastChokedA, FadeTime, true)
    	    		releaseVoice(idLastChokedA)
					fadeout(idLastChokedB, FadeTime, true)
        			releaseVoice(idLastChokedB)
        			idLastChokedA = postEvent(e)
				else
        			idLastChokedB = postEvent(e)
        			NewNote = 0
        			LastLayer = e.layer
				end
			elseif LastLayer == 1 then
				NewNote = NewNote + 1
				if NewNote == 1 then
					fadeout(idLastChokedA, FadeTime, true)
    	    		releaseVoice(idLastChokedA)
					fadeout(idLastChokedB, FadeTime, true)
        			releaseVoice(idLastChokedB)
        			idLastChokedA = postEvent(e)
				elseif NewNote == 2 then
        			idLastChokedB = postEvent(e)
				elseif NewNote == 3 then
        			idLastChokedC = postEvent(e)
        			NewNote = 0
        			LastLayer = e.layer
				end
			elseif LastLayer == 4 then
				NewNote = NewNote + 1
				if NewNote == 1 then
					fadeout(idLastChokedA, FadeTime, true)
    	    		releaseVoice(idLastChokedA)
					fadeout(idLastChokedB, FadeTime, true)
        			releaseVoice(idLastChokedB)
        			idLastChokedA = postEvent(e)
				elseif NewNote == 2 then
        			idLastChokedB = postEvent(e)
				elseif NewNote == 3 then
        			idLastChokedC = postEvent(e)
				elseif NewNote == 4 then
        			idLastChokedD = postEvent(e)
        			NewNote = 0
        			LastLayer = e.layer
				end
			elseif LastLayer == 2 or LastLayer == 3 then
				NewNote = NewNote + 1
				if NewNote == 1 then
					fadeout(idLastChokedA, FadeTime, true)
    	    		releaseVoice(idLastChokedA)
					fadeout(idLastChokedB, FadeTime, true)
        			releaseVoice(idLastChokedB)
        			idLastChokedA = postEvent(e)
				elseif NewNote == 2 then
        			idLastChokedB = postEvent(e)
				elseif NewNote == 3 then
        			idLastChokedC = postEvent(e)
				elseif NewNote == 4 then
        			idLastChokedD = postEvent(e)
				elseif NewNote == 5 then
        			idLastChokedE = postEvent(e)
        			NewNote = 0
        			LastLayer = e.layer
				end
			end
        else		-- On first note, just remember the Layer and the id to stop on Choke
        	if e.layer == 5 or e.layer == 6 or e.layer == 7 or e.layer == 8 then
        		FirstNote = FirstNote + 1
        		if FirstNote == 1 then
        			idLastChokedA = postEvent(e)
        		else
        			idLastChokedB = postEvent(e)
        			FirstNote = 10
        			LastLayer = e.layer
        		end
        	elseif e.layer == 1 then
        		FirstNote = FirstNote + 1
        		if FirstNote == 1 then
        			idLastChokedA = postEvent(e)
        		elseif FirstNote == 2 then
        			idLastChokedB = postEvent(e)
        		elseif FirstNote == 3 then
        			idLastChokedC = postEvent(e)
        			FirstNote = 10
        			LastLayer = e.layer
        		end
        	elseif e.layer == 4 then
        		FirstNote = FirstNote + 1
        		if FirstNote == 1 then
        			idLastChokedA = postEvent(e)
        		elseif FirstNote == 2 then
        			idLastChokedB = postEvent(e)
        		elseif FirstNote == 3 then
        			idLastChokedC = postEvent(e)
        		elseif FirstNote == 4 then
        			idLastChokedD = postEvent(e)
        			FirstNote = 10
        			LastLayer = e.layer
        		end
        	elseif e.layer == 2 or e.layer == 3 then
        		FirstNote = FirstNote + 1
        		if FirstNote == 1 then
        			idLastChokedA = postEvent(e)
        		elseif FirstNote == 2 then
        			idLastChokedB = postEvent(e)
        		elseif FirstNote == 3 then
        			idLastChokedC = postEvent(e)
        		elseif FirstNote == 4 then
        			idLastChokedD = postEvent(e)
        		elseif FirstNote == 5 then
        			idLastChokedE = postEvent(e)
        			FirstNote = 10
        			LastLayer = e.layer
        		end
        	end
        end
	end
end

function onRelease(e)
	postEvent(e)
end