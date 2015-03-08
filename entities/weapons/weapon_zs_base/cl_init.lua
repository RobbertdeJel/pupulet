include('shared.lua')
include( 'sh_weaponskins.lua' )

SWEP.Slot				= 0						-- Slot in the weapon selection menu
SWEP.SlotPos			= 10	
SWEP.PrintName			= "sp_base"					-- Position in the slot
SWEP.DrawAmmo			= false			-- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair		= false 					-- Should draw the default crosshair
SWEP.DrawWeaponInfoBox	= true					-- Should draw the weapon info box
SWEP.BounceWeaponIcon   = true					-- Should the weapon icon bounce?
SWEP.ViewModelFOV		= 75
SWEP.RenderGroup 		= RENDERGROUP_OPAQUE


SWEP.SelectedSkinRarety = false
SWEP.SelectedSkinClass  = false
SWEP.SkinRaretyfunction = ""
SWEP.SkinRarety = 0
SWEP.SkinClass = 0
SWEP.SkinTextColor = Color( 255, 255, 255, 255 )

//some angle stuff...
SWEP.AngX = 0
SWEP.AngY = 0
SWEP.AngZ = 0



-- Override this in your SWEP to set the icon in the weapon selection
SWEP.WepSelectIcon		= surface.GetTextureID( "weapons/swep" )

-- This is the corner of the speech bubble
SWEP.SpeechBubbleLid	= surface.GetTextureID( "gui/speech_lid" )

function SWEP:ChangeSomeStuff()
	self.PrintName = self.PrintName.." | "..WeaponSkins[ self:GetSkinType() ][ self:GetSkinType2() ].name
	self.SkinTextColor = WeaponSkins[ self:GetSkinType() ].color or Color( 255, 255, 255, 255 )
end

function SWEP:SelectSkinRarety()
	
	if self:GetSkinType() != 0 and self:GetSkinType2() != 0 and WeaponSkins[ self:GetSkinType() ][ self:GetSkinType2() ].skin  then
		if !self.SelectedSkinRarety then
			self.SelectedSkinRarety = true
			self:ChangeSomeStuff()
		end
		return WeaponSkins[ self:GetSkinType() ][ self:GetSkinType2() ].skin 
	else
		return ""
	end

end


function SWEP:ViewModelDrawn( wep )
		wep:SetMaterial( self:SelectSkinRarety() )
	
end

function SWEP:DrawWorldModel()
	
	self.Weapon:DrawModel()
		self:SetMaterial( self:SelectSkinRarety() )
	
end

--[[---------------------------------------------------------
	Checks the objects before any action is taken
	This is to make sure that the entities haven't been removed
-----------------------------------------------------------]]
function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
	
	-- Set us up the texture
	surface.SetDrawColor( 255, 255, 255, alpha )
	surface.SetTexture( self.WepSelectIcon )
	
	-- Lets get a sin wave to make it bounce
	local fsin = 0
	
	if ( self.BounceWeaponIcon == true ) then
		fsin = math.sin( CurTime() * 10 ) * 5
	end
	
	-- Borders
	y = y + 10
	x = x + 10
	wide = wide - 20
	
	-- Draw that mother
	surface.DrawTexturedRect( x + (fsin), y - (fsin),  wide-fsin*2 , ( wide / 2 ) + (fsin) )
	
	-- Draw weapon info box
	self:PrintWeaponInfo( x + wide + 20, y + tall * 0.95, alpha )
	
end


--[[---------------------------------------------------------
	This draws the weapon info box
-----------------------------------------------------------]]
function SWEP:PrintWeaponInfo( x, y, alpha )
	return;
end


--[[---------------------------------------------------------
   Name: SWEP:FreezeMovement()
   Desc: Return true to freeze moving the view
-----------------------------------------------------------]]
function SWEP:FreezeMovement()
	return false
end


--[[---------------------------------------------------------
   Name: SWEP:ViewModelDrawn( ViewModel )
   Desc: Called straight after the viewmodel has been drawn
-----------------------------------------------------------]]

--[[---------------------------------------------------------
   Name: OnRestore
   Desc: Called immediately after a "load"
-----------------------------------------------------------]]
function SWEP:OnRestore()
end

--[[---------------------------------------------------------
   Name: OnRemove
   Desc: Called just before entity is deleted
-----------------------------------------------------------]]
function SWEP:OnRemove()
end

--[[---------------------------------------------------------
   Name: CustomAmmoDisplay
   Desc: Return a table
-----------------------------------------------------------]]
function SWEP:CustomAmmoDisplay()
end

--[[---------------------------------------------------------
   Name: GetViewModelPosition
   Desc: Allows you to re-position the view model
-----------------------------------------------------------]]
function SWEP:GetViewModelPosition( pos, ang )
	local bIron = self:GetDTBool( 0 )
	
	
	if ( bIron != self.bLastIron ) then
	
		self.bLastIron = bIron 
		self.fIronTime = CurTime() 
		
		if ( bIron ) then 
			self.SwayScale 	= 0.8
			self.BobScale 	= 0.8
		else 
			self.AngX = 0
			self.AngY = 0
			self.AngZ = 0
			self.SwayScale 	= 2.0
			self.BobScale 	= 1.5
		end
	end
	local Mul = math.Clamp((CurTime() - (self.fIronTime or 0)) * 4, 0, 1)
	if not bIron then Mul = 1 - Mul end

	if Mul > 0 then
		local Offset = self.IronSightsPos
		
		if self.IronSightsAng then
			self.AngX = math.Approach( self.AngX, self.IronSightsAng.x, FrameTime() * 2 )
			self.AngY = math.Approach( self.AngY, self.IronSightsAng.y, FrameTime() * 2 )
			self.AngZ = math.Approach( self.AngZ, self.IronSightsAng.z, FrameTime() * 2 )			
			print( self.AngX )
			print( self.IronSightsAng.x )
			
			
			ang = Angle(ang.p, ang.y, ang.r)
			ang:RotateAroundAxis( ang:Right(), self.AngX )
			ang:RotateAroundAxis( ang:Up(), self.AngY )
			ang:RotateAroundAxis( ang:Forward(), self.AngZ )
		end

		pos = pos + Offset.x * Mul * ang:Right() + Offset.y * Mul * ang:Forward() + Offset.z * Mul * ang:Up()
	end
	return pos, ang
end


--[[---------------------------------------------------------
   Name: TranslateFOV
   Desc: Allows the weapon to translate the player's FOV (clientside)
-----------------------------------------------------------]]
function SWEP:TranslateFOV( current_fov )
	
	return current_fov

end

--[[---------------------------------------------------------
   Name: DrawWorldModelTranslucent
   Desc: Draws the world model (not the viewmodel)
-----------------------------------------------------------]]
function SWEP:DrawWorldModelTranslucent()
	
	self.Weapon:DrawModel()

end


--[[---------------------------------------------------------
   Name: AdjustMouseSensitivity()
   Desc: Allows you to adjust the mouse sensitivity.
-----------------------------------------------------------]]
function SWEP:AdjustMouseSensitivity()

	return nil
	
end

--[[---------------------------------------------------------
   Name: GetTracerOrigin()
   Desc: Allows you to override where the tracer comes from (in first person view)
		 returning anything but a vector indicates that you want the default action
-----------------------------------------------------------]]
function SWEP:GetTracerOrigin()

--[[
	local ply = self:GetOwner()
	local pos = ply:EyePos() + ply:EyeAngles():Right() * -5
	return pos
--]]

end

function SWEP:GetCrossHairColor()

local eyetrace = self.Owner:GetEyeTrace()
local aplha = math.Clamp( 255 - self.Owner:GetVelocity():Length(), 180, 255 )
local ent = eyetrace.Entity
	if eyetrace.Hit then
		if IsValid( ent ) and ent:IsPlayer() and ent:Team() == 3 then
			color = Color( 220, 0, 0, aplha )
		else
			color = Color( 255, 255, 255, aplha )
		end
	end
return color

end

function SWEP:DrawHUD()
	local w = ScrW()
	local h = ScrH()
	local scale = math.Clamp ( 20 * self:GetCones(), 0, 2 ) 
	local eyetrace = self.Owner:GetEyeTrace()
	local CColor = self:GetCrossHairColor()
	surface.SetDrawColor( 255, 255, 255, aplha )
	// Scale the size of the crosshair according to how long ago we fired our weapon
	local LastShootTime = self.Weapon:GetNetworkedFloat( "LastShootTime", 0 )
	scale = scale * (2 - math.Clamp( (CurTime() - LastShootTime) * 5, 0.0, 1.0 ))
	

			if ( !self.Owner:KeyDown( IN_ATTACK2 ) ) then
				local gap = 20 * scale
				local length = gap + 30 * scale
				draw.RoundedBox( 0,( w * 0.50 )- length, ( h * 0.50 ), ( ScrW() * 0.001 ) + gap, 1, CColor )
				draw.RoundedBox( 0,( w * 0.50 ) + length - gap, ( h * 0.50 ), ( ScrW() * 0.001 ) + gap, 1, CColor )
				draw.RoundedBox( 0,( w * 0.50 ), ( h * 0.50 ) - length, 1, ( ScrW() * 0.001 ) + gap, CColor )
				draw.RoundedBox( 0,( w* 0.50 ), ( h * 0.50 ) + length - gap, 1, ( ScrW() * 0.001 ) + gap, CColor )

			end
		draw.RoundedBox( 0, ( w * 0.50 ) -1 , ( h * 0.50 )-1, 3, 3, Color( 255, 0, 0, 255 ) )
end

