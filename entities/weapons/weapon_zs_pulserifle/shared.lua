
if SERVER then
	AddCSLuaFile("shared.lua")
end

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.PrintName = "Pulse Rifle"			
	SWEP.Slot = 0
	SWEP.SlotPos = 1
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60
	SWEP.killFont = "weaponSelectionFont_HL2_Big"
	SWEP.WeaponSlot = 1
	SWEP.IconLetter = "2"
	SWEP.showSecondary = true
	killicon.AddFont("weapon_zs_pulserifle", "HL2MPTypeDeath", SWEP.IconLetter, Color(255, 255, 255, 255 ))
end

SWEP.HoldType = "ar2"
SWEP.Base				= "weapon_zs_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/c_IRifle.mdl"
SWEP.WorldModel			= "models/weapons/w_IRifle.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("Airboat.FireGunHeavy")
SWEP.Primary.Recoil			= 2
SWEP.Primary.Unrecoil		= 2
SWEP.Primary.Damage			= 15
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 35
SWEP.Primary.Delay			= 0.1
SWEP.Primary.DefaultClip	= 35
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"
SWEP.Primary.ConeMax		= 0.15
SWEP.Primary.ConeMin		= 0.042

SWEP.Secondary.ClipSize		= 20
SWEP.Secondary.DefaultClip	= 20
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.fired = false
SWEP.lastfire = 0
SWEP.rechargetimer = 0
SWEP.rechargerate = 0.40
SWEP.startcharge = 1
SWEP.MaxClip = 35


SWEP.IronSightsPos = Vector(-5, -4, 1 )
SWEP.IronSightsAng = Vector( 0, 0, 0 )

function SWEP:Think()
	if SERVER then
		local ply = self.Owner
		
			if !self.Owner:KeyDown( IN_ATTACK2 ) then
				self:SetIronsights( false )
			end
		-- Show reload animation when player stops firing. Looks cool.
		if ply:KeyDown( IN_ATTACK ) then	
			self.fired = true
			self.lastfire = CurTime()
		else
			if self.Owner:IsPlayer() then
				self.MaxClip = self.Primary.DefaultClip
				self.startcharge = 1
			end
			
			if self.lastfire < CurTime() - self.startcharge and self.rechargetimer < CurTime() then
				self.Weapon:SetClip1(math.min(self.MaxClip,self.Weapon:Clip1() + 1))
				self.rechargerate = 0.1
				self.rechargetimer = CurTime() + self.rechargerate 
			end
			if self.fired then 
				self.fired = false
				self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
			end
		end
	end
end

function SWEP:Reload()
	return false
end



