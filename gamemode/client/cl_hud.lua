include( "object_player_exstended_cl.lua" )  
local w, h = ScrW(), ScrH()
local deathTime = 0


local function getTimeVariable( id )
local ent = game.GetWorld()
	return ent:GetDTFloat( id ) 
end 

net.Receive( "setDeathTimeVariable", function( len, pl )  
	local deathTimeVariable = net.ReadFloat()
	deathTime = deathTimeVariable
end )


//Hud variables.
local HUD = {}
HUD.showhealth = 0
HUD.healthNumber = 0


local healthBarTable = {
	width = ( w * 0.159 ),
	height = ( h * 0.033 ),
	wPos = ( w * 0.091 ),
	hPos = ( h - ( h * 0.03 ) * 3.48 ),
	wPosText = ( w * 0.091 ) + ( ( w * 0.159 )/2 ),
	hPosText = ( h - ( h * 0.10485 ) ) + ( ( h * 0.033 ) * 0.5 ),
	textColor = Color( 255, 255, 255, 255 ),
	backgroundColor = Color( 60, 60, 60, 255 )
}

local mainLayoutTable = {
	HPwidth = ( w * 0.162 ),
	HPheight = ( h * 0.051 ),
	HPwPos = ( w * 0.09 ),
	HPhPos = ( h - ( ( h * 0.052 ) * 2.0633 ) ),
	HPcolor = Color( 0, 0, 0, 245 ),
	avatarWPos = ( ( w * 0.091 ) - ( w *0.0701 ) ),
	avatarHPos =  ( h - ( ( h * 0.052 ) * 1.08 ) - ( w * 0.0698 ) ),
	avatarWidth = ( w * 0.07 ),
	avatarHeight = ( w * 0.07  ),
	avatarColor = Color( 0, 0, 0, 250 ),
	bottomBoxWidth = ( w * 0.17 ),
	bottomBoxHeight = ( h * 0.033 ),
	bottomBoxWPos = ( ( w * 0.09 ) - ( ( w *0.0698 ) * 0.8 ) ),
	bottomBoxHPos = ( h - ( ( h * 0.0517 ) * 1.1 ) ),
	bottomBoxColor = Color( 0, 0, 0, 245 ),
	textPosH = ( h - ( ( h * 0.0517 ) * 1.04 ) ),
	textPosW = ( ( w * 0.09 ) - ( ( w *0.0698 ) * 0.7 ) ),
	textColor = Color( 255, 255, 255, 255 )
}

local radarTable = {
	width = healthBarTable.width,
	height = ( h * 0.01 ),
	wPos = healthBarTable.wPos,
	hPos = ( h - ( ( h * 0.023 ) * 3.03 ) ),
	nColor = Color( 60, 60, 60, 255 ),
	bColor = nil
}

local extraInfoTable = {
	killConWPos = ( w * 0.10 ),
	killConHPos = ( h - ( ( h * 0.0517 ) * 1.1 ) ),
	killsWPos = ( w * 0.13 ),
	killsHPos = ( h - ( ( h * 0.0517 ) * 1 ) ),
	timerClockWPos = ( w * 0.14 ),
	timerClockHPos = ( h - ( ( h * 0.0517 ) * .05 ) ),
	timerCounterWPos = ( w * 0.19 ),
	timerCounterHPos = ( h - ( ( h * 0.0517 ) * 1 ) )
}

local ammoTable = {
	clipWPos = w - ( w * 0.14 ),
	cliphPos = h - ( h * 0.13 ),
	resWPos = w - ( w * 0.06 ),
	reshPos = h - ( h * 0.10 ),
}

local timerPanels = {
	panelOneWidth = ( w * 0.1401 ),
	panelOneheight = ( h * 0.04 ),
	panelOneWPos = ( w * 0.325 ),
	panelOneHPos = ( h * 0.055 ),
	panelTwoWidth = ( w * 0.1401 ),
	panelTwoheight = ( h * 0.04 ),
	panelTwoWPos = ( w * 0.5252 ),
	panelTwoHPos = ( h * 0.055 ),
	panelThreeWidth = ( w * 0.06 ),
	panelThreeheight = ( h * 0.1 ),
	panelThreeWPos = ( w * 0.4651 ),
	panelThreeHPos = ( h * 0.025 ),
	biohazardwidth = ( w * 0.095 ),
	biohazardheight = ( w * 0.095 ),
	biohazardWPos = ( w * 0.449 ),
	biohazardHPos = 0 - ( h * 0.005 ),
	bloodWidth = ( w * 0.1 ),
	bloodHeight = ( h * 0.1 ),
	bloodWPos = ( w * 0.447 ),
	BloodHPos = ( h * 0.025 ),
	textPosW = ( w * 0.491 ),
	textPosH = ( h *0.056 ),
	

}

local textTable = {
	timerkilConWPos = ( w * 0.33 ),
	timerkilConHPos = ( h * 0.122 ),
	timerWPos = ( w * 0.37 ),
	timerHPos = ( h * 0.089 ),
	zombieWPos = ( w * 0.54 ), 
	zombieHPos = ( h * 0.089 ),
}

ZombieClusterFuckTableHuman = {
[ 4 ] = {
	[ 1 ] ={ text = "Nothing to worry", color = Color( 60, 132, 38, 255 )},
	[ 2 ] ={ text = "Rotten meatbag..", color = Color( 108, 111, 39, 255 )},
	[ 3 ] ={ text = "Zombie Fuck-up!", color = Color ( 115, 132, 38, 255 )},
	[ 4 ] ={ text = "HOLY SHI- F#$^", color = Color ( 143, 96, 15, 255 )},
	[ 5 ] ={ text = "ZOMBIELAND!", color = Color ( 130, 19, 19,255 )},
	    },
[ 3 ] = {
	[ 1 ] ={ text = "Kill all humans!", color = Color( 60, 132, 38, 255 )},
	[ 2 ] ={ text = "Fistful of flesh..", color = Color( 108, 111, 39, 255 )},
	[ 3 ] ={ text = "Zombie Party!", color = Color ( 115, 132, 38, 255 )},
	[ 4 ] ={ text = "ARMY OF DEAD!", color = Color ( 143, 96, 15, 255 )},
	[ 5 ] ={ text = "DEAD RISING!", color = Color ( 130, 19, 19,255 )},
	    }
}

local humanClassImage = {
	[ 1 ] = { img = "faces/avatar_sharpshooter.vtf" },
	[ 2 ] = { img = "faces/avatar_support.vtf" },
	[ 3 ] = { img = "materials/entities/npc_combine_s.png" },
	[ 4 ] = { img = "materials/entities/npc_monk.png" },
	[ 5 ] = { img = "faces/avatar_medic.vtf" },
	[ 6 ] = { img = "faces/avatar_engineer.vtf" }
} 

local zombieClassImage = {
	[ 1 ] = { img = "materials/entities/npc_zombie.png" },
	[ 2 ] = { img = "materials/entities/npc_headcrab.png" },
	[ 3 ] = { img = "materials/entities/npc_stalker.png" },
	[ 4 ] = { img = "materials/entities/npc_fastzombie.png" },
	[ 5 ] = { img = "materials/entities/npc_headcrab_black.png" },
	[ 6 ] = { img = "materials/entities/npc_poisonzombie.png" },
	[ 7 ] = { img = "materials/entities/npc_zombine.png" }
} 
  


local NextAura = 0
local ShowTeamMates = 0


function HUD:drawImageHuman( pl )
local humanClass = pl:GetHumanClass()
			surface.SetDrawColor( Color( 255, 255, 255, 255 )  ) 
			surface.SetMaterial( Material( humanClassImage[ humanClass ].img ) )						
			surface.DrawTexturedRect( mainLayoutTable.avatarWPos + ( w * 0.0025 ), mainLayoutTable.avatarHPos + ( w * 0.002 ), mainLayoutTable.avatarWidth - ( w * 0.0036 ), mainLayoutTable.avatarHeight - ( w * 0.0045 ) ) 

end

function HUD:drawImageZombie( pl )
local zombieClass = pl:GetZombieClass()
			surface.SetDrawColor( Color( 255, 255, 255, 255 )  ) 
			surface.SetMaterial( Material( zombieClassImage[ zombieClass ].img ) )						
			surface.DrawTexturedRect( mainLayoutTable.avatarWPos + ( w * 0.0025 ), mainLayoutTable.avatarHPos + ( w * 0.002 ), mainLayoutTable.avatarWidth - ( w * 0.0036 ), mainLayoutTable.avatarHeight - ( w * 0.0045 ) ) 

end

hook.Add("HUDShouldDraw", "HideThisCrap", function( name ) 
	for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"})do
		if name == v then return false end
	end
end )

surface.CreateFont( "health_Font", {
	font = "TargetID",
	size = ( ScrW() * 0.012 ) ,
	weight = 400,
	blursize = 0,
	scanlines = 1000,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = true,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )


function HUD:animatedHealthBar( amount, newAmount, Rate )
	return math.Approach( amount, newAmount, Rate )  
end 
 
function HUD:animatedText( amount, newAmount, Rate )
	return math.Approach( amount, newAmount, Rate )  
end 

function HUD:HealthBar( pl )
	local HP = pl:Health()
	local color = HUD:GetHealthColor( pl )
	local targethealth = math.min( ( healthBarTable.width * ( HP / pl:GetMaxHealth() ) ) , healthBarTable.width )
	HUD.showhealth = self:animatedHealthBar( HUD.showhealth, targethealth, FrameTime() * 150 )   
	HUD.healthNumber = math.Clamp ( self:animatedText( HUD.healthNumber, HP, FrameTime() * 70 ), 0, pl:GetMaxHealth() )
	
	local drawnnumber = math.ceil( HUD.healthNumber )
	draw.RoundedBox( 0, healthBarTable.wPos, healthBarTable.hPos, healthBarTable.width, healthBarTable.height, healthBarTable.backgroundColor ) 
	draw.RoundedBox( 0, healthBarTable.wPos, healthBarTable.hPos, HUD.showhealth, healthBarTable.height, color )
	draw.SimpleText( "+"..drawnnumber, "health_Font", healthBarTable.wPosText, healthBarTable.hPosText , healthBarTable.textColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )  
end 			

function HUD:mainLayout()
	
	//DrawImage( Color( 255, 0, 0, 230 ), "hud3/blood_makeup.png", -10, BetterScreenScaleH() * 825, BetterScreenScaleH() * 300, BetterScreenScaleH() * 200 )	
	//DrawImage( Color( 255, 0, 0, 230 ), "hud3/blood_makeup.png", -10, BetterScreenScaleH() * 825, BetterScreenScaleH() * 300, BetterScreenScaleH() * 200 )	
	draw.RoundedBoxEx( 2, mainLayoutTable.HPwPos, mainLayoutTable.HPhPos, mainLayoutTable.HPwidth, mainLayoutTable.HPheight, mainLayoutTable.HPcolor, false, true, false, true )
	draw.RoundedBox( 0, mainLayoutTable.avatarWPos, mainLayoutTable.avatarHPos, mainLayoutTable.avatarWidth, mainLayoutTable.avatarHeight, mainLayoutTable.avatarColor ) --< this avatar
	draw.RoundedBoxEx( 4, mainLayoutTable.bottomBoxWPos, mainLayoutTable.bottomBoxHPos, mainLayoutTable.bottomBoxWidth, mainLayoutTable.bottomBoxHeight, mainLayoutTable.bottomBoxColor, false, false, true, false )
	draw.SimpleText( team.NumPlayers( 4 ) + team.NumPlayers( 1 )..  " : Humans left", "Shit!2", mainLayoutTable.textPosW, mainLayoutTable.textPosH, mainLayoutTable.textColor, TEXT_ALIGN_BOTTOM, TEXT_ALIGN_BOTTOM ) 

	
end 

function HUD:extraInfo( pl )
	local AmmorRegenTime = math.ceil( getTimeVariable( 2 ) - CurTime() )
	local ammoColor = Color( 255, 255, 255, 255 )
	if ( AmmorRegenTime <= 0 ) then AmmorRegenTime = 0 end
	if ( AmmorRegenTime <= 10 ) then ammoColor = Color( math.sin( RealTime() * 6 )* 400, 0, 0, 255 ) end
	local kills = pl:Frags()
	local DrawingTime = string.ToMinutesSeconds( AmmorRegenTime ) 
	
	
	draw.SimpleText( "D", "CSKillIconsHUD", extraInfoTable.killConWPos, extraInfoTable.killConHPos, Color( 255, 255, 255, 255 ), TEXT_ALIGN_BOTTOM, TEXT_ALIGN_BOTTOM ) 
	draw.SimpleText( kills, "Shit!2", extraInfoTable.killsWPos, extraInfoTable.killsHPos , Color( 255, 255, 255, 255 ), TEXT_ALIGN_BOTTOM, TEXT_ALIGN_BOTTOM ) 
	draw.SimpleText( "G", "CSKillIconsHUD", extraInfoTable.timerClockWPos, extraInfoTable.timerClockHPos, Color( 255 ,255 ,255 ,255 ), TEXT_ALIGN_TOP, TEXT_ALIGN_TOP ) 
	draw.SimpleText( DrawingTime, "Shit!2", extraInfoTable.timerCounterWPos, extraInfoTable.timerCounterHPos, ammoColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM ) 

end

function HUD:Radar( pl )
	local w, h = ScrW(), ScrH()
	local color
	local HumanTeamMates = math.min( ( ( radarTable.width / 16 ) * ( pl:getTeamMAtesAroundMe( team.GetPlayers( pl:Team() ))) ), radarTable.width )
	ShowTeamMates = self:animatedHealthBar( ShowTeamMates, HumanTeamMates, FrameTime() * 150 ) 
	if ( pl:Team() == 4 ) then
		radarTable.bColor = Color( 242, 255, 0, 255 )
	else
		radarTable.bColor = Color( 235, 0,0,235 )
	end

	draw.RoundedBox( 0, radarTable.wPos, radarTable.hPos, radarTable.width, radarTable.height , radarTable.nColor )
	draw.RoundedBox( 0, radarTable.wPos, radarTable.hPos, ShowTeamMates, radarTable.height , radarTable.bColor )
end


function HUD:GetHealthColor( pl )
local fHealth, fMaxHealth = math.max(pl:Health(),0), pl:GetMaxHealth() 
	local iPercentage = math.Clamp ( fHealth / fMaxHealth, 0, 1 )	
	//Color of healthbar
	local colHealthBar, sHealthIndication = Color( 0, 120, 0, 235 ) 
	if ( pl:Team() == 4 ) then
	if 0.8 < iPercentage then colHealthBar = Color ( 0, 120, 0, 235 ) elseif 0.6 < iPercentage then colHealthBar = Color ( 146,142,22,235 ) elseif 0.3 < iPercentage then colHealthBar = Color ( 166,79,3,235 ) 
	else colHealthBar = Color( math.abs( math.sin( RealTime() * 3 ) )* 300, 0, 0, 255 ) end
	else
	if
	iPercentage > 0.3 then colHealthBar = Color( 235, 0,0,235 ) elseif iPercentage <0.31 then  colHealthBar = Color ( 153,7,4,math.sin(RealTime() * 6) * 127.5 + 127.5 )
	end
	end
		

return colHealthBar

end

function HUD:TimerPanels( pl )
		if ( team.NumPlayers( 3 ) + team.NumPlayers( 2 ) ) >= 10 then 
			timerPanels.textPosW = ( w * 0.486 )
		end
		local Seconds = getTimeVariable( 1 )
		local timerColor = Color( 255, 255, 255, 255 )
		local DrawTime = ( Seconds - CurTime() )
		if ( DrawTime <= 0 ) then DrawTime = 0 end
		if ( DrawTime <= 15 ) then timerColor = Color( math.sin( RealTime() * 6 )* 400, 0, 0, 255 ) end
		local GameTimer = string.ToMinutesSecondsMilliseconds(  DrawTime )
		local maxZombies = math.Clamp( math.Min( pl:getTeamMAtesAroundMe( team.GetPlayers( 3 )), 5 ), 1, 5 )
		
			draw.RoundedBoxEx( 8, timerPanels.panelOneWPos, timerPanels.panelOneHPos, timerPanels.panelOneWidth, timerPanels.panelOneheight, Color( 0, 0, 0, 240 ), true, false, true, false )
			draw.RoundedBoxEx( 8, timerPanels.panelTwoWPos, timerPanels.panelTwoHPos, timerPanels.panelTwoWidth, timerPanels.panelTwoheight, Color( 0, 0, 0, 240 ), false, true, false, true )
			draw.RoundedBox( 8, timerPanels.panelThreeWPos, timerPanels.panelThreeHPos, timerPanels.panelThreeWidth, timerPanels.panelThreeheight, Color( 0, 0, 0, 240 ) )
			draw.SimpleText( ZombieClusterFuckTableHuman[ pl:Team() ][ maxZombies ].text, "HUDTIMERFONT", textTable.zombieWPos , textTable.zombieHPos , ZombieClusterFuckTableHuman[ pl:Team() ][ maxZombies ].color, TEXT_ALIGN_TOP, TEXT_ALIGN_TOP )
			draw.SimpleText( GameTimer, "HUDTIMERFONT", textTable.timerWPos , textTable.timerHPos , timerColor, TEXT_ALIGN_TOP, TEXT_ALIGN_TOP )
			draw.SimpleText( "G", "CSKillIconsHUDTIMER", textTable.timerkilConWPos , textTable.timerkilConHPos , Color( 255 ,255 ,255 ,255 ), TEXT_ALIGN_TOP, TEXT_ALIGN_TOP )
			DrawImage( Color( 255, 0, 0, 230 ), "hud3/blood_makeup.png", timerPanels.bloodWPos , timerPanels.BloodHPos, timerPanels.bloodWidth , timerPanels.bloodHeight )
			DrawImage( Color( 255, 255, 255, 255 ), "hud3/biohazart", timerPanels.biohazardWPos , timerPanels.biohazardHPos, timerPanels.biohazardwidth , timerPanels.biohazardheight )
			draw.SimpleText( team.NumPlayers( 3 ) + team.NumPlayers( 2 ), "zombieAmontIndicator_Hud", timerPanels.textPosW , timerPanels.textPosH , Color( 255, 255, 255, 255 ), TEXT_ALIGN_BOTTOM, TEXT_ALIGN_BOTTOM ) 
end

function HUD:DrawAura()
local pl = LocalPlayer()
local w, h = ScrW(), ScrH()
	if RealTime() < NextAura then return end
	NextAura = RealTime() + 0.5
	local mypos = pl:GetPos()
	local cap = 0
	for _, pl in pairs(player.GetAll()) do
		if cap >= 8 then return end -- Cult linked list overflow with lots of humans
		if pl:Team() == 4 and pl:Alive() then
			local pos = pl:GetPos() + Vector( -6, -6 ,52 )
			if pos:Distance(mypos) < 1024 then
				local toscreen = pos:ToScreen() -- hacky shit to stop making emitters off screen.
				if toscreen.x > 0 and toscreen.x < w and toscreen.y > 0 and toscreen.y < h then
					local vel = pl:GetVelocity() * 0.7
						local HP = pl:Health()
						local C_HP = math.Clamp( HP, 0, 100 )
							local PC_HP = ( C_HP / 100 )
					local emitter = ParticleEmitter(pos)
					for i=1, 4 do
						local particle = emitter:Add("Sprites/light_glow02_add_noz", pos)
						particle:SetVelocity(vel + Vector(math.random(-12, 12),math.random(-12, 12), math.Rand(22,29 ))) 
						particle:SetDieTime( 0.9 )
						particle:SetStartAlpha(240)
						particle:SetEndAlpha(40)
						particle:SetStartSize(math.random(22, 29))
						particle:SetEndSize(0)
						particle:SetColor(( 1 - PC_HP ) * 160, PC_HP * 160, 0, 140 )
						particle:SetRoll(math.random(0, 360))
					end
					emitter:Finish()
					cap = cap + 1
				end
			end
		end
	end
end


 

function HUD:DeathHud()
	local w, h = ScrW(), ScrH()
	local pl = LocalPlayer()
	local time = deathTime - CurTime()
	local deathColor = Color( 0, 100, 0, 255 )
	if ( time <= 0  ) then time = 0 end
	if ( time <= 3  ) then deathColor = Color( math.sin( RealTime() * 6 )* 400, 0, 0, 255 ) end
	local drawTime = string.ToMinutesSecondsMilliseconds( time )
	draw.RoundedBox( 0, 0, 0, w, ( h * 0.15 ), Color( 0, 0, 0, 255 ) )
	draw.RoundedBox( 0, 0, h - ( h * 0.15 ), w, ( h * 0.15 ) , Color( 0, 0, 0, 255 ) )
	draw.SimpleText( "YOU ARE DEAD", "deathHudBig", ( w * 0.5 ) , ( h * 0.04 ) , Color( 255, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) 
	draw.SimpleText( "You died But the fight isn't over yet, dust your self off and get ready!", "deathHudSmall", ( w * 0.5 ) , ( h * 0.08 ) , Color( 0, 100, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) 
	
	draw.SimpleText( "Get ready to respawn in : ", "deathHudBig", ( w * 0.45 ) , h - ( h * 0.1 ) , Color( 0, 100, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) 
	draw.SimpleText( drawTime, "deathHudBig", ( w * 0.62 ) , h - ( h * 0.1 ) , deathColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) 
	draw.SimpleText( "HINT: Zombie get damage resistance when they are around their kin.", "deathHudSmall", ( w * 0.5 ) , h - ( h * 0.06 ) , Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) 
end

local motionBlur = 0
local function GetMotionBlurValues( x, y, fwd, spin )
	local pl = LocalPlayer()
	local wep = pl:GetActiveWeapon()
	local blur = 0
	local Health =  0
	local rate = 0
	local MotionBlurAmount = 0
	
	if (pl:Team() == 4 ) then
		if ( wep.GetIronSights and IsValid( wep ) and wep:GetIronSights() ) then
			MotionBlurAmount =  0.06
			rate = 0.25
		else
			MotionBlurAmount =  math.Clamp( 1 - ( pl:Health() * 0.035 ),0, 0.06 )
			rate = 0.05
		end
	else
		MotionBlurAmount = 0
		rate = 20
	end	
	
	motionBlur = math.Approach(motionBlur, MotionBlurAmount, FrameTime() * rate )
	return 0, 0, math.max(fwd, motionBlur), 0 
end
hook.Add( "GetMotionBlurValues", "IWMotionBlur", GetMotionBlurValues )

function GM:HUDPaint()
local pl = LocalPlayer() 
	if ( IsValid( pl ) and  pl:Team() == 4  ) then
	HUD:mainLayout()
	HUD:HealthBar( pl )
	HUD:Radar( pl )
	HUD:extraInfo( pl )
	HUD:TimerPanels( pl )
	HUD:drawImageHuman( pl )
	end
		if( pl:Team() == 3 ) then
		HUD:mainLayout()
		HUD:HealthBar( pl )
		HUD:Radar( pl )
		HUD:extraInfo( pl )
		HUD:TimerPanels( pl )
		HUD:DrawAura()
		HUD:drawImageZombie( pl )
		end
		if pl:Team() == 2 then
			HUD:DeathHud()
		end
	GetMotionBlurValues( 10, 50, 130, 10000 )
end 

local matWireframe = Material("models/wireframe")
hook.Add( "PostDrawOpaqueRenderables", "PostDrawing", function( )
if ( !IsValid( LocalPlayer() ) or LocalPlayer():Team() != 4 ) then return end
local pl = LocalPlayer()
local WeaponCount = 0
local Resupplytime = math.ceil( pl:GetSuppliesTime() - CurTime() ) 

	//Choose the color
	local text = "Supplies are ready in:  " ..string.ToMinutesSeconds( Resupplytime )
	if pl:GetSuppliesTime() < CurTime() then
		text = "     Supplies Are Ready!"
	end
	for k, v in pairs( ents.FindByClass( "item_supplycrate" ) ) do
	local ang = Angle( 0, pl:EyeAngles().y - 90, 90 - pl:EyeAngles().x )
	local pos = v:GetPos() +  Vector( 0, 20, 70 )
	// Start the fun
	cam.Start3D2D( pos, ang, 0.3 )
		
		surface.SetFont( "Trebuchet24" )
		surface.SetTextColor( 255, 255, 255, 255 )
		surface.SetTextPos( -110, 0 )
		surface.DrawText( text )
		
		
		cam.End3D2D()
	end
	
	
end)


