if SERVER then
	AddCSLuaFile("shared.lua")
end


SWEP.HoldType           = "ar2"

if CLIENT then
	SWEP.PrintName          = "Scout"
	SWEP.Slot               = 0
	SWEP.SlotPos              = 1
	SWEP.ViewModelFlip		= false
	SWEP.ViewModelFOV = 55

	SWEP.killFont = "weaponSelectionFont_CSS_Big"
	SWEP.WeaponSlot = 1
	SWEP.IconLetter = "n"
	killicon.AddFont("weapon_zs_scout", "CSKillIcons", SWEP.IconLetter, Color(255, 255, 255, 255 ))
end

SWEP.Base				= "weapon_zs_base"
SWEP.Spawnable = true


SWEP.Primary.Sound = Sound("weapons/scout/scout_fire-1.wav")
SWEP.Secondary.Sound = Sound("Default.Zoom")
SWEP.Primary.Delay          = 1.5
SWEP.Primary.Recoil         = 7
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "357"
SWEP.Primary.Damage = 50
SWEP.Primary.ClipSize = 10
SWEP.Primary.DefaultClip = 10

SWEP.Primary.ConeMax		= 0.12
SWEP.Primary.ConeMin		= 0.001


SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 54
SWEP.ViewModel          = Model("models/weapons/cstrike/c_snip_scout.mdl")
SWEP.WorldModel         = Model("models/weapons/w_snip_scout.mdl")

SWEP.CSMuzzleFlashes = true

SWEP.IronSightsPos      = Vector( -5, -12, 2 )
SWEP.IronSightsAng      = Vector( 2.6, 1.37, 3.5 )



function SWEP:IsScoped()
	return self.Owner:KeyDown( IN_ATTACK2 ) and self.fIronTime and self.fIronTime + 0.25 <= CurTime()
end


function ScoutCalcView( pl, pos, angles, fov )
		local wep = pl:GetActiveWeapon()
		if ( !IsValid( pl ) ) then return end
		
		
		if IsValid( wep ) and wep:GetClass() == "sp_scout" and pl:KeyDown( IN_ATTACK2 ) then 
			local SCOPE = {}
			SCOPE.origin = pos
			SCOPE.angles = angles
			SCOPE.fov = fov -50
	
  
			return SCOPE
		end
	end
hook.Add( "CalcView", "ScoutCalcView", ScoutCalcView )


hook.Add("ShouldDrawLocalPlayer", "DrawLocalPlayer", function( pl )

   if ( pl:KeyDown( IN_ATTACK2 ) ) then
	
		return false
	
	end
end)

function SWEP:SendWeaponAnimation()
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
end


if CLIENT then

	function SWEP:GetViewModelPosition(pos, ang)
	if !IsValid( self.Owner ) then return end
		if self:IsScoped() then
			return pos + ang:Up() * 256, ang
		end

		return self.BaseClass.GetViewModelPosition(self, pos, ang)
	end

	local matScope = Material("sprites/scope")
	function SWEP:DrawHUD()
		if self:IsScoped() then
			local scrw, scrh = ScrW(), ScrH()
			local size = math.min(scrw, scrh)
			surface.SetMaterial(matScope)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRect((scrw - size) * 0.5, (scrh - size) * 0.5, size, size)
			surface.SetDrawColor(0, 0, 0, 255)
			
			local x = ScrW() / 2.0
			local y = ScrH() / 2.0
			local scope_size = ScrH()

			-- crosshair
			local gap = 80
			local length = scope_size
			surface.DrawLine( x - length, y, x - gap, y )
			surface.DrawLine( x + length, y, x + gap, y )
			surface.DrawLine( x, y - length, x, y - gap )
			surface.DrawLine( x, y + length, x, y + gap )

			gap = 0
			length = 50
			surface.DrawLine( x - length, y, x - gap, y )
			surface.DrawLine( x + length, y, x + gap, y )
			surface.DrawLine( x, y - length, x, y - gap )
			surface.DrawLine( x, y + length, x, y + gap )
			if scrw > size then
				local extra = (scrw - size) * 0.5
				surface.DrawRect(0, 0, extra, scrh)
				surface.DrawRect(scrw - extra, 0, extra, scrh)
			end
			if scrh > size then
				local extra = (scrh - size) * 0.5
				surface.DrawRect(0, 0, scrw, extra)
				surface.DrawRect(0, scrh - extra, scrw, extra)
			end
		end
	end
end

function SWEP:AdjustMouseSensitivity()
    if self.Owner:KeyDown( IN_ATTACK2 ) then  
		return 0.3
	else 
		return 1
	end
end

