BEGIN ~WTPFAMP3~

IF ~ReputationLT(%famsummoner%,3)Global("WTPFAMLG","GLOBAL",2)~ THEN BEGIN famgo_rept
   SAY @28
   IF ~~ THEN DO ~ChangeEnemyAlly(Myself,NEUTRAL)SetGlobal("#GFAMGO","GLOBAL",1)~ EXIT
END

IF ~Global("#GHARAS","GLOBAL",2)~ THEN BEGIN famharas1
   SAY @22
   IF ~Global("#GMIRPEN","GLOBAL",0)~ THEN DO ~IncrementGlobal("#GHARAS","GLOBAL",1)SetGlobal("#GMIRPEN","GLOBAL",1)SetGlobalTimer("#GFAMHAR","GLOBAL",7200)~ EXIT
   IF ~GlobalGT("#GMIRPEN","GLOBAL",0)~ THEN DO ~IncrementGlobal("#GHARAS","GLOBAL",1)SetGlobalTimer("#GFAMHAR","GLOBAL",7200)~ EXIT
END

IF ~Global("#GHARAS","GLOBAL",5)~ THEN BEGIN famharas2
   SAY @23
   IF ~GlobalLT("#GMIRPEN","GLOBAL",2)~ THEN DO ~IncrementGlobal("#GHARAS","GLOBAL",1)SetGlobal("#GMIRPEN","GLOBAL",2)SetGlobalTimer("#GFAMHAR","GLOBAL",14400)~ EXIT
   IF ~Global("#GMIRPEN","GLOBAL",2)~ THEN DO ~IncrementGlobal("#GHARAS","GLOBAL",1)SetGlobalTimer("#GFAMHAR","GLOBAL",14400)~ EXIT
END

IF ~Global("#GHARAS","GLOBAL",8)~ THEN BEGIN famgo_haras
   SAY @24
   IF ~~ THEN DO ~ChangeEnemyAlly(Myself,NEUTRAL)SetGlobal("#GFAMGO","GLOBAL",1)~ EXIT
END

IF ~Global("#GINPACK","GLOBAL",1)~ THEN BEGIN faminpack1
   SAY @12
   IF ~~ THEN DO ~IncrementGlobal("#GINPACK","GLOBAL",1)SetGlobalTimer("#GWANOUT","GLOBAL",120)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~Global("#GINPACK","GLOBAL",3)~ THEN BEGIN faminpack2
   SAY @13
   IF ~~ THEN DO ~IncrementGlobal("#GINPACK","GLOBAL",1)SetGlobalTimer("#GWANOUT","GLOBAL",90)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~Global("#GINPACK","GLOBAL",5)~ THEN BEGIN faminpack3
   SAY @14
   IF ~~ THEN DO ~IncrementGlobal("#GINPACK","GLOBAL",1)SetGlobalTimer("#GWANOUT","GLOBAL",60)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~!InPartySlot(LastTalkedToBy,0)~ THEN BEGIN famshy
  SAY #58356 /* ~The small creature looks at you with suspicion, and after a moment's inspection, it turns and gives you full view of its rear while it strolls to <CHARNAME>.~ */
  IF ~~ THEN DO ~MoveToObject(%famsummoner%)ClearActions(Myself)~ EXIT
END

IF ~InPartySlot(LastTalkedToBy,0)~ THEN BEGIN famtalk
  SAY #58357 /* ~The familiar sighs, its nose twitching slightly with curiosity as it looks up with dark eyes. "What is it now, <PRO_MANWOMAN>? I am hungry. I wish to be petted and fed."~ */
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!GlobalsEqual("#GFAMLVL","#GPLALVL")~ THEN REPLY @20 GOTO famlevelup
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMLN","GLOBAL",2)!GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #58358 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO fam1intopack
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMLG","GLOBAL",2)!GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #58872 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO fam2intopack
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMCN","GLOBAL",2)!GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #58873 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO fam3intopack
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #58873 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO famnotpack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMLN","GLOBAL",2)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,30)%IsInBG1%~ THEN REPLY @26 GOTO fam1hurt_intopack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMLN","GLOBAL",2)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,45)%IsInSoA%~ THEN REPLY @26 GOTO fam1hurt_intopack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMLN","GLOBAL",2)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,60)%IsInToB%~ THEN REPLY @26 GOTO fam1hurt_intopack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMLG","GLOBAL",2)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,30)%IsInBG1%~ THEN REPLY @26 GOTO fam2hurt_intopack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMLG","GLOBAL",2)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,45)%IsInSoA%~ THEN REPLY @26 GOTO fam2hurt_intopack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMLG","GLOBAL",2)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,60)%IsInToB%~ THEN REPLY @26 GOTO fam2hurt_intopack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMCN","GLOBAL",2)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,30)%IsInBG1%~ THEN REPLY @26 GOTO fam3hurt_intopack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMCN","GLOBAL",2)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,45)%IsInSoA%~ THEN REPLY @26 GOTO fam3hurt_intopack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMCN","GLOBAL",2)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,60)%IsInToB%~ THEN REPLY @26 GOTO fam3hurt_intopack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)HPPercentGT(Myself,50)HPPercentGT(%famsummoner%,30)%IsInBG1%~ THEN REPLY @26 GOTO famhurt_notpack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)HPPercentGT(Myself,50)HPPercentGT(%famsummoner%,45)%IsInSoA%~ THEN REPLY @26 GOTO famhurt_notpack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)HPPercentGT(Myself,50)HPPercentGT(%famsummoner%,60)%IsInToB%~ THEN REPLY @26 GOTO famhurt_notpack
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))~ THEN REPLY #58360 /* ~(pet the familiar)~ */ GOTO fampet
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!HPPercentLT(Myself,100)~ THEN REPLY #73442 /* ~(feed the familiar)~ */ GOTO famfeed_full
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))HPPercentLT(Myself,100)~ THEN REPLY #73443 /* ~(feed the familiar)~ */ GOTO famfeed_hurt
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))%IsInBG1%~ THEN REPLY #58383 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO bg1_advice
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))%IsInSoA%~ THEN REPLY #58383 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO soa_advice
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))%IsInToB%~ THEN REPLY #58383 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO tob_advice
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))~ THEN REPLY #58384 /* ~How are you?  Everything okay down there?~ */ GOTO famstatus
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))~ THEN REPLY #59804 /* ~Give me anything you have pickpocketed, will you?~ */ GOTO famloot
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))Global("#GAFTER","GLOBAL",0)~ THEN REPLY @16 GOTO famclose
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))Global("#GAFTER","GLOBAL",1)~ THEN REPLY @17 GOTO famroam
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!Global("WTPFAMLG","GLOBAL",2)OR(2)ReputationGT(%famsummoner%,15)ReputationLT(%famsummoner%,6)~ THEN REPLY #58385 /* ~Perhaps later.  Let's just keep going.~ */ GOTO fam1complain
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!Global("WTPFAMLG","GLOBAL",2)ReputationLT(%famsummoner%,13)ReputationGT(%famsummoner%,7)~ THEN REPLY #58385 /* ~Perhaps later.  Let's just keep going.~ */ GOTO fam1happy
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!Global("WTPFAMLG","GLOBAL",2)!ReputationGT(%famsummoner%,15)!ReputationLT(%famsummoner%,6)!Reputation(%famsummoner%,8)!Reputation(%famsummoner%,9)!Reputation(%famsummoner%,10)!Reputation(%famsummoner%,11)!Reputation(%famsummoner%,12)~ THEN REPLY #58385 /* ~Perhaps later.  Let's just keep going.~ */ GOTO famneutral
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))Global("WTPFAMLG","GLOBAL",2)ReputationGT(%famsummoner%,16)~ THEN REPLY #58385 /* ~Perhaps later.  Let's just keep going.~ */ GOTO fam2happy
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))Global("WTPFAMLG","GLOBAL",2)!ReputationGT(%famsummoner%,16)~ THEN REPLY #58385 /* ~Perhaps later.  Let's just keep going.~ */ GOTO famneutral
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))~ THEN REPLY @31 GOTO famfight
END

IF ~~ THEN BEGIN fam1intopack
  SAY #58359 /* ~The familiar eyes your pack, and then reluctantly crawls inside. "Very well. It is better that you carry me. Do not bump me around so much this time."~ */
  IF ~~ THEN DO ~SetGlobal("#GEMPCHA","GLOBAL",1)SetGlobal("#GSKIRES","GLOBAL",1)GivePartyAllEquipment()ReallyForceSpellRES("wtpclear",Myself)Wait(1)GiveItemCreate("wtpfmfer",%famsummoner%,0,0,0)SetGlobalTimer("#GWANOUT","GLOBAL",300)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~~ THEN BEGIN fampet
  SAY #58361 /* ~"Aahhhh..."  The familiar half-closes its eyes with contentment, a pleased smile creeping across its face.  "Yes, this is good.  Food would also be nice."~ */
  IF ~!GlobalsEqual("#GFAMLVL","#GPLALVL")~ THEN REPLY @20 GOTO famlevelup
  IF ~!InventoryFull(%famsummoner%)Global("WTPFAMLN","GLOBAL",2)!GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #58362 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO fam1intopack
  IF ~!InventoryFull(%famsummoner%)Global("WTPFAMLG","GLOBAL",2)!GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #59478 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO fam2intopack
  IF ~!InventoryFull(%famsummoner%)Global("WTPFAMCN","GLOBAL",2)!GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #59479 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO fam3intopack
  IF ~!InventoryFull(%famsummoner%)GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #58873 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO famnotpack
  IF ~%IsInBG1%~ THEN REPLY #58363 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO bg1_advice
  IF ~%IsInSoA%~ THEN REPLY #58363 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO soa_advice
  IF ~%IsInToB%~ THEN REPLY #58363 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO tob_advice
  IF ~~ THEN REPLY #58373 /* ~How are you?  Everything okay down there?~ */ GOTO famstatus
  IF ~~ THEN REPLY #59812 /* ~Give me anything you have pickpocketed, will you?~ */ GOTO famloot_pet
  IF ~Global("#GAFTER","GLOBAL",0)~ THEN REPLY @16 GOTO famclose
  IF ~Global("#GAFTER","GLOBAL",1)~ THEN REPLY @17 GOTO famroam
  IF ~!Global("WTPFAMLG","GLOBAL",2)OR(2)ReputationGT(%famsummoner%,16)ReputationLT(%famsummoner%,5)~ THEN REPLY #58381 /* ~Let's just keep going, then.~ */ GOTO fam1complain
  IF ~!Global("WTPFAMLG","GLOBAL",2)ReputationLT(%famsummoner%,12)ReputationGT(%famsummoner%,8)~ THEN REPLY #58381 /* ~Let's just keep going, then.~ */GOTO fam1happy
  IF ~!Global("WTPFAMLG","GLOBAL",2)!ReputationGT(%famsummoner%,16)!ReputationLT(%famsummoner%,5)!Reputation(%famsummoner%,9)!Reputation(%famsummoner%,10)!Reputation(%famsummoner%,11)~ THEN REPLY #58381 /* ~Let's just keep going, then.~ */ GOTO famneutral
  IF ~Global("WTPFAMLG","GLOBAL",2)ReputationGT(%famsummoner%,16)~ THEN REPLY #58381 /* ~Let's just keep going, then.~ */ GOTO fam2happy
  IF ~Global("WTPFAMLG","GLOBAL",2)!ReputationGT(%famsummoner%,16)~ THEN REPLY #58381 /* ~Let's just keep going, then.~ */ GOTO famneutral
END

IF ~~ THEN BEGIN soa_advice
  SAY #58364 /* ~The animal looks at you, fairly close to bewildered. "Me? I suppose I have thoughts that it would amuse me to share, but would you even regard them, <PRO_MANWOMAN>?"~ */
  IF ~Global("chapter","GLOBAL",%bg2_chapter_1%)AreaType(DUNGEON)~ THEN GOTO soa_advice_ch1_dungeon
  IF ~Global("chapter","GLOBAL",%bg2_chapter_1%)!AreaType(DUNGEON)~ THEN GOTO soa_advice_ch1_promenade
  IF ~Global("chapter","GLOBAL",%bg2_chapter_2%)~ THEN GOTO soa_advice_ch2
  IF ~Global("chapter","GLOBAL",%bg2_chapter_3%)~ THEN GOTO soa_advice_ch3
  IF ~Global("chapter","GLOBAL",%bg2_chapter_4%)~ THEN GOTO soa_advice_ch4
  IF ~Global("chapter","GLOBAL",%bg2_chapter_5%)~ THEN GOTO soa_advice_ch5
  IF ~Global("chapter","GLOBAL",%bg2_chapter_6%)~ THEN GOTO soa_advice_ch6
  IF ~Global("chapter","GLOBAL",%bg2_chapter_7%)~ THEN GOTO soa_advice_ch7
END

IF ~~ THEN BEGIN soa_advice_ch1_dungeon
  SAY #58365 /* ~Looking about at the darkness, the familiar turns back with a shrug. "I would say let us be off to the surface, <PRO_MANWOMAN>. Surely food is more plentiful there."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch1_promenade
  SAY #58366 /* ~It looks about for several moments, watching various city animals and people. It finally turns back, almost startled. "What? Advice? Ah...no. No advice."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch2
  SAY #58367 /* ~The little animal thinks to itself for a few moments and then saunters away, presenting its tail and bum to you.  Apparently, it has tired of thinking.~ */
  IF ~~ THEN DO ~RunAwayFrom(LastTalkedToBy,5)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch3
  SAY #58368 /* ~It thinks for a long moment and then seems to drift off, yawning widely. It stares, blinking several times. "Feed me, and then pet me some more. That is my advice."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch4
  SAY #58369 /* ~"Let's see...the wizard is behind all your trials, yes? Then it is easy, <PRO_MANWOMAN>. Find him, kill him, and your troubles are no more. Now will you feed me, yes?"~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch5
  SAY #58370 /* ~It looks about balefully, its ears folding back against its head in fear. "This...is a place where I am food. I do not like this place. We should go elsewhere."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch6
  SAY #58371 /* ~"Hmm, the elven city has the Tree of Life within, <PRO_MANWOMAN>, a wondrous thing connected to all that is natural. You must find the city and the Tree. That is my advice."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch7
  SAY @10 /* ~As it thinks, its eyes glow red with uncharacteristic ferocity. "There is only one solution, <PRO_MANWOMAN>. For you to survive, the wizard must die. That is how it must be."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famstatus
  SAY #58374 /* ~It looks up with dark eyes, seemingly content to just be near you. It sighs and looks away briefly. "We are connected, you and I. If you are well, so am I."~ */
  IF ~HPPercentLT(Myself,100)!HPPercentLT(Myself,50)~ THEN GOTO famhurt_light
  IF ~HPPercentLT(Myself,50)~ THEN GOTO famhurt_bad
  IF ~!HPPercentLT(Myself,100)RandomNum(4,1)~ THEN GOTO famokay1
  IF ~!HPPercentLT(Myself,100)RandomNum(4,2)~ THEN GOTO famokay2
  IF ~!HPPercentLT(Myself,100)RandomNum(4,3)~ THEN GOTO famokay3
  IF ~!HPPercentLT(Myself,100)RandomNum(4,4)~ THEN GOTO famokay4
END

IF ~~ THEN BEGIN famhurt_light
  SAY #58375 /* ~"But I, myself, have a few insignificant injuries. I am strengthened because you are stronger than I. If you could treat my wounds, it would please me."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famhurt_bad
  SAY @11 /* ~"But I, myself, am hurt very badly.  I bleed, <PRO_MANWOMAN>.  I may survive, or I may not... we shall see."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famokay1
  SAY #58377 /* ~"But since you ask, I am possessed of a craving for food.  Procure some for me and I shall allow you to pet me for a while longer."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famokay2
  SAY #58378 /* ~"But I think you are a good enough traveling companion. I am pleased with the progress we make. Perhaps I shall remain with you for some time to come, we shall see."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famokay3
  SAY #58379 /* ~The small animal seems to ponder saying something else, but eventually its attention drifts and it finds something more interesting than you elsewhere.  Walking away, it presents its tail and bum to you.~ */
  IF ~~ THEN DO ~RunAwayFrom(LastTalkedToBy,10)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famokay4
  SAY #58380 /* ~"But all is well enough, <PRO_MANWOMAN>.  Why?  Are you not well?  You will not sicken and die on me, <PRO_MANWOMAN>, would you?  If you did it would sadden me, for a while."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famneutral
  SAY #58382 /* ~The familiar sighs and turns its eyes disinterestedly to the path before you.  "I would prefer to choose our path, myself, but you'll no doubt want to be stubborn."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN fam2intopack
  SAY #58874 /* ~The familiar eyes your pack for a moment, and then reluctantly crawls inside.  "Very well.  It is better that you carry me.  Do not bump me around so much, this time, however."~ */
  IF ~~ THEN DO ~SetGlobal("#GEMPCHA","GLOBAL",1)SetGlobal("#GSKIRES","GLOBAL",1)GivePartyAllEquipment()ReallyForceSpellRES("wtpclear",Myself)Wait(1)GiveItemCreate("wtpfmrab",%famsummoner%,0,0,0)SetGlobalTimer("#GWANOUT","GLOBAL",300)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~~ THEN BEGIN fam3intopack
  SAY #58875 /* ~The familiar eyes your pack for a moment, and then reluctantly crawls inside.  "Very well.  It is better that you carry me.  Do not bump me around so much, this time, however."~ */
  IF ~~ THEN DO ~SetGlobal("#GEMPCHA","GLOBAL",1)SetGlobal("#GSKIRES","GLOBAL",1)GivePartyAllEquipment()ReallyForceSpellRES("wtpclear",Myself)Wait(1)GiveItemCreate("wtpfmcat",%famsummoner%,0,0,0)SetGlobalTimer("#GWANOUT","GLOBAL",300)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~~ THEN BEGIN famloot
  SAY #59805 /* ~The familiar eyes you suspiciously.  "But when I take things they belong to me."~ */
  IF ~~ THEN REPLY #59806 /* ~Never mind that.  Hand it over.~ */ GOTO famloot_demand
  IF ~~ THEN REPLY #59807 /* ~Pretty please?  I'll feed you and pet you...~ */ GOTO famloot_pet
  IF ~~ THEN REPLY #59808 /* ~Oh, never mind, then.~ */ GOTO famloot_bye
END

IF ~~ THEN BEGIN famloot_demand
  SAY #59809 /* ~The small animal rolls its eyes and sighs petulantly.  "Fine.  But you are very cruel to me, you know."~ */
  IF ~~ THEN DO ~GivePartyAllEquipment()ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famloot_pet
  SAY #59810 /* ~The small animal twitches its tail, pondering.  "Well... perhaps.  But I would not put it past you not to keep your word.  (sigh)  Oh, very well.  It amuses me when you beg."~ */
  IF ~~ THEN DO ~GivePartyAllEquipment()ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famloot_bye
  SAY #59811 /* ~"As it should be.  I earned it, after all."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famloot_pet
  SAY #59813 /* ~"(sigh)  Very well.  Although next time don't expect such co-operation just from a few seconds of petting."~ */
  IF ~~ THEN DO ~GivePartyAllEquipment()ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN tob_advice
  SAY #72593 /* ~The animal looks at you, fairly close to bewildered. "Me? I suppose I have thoughts that it would amuse me to share, but would you even regard them, <PRO_MANWOMAN>?"~ */
  IF ~True()~ THEN EXIT
  IF ~Global("chapter","GLOBAL",%bg2_chapter_8%)~ THEN GOTO tob_advice_ch8
  IF ~Global("chapter","GLOBAL",%bg2_chapter_9%)~ THEN GOTO tob_advice_ch9
  IF ~Global("chapter","GLOBAL",%bg2_chapter_10%)~ THEN GOTO tob_advice_ch10
END

IF ~~ THEN BEGIN tob_advice_ch8
  SAY #72700 /* ~The little animal shrugs, bored.  "I do not know what advice to give.  The wizard is dead, you have your soul... can you not just leave?"  It yawns widely.  "Maybe build an army.  Isn't that what you do?"~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN tob_advice_ch9
  SAY #72701 /* ~It blinks several times, thinking hard.  "It...seems to me that there is a reason that all the children of Bhaal are coming together.  You must end it, I think."  It grins suddenly.  "And, of course, you must win!"~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN tob_advice_ch10
  SAY #72702 /* ~"The only answer must be obvious...you must find this female who has lied to you and kill her!  You must travel to the Abyss and her life must be ended!"  It shrugs.  "Or, at least, that's what I would do."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famfeed_full
  SAY #73444 /* ~You scrounge up some food from your pack and offer it to the creature.  It seems pleased and nibbles away contentedly, pausing every now and again to grin at you.  "Thank you, my <PRO_LADYLORD>."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famfeed_hurt
  SAY #73445 /* ~The little creature seems ravenous and digs into the food you offer immediately.  Its wounds begin to close before your eyes.  The pleased familiar grins at you repeatedly.  "Many thanks, my <PRO_LADYLORD>!"~ */
  IF ~~ THEN DO ~ApplySpell(Myself,CLERIC_CURE_MEDIUM_WOUNDS)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bg1_advice
  SAY #58364 /* ~The animal looks at you, fairly close to bewildered. "Me? I suppose I have thoughts that it would amuse me to share, but would you even regard them, <PRO_MANWOMAN>?"~ */
  IF ~Global("chapter","GLOBAL",%bg1_chapter_0%)~ THEN GOTO bgt1_advice_prologue
  IF ~Global("chapter","GLOBAL",%bg1_chapter_1%)~ THEN GOTO bgt1_advice_ch1
  IF ~Global("chapter","GLOBAL",%bg1_chapter_2%)~ THEN GOTO bgt1_advice_ch2
  IF ~Global("chapter","GLOBAL",%bg1_chapter_3%)~ THEN GOTO bgt1_advice_ch3
  IF ~Global("chapter","GLOBAL",%bg1_chapter_4%)~ THEN GOTO bgt1_advice_ch4
  IF ~Global("chapter","GLOBAL",%bg1_chapter_5%)%InBGAreaCheck%~ THEN GOTO bgt1_advice_ch5bg
  IF ~Global("chapter","GLOBAL",%bg1_chapter_5%)%NotInBGAreaCheck%~ THEN GOTO bgt1_advice_ch5
  IF ~Global("chapter","GLOBAL",%bg1_chapter_6%)!Global("Teth","Global",1)~ THEN GOTO bgt1_advice_ch6
  IF ~Global("chapter","GLOBAL",%bg1_chapter_6%)Global("Teth","Global",1)~ THEN GOTO bgt1_advice_ch6teth
  IF ~Global("chapter","GLOBAL",%bg1_chapter_7%)~ THEN GOTO bgt1_advice_ch7
END

IF ~~ THEN BEGIN bgt1_advice_prologue
  SAY @0 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch1
  SAY @1 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch2
  SAY @2 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch3
  SAY @3 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch4
  SAY @4 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch5bg
  SAY @5 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch5
  SAY @6 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch6
  SAY @7 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch6teth
  SAY @8 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch7
  SAY @9 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famnotpack
  SAY @15 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famclose
  SAY @18 /* ~~ */
  IF ~~ THEN DO ~SetGlobal("#GAFTER","GLOBAL",1)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famroam
  SAY @19 /* ~~ */
  IF ~~ THEN DO ~SetGlobal("#GAFTER","GLOBAL",0)RunAwayFrom(%famsummoner%,45)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famlevelup
  SAY @21 /* ~~ */
  IF ~~ THEN DO ~SetGlobal("#GAFTER","GLOBAL",0)SetGlobal("#GFLVUP","GLOBAL",1)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN fam1complain
  SAY @25 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN fam1hurt_intopack
  SAY @27 /* ~~ */
  IF ~~ THEN DO ~SetGlobal("#GEMPCHA","GLOBAL",1)SetGlobal("#GSKIRES","GLOBAL",1)GivePartyAllEquipment()ReallyForceSpellRES("wtpclear",Myself)Wait(1)GiveItemCreate("wtpfmfer",%famsummoner%,0,0,0)SetGlobalTimer("#GWANOUT","GLOBAL",300)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~~ THEN BEGIN fam2hurt_intopack
  SAY @27 /* ~~ */
  IF ~~ THEN DO ~SetGlobal("#GEMPCHA","GLOBAL",1)SetGlobal("#GSKIRES","GLOBAL",1)GivePartyAllEquipment()ReallyForceSpellRES("wtpclear",Myself)Wait(1)GiveItemCreate("wtpfmrab",%famsummoner%,0,0,0)SetGlobalTimer("#GWANOUT","GLOBAL",300)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~~ THEN BEGIN fam3hurt_intopack
  SAY @27 /* ~~ */
  IF ~~ THEN DO ~SetGlobal("#GEMPCHA","GLOBAL",1)SetGlobal("#GSKIRES","GLOBAL",1)GivePartyAllEquipment()ReallyForceSpellRES("wtpclear",Myself)Wait(1)GiveItemCreate("wtpfmcat",%famsummoner%,0,0,0)SetGlobalTimer("#GWANOUT","GLOBAL",300)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~~ THEN BEGIN fam1happy
  SAY @29 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN fam2happy
  SAY @30 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famfight
  SAY @32 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famhurt_notpack
  SAY @33 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

