if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = " sp_shotgun_base "
	SWEP.Author	= "Rob"
	SWEP.Slot = 3
	SWEP.SlotPos = 3
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60
	
end

SWEP.Base				= "weapon_zs_base"
SWEP.HoldType 			= "shotgun"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/cstrike/c_shot_m3super90.mdl"
SWEP.WorldModel			= "models/weapons/w_shot_m3super90.mdl"

SWEP.Weight				= 10
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("Weapon_M3.Single")
SWEP.Primary.Recoil			= 5
SWEP.Primary.Damage			= 4
SWEP.Primary.NumShots		= 10
SWEP.Primary.ClipSize		= 5
SWEP.Primary.Delay 			= 0.95
SWEP.ReloadDelay = 0.4
SWEP.Primary.DefaultClip	= SWEP.Primary.ClipSize*5
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "buckshot"
SWEP.Primary.Cone			= 0.11
SWEP.Primary.ConeMoving		= 0.14
SWEP.Primary.ConeCrouching	= 0.08


SWEP.IronSightsPos = Vector(-3.73,-4,1.375)
SWEP.IronSightsAng = Vector( 0, 0, 0 )



SWEP.reloadtimer = 0
SWEP.nextreloadfinish = 0

function SWEP:Deploy()
	 self.reloading = false

	self.Weapon:SendWeaponAnim(ACT_VM_DRAW) 
	if SERVER then
		self.Owner:DrawWorldModel(true)
	end
	self:SetColor(Color(255, 255, 255, 255))
	self.Owner:SetColor(Color(255, 255, 255, 255))

	self.Weapon:SetNextPrimaryFire(CurTime() + 1)

	self.Weapon:SetNetworkedBool( "reloading", false)

	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	-- Set the deploy animation when deploying

	self.Weapon:SetNextPrimaryFire(CurTime() + 1)
	-- Set the next primary fire to 1 second after deploying
	
	self:SetIronsights(false)
	return true
end



function SWEP:Reload()
	if self.reloading then return end

	if self:Clip1() < self.Primary.ClipSize and 0 < self.Owner:GetAmmoCount(self.Primary.Ammo) then
		self:SetNextPrimaryFire( CurTime() + self.ReloadDelay )
		self.reloading = true
		self.reloadtimer = CurTime() + self.ReloadDelay
		self:SendWeaponAnim( ACT_SHOTGUN_RELOAD_START )
		self.Owner:DoReloadEvent()
	end
end


function SWEP:Think()
	if self.reloading and self.reloadtimer < CurTime() then
		self.reloadtimer = CurTime() + self.ReloadDelay
		self:SendWeaponAnim( ACT_VM_RELOAD )

		self.Owner:RemoveAmmo(1, self.Primary.Ammo, false)
		self:SetClip1(self:Clip1() + 1)
		self:EmitSound("Weapon_Shotgun.Reload")

		if self.Primary.ClipSize <= self:Clip1() or self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then
			self.nextreloadfinish = CurTime() + self.ReloadDelay
			self.reloading = false
			self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		end
	end

	local nextreloadfinish = self.nextreloadfinish
	if nextreloadfinish ~= 0 and nextreloadfinish < CurTime() then
		self:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )
		self:EmitSound("Weapon_Shotgun.Special1")
		self.nextreloadfinish = 0
	end


	if !self.Owner:KeyDown(IN_ATTACK2) then
		self:SetIronsights(false)
	end
end



function SWEP:CanPrimaryAttack()

	if self:Clip1() <= 0 then
		self:EmitSound("Weapon_Shotgun.Empty")
		self:SetNextPrimaryFire(CurTime() + 0.25)
		return false
	end

	if self.reloading then
		if 0 < self:Clip1() then
			self:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )
			self:EmitSound("Weapon_Shotgun.Special1")
		else
			self:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )
		end
		self.reloading = false
		self:SetNextPrimaryFire(CurTime() + 0.25)
		return false
	end

	return true
end


