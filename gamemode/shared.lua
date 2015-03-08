include( "shared/sh_zombieanimations.lua" )
include( 'shared/sh_object_player_exstended.lua' )
include( 'shared/sh_obj_entity_exstended.lua' )
CUSTOM_PRIMARY, CUSTOM_SECONDARY = 100,200

clrTable = {} 
clrTable["Green"] = Color( 20, 150, 20, 255 )
clrTable["White"] = Color( 255, 255, 255, 255 )

-------------------------
 
GM.Name 		= "Pupulet"
GM.Author 		= "Rob"
GM.Email 		= "robbertdejel@hotmail.com"
GM.Website 		= "N/A"
 

function GM:ShouldCollide( ent1, ent2 )
	if ( ent1:IsPlayer() and ent2:IsPlayer() and ent1:Team() == ent2:Team() )  then
		return false
	end
	if ent1:Team() == ent2.teamCollison then
		return false
	end
	return true

end 

game.AddDecal( "poisonHeadCrab", "decals/yblood1" )


hook.Add("Initialize", "NixTheLag", function()
	-- Horrible amount of cycle usage, especially on the server.
	hook.Remove("PlayerTick", "TickWidgets")

	if SERVER then
		-- Forget what this is but probably retarded.
		if timer.Exists("CheckHookTimes") then
			timer.Remove("CheckHookTimes")
		end
	end

	if CLIENT then
		-- These call on bloated convar getting methods and aren't ever used anyway outside of sandbox.
		hook.Remove("RenderScreenspaceEffects", "RenderColorModify")
		hook.Remove("RenderScreenspaceEffects", "RenderBloom")
		hook.Remove("RenderScreenspaceEffects", "RenderToyTown")
		hook.Remove("RenderScreenspaceEffects", "RenderTexturize")
		hook.Remove("RenderScreenspaceEffects", "RenderSunbeams")
		hook.Remove("RenderScreenspaceEffects", "RenderSobel")
		hook.Remove("RenderScreenspaceEffects", "RenderSharpen")
		hook.Remove("RenderScreenspaceEffects", "RenderMaterialOverlay")
		hook.Remove("RenderScreenspaceEffects", "RenderMotionBlur")
		hook.Remove("RenderScene", "RenderStereoscopy")
		hook.Remove("RenderScene", "RenderSuperDoF")
		hook.Remove("GUIMousePressed", "SuperDOFMouseDown")
		hook.Remove("GUIMouseReleased", "SuperDOFMouseUp")
		hook.Remove("PreventScreenClicks", "SuperDOFPreventClicks")
		hook.Remove("PostRender", "RenderFrameBlend")
		hook.Remove("PreRender", "PreRenderFrameBlend")
		hook.Remove("Think", "DOFThink")
		hook.Remove("RenderScreenspaceEffects", "RenderBokeh")
		hook.Remove("NeedsDepthPass", "NeedsDepthPass_Bokeh")

		-- Useless since we disabled widgets above.
		hook.Remove("PostDrawEffects", "RenderWidgets")

		-- Could screw with people's point shops but whatever.
		hook.Remove("PostDrawEffects", "RenderHalos")
	end
end)



//MUST.PRECACHE.MODELS
FullPlayerModelPrecache = {
	"models/player/kleiner.mdl",
	"models/player/eli.mdl",
	"models/player/alyx.mdl",
	"models/player/Group01/Male_01.mdl",
	"models/player/Group01/Male_02.mdl",
	"models/player/Group01/Male_03.mdl",
	"models/player/Group01/Female_01.mdl",
	"models/player/Group01/Female_02.mdl",
	"models/player/Group01/Female_03.mdl",
	"models/player/Group03/Male_01.mdl",
	"models/player/Group03/Male_02.mdl",
	"models/player/Group03/Male_03.mdl",
	"models/player/Group03/Female_01.mdl",
	"models/player/Group03/Female_02.mdl",
	"models/player/Group03/Female_03.mdl",
	"models/player/monk.mdl",
	"models/player/Combine_Soldier.mdl",
	"models/player/Combine_Soldier_PrisonGuard.mdl",
	"models/player/leet.mdl",
	"models/player/guerilla.mdl",
	"models/player/arctic.mdl",
	"models/player/phoenix.mdl",
	"models/player/urban.mdl",
	"models/player/gasmask.mdl",
	"models/player/riot.mdl",
	"models/player/swat.mdl",
	"models/Zombie/Fast.mdl",
	"models/headcrabblack.mdl",
	"models/stalker.mdl",
	"models/headcrabclassic.mdl",
	"models/player/zombie_classic.mdl",
	"models/props_pipes/destroyedpipes01d.mdl"
}

for k, v in pairs( FullPlayerModelPrecache ) do
	util.PrecacheModel( v )
end

//CAN'T. RESIST. PRECHACHE.
TableAlSounds = {
	"npc/headcrab_poison/ph_wallpain2.wav",
	"npc/headcrab_poison/ph_wallpain3.wav",
	"npc/fast_zombie/leap1.wav",
	"npc/fast_zombie/wake1.wav",
	"npc/stalker/stalker_pain1.wav",
	"npc/stalker/stalker_pain2.wav",
	"npc/stalker/stalker_pain3.wav",
	"npc/headcrab/pain1.wav",
	"npc/headcrab/pain2.wav",
	"npc/headcrab/pain3.wav",
	"npc/zombie/zombie_pain1.wav", 
	"npc/zombie/zombie_pain2.wav", 
	"npc/zombie/zombie_pain3.wav", 
	"npc/zombie/zombie_pain4.wav", 
	"npc/zombie/zombie_pain5.wav", 
	"npc/zombie/zombie_pain6.wav",
	"vo/npc/female01/pain01.wav",
	"vo/npc/female01/pain02.wav",
	"vo/npc/female01/pain03.wav",
	"vo/npc/female01/pain04.wav",
	"vo/npc/female01/pain05.wav",
	"vo/npc/female01/pain06.wav",
	"vo/npc/female01/pain07.wav",
	"vo/npc/female01/pain08.wav",
	"vo/npc/female01/pain09.wav",
	"vo/npc/male01/pain01.wav",
	"vo/npc/male01/pain02.wav",
	"vo/npc/male01/pain03.wav",
	"vo/npc/male01/pain04.wav",
	"vo/npc/male01/pain05.wav",
	"vo/npc/male01/pain06.wav",
	"vo/npc/male01/pain07.wav",
	"vo/npc/male01/pain08.wav",
	"vo/npc/male01/pain09.wav",
	"pupuletsound/unlife_pupulet.mp3",
	"pupuletsound/robzombiehotrodremix.mp3",
	"pupuletsound/buttonclickrelease.wav",
	"pupuletsound/menu_accept.wav",
	"pupuletsound/Menu_Click01.wav",
	"pupuletsound/thunder1.mp3",
	"pupuletsound/thunder2.mp3",
	"pupuletsound/thunder3.mp3",
	"pupuletsound/thunder4.mp3",
	"music/HL1_song14.mp3",
	"music/HL1_song15.mp3",
	"music/HL1_song17.mp3",
	"music/HL1_song19.mp3",
	"music/HL1_song20.mp3", 
	"music/HL1_song21.mp3",
	"music/HL1_song3.mp3",
	"music/HL1_song5.mp3",
	"music/HL1_song6.mp3", 
	"music/HL1_song9.mp3",
	"music/HL2_intro.mp3",
	"music/HL2_song0.mp3",
	"music/HL2_song1.mp3",
	"music/HL2_song10.mp3",
	"music/HL2_song11.mp3",
	"music/HL2_song32.mp3",
	"music/HL2_song30.mp3",
	"music/HL2_song29.mp3",
	"music/HL2_song26_trainstation1.mp3",
	"music/HL2_song26.mp3",
	"music/HL2_song23_suitsong3.mp3",
	"music/HL2_song20_submix0.mp3",
	"music/HL2_song12_long.mp3",
	"music/HL2_song2.mp3",
	"physics/flesh/flesh_bloody_impact_hard1.wav",
	"physics/flesh/flesh_bloody_impact_hard2.wav",
	"physics/flesh/flesh_bloody_impact_hard3.wav",
	"physics/flesh/flesh_bloody_impact_hard4.wav",
}
for k, v in pairs( TableAlSounds ) do
	util.PrecacheSound( v )
end

function GM:CreateTeams()


TEAM_HUMAN_SPECTATOR = 1
team.SetUp( TEAM_HUMAN_SPECTATOR, "HUMAN_SPECTATOR", Color( 255, 255, 255, 255 ) ) 

TEAM_ZOMBIE_SPECTATOR = 2
team.SetUp( TEAM_ZOMBIE_SPECTATOR, "ZOMBIE_SPECTATOR", Color( 255, 255, 255, 255 ) ) 

TEAM_ZOMBIE = 3
team.SetUp( TEAM_ZOMBIE, "TEAM_ZOMBIE", Color( 0, 200, 0, 255 ) )

TEAM_HUMAN = 4
team.SetUp( TEAM_HUMAN, "TEAM_HUMAN", Color( 80, 80, 255, 255 ) ) 
end


function GM:PropBreak( attacker, prop )
end


 //Mananges playback rate and such
function GM:UpdateAnimation( pl, vel, maxseqgroundspeed )	


 if pl:Team() == 3 then if self.UpdateAnimations[ pl:GetZombieClass() ] then return self.UpdateAnimations[ pl:GetZombieClass() ]( pl, vel, maxseqgroundspeed ) end end

	//Controls playback
	local len2d = vel:Length2D()
	local rate = 1.0
	
	if len2d > 0.5 then
		rate = ( ( len2d * 0.8 ) / maxseqgroundspeed )
	end
	
	rate = math.Clamp(rate, 0, 1.5)
	
	pl:SetPlaybackRate( rate )
	
		
	if ( CLIENT ) and pl:Team() == 4 then
		GAMEMODE:GrabEarAnimation( pl )
	end
	
end


//Manages activities to play I think
function GM:CalcMainActivity( pl, vel )	
	//Human animations
	if pl:Team() == 4 then
		//Default mp model activity
		pl.CalcIdeal = ACT_MP_STAND_IDLE
		pl.CalcSeqOverride = -1
	
		if 	self:HandlePlayerJumping( pl, vel ) ||
			self:HandlePlayerDucking( pl, vel ) ||
			self:HandlePlayerSwimming( pl, vel ) then
		else
			local len2d = vel:Length2D()
			
			if len2d > 120 then
				pl.CalcIdeal = ACT_MP_RUN
			elseif len2d > 0.5 then
				pl.CalcIdeal = ACT_MP_WALK
			end
		end
		
		local weapon = pl:GetActiveWeapon()
	
		if pl.CalcIdeal == ACT_MP_CROUCH_IDLE &&
			IsValid(weapon) &&
			( weapon:GetHoldType() == "knife" || weapon:GetHoldType() == "melee2" ) then
		
			pl.CalcSeqOverride = pl:LookupSequence("cidle_" .. weapon:GetHoldType())
		end
	
		
		return pl.CalcIdeal, pl.CalcSeqOverride
	end
	
	//Undead animations
 if pl:Team() == 3 then if self.CalcMainActivityZombies[ pl:GetZombieClass() ] then  return self.CalcMainActivityZombies[ pl:GetZombieClass() ]( pl, vel ) end end
end

function GM:DoAnimationEvent( pl, event, data )	
	// Animation event handle for zombies
	if pl:Team() == 3 then if self.DoAnimationEventZombies[ pl:GetZombieClass() ] then return self.DoAnimationEventZombies[ pl:GetZombieClass() ]( pl, event, data ) end end
end

function timer.CreateEx(timername, delay, repeats, action, ...)
	if ... == nil then
		timer.Create(timername, delay, repeats, action)
	else
		local a, b, c, d, e, f, g, h, i, j, k = ...
		timer.Create(timername, delay, repeats, function() action(a, b, c, d, e, f, g, h, i, j, k) end)
	end
end