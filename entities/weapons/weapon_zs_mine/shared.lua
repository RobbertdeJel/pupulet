if( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

SWEP.HoldType = "melee"

if( CLIENT ) then
	SWEP.PrintName = "Mine"
	SWEP.Slot = 3
	SWEP.SlotPos = 1
	SWEP.DrawCrosshair = false
	SWEP.IconLetter = "I"
	SWEP.killFont = "weaponSelectionFont_CSS"
	SWEP.WeaponSlot = 4
	SWEP.showPrimary = true
	killicon.AddFont("weapon_zs_mine", "CSKillIcons", SWEP.IconLetter, Color(255, 255, 255, 255 ))
end
------------------------------------------------------------------------------------------------------
SWEP.Author			= "" -- Original code by Amps, edited by ClavusElite for the IW gamemode
SWEP.Instructions	= "Stand close to a wall to plant the mine. Detonates when enemy is within visible range." 
SWEP.NextPlant = 0
------------------------------------------------------------------------------------------------------
SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= true
------------------------------------------------------------------------------------------------------
SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false
------------------------------------------------------------------------------------------------------
SWEP.ViewModel      = "models/weapons/v_c4.mdl"
SWEP.WorldModel   = "models/weapons/w_c4.mdl"
------------------------------------------------------------------------------------------------------
SWEP.Primary.Delay			= 2	
SWEP.Primary.Recoil			= 0		
SWEP.Primary.Damage			= 7	
SWEP.Primary.NumShots		= 1		
SWEP.Primary.Cone			= 0 	
SWEP.Primary.ClipSize		= 0
SWEP.Primary.DefaultClip	= 3
SWEP.Primary.Automatic   	= false
SWEP.Primary.Ammo         	= "slam"	
------------------------------------------------------------------------------------------------------
SWEP.Secondary.Delay		= 0.9
SWEP.Secondary.Recoil		= 0
SWEP.Secondary.Damage		= 6
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.Cone			= 0
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= 1
SWEP.Secondary.Automatic   	= false
SWEP.Secondary.Ammo         = "none"
------------------------------------------------------------------------------------------------------
//Preload
util.PrecacheSound("weapons/c4/c4_beep1.wav")
util.PrecacheSound("weapons/c4/c4_plant.wav")




function SWEP:Initialize( ply )
	self:SetWeaponHoldType(self.HoldType)
end

function SWEP:Precache()
end




function SWEP:Deploy()
	self:SetWeaponHoldType(self.HoldType)
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	return true
end


function SWEP:PrimaryAttack()
	if( CurTime() < self.NextPlant ) or not self:CanPrimaryAttack() or not SERVER then return end
	self.NextPlant = ( CurTime() + self.Primary.Delay )
	//
	local mines = 0
	local pos = self.Owner:GetPos()
	
	
	local trace = {}
	trace.start = self.Owner:GetShootPos()
	trace.endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 64
	trace.mask = MASK_NPCWORLDSTATIC
	trace.filter = self.Owner
	local tr = util.TraceLine( trace )

		
	
	//
	if ( tr.Hit ) then
	--self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		local ent = ents.Create ("proxbomb")
		if ( ent ~= nil and ent:IsValid() ) then
			ent:SetPos(tr.HitPos)		
			ent:SetOwner(self.Owner)
			ent:Spawn()
			ent:Activate()
			self.Owner:EmitSound( "weapons/c4/c4_plant.wav" )
			self.Owner:SetAnimation(PLAYER_ATTACK1)
			ent:WallPlant( tr.HitPos + tr.HitNormal, tr.HitNormal )
			
			self:TakePrimaryAmmo( 1 )
		end
	end
end

function SWEP:CanPrimaryAttack()
	if self.Owner:GetAmmoCount(self.Weapon:GetPrimaryAmmoType()) <= 0 then
		self.Weapon:EmitSound("Weapon_Pistol.Empty")
		self.NextPlant = ( CurTime() + self.Primary.Delay )
		return false
	end
	return true
end

function SWEP:Reload() 
	return false
end  

function SWEP:SecondaryAttack()
end 

--[[---------------------------------------------------------
   Name: Equip
   Desc: A player or NPC has picked the weapon up
-----------------------------------------------------------]]
function SWEP:Equip( NewOwner )

	if CLIENT then return end
	
	if self.Primary.RemainingAmmo then
		self:TakePrimaryAmmo ( self:Clip1() - self.Primary.RemainingAmmo )
	end

	//Magazine clip is stored in the weapon, instaed of player
	NewOwner:RemoveAmmo ( 1500, self.Primary.Ammo )
	NewOwner:GiveAmmo ( self.Primary.Magazine or self.Primary.DefaultClip, self.Primary.Ammo or nil )

end
