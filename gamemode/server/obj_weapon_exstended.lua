local META = FindMetaTable("Weapon")
if not META then return end


function META:GetRandomeWeaponSkin()
	return self.SkinTextColor 
end


function META:GetSkinRaretyFromServer()
	return 1
end


function META:GetSkinTypeFromServer()
	return 15
end

