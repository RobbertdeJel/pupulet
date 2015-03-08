
local notice = {}

notice.Cache, notice.Drawing = {}, {}
notice.bAddNext = false
notice.Timer = 0
local TextClimb = 0
local TextFade = 0
local w, h = ScrW(), ScrH()


local typeTable = {
	[ 1 ] = { img = "hud3/biohazart", sound = "npc/zombie_poison/pz_call1.wav", wPos = w * 0.3 , hPos = ( h - ( h * 0.2 ) ),sizeW = ( w * 0.1 ), sizeH = ( h * 0.15 ) },
	[ 2 ] = { img = "hud3/hud_warning1", sound = "weapons/physcannon/physcannon_charge.wav", wPos = w * 0.35 , hPos = ( h - ( h * 0.175 ) ), sizeW = ( w * 0.05 ), sizeH = ( h * 0.075 ) },
}

function Message( duration, text, sType, color )
	if ( !IsValid( LocalPlayer() ) ) then return end
 
	if notice.Timer <= CurTime() then
		if ( #notice == 0 ) then
				table.insert( notice.Drawing, { duration = duration or 3.5, text = text, sType = sType or 1, color = color or Color( 255,255,255,255 ) } )
				notice.Timer = CurTime() + ( duration or 3.5 )
				TextClimb = 0
				TextFade = 0
				surface.PlaySound( typeTable[ sType ].sound )
		end
	else
		
		//Add it to cache
		table.insert( notice.Cache, { duration = duration or 3.5, text = text, sType = sType or 1, color = color or Color( 255,255,255,255 ) } )
	end
end


net.Receive( "SendHoard",  function()

	local DrawTime = net.ReadFloat() 
	local text = net.ReadString()
	local sType = net.ReadFloat()
	local color = net.ReadVector()
		Message( DrawTime, text, sType, Color( color.x, color.y, color.z, 255 ) )
end ) 


hook.Add( "HUDPaint", "Popupmessage", function()

	if !IsValid( LocalPlayer() ) then return end
	local GrowAmount = math.sin(RealTime() * 9 ) * 5
	//Clear the already used messages
	if notice.Timer and notice.Timer <= CurTime() then
		notice.Drawing = {}

		
		
		//Get latest entry from cache
		if #notice.Cache > 0 and not notice.bAddNext then
		
			//So it doesn't loop
			notice.bAddNext = true
			
			//Delay for next message in cache
			timer.Simple ( 1, function()
				if #notice.Cache > 0 then	
						table.insert( notice.Drawing, { duration = notice.Cache[1].duration or 3.5, text = notice.Cache[1].text, sType = sType or 1, color = notice.Cache[1].color } )
						//Cooldown
						notice.Timer = CurTime() + ( notice.Cache[1].duration or 3.5 )
						if( notice.Cache[ 1 ].sType ) then 
							surface.PlaySound( typeTable[ notice.Cache[1].sType ].sound )
						end
						notice.Cache[1] = nil
						table.Resequence ( notice.Cache )
						TextClimb = 0
						TextFade = 0
						notice.bAddNext = false
				end
			end )
		end
	end
	
		if #notice.Drawing == 0 then return end
			local TextWeDraw = notice.Drawing[1].text
			local sizeW, sizeH = typeTable[ notice.Drawing[1].sType ].sizeW, typeTable[ notice.Drawing[1].sType ].sizeH
			local wPos, hPos = typeTable[ notice.Drawing[1].sType ].wPos, typeTable[ notice.Drawing[1].sType ].hPos
			local img = typeTable[ notice.Drawing[1].sType ].img
			local color = notice.Drawing[1].color 
			TextClimb = math.Approach( TextClimb,  h *0.1 , FrameTime() * 70 ) 
			TextFade = math.Approach( TextFade, 255, FrameTime() * 210 ) 
				DrawImage( Color( 255, 255, 255, ( 0 + TextFade ) ), img, wPos - GrowAmount , ( hPos - GrowAmount ) - TextClimb, sizeW  + GrowAmount, sizeH + GrowAmount )
					draw.SimpleText( TextWeDraw, "HUDTIMERFONT",  w * 0.4 , ( h - ( h * 0.15 ) ) - TextClimb , color, TEXT_ALIGN_BOTTOM, TEXT_ALIGN_BOTTOM )
	

	
end )