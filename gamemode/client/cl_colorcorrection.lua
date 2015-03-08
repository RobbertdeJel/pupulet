
local colorMod = {}
	colorMod[ "$pp_colour_addr" ] 		= 0
	colorMod[ "$pp_colour_addg" ] 		= 0
	colorMod[ "$pp_colour_addb" ] 		= 0
	colorMod[ "$pp_colour_brightness" ] 	= 0
	colorMod[ "$pp_colour_contrast" ] 	=  1
	colorMod[ "$pp_colour_colour" ] 		= 1.96
	colorMod[ "$pp_colour_mulr" ] 		= 0
	colorMod[ "$pp_colour_mulg" ] 		= 0
	colorMod[ "$pp_colour_mulb" ] 		= 0



local zombieColorMod = {}
	zombieColorMod[ "$pp_colour_addr" ] 		= 0
	zombieColorMod[ "$pp_colour_addg" ] 		= 0
	zombieColorMod[ "$pp_colour_addb" ] 		= 0
	zombieColorMod[ "$pp_colour_brightness" ] 	= 0.1
	zombieColorMod[ "$pp_colour_contrast" ] 	= 0.9
	zombieColorMod[ "$pp_colour_colour" ] 		= 1.96
	zombieColorMod[ "$pp_colour_mulr" ] 		= 0
	zombieColorMod[ "$pp_colour_mulg" ] 		= 0
	zombieColorMod[ "$pp_colour_mulb" ] 		= 0



local function animatedColor( start, newValue, rate )
	return math.Approach( start, newValue, rate )
end

local function renderColorModSpectators( pl )
local iBrightness, iContrast = 0, 0.25;

		colorMod[ "$pp_colour_contrast" ] = iContrast
		colorMod[ "$pp_colour_brightness" ] = iBrightness

	DrawColorModify( colorMod )
end

local function rendercolorMod( pl )
local iRed, iGreen, iBlue = 0, 0, 0; //Set up the value's
local mulRed, mulGreen, mulBlue = 0, 0, 0; //Set up the value's
local iBrightness, iContrast, brightnessRate, contrastRate = 0.01, 1.08, 0.4, 0.4;
local vColor = colorMod[ "$pp_colour_colour" ]
local red, green = colorMod[ "$pp_colour_addr" ], colorMod[ "$pp_colour_addg" ]
local mRed, mGreen = colorMod[ "$pp_colour_mulr" ], colorMod[ "$pp_colour_mulg" ]
local mContrast, mBrightness = colorMod[ "$pp_colour_contrast" ], colorMod[ "$pp_colour_brightness" ]
local mColor = math.Clamp( 1.97 - ( 1.97 / pl:getTeamMAtesAroundMe( team.GetPlayers( pl:Team() )) ), 0.9, 1.97 )

	local pHealth = pl:Health();
		if pHealth <= 50 && pHealth > 40 then 
			iRed, mulRed, iGreen, mulGreen, iBrightness, iContrast, brightnessRate, contrastRate = 0.12, 0.11, 0.08, 0.08, 0, 0.9, 0.18, 0.12  
		end
		
		if pHealth <= 40 && pHealth > 25 then
			iRed, iGreen, mulRed, mulGreen, iBrightness, iContrast, brightnessRate, contrastRate = 0.22, 0.08, 0.04, 0.18, 0, 0.85, 0.18, 0.12
		end
		
		if pHealth <= 25 then
			iRed, iGreen, mulRed, mulGreen, iBrightness, iContrast, brightnessRate, contrastRate = 0.28, 0.14, 0.44, 0.35, -0.05, 0.75, 0.18, 0.12
		end
		colorMod[ "$pp_colour_addr" ] 	= animatedColor( red, iRed, FrameTime() * 0.18 )
		colorMod[ "$pp_colour_addg" ] 	= animatedColor( green, iGreen, FrameTime() * 0.12 )
		colorMod[ "$pp_colour_mulr" ] 	= animatedColor( mRed, mulRed, FrameTime() * 0.24 )
		colorMod[ "$pp_colour_mulg" ] 	= animatedColor( mGreen, mulGreen, FrameTime() * 0.16 )
		colorMod[ "$pp_colour_contrast" ] = animatedColor( mContrast, iContrast, FrameTime() * contrastRate )
		colorMod[ "$pp_colour_brightness" ] = animatedColor( mBrightness, iBrightness, FrameTime() * brightnessRate )
		colorMod[ "$pp_colour_colour" ] = animatedColor( vColor, mColor, FrameTime() * 0.45 )

	DrawColorModify( colorMod )
end

local function drawZombieColorMod( pl )
	local iRed, iGreen = 0.28, 0.18; //Set up the value's
	local mulRed, mulGreen = 0.32, 0.28; //Set up the value's

	local red, green = colorMod[ "$pp_colour_addr" ], colorMod[ "$pp_colour_addg" ]
	local mRed, mGreen = colorMod[ "$pp_colour_mulr" ], colorMod[ "$pp_colour_mulg" ]
	colorMod[ "$pp_colour_colour" ] 		= 1.96

	
	colorMod[ "$pp_colour_addr" ] 	= animatedColor( red, iRed, FrameTime() * 0.50 )
	colorMod[ "$pp_colour_addg" ] 	= animatedColor( green, iGreen, FrameTime() * 0.2 )
	colorMod[ "$pp_colour_mulr" ] 	= animatedColor( mRed, mulRed, FrameTime() * 0.2 )
	colorMod[ "$pp_colour_mulg" ] 	= animatedColor( mGreen, mulGreen, FrameTime() * 0.2 )
	DrawColorModify( colorMod )
end

hook.Add( "RenderScreenspaceEffects", "ScreenEffects", function()
local pl = LocalPlayer()   
	if ( IsValid( pl ) && pl:Team() == 4 && pl:Alive() ) then
		rendercolorMod( pl )
		DrawBloom( .65, 1, 9, 9, 1, .65, 1, 1, 1 )
	end
	if ( IsValid( pl ) && pl:Team() == 1  ) then
		renderColorModSpectators( pl )
	end
	if ( IsValid( pl ) && pl:Team() == 3 || pl:Team() == 2 ) then
		drawZombieColorMod( pl )
		DrawBloom( .65, 1, 9, 9, 1, .65, 1, 1, 1 )
	end
end )
