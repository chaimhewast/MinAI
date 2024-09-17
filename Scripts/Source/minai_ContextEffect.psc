scriptname minai_ContextEffect extends ActiveMagicEffect


minai_Sex sex
minai_Survival survival
minai_Arousal arousal
minai_DeviousStuff devious
minai_AIFF aiff

Function OnEffectStart(Actor target, Actor caster)
  actor akTarget = GetTargetActor()
  aiff = Game.GetFormFromFile(0x0802, "MinAI.esp") as minai_AIFF
  if (!target || !aiff || !aiff.IsInitialized())
    return
  EndIf
  string targetName = akTarget.GetActorBase().GetName()
  Debug.Trace("[minai (DEBUG)]: OnEffectStart(" + targetName +") START")
  if AIAgentFunctions.getAgentByName(targetName)
    Debug.Trace("- Updating context for managed NPC: " + targetName)
    ; sex = (Self as Quest) as minai_Sex
    aiff.SetContext(akTarget)
    RegisterForSingleUpdate(aiff.ContextUpdateInterval)
  ElseIf akTarget
    ; Store voice types even if they're not a managed actor so that they will immediately have voices when spoken to
    aiff.StoreActorVoice(akTarget)
    ; Store factions and keywords for the same reason
    ; aiff.StoreFactions(akTarget)
    ; aiff.StoreKeywords(akTarget)
  EndIf
  Debug.Trace("[minai (DEBUG)]: OnEffectStart(" + targetName +") END")
EndFunction


Event OnUpdate()
  actor akTarget = GetTargetActor()
  if(!aiff || !akTarget.Is3DLoaded())
    UnregisterForUpdate()
    return
  endif
  Debug.Trace("- Updating context for managed NPC: " + akTarget.GetDisplayName())
  aiff.SetContext(akTarget)
  RegisterForSingleUpdate(aiff.ContextUpdateInterval)
EndEvent