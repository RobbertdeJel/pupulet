include( "shared.lua" ) 
include( "client/cl_timers.lua" )
include( "client/cl_hud.lua" )
include( "client/cl_options.lua" )
include( "client/cl_classmenu.lua" )
include( "client/cl_killfeed.lua" )
include( "client/splitmessage.lua" )  
include( "client/object_player_exstended_cl.lua" )  
include( "client/cl_weapon_selection.lua" )  
include( "client/cl_colorcorrection.lua" )  
include( "client/cl_targetid.lua" )  
include( "client/cl_scoreboard.lua" )  

GM.FOVLerp = 1
pl = pl or NULL

local render = render
local surface = surface
local draw = draw
local cam = cam
local player = player
local ents = ents
local hook = hook
local util = util
local math = math
local string = string
local gui = gui

local Vector = Vector
local VectorRand = VectorRand
local Angle = Angle
local Entity = Entity
local Color = Color
local FrameTime = FrameTime
local RealTime = RealTime
local CurTime = CurTime
local EyePos = EyePos
local EyeAngles = EyeAngles
local pairs = pairs
local ipairs = ipairs
local IsValid = IsValid
local tostring = tostring
local tonumber = tonumber
local ScrW = ScrW
local ScrH = ScrH

local TEXT_ALIGN_CENTER = TEXT_ALIGN_CENTER
local TEXT_ALIGN_LEFT = TEXT_ALIGN_LEFT
local TEXT_ALIGN_RIGHT = TEXT_ALIGN_RIGHT
local TEXT_ALIGN_TOP = TEXT_ALIGN_TOP
local TEXT_ALIGN_BOTTOM = TEXT_ALIGN_BOTTOM


hook.Add("InitPostEntity", "GetLocal", function()
	pl = LocalPlayer()
end )

function GM:Initialize()
	self:CreateTheFonts()
end


function DrawImage( DColor, Image, XP, YP, XZ, YZ )
			surface.SetDrawColor(  DColor  ) 
			surface.SetMaterial( Material( Image ) )						
			surface.DrawTexturedRect( XP, YP, XZ, YZ ) 
end

function BetterScreenScaleW()
	return ScrW() / 1920 
end

usermessage.Hook( "ChatStuff", function()

local CP = math.random( 1, #ChatTable )
chat.AddText(  ChatTable[ CP ].color, ChatTable[ CP ].text, ChatTable[ CP ].color2, ChatTable[ CP ].text2 )	
surface.PlaySound( "buttons/button14.wav" )
end )

function GM:CreateTheFonts()
surface.CreateFont( "weaponSelectionFont_HL2_Small", {
	font = "HL2MP",
	size = ( ScrH() * 0.055 ) ,
	weight = 400,
	blursize = 0,
	scanlines = 0,
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

surface.CreateFont( "weaponSelectionFont_HL2", {
	font = "HL2MP",
	size = ( ScrH() * 0.075 ) ,
	weight = 400,
	blursize = 0,
	scanlines = 0,
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


surface.CreateFont( "weaponSelectionFont_HL2_Big", {
	font = "HL2MP",
	size = ( ScrH() * 0.09 ) ,
	weight = 400,
	blursize = 0,
	scanlines = 0,
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

surface.CreateFont( "weaponSelectionFont_CSS_Big", {
	font = "csd",
	size = ( ScrH() * 0.1 ) ,
	weight = 200,
	blursize = 0,
	scanlines = 0,
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
 
surface.CreateFont( "weaponSelectionFont_CSS", {
	font = "csd",
	size = ( ScrH() * 0.07 ) ,
	weight = 200,
	blursize = 0,
	scanlines = 0,
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

surface.CreateFont( "weaponSelectionFont_CSS_Small", {
	font = "csd",
	size = ( ScrH() * 0.05 ) ,
	weight = 200,
	blursize = 0,
	scanlines = 0,
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


surface.CreateFont( "ammoFont_Small", {
	font = "TargetID",
	size = ( ScrH() * 0.025 ) ,
	weight = 600,
	blursize = 0,
	scanlines = 0,
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

surface.CreateFont( "ammoFont", {
	font = "TargetID",
	size = ( ScrH() * 0.03 ) ,
	weight = 600,
	blursize = 0,
	scanlines = 0,
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

surface.CreateFont( "ammoFont_Big", {
	font = "TargetID",
	size = ( ScrH() * 0.03 ) ,
	weight = 600,
	blursize = 0,
	scanlines = 0,
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

surface.CreateFont( "health_Font", {
	font = "TargetID",
	size = ( ScrW() * 0.012 ) ,
	weight = 400,
	blursize = 0,
	scanlines = 0,
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

surface.CreateFont( "Shit!2", {
	font = "TargetID",
	size = ( ScrH() * 0.020 ) ,
	weight = 400,
	blursize = 0,
	scanlines = 0,
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


surface.CreateFont( "CSKillIcons", {
	font = "csd",
	size = ( ScrH() * 0.065 ) ,
	weight = 400,
	blursize = 0,
	scanlines = 0,
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

surface.CreateFont( "CSKillIconsHUD", {
	font = "csd",
	size = ( ScrH() * 0.055 ) ,
	weight = 5,
	blursize = 0,
	scanlines = 0,
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
surface.CreateFont( "CSKillIconsHUDTIMER", {
	font = "csd",
	size = ( ScrH() * 0.065 ) ,
	weight = 200,
	blursize = 0,
	scanlines = 0,
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

surface.CreateFont( "HUDTIMERFONT", {
	font = "TargetID",
	size = ( ScrH() * 0.032 ) ,
	weight = 400,
	blursize = 0,
	scanlines = 0,
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

surface.CreateFont( "zombieAmontIndicator_Hud", {
	font = "akbar",
	size = ( ScrH() * 0.04 ) ,
	weight = 400,
	blursize = 0,
	scanlines = 0,
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


surface.CreateFont( "menuDescFonttitle", {
	font = "CloseCaption_Bold",
	size = ( ScrH() * 0.041 ) ,
	weight = 800,
	blursize = 0,
	scanlines = 0,
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

surface.CreateFont( "menuDescFont", {
	font = "Trebuchet24",
	size = ( ScrH() * 0.032 ) ,
	weight = 400,
	blursize = 0,
	scanlines = 0,
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

surface.CreateFont( "HL2MPTypeDeath", {
	font = "HL2MP",
	size = ( ScrH() * 0.045 ) ,
	weight = 400,
	blursize = 0,
	scanlines = 0,
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


surface.CreateFont( "deathHudBig", {
	font = "CloseCaption_Bold",
	size = ( ScrH() * 0.041 ) ,
	weight = 800,
	blursize = 0,
	scanlines = 0,
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


surface.CreateFont( "deathHudSmall", {
	font = "CloseCaption_Bold",
	size = ( ScrH() * 0.031 ) ,
	weight = 800,
	blursize = 0,
	scanlines = 0,
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

surface.CreateFont( "ScoreboardDefault", {
	font = "TargetID",
	size = ( ScrH() * 0.018 ) ,
	weight = 800,
	blursize = 0,
	scanlines = 0,
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

surface.CreateFont( "ScoreboardDefaultTitle", {
	font = "TargetID",
	size = ( ScrH() * 0.025 ) ,
	weight = 800,
	blursize = 0,
	scanlines = 0,
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
end


function GM:PlayerBindPress( pl, bind, pressed )
   if ( bind == "+menu" ) and pressed then
      RunConsoleCommand( "drop" )
      return true
   end
   if ( pl:Team() == 3 and pl:GetZombieClass() == 2 or pl:GetZombieClass() == 5 ) then
		if ( bind == "+duck" ) then 
			return true 
		end
	end
end


net.Receive( "PlayMusic", function( len )
local bool =  net.ReadBit()
local music = net.ReadString()

	if bool == 1 then 
		RunConsoleCommand( "stopsound" )
	end

	timer.Simple( 1, function()
		surface.PlaySound( music )   
	end ) 
end )

function GM:CalcView( pl, pos, angles, fov )
local vieuw
				
   local HeadCrab = {}
    HeadCrab.origin = pos-( Vector( 0, 0, 50 ) )
    HeadCrab.angles = angles
    HeadCrab.fov = fov

if ( IsValid( pl ) and pl:Team() == 3 and pl:GetZombieClass() == 2 or pl:Team() == 3 and pl:GetZombieClass() == 5 ) then
    return HeadCrab
end
end


net.Receive("SetHull", function()
local pl = LocalPlayer()

if ( pl:Team() == 3 and ZombieClasses[ pl:GetZombieClass() ].HullSize1 and ZombieClasses[ pl:GetZombieClass() ].HullSize2  ) then
	pl:SetHull(	ZombieClasses[ pl:GetZombieClass() ].HullSize1, ZombieClasses[ pl:GetZombieClass() ].HullSize2 )
end

end ) 

function table.Resequence ( oldtable )
	local newtable = table.Copy ( oldtable )
	local id = 0
	
	--Clear old table
	table.Empty ( oldtable )
	
	--Write the new one
	for k,v in pairs ( newtable ) do
		id = id + 1
		oldtable[id] = newtable[k]
	end
end
  
function GM:HUDWeaponPickedUp ( weapon )
	if ( weapon.GetPrintName ) then
		Message( 5, "Arsenal Updated: "..weapon:GetPrintName(), 2, Vector( 255, 255, 255 ) )
	end
end

function GM:HUDItemPickedUp(itemname)
	return false
end

function GM:HUDAmmoPickedUp(itemname, amount)
	return false
end