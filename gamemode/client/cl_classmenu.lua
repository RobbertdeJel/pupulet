
local w, h = ScrW(), ScrH()

local classmenuTable = {
	[ 1 ] = { normalColor = Color( 20, 20, 20, 255 ), hoverColor = Color( 0, 160, 0, 240 ), curColor = nil, posW = w * 0.05, posH = h * 0.05, img = "faces/avatar_sharpshooter.vtf", command = "SharpShooter",
	[ 0 ] = "Sharpshooter", [ 1 ] = "Great accuratsie.", [ 2 ] = "Faster then normal.", [ 3 ] = "Extra headshot damage.", [ 4 ] = "Starts with a p228 and a knife.", [ 5 ] = "Low starting ammo.", [ 6 ] = "Doest pack a punch..", },
	[ 2 ] = { normalColor = Color( 20, 20, 20, 255 ), hoverColor = Color( 0, 160, 0, 240 ), curColor = nil, posW = w * 0.20, posH = h * 0.05, img = "faces/avatar_support.vtf", command = "Support",
	[ 0 ] = "Support", [ 1 ] = "High Damage with shotguns.", [ 2 ] = "takes less damage.", [ 3 ] = "Extra ammo.", [ 4 ] = "Starts with a USP and a plank.", [ 5 ] = "Slower the usual.", [ 6 ] = "Takes extra damage from explosives.", },
	[ 3 ] = { normalColor = Color( 20, 20, 20, 255 ), hoverColor = Color( 0, 160, 0, 240 ), curColor = nil, posW = w * 0.35, posH = h * 0.05, img = "materials/entities/npc_combine_s.png", command = "Commando",
	[ 0 ] = "Commando", [ 1 ] = "High Damage with assualt rifles.", [ 2 ] = "takes less damage.", [ 3 ] = "Extra ammo from crates.", [ 4 ] = "Starts with a USP and a knife.", [ 5 ] = "Slower the usual.", [ 6 ] = "Less health from the crate.", }, 
	[ 4 ] = { normalColor = Color( 20, 20, 20, 255 ), hoverColor = Color( 0, 160, 0, 240 ), curColor = nil, posW = w * 0.50, posH = h * 0.05, img = "materials/entities/npc_monk.png", command = "Berserker",
	[ 0 ] = "Berserker", [ 1 ] = "High Damage with melee weapons.", [ 2 ] = "Leeches health with melee.", [ 3 ] = "Extra ammo from crates.", [ 4 ] = "Starts with a USP and a knife.", [ 5 ] = "Does less damage with guns.", [ 6 ] = "Get's no health from the crate.", },
	[ 5 ] = { normalColor = Color( 20, 20, 20, 255 ), hoverColor = Color( 0, 160, 0, 240 ), curColor = nil, posW = w * 0.65, posH = h * 0.05, img = "faces/avatar_medic.vtf", command = "Medic",
	[ 0 ] = "Medic", [ 1 ] = "High Damage with SMG's.", [ 2 ] = "Ability to heal people.", [ 3 ] = "Extra Health from the create.", [ 4 ] = "Starts with a p228 and a medkit.", [ 5 ] = "Takes more damage then usual.", [ 6 ] = "Slows down while healing.", }, 
	[ 6 ] = { normalColor = Color( 20, 20, 20, 255 ), hoverColor = Color( 0, 160, 0, 240 ), curColor = nil, posW = w * 0.80, posH = h * 0.05, img = "faces/avatar_engineer.vtf", command = "Engineer",
	[ 0 ] = "Engineer", [ 1 ] = "High Damage with Explosives.", [ 2 ] = "Takes less damage from explosives.", [ 3 ] = "Gains mines from the create.", [ 4 ] = "Starts with a p228 and mines.", [ 5 ] = "Takes more damage then usual.", [ 6 ] = "Slower then usual.", },
} 
  
local classDescriptiontext = {
	[ 0 ] = { color = Color( 255, 255, 255, 255 ), font = "menuDescFonttitle", text = "", posW = w * 0.28, posH = 0 },
	[ 1 ] = { color = Color( 255, 255, 255, 255 ), font = "menuDescFont", text = "", posW = w * 0.38, posH = h * 0.05 },
	[ 2 ] = { color = Color( 255, 255, 255, 255 ), font = "menuDescFont", text = "", posW = w * 0.38, posH = h * 0.08 },
	[ 3 ] = { color = Color( 255, 255, 255, 255 ), font = "menuDescFont", text = "", posW = w * 0.38, posH = h * 0.11 },
	[ 4 ] = { color = Color( 255, 255, 255, 255 ), font = "menuDescFont", text = "", posW = w * 0.38, posH = h * 0.14 },
	[ 5 ] = { color = Color( 255, 0, 0, 255 ), font = "menuDescFont", text = "", posW = w * 0.38, posH = h * 0.17 },
	[ 6 ] = { color = Color( 255, 0, 0, 255 ), font = "menuDescFont", text = "", posW = w * 0.38, posH = h * 0.20 },
} 

local spawnButtonTable = {
	normalColor = Color( 0, 0, 0, 230 ),
	backgroundColorNormal = Color( 80, 0, 0, 230 ),
	hoverColor = Color( 40, 40, 40, 255 ),
	backgroundColorHovered = Color( 0, 80, 0, 230 ),
	newColor = nil,
	newBackGroundColor = nil,
}

local saveDataDerma = {
	panelType = nil,
	oldColor = nil,
	command = nil,
}

usermessage.Hook( "OpenClassMenuHuman" , function()
		if ( w ~= ScrW() and h ~= ScrH() ) then 
		w = ScrW()
		h = ScrH()
	end
	local humanPanel = vgui.Create( "DFrame" )
	humanPanel:SetSize( w, h )
	humanPanel:Center()
	humanPanel:SetVisible( true )
	humanPanel:MakePopup()
	humanPanel:SetBackgroundBlur( true )
	humanPanel:SetDraggable( false )
	humanPanel:ShowCloseButton( false )
	humanPanel:SetTitle( "" )
	humanPanel.Paint = function()
		draw.RoundedBox( 0, 0, 0, humanPanel:GetWide(), humanPanel:GetTall(), Color( 20, 20, 20, 160 ) )
	end

	for i = 0, 6 do
		classDescriptiontext[ i ].text = ""
		if i > 0 then
			classmenuTable[ i ].curColor = classmenuTable[ i ].normalColor
			
			saveDataDerma.panelType = nil
			saveDataDerma.oldColor = nil
			saveDataDerma.command = nil
			
			local BottemPanel = vgui.Create( "DFrame", humanPanel )
				BottemPanel:SetSize( w * 0.14, w * 0.14 )
				BottemPanel:SetPos( classmenuTable[ i ].posW, classmenuTable[ i ].posH )
				BottemPanel:SetDraggable( false )
				BottemPanel:ShowCloseButton( false )
				BottemPanel:SetTitle( "" )
				BottemPanel.Paint = function()
					draw.RoundedBox( 4, 0, 0, BottemPanel:GetWide(), BottemPanel:GetTall(), classmenuTable[ i ].curColor )
					surface.SetDrawColor(  Color( 255, 255, 255, 255 )  ) 
					surface.SetMaterial( Material( classmenuTable[ i ].img ) )						
					surface.DrawTexturedRect( w * 0.005, w * 0.005, w * 0.13, w * 0.13 )  
				end
				BottemPanel.OnCursorEntered = function()
					if saveDataDerma.panelType == i then return end
						classmenuTable[ i ].curColor = classmenuTable[ i ].hoverColor
						surface.PlaySound( "buttonclickrelease.wav" )
				end
				BottemPanel.OnCursorExited = function()
					if saveDataDerma.panelType == i then return end
					classmenuTable[ i ].curColor = classmenuTable[ i ].normalColor
				end
				BottemPanel.OnMousePressed = function()
					saveDataDerma.command = classmenuTable[ i ].command 
					surface.PlaySound( "menu_accept.wav" )
					if saveDataDerma.panelType then
						if saveDataDerma.panelType ~= i then
							classmenuTable[ saveDataDerma.panelType ].curColor = classmenuTable[ saveDataDerma.panelType ].normalColor;
							saveDataDerma.oldColor = classmenuTable[ i ].normalColor;
							saveDataDerma.panelType = i;
						end
					else
						saveDataDerma.panelType = i
						saveDataDerma.oldColor = classmenuTable[ i ].normalColor
						colorNew = classmenuTable[ i ].hoverColor
					end
				for a = 0, 6 do
						classDescriptiontext[ a ].text = classmenuTable[ i ][ a ]
				end
			end
				
		end
	end
	
		local infoHumanPanel = vgui.Create( "DFrame", humanPanel )
			infoHumanPanel:SetSize( w * 0.65, h * 0.30 )
			infoHumanPanel:Center()
			infoHumanPanel:SetVisible( true )
			infoHumanPanel:SetDraggable( false ) 
			infoHumanPanel:ShowCloseButton( false )
			infoHumanPanel:SetTitle( "" )
			infoHumanPanel.Paint = function()
				draw.RoundedBox( 8, 0, 0, infoHumanPanel:GetWide(), infoHumanPanel:GetTall(), Color( 20, 20, 20, 235 ) )
				for i= 0, 6 do
						draw.SimpleText( classDescriptiontext[ i ].text, classDescriptiontext[ i ].font, classDescriptiontext[ i ].posW, classDescriptiontext[ i ].posH, classDescriptiontext[ i ].color )
				end 
			end
			
			spawnButtonTable.newBackGroundColor = spawnButtonTable.backgroundColorNormal
			local SpawnHumanPanelBackgound = vgui.Create( "DFrame", humanPanel )
				SpawnHumanPanelBackgound:SetSize( w * 0.30, h * 0.07 )
				SpawnHumanPanelBackgound:SetPos( w * 0.35, h - ( h * 0.10 ) ) 
				SpawnHumanPanelBackgound:SetVisible( true )
				SpawnHumanPanelBackgound:SetDraggable( false ) 
				SpawnHumanPanelBackgound:ShowCloseButton( false )
				SpawnHumanPanelBackgound:SetTitle( "" )
				SpawnHumanPanelBackgound.Paint = function()
					draw.RoundedBox( 4, 0, 0, SpawnHumanPanelBackgound:GetWide(), SpawnHumanPanelBackgound:GetTall(), spawnButtonTable.newBackGroundColor )
				end
				
				spawnButtonTable.newColor = spawnButtonTable.normalColor
				local SpawnHumanPanel = vgui.Create( "DButton", SpawnHumanPanelBackgound )
					SpawnHumanPanel:SetSize( w * 0.29, h * 0.06 )
					SpawnHumanPanel:Center()
					SpawnHumanPanel:SetText( "" )
					SpawnHumanPanel.Paint = function()
						draw.RoundedBox( 0, 0, 0, SpawnHumanPanel:GetWide(), SpawnHumanPanel:GetTall(), spawnButtonTable.newColor )
						draw.SimpleText( "Spawn!", "menuDescFonttitle", w * 0.11, h * 0.011, Color( 255, 255, 255, 255 ) ) 
					end
				SpawnHumanPanel.OnCursorEntered = function()
					spawnButtonTable.newBackGroundColor = spawnButtonTable.backgroundColorHovered;
					surface.PlaySound( "buttonclickrelease.wav" )
				end
				SpawnHumanPanel.OnCursorExited = function()
					spawnButtonTable.newBackGroundColor = spawnButtonTable.backgroundColorNormal;
					surface.PlaySound( "buttonclickrelease.wav" )
				end
				SpawnHumanPanel.OnMousePressed = function()
					surface.PlaySound( "menu_accept.wav" )
					if saveDataDerma.command then
						RunConsoleCommand( saveDataDerma.command )
						humanPanel:SetVisible( false )
						timer.Simple( 1, function()
							RunConsoleCommand( "SpawnAsHuman" )
						end )
					end
				end
end )



local w, h = ScrW(), ScrH()

local undeadRestInfo = {
	shadePanelColor = Color( 0, 0, 0, 120 ),
	fillerPanelColor = Color( 20, 20, 20, 180 ),
	undeadTextOne = "Select an undead class to destroy humanity!",
	undeadTextOneFont = "CloseCaption_Bold",
	undeadTextTwo = "Rise my minions, Rise!",
	undeadTextTwoFont = "Trebuchet24",
}


local classmenuTableZombies = {
	[ 1 ] = { normalColor = Color( 160, 20, 20, 255 ), hoverColor = Color( 0, 160, 0, 240 ), curColor = nil, posW = w * 0.075, posH = h * 0.30, img = "materials/entities/npc_zombie.png", command = "NormalZombie",
	[ 0 ] = "Normal zombie", [ 1 ] = "The backbone of the horde.", [ 2 ] = "We never seen it coming until it was to late.. this beast has the capability's to destroy everything we once loved" },
	[ 2 ] = { normalColor = Color( 160, 20, 20, 255 ), hoverColor = Color( 0, 160, 0, 240 ), curColor = nil, posW = w * 0.195, posH = h * 0.30, img = "materials/entities/npc_headcrab.png", command = "HeadCrab",
	[ 0 ] = "Headcrab", [ 1 ] = "The backbone of the horde.", [ 2 ] = "We never seen it coming until it was to late.. this beast has the capability's to destroy everything we once loved"},
	[ 3 ] = { normalColor = Color( 160, 20, 20, 255 ), hoverColor = Color( 0, 160, 0, 240 ), curColor = nil, posW = w * 0.315, posH = h * 0.30 , img = "materials/entities/npc_stalker.png", command = "Stalker",
	[ 0 ] = "Wraith", [ 1 ] = "The backbone of the horde.", [ 2 ] = "We never seen it coming until it was to late.. this beast has the capability's to destroy everything we once loved" }, 
	[ 4 ] = { normalColor = Color( 160, 20, 20, 255 ), hoverColor = Color( 0, 160, 0, 240 ), curColor = nil, posW = w * 0.435, posH = h * 0.30, img = "materials/entities/npc_fastzombie.png", command = "FastZombie",
	[ 0 ] = "Fast zombie", [ 1 ] = "The backbone of the horde.", [ 2 ] = "We never seen it coming until it was to late.. this beast has the capability's to destroy everything we once loved" },
	[ 5 ] = { normalColor = Color( 160, 20, 20, 255 ), hoverColor = Color( 0, 160, 0, 240 ), curColor = nil, posW = w * 0.555, posH = h * 0.30, img = "materials/entities/npc_headcrab_black.png", command = "PoisonCrab",
	[ 0 ] = "Poison headcrab", [ 1 ] = "The backbone of the horde.", [ 2 ] = "We never seen it coming until it was to late.. this beast has the capability's to destroy everything we once loved" }, 
	[ 6 ] = { normalColor = Color( 160, 20, 20, 255 ), hoverColor = Color( 0, 160, 0, 240 ), curColor = nil, posW = w * 0.675, posH = h * 0.30, img = "materials/entities/npc_poisonzombie.png"  , command = "PoisonZombie",
	[ 0 ] = "Poison Zombie", [ 1 ] = "The backbone of the horde.", [ 2 ] = "We never seen it coming until it was to late.. this beast has the capability's to destroy everything we once loved" },
	[ 7 ] = { normalColor = Color( 160, 20, 20, 255 ), hoverColor = Color( 0, 160, 0, 240 ), curColor = nil, posW = w * 0.795, posH = h * 0.30, img = "materials/entities/npc_zombine.png"  , command = "Zombine",
	[ 0 ] = "Zombine", [ 1 ] = "The backbone of the horde.", [ 2 ] = "We never seen it coming until it was to late.. this beast has the capability's to destroy everything we once loved" },
} 
  
local classDescriptiontextZombies = {
	[ 0 ] = { color = Color( 255, 255, 255, 255 ), font = "menuDescFonttitle", text = "", posW = w * 0.45, posH = h * 0.26 },
	[ 1 ] = { color = Color( 255, 255, 255, 255 ), font = "menuDescFont", text = "", posW = w * 0.10, posH = h * 0.32 },
	[ 2 ] = { color = Color( 255, 255, 255, 255 ), font = "menuDescFont", text = "", posW = w * 0.10, posH = h * 0.35 },
} 


local spawnButtonTableZombies = {
	normalColor = Color( 0, 0, 0, 230 ),
	backgroundColorNormal = Color( 80, 0, 0, 230 ),
	hoverColor = Color( 40, 40, 40, 255 ),
	backgroundColorHovered = Color( 0, 80, 0, 230 ),
	newColor = nil,
	newBackGroundColor = nil,
}

local saveDataDermaZombies = {
	panelType = nil,
	oldColor = nil,
	command = nil,
}

usermessage.Hook( "OpenZombieClasses" , function()
	

	if ( w ~= ScrW() and h ~= ScrH() ) then 
		w = ScrW()
		h = ScrH()
	end
	local humanPanel = vgui.Create( "DFrame" )
	humanPanel:SetSize( w, h )
	humanPanel:Center()
	humanPanel:SetVisible( true )
	humanPanel:MakePopup()
	humanPanel:SetBackgroundBlur( true )
	humanPanel:SetDraggable( false )
	humanPanel:ShowCloseButton( false )
	humanPanel:SetTitle( "" )
	humanPanel.Paint = function()
		draw.RoundedBox( 0, 0, 0, humanPanel:GetWide(), humanPanel:GetTall(), undeadRestInfo.shadePanelColor )
		surface.SetDrawColor(  Color( 220, 0, 0, 255 )  )   
		surface.SetMaterial( Material( "hud3/bloodbackground.png" ) )	 	
		surface.DrawTexturedRect( 0, 0, w, h )  
	end
	
	local classBackPanel = vgui.Create( "DFrame", humanPanel )
		classBackPanel:SetSize( w, h * 0.50 )
		classBackPanel:Center()
		classBackPanel:SetVisible( true )
		classBackPanel:SetDraggable( false )  
		classBackPanel:ShowCloseButton( false )
		classBackPanel:SetTitle( "" )
		classBackPanel.Paint = function()
			draw.RoundedBox( 0, 0, 0, classBackPanel:GetWide(), classBackPanel:GetTall(), undeadRestInfo.fillerPanelColor )
			for i= 0, 2 do
					draw.SimpleText( classDescriptiontextZombies[ i ].text, classDescriptiontextZombies[ i ].font, classDescriptiontextZombies[ i ].posW, classDescriptiontextZombies[ i ].posH, classDescriptiontextZombies[ i ].color )
			end
		end
		
	local topBackroundPanel = vgui.Create( "DFrame", humanPanel )
		topBackroundPanel:SetSize( w, h * 0.20 )
		topBackroundPanel:SetPos( 0, 0 )
		topBackroundPanel:SetVisible( true )
		topBackroundPanel:SetDraggable( false ) 
		topBackroundPanel:ShowCloseButton( false )
		topBackroundPanel:SetTitle( "" )
		topBackroundPanel.Paint = function()
			draw.RoundedBox( 0, 0, 0, topBackroundPanel:GetWide(), topBackroundPanel:GetTall(), undeadRestInfo.fillerPanelColor )
			draw.SimpleText( undeadRestInfo.undeadTextOne, undeadRestInfo.undeadTextOneFont, w*0.04, h*0.05, Color( 255, 255, 255, 255 ) )
			draw.SimpleText( undeadRestInfo.undeadTextTwo, undeadRestInfo.undeadTextTwoFont, w*0.04, h*0.09, Color( 255, 255, 255, 255 ) )
		end
		
	local bottomBackgroundPanel = vgui.Create( "DFrame", humanPanel )
		bottomBackgroundPanel:SetSize( w, h * 0.20 )
		bottomBackgroundPanel:SetPos( 0, h - ( h * 0.20 ) )
		bottomBackgroundPanel:SetVisible( true )
		bottomBackgroundPanel:SetDraggable( false ) 
		bottomBackgroundPanel:ShowCloseButton( false )
		bottomBackgroundPanel:SetTitle( "" )
		bottomBackgroundPanel.Paint = function()
			draw.RoundedBox( 0, 0, 0, bottomBackgroundPanel:GetWide(), bottomBackgroundPanel:GetTall(), undeadRestInfo.fillerPanelColor )
		end

	for i = 0, 7 do
		if i < 3 then
			classDescriptiontextZombies[ i ].text = ""
		end
		if i > 0 then
			classmenuTableZombies[ i ].curColor = classmenuTableZombies[ i ].normalColor
			saveDataDermaZombies.panelType = nil
			saveDataDermaZombies.oldColor = nil
			saveDataDermaZombies.command = nil
			
			local BottemPanel = vgui.Create( "DFrame", humanPanel )
				BottemPanel:SetSize( w * 0.11, w * 0.11 )
				BottemPanel:SetPos( classmenuTableZombies[ i ].posW, classmenuTableZombies[ i ].posH )
				BottemPanel:SetDraggable( false )
				BottemPanel:ShowCloseButton( false )
				BottemPanel:SetTitle( "" )
				BottemPanel.Paint = function()
					draw.RoundedBox( 4, 0, 0, BottemPanel:GetWide(), BottemPanel:GetTall(), classmenuTableZombies[ i ].curColor )
					surface.SetDrawColor(  Color( 255, 255, 255, 255 )  ) 
					surface.SetMaterial( Material( classmenuTableZombies[ i ].img ) )						
					surface.DrawTexturedRect( w * 0.005, w * 0.005, w * 0.10, w * 0.10 )  
				end
				BottemPanel.OnCursorEntered = function()
					if saveDataDermaZombies.panelType == i then return end
						classmenuTableZombies[ i ].curColor = classmenuTableZombies[ i ].hoverColor
						surface.PlaySound( "pupuletsound/buttonclickrelease.wav" )
				end
				BottemPanel.OnCursorExited = function()
					if saveDataDermaZombies.panelType == i then return end
					classmenuTableZombies[ i ].curColor = classmenuTableZombies[ i ].normalColor
				end
				BottemPanel.OnMousePressed = function()
					saveDataDermaZombies.command = classmenuTableZombies[ i ].command 
					surface.PlaySound( "pupuletsound/menu_accept.wav" )
					if saveDataDermaZombies.panelType then
						if saveDataDermaZombies.panelType ~= i then
							classmenuTableZombies[ saveDataDermaZombies.panelType ].curColor = classmenuTableZombies[ saveDataDermaZombies.panelType ].normalColor;
							saveDataDermaZombies.oldColor = classmenuTableZombies[ i ].normalColor;
							saveDataDermaZombies.panelType = i;
						end
					else
						saveDataDermaZombies.panelType = i
						saveDataDermaZombies.oldColor = classmenuTableZombies[ i ].normalColor
						colorNew = classmenuTableZombies[ i ].hoverColor
					end
				for a = 0, 2 do
						classDescriptiontextZombies[ a ].text = classmenuTableZombies[ i ][ a ]
				end
			end
				
		end
	end
	
			
			spawnButtonTableZombies.newBackGroundColor = spawnButtonTableZombies.backgroundColorNormal
			local SpawnHumanPanelBackgound = vgui.Create( "DFrame", bottomBackgroundPanel )
				SpawnHumanPanelBackgound:SetSize( w * 0.30, h * 0.05 )
				SpawnHumanPanelBackgound:SetPos( w * 0.35 , h * 0.10 )
				SpawnHumanPanelBackgound:SetVisible( true )
				SpawnHumanPanelBackgound:SetDraggable( false ) 
				SpawnHumanPanelBackgound:ShowCloseButton( false )
				SpawnHumanPanelBackgound:SetTitle( "" )
				SpawnHumanPanelBackgound.Paint = function()
					draw.RoundedBox( 4, 0, 0, SpawnHumanPanelBackgound:GetWide(), SpawnHumanPanelBackgound:GetTall(), spawnButtonTableZombies.newBackGroundColor )
				end
				
				spawnButtonTableZombies.newColor = spawnButtonTableZombies.normalColor
				local SpawnHumanPanel = vgui.Create( "DButton", SpawnHumanPanelBackgound )
					SpawnHumanPanel:SetSize( w * 0.29, h * 0.04 )
					SpawnHumanPanel:Center()
					SpawnHumanPanel:SetText( "" )
					SpawnHumanPanel.Paint = function()
						draw.RoundedBox( 0, 0, 0, SpawnHumanPanel:GetWide(), SpawnHumanPanel:GetTall(), spawnButtonTableZombies.newColor )
						draw.SimpleText( "Spawn!", "Trebuchet24", w * 0.115, h * 0.008, Color( 255, 255, 255, 255 ) ) 
					end
				SpawnHumanPanel.OnCursorEntered = function()
					spawnButtonTableZombies.newBackGroundColor = spawnButtonTableZombies.backgroundColorHovered;
					surface.PlaySound( "buttonclickrelease.wav" )
				end
				SpawnHumanPanel.OnCursorExited = function()
					spawnButtonTableZombies.newBackGroundColor = spawnButtonTableZombies.backgroundColorNormal;
					surface.PlaySound( "buttonclickrelease.wav" )
				end
				SpawnHumanPanel.OnMousePressed = function()
					surface.PlaySound( "menu_accept.wav" )
					if saveDataDermaZombies.command then
						RunConsoleCommand( saveDataDermaZombies.command )
						humanPanel:SetVisible( false )
					end
				end
end )


