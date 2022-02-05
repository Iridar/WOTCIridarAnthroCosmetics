class X2DLCInfo_AnthroCosmetics extends X2DownloadableContentInfo;

static function UpdateHumanPawnMeshComponent(XComGameState_Unit UnitState, XComHumanPawn Pawn, MeshComponent MeshComp)
{
	local MaterialInstanceConstant	MIC;
	local MaterialInstanceConstant	ParentMIC;
	local int Idx;

	// Proceed only if the unit has an anthro head
	if (InStr(string(Pawn.m_kAppearance.nmHead), "IRI_AnthroHead_") == INDEX_NONE)
	{
		return;
	}

	//`LOG("MeshComp:" @ MeshComp.ObjectArchetype,, 'IRITEST');

	// Replace instances of skin materials with the one using furry skin texture.
	for (Idx = 0; Idx < MeshComp.GetNumElements(); Idx++)
	{
		MIC = MaterialInstanceConstant(MeshComp.GetMaterial(Idx));
		if (MIC == none || MIC.Parent == none)
			continue;

		ParentMIC = MaterialInstanceConstant(MIC.Parent);
		if (ParentMIC == none || ParentMIC.Parent == none)
			continue;
		
		if (MIC != none && MIC.Parent != none && PathName(ParentMIC.Parent) == "Materials.Approved.SkinCustomizable_TC") // This check catches all materials using skin material as their parent.
		{				
			if (InStr(PathName(MIC.Parent), "Arm") != INDEX_NONE)
			{
				if (InStr(string(Pawn.m_kAppearance.nmHead), "RatHead") != INDEX_NONE)
				{
					`LOG("Replacing arm skin material with rat skin",, 'IRITEST');
					MeshComp.SetMaterial(Idx, MaterialInstanceConstant(`CONTENT.RequestGameArchetype("IRI_Anthro_Common.Materials.Rat_Skin_Arms")));
				}
				else
				{
					`LOG("Replacing arm skin material with fur skin",, 'IRITEST');
					MeshComp.SetMaterial(Idx, MaterialInstanceConstant(`CONTENT.RequestGameArchetype("IRI_Anthro_Common.Materials.Anthro_Skin_Arms")));
				}
			}
		}
	}
}

