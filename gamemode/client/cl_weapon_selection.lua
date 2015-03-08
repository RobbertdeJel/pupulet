
local w, h = ScrW(), ScrH()
local oldActiveSlot = 0;  
local fade = 0


 
 
local weaponPosistionTable = {
	[ 1 ] = { width = ( w * 0.11 ), height = ( h * 0.075 ), wPos = ( w - ( w * 0.115 ) ), hPos = ( h * 0.25 ), activeWeapon = "", wasChange = false, img = "hud3/scalablepanel_bgmidgrey_outlinegrey", color = Color( 255, 255, 255, 255 ), fade = 0 }, 
	[ 2 ] = { width = ( w * 0.085 ), height = ( h * 0.075 ), wPos = ( w - ( w * 0.09 ) ), hPos = ( h * 0.332 ), activeWeapon = "", wasChange = false, img = "hud3/scalablepanel_bgmidgrey_outlinegrey", color = Color( 255, 255, 255, 255 ), fade = 0 },
	[ 3 ] = { width = ( w * 0.085 ), height = ( h * 0.075 ), wPos = ( w - ( w * 0.09 ) ), hPos = ( h * 0.413 ), activeWeapon = "", wasChange = false, img = "hud3/scalablepanel_bgmidgrey_outlinegrey", color = Color( 255, 255, 255, 255 ),fade = 0 },
	[ 4 ] = { width = ( w * 0.065 ), height = ( h * 0.075 ), wPos = ( w - ( w * 0.07 ) ), hPos = ( h * 0.496 ), activeWeapon = "", wasChange = false, img = "hud3/scalablepanel_bgmidgrey_outlinegrey", color = Color( 255, 255, 255, 255 ), fade = 0 },
}

local changePosTable = {
[ 1 ] = { [ 2 ] = ( h * 0.37 ), [ 3 ] = ( h * 0.45 ), [ 4 ] = ( h * 0.53 ) }, 
[ 2 ] = { [ 1 ] = ( h * 0.25 ), [ 3 ] = ( h * 0.45 ), [ 4 ] = ( h * 0.53 ) },
[ 3 ] = { [ 1 ] = ( h * 0.25 ), [ 2 ] = ( h * 0.34 ), [ 4 ] = ( h * 0.54 ) },
[ 4 ] = { [ 1 ] = ( h * 0.25 ), [ 2 ] = ( h * 0.34 ), [ 3 ] = ( h * 0.42 ) },
} 

local texttable = {
[ 1 ] = { clipWPos = weaponPosistionTable[ 1 ].wPos * 1.012, clipHPos = weaponPosistionTable[ 1 ].hPos * 1.092, spareWPos =  weaponPosistionTable[ 1 ].wPos * 1.028, spareHPos = weaponPosistionTable[ 1 ].hPos * 1.15, killconWPos = weaponPosistionTable[ 1 ].wPos * 1.032, killconHpos = weaponPosistionTable[ 1 ].hPos * 0.98 },
[ 2 ] = { clipWPos = weaponPosistionTable[ 2 ].wPos * 1.012, clipHPos = weaponPosistionTable[ 2 ].hPos * 1.082, spareWPos =  weaponPosistionTable[ 2 ].wPos * 1.022, spareHPos = weaponPosistionTable[ 2 ].hPos * 1.11, killconWPos = weaponPosistionTable[ 2 ].wPos * 1.035, killconHpos = weaponPosistionTable[ 2 ].hPos * 0.98  },
[ 3 ] = { clipWPos = -50, clipHPos = 0, spareWPos =  -50, spareHPos = 0, killconWPos = weaponPosistionTable[ 3 ].wPos * 1.015	, killconHpos = weaponPosistionTable[ 3 ].hPos * 1.05 },
[ 4 ] = { clipWPos = -50, clipHPos = 0, spareWPos =  weaponPosistionTable[ 4 ].wPos * 1.001, spareHPos = weaponPosistionTable[ 4 ].hPos * 1.08, killconWPos = weaponPosistionTable[ 4 ].wPos * 1.03, killconHpos = weaponPosistionTable[ 4 ].hPos * 1.01 },
}

local function animatedSelection( amount, newAmount, Rate )
	return math.Approach( amount, newAmount, Rate )  
end 
  
local function getIcon( pl, number ) 
if ( !IsValid( pl ) && !pl.GetActiveWeapon && pl:Alive() && !number ) then return end 
local activeWeapon = pl:GetActiveWeapon()
local rest = weaponPosistionTable[ number ]
		if ( activeWeapon.WeaponSlot && activeWeapon.WeaponSlot ~= oldActiveSlot ) then 
			oldActiveSlot = activeWeapon.WeaponSlot
			weaponPosistionTable[ activeWeapon.WeaponSlot ].img = "hud3/scalablepanel_bgmidgrey_outlinegreen_glow"
			weaponPosistionTable[ activeWeapon.WeaponSlot ].color = Color( 0, 200, 0, 255 )
			weaponPosistionTable[ activeWeapon.WeaponSlot ].wasChange = false
		else
			if ( number ~= oldActiveSlot && !weaponPosistionTable[ number ].wasChange ) then
				for k, v in pairs( pl:GetWeapons() ) do 
						if ( v.WeaponSlot ~= activeWeapon.WeaponSlot ) then
							weaponPosistionTable[ v.WeaponSlot ].img = "hud3/scalablepanel_bgmidgrey_outlinegrey"
							weaponPosistionTable[ v.WeaponSlot ].color = Color( 255, 255, 255, 255 )
							weaponPosistionTable[ v.WeaponSlot ].wasChange = true
							fade = 0
						end
					end
			end
	end
end

hook.Add( "HUDPaint", "dawWeaponSelection", function()
local pl = LocalPlayer()
fade = animatedSelection( fade, 255, FrameTime() * 40 )

if ( pl:Team() == 4 ) then
		for k, v in pairs( pl:GetWeapons() ) do
			if !weaponPosistionTable[ v.WeaponSlot ] then continue; end 
			getIcon( pl, v.WeaponSlot )
			local color = weaponPosistionTable[ v.WeaponSlot ].color
			local newColor = weaponPosistionTable[ v.WeaponSlot ].color
			if ( pl.GetActiveWeapon && pl:GetActiveWeapon().WeaponSlot && v.WeaponSlot ~= pl:GetActiveWeapon().WeaponSlot ) then newColor = Color( color.r, color.g, color.b, color.a - fade ) end
			
			
				DrawImage( newColor, weaponPosistionTable[ v.WeaponSlot ].img , weaponPosistionTable[ v.WeaponSlot ].wPos, weaponPosistionTable[ v.WeaponSlot ].hPos, weaponPosistionTable[ v.WeaponSlot ].width, weaponPosistionTable[ v.WeaponSlot ].height )
				draw.SimpleText( v.IconLetter, v.killFont, texttable[ v.WeaponSlot ].killconWPos , texttable[ v.WeaponSlot ].killconHpos, newColor )
				draw.SimpleText( v:Clip1(), "ammoFont_Big", texttable[ v.WeaponSlot ].clipWPos , texttable[ v.WeaponSlot ].clipHPos, newColor )
				if ( v.showSecondary ) then continue end
				draw.SimpleText( "   "..pl:GetAmmoCount( v:GetPrimaryAmmoType() ), "ammoFont_Small",texttable[ v.WeaponSlot ].spareWPos , texttable[ v.WeaponSlot ].spareHPos, newColor )
		end
	end
end )