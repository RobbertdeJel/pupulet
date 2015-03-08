SWEP.Base = "weapon_zs_zombie"

SWEP.MeleeDelay = 0.5
SWEP.MeleeReach = 48
SWEP.MeleeSize = 1.5
SWEP.MeleeDamage = 40
SWEP.MeleeDamageType = DMG_SLASH
SWEP.VmodelScale = 0
SWEP.TeleportDelay = 6

SWEP.Primary.Delay = 2

SWEP.ViewModel = Model("models/weapons/v_pza.mdl")
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"

//15

function SWEP:VieuwModelEffect()

	local vm = self.Owner:GetViewModel()
	local vel = self.Owner:GetVelocity():Length()
	local velC = math.Clamp( vel, 100, 220 )
		vm:SetRenderMode(1)
		vm:SetColor( Color( 1, 1, 1, velC ) )
		

end


function SWEP:Precache()
	util.PrecacheSound("npc/antlion/distract1.wav")
	util.PrecacheSound("ambient/machines/slicer1.wav")
	util.PrecacheSound("ambient/machines/slicer2.wav")
	util.PrecacheSound("ambient/machines/slicer3.wav")
	util.PrecacheSound("ambient/machines/slicer4.wav")
	util.PrecacheSound("npc/zombie/claw_miss1.wav")
	util.PrecacheSound("npc/zombie/claw_miss2.wav")
end

function SWEP:StopMoaningSound()
end

function SWEP:StartMoaningSound()
	self.Owner:EmitSound("zombiesurvival/wraithdeath"..math.random(4)..".ogg")
end

function SWEP:PlayHitSound()
	self.Owner:EmitSound("ambient/machines/slicer"..math.random(4)..".wav", 90, 80)
end

function SWEP:PlayMissSound()
	self.Owner:EmitSound("npc/zombie/claw_miss"..math.random(1, 2)..".wav", 90, 80)
end

function SWEP:PlayAttackSound()
	self.Owner:EmitSound("npc/antlion/distract1.wav")
end


SWEP.NextWalk = 0
function SWEP:Think()
self:CheckMeleeAttack()
if ( CurTime() > self.NextWalk ) then
GAMEMODE:SetPlayerSpeed( self.Owner, 200,200 )

end
end


function SWEP:PrimaryAttack()
	if CurTime() < self:GetNextPrimaryFire() then return end

	local speed = 1

if SERVER then
			GAMEMODE:SetPlayerSpeed( self.Owner, speed,speed )
			self.Owner:SetLocalVelocity ( Vector ( 0,0,0 ) )
			self.NextWalk = CurTime() + 1.2
end		
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire(self:GetNextPrimaryFire() + 0.5)
	self:StartSwinging()

end

function SWEP:TeleportFail()
	if SERVER then
		if ( self.TeleportWarnTime or 0 )  <= CurTime() then
			self.Owner:EmitSound( "npc/stalker/stalker_ambient01.wav", 150, 100 ) 
			self.TeleportWarnTime = CurTime() + 0.97 
		end
	end
end

SWEP.TeleportTimer = 0
function SWEP:SecondaryAttack()

	if CurTime() < self.TeleportTimer then return end
	self:SetNextSecondaryFire(CurTime() + self.TeleportDelay )
local aimTrace = util.TraceLine( { start = self.Owner:GetShootPos(), endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 1000, filter = team.GetPlayers( 4 ), mask = MASK_PLAYERSOLID_BRUSHONLY } ) 
if not aimTrace.Hit or aimTrace.HitNormal != Vector( 0,0,1 ) then self:TeleportFail() return end
local hullTrace = util.TraceHull( { start = aimTrace.HitPos, endpos = aimTrace.HitPos, filter = team.GetPlayers( 4 ), mins = Vector ( -16, -16, 0 ), maxs = Vector ( 16, 16, 72 ) } )
if hullTrace.Hit then self:TeleportFail() return end
		local eData = EffectData()
			eData:SetEntity( self.Owner )
			eData:SetOrigin( self.Owner:GetPos() )
		util.Effect( "WraithTeleport", eData )
if SERVER then self.Owner:SetPos( hullTrace.HitPos ) end
if SERVER then self.Owner:EmitSound( "npc/stalker/stalker_scream"..math.random(1,4)..".wav", 80, math.random( 100, 115 ) ) end
self.TeleportTimer = CurTime() + 2.8
end

