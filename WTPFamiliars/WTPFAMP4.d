BEGIN ~WTPFAMP4~

IF ~Global("#GHARAS","GLOBAL",2)~ THEN BEGIN famharas1
   SAY @38
   IF ~Global("#GMIRPEN","GLOBAL",0)~ THEN DO ~IncrementGlobal("#GHARAS","GLOBAL",1)SetGlobal("#GMIRPEN","GLOBAL",1)SetGlobalTimer("#GFAMHAR","GLOBAL",7200)~ EXIT
   IF ~GlobalGT("#GMIRPEN","GLOBAL",0)~ THEN DO ~IncrementGlobal("#GHARAS","GLOBAL",1)SetGlobalTimer("#GFAMHAR","GLOBAL",7200)~ EXIT
END

IF ~Global("#GHARAS","GLOBAL",5)~ THEN BEGIN famharas2
   SAY @39
   IF ~GlobalLT("#GMIRPEN","GLOBAL",2)~ THEN DO ~IncrementGlobal("#GHARAS","GLOBAL",1)SetGlobal("#GMIRPEN","GLOBAL",2)SetGlobalTimer("#GFAMHAR","GLOBAL",14400)~ EXIT
   IF ~Global("#GMIRPEN","GLOBAL",2)~ THEN DO ~IncrementGlobal("#GHARAS","GLOBAL",1)SetGlobalTimer("#GFAMHAR","GLOBAL",14400)~ EXIT
END

IF ~Global("#GHARAS","GLOBAL",8)~ THEN BEGIN famgo_haras
   SAY @40
   IF ~~ THEN DO ~ChangeEnemyAlly(Myself,NEUTRAL)SetGlobal("#GFAMGO","GLOBAL",1)~ EXIT
END

IF ~Global("#GINPACK","GLOBAL",1)~ THEN BEGIN faminpack1
   SAY @27
   IF ~~ THEN DO ~IncrementGlobal("#GINPACK","GLOBAL",1)SetGlobalTimer("#GWANOUT","GLOBAL",120)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~Global("#GINPACK","GLOBAL",3)~ THEN BEGIN faminpack2
   SAY @28
   IF ~~ THEN DO ~IncrementGlobal("#GINPACK","GLOBAL",1)SetGlobalTimer("#GWANOUT","GLOBAL",90)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~Global("#GINPACK","GLOBAL",5)~ THEN BEGIN faminpack3
   SAY @29
   IF ~~ THEN DO ~IncrementGlobal("#GINPACK","GLOBAL",1)SetGlobalTimer("#GWANOUT","GLOBAL",60)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~!InPartySlot(LastTalkedToBy,0)~ THEN BEGIN famshy
  SAY @0 /* ~The bulbous creature looks at you with its unblinking eyes, and after a moment's inspection, it turns and scuttles back to <CHARNAME>.~ */
  IF ~~ THEN DO ~MoveToObject(%famsummoner%)ClearActions(Myself)~ EXIT
END

IF ~InPartySlot(LastTalkedToBy,0)~ THEN BEGIN famtalk
  SAY @23 /* ~The familiar turns and stares at you, its fangs twitching slightly with curiosity. "What is it now, <PRO_MANWOMAN>?"~ */
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!GlobalsEqual("#GFAMLVL","#GPLALVL")~ THEN REPLY @36 GOTO famlevelup
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)!GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #58358 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO fam1intopack
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #58358 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO famnotpack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,30)%IsInBG1%~ THEN REPLY @42 GOTO fam1hurt_intopack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,45)%IsInSoA%~ THEN REPLY @42 GOTO fam1hurt_intopack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,60)%IsInToB%~ THEN REPLY @42 GOTO fam1hurt_intopack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)HPPercentGT(Myself,50)HPPercentGT(%famsummoner%,30)%IsInBG1%~ THEN REPLY @42 GOTO famhurt_notpack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)HPPercentGT(Myself,50)HPPercentGT(%famsummoner%,45)%IsInSoA%~ THEN REPLY @42 GOTO famhurt_notpack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)HPPercentGT(Myself,50)HPPercentGT(%famsummoner%,60)%IsInToB%~ THEN REPLY @42 GOTO famhurt_notpack
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))~ THEN REPLY #58360 /* ~(pet the familiar)~ */ GOTO fampet
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!HPPercentLT(Myself,100)~ THEN REPLY #73442 /* ~(feed the familiar)~ */ GOTO famfeed_full
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))HPPercentLT(Myself,100)~ THEN REPLY #73443 /* ~(feed the familiar)~ */ GOTO famfeed_hurt
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))%IsInBG1%~ THEN REPLY #58383 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO bg1_advice
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))%IsInSoA%~ THEN REPLY #58383 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO soa_advice
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))%IsInToB%~ THEN REPLY #58383 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO tob_advice
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))~ THEN REPLY #58384 /* ~How are you?  Everything okay down there?~ */ GOTO famstatus
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))Global("#GAFTER","GLOBAL",0)~ THEN REPLY @32 GOTO famclose
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))Global("#GAFTER","GLOBAL",1)~ THEN REPLY @33 GOTO famroam
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))OR(2)ReputationGT(%famsummoner%,16)ReputationLT(%famsummoner%,5)~ THEN REPLY #58385 /* ~Perhaps later.  Let's just keep going.~ */ GOTO fam1complain
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))ReputationLT(%famsummoner%,12)ReputationGT(%famsummoner%,8)~ THEN REPLY #58385 /* ~Perhaps later.  Let's just keep going.~ */ GOTO fam1happy
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!ReputationGT(%famsummoner%,16)!ReputationLT(%famsummoner%,5)!Reputation(%famsummoner%,9)!Reputation(%famsummoner%,10)!Reputation(%famsummoner%,11)~ THEN REPLY #58385 /* ~Perhaps later.  Let's just keep going.~ */ GOTO famneutral
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))~ THEN REPLY @45 GOTO famfight
END

IF ~~ THEN BEGIN fam1intopack
  SAY #58359 /* ~The familiar eyes your pack, and then reluctantly crawls inside. "Very well. It is better that you carry me. Do not bump me around so much this time."~ */
  IF ~~ THEN DO ~SetGlobal("#GEMPCHA","GLOBAL",1)SetGlobal("#GSKIRES","GLOBAL",1)GivePartyAllEquipment()ReallyForceSpellRES("wtpclear",Myself)GiveItemCreate("wtpfmspd",%famsummoner%,0,0,0)SetGlobalTimer("#GWANOUT","GLOBAL",300)SetGlobalTimer("","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~~ THEN BEGIN fampet
  SAY @1 /* ~"Aahhhh..."  The familiar hums with contentment, its fangs twitching.  "Yes, this is good.  Food would also be nice."~ */
  IF ~!GlobalsEqual("#GFAMLVL","#GPLALVL")~ THEN REPLY @36 GOTO famlevelup
  IF ~!InventoryFull(%famsummoner%)!GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #58362 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO fam1intopack
  IF ~!InventoryFull(%famsummoner%)GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #58362 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO famnotpack
  IF ~%IsInBG1%~ THEN REPLY #58363 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO bg1_advice
  IF ~%IsInSoA%~ THEN REPLY #58363 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO soa_advice
  IF ~%IsInToB%~ THEN REPLY #58363 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO tob_advice
  IF ~~ THEN REPLY #58373 /* ~How are you?  Everything okay down there?~ */ GOTO famstatus
  IF ~Global("#GAFTER","GLOBAL",0)~ THEN REPLY @32 GOTO famclose
  IF ~Global("#GAFTER","GLOBAL",1)~ THEN REPLY @33 GOTO famroam
  IF ~OR(2)ReputationGT(%famsummoner%,16)ReputationLT(%famsummoner%,5)~ THEN REPLY #58381 /* ~Let's just keep going, then.~ */ GOTO fam1complain
  IF ~ReputationLT(%famsummoner%,12)ReputationGT(%famsummoner%,8)~ THEN REPLY #58381 /* ~Let's just keep going, then.~ */ GOTO fam1happy
  IF ~!ReputationGT(%famsummoner%,16)!ReputationLT(%famsummoner%,5)!Reputation(%famsummoner%,9)!Reputation(%famsummoner%,10)!Reputation(%famsummoner%,11)~ THEN REPLY #58381 /* ~Let's just keep going, then.~ */ GOTO famneutral
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
  SAY @2 /* ~Looking about at the darkness, the familiar turns back to face you. "I would say let us be off to the surface, <PRO_MANWOMAN>. Surely food is more plentiful there."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch1_promenade
  SAY #58366 /* ~It looks about for several moments, watching various city animals and people. It finally turns back, almost startled. "What? Advice? Ah...no. No advice."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch2
  SAY @3 /* ~The spider thinks to itself for a few moments and then scurries off after a small prey.  Apparently, its animal instincts took over.~ */
  IF ~~ THEN DO ~RunAwayFrom(LastTalkedToBy,5)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch3
  SAY @4 /* ~It thinks for a long moment and then seems to drift off. At long last it speaks. "Before you continue your journey make sure you won't need to rely on me for decisions, <PRO_MANWOMAN>. That is my advice."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch4
  SAY #58369 /* ~"Let's see...the wizard is behind all your trials, yes? Then it is easy, <PRO_MANWOMAN>. Find him, kill him, and your troubles are no more. Now will you feed me, yes?"~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch5
  SAY @5 /* ~It looks about balefully, its hairy abdomen quivering in distress. "I do not like this place. We should leave immediately."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch6
  SAY #58371 /* ~"Hmm, the elven city has the Tree of Life within, <PRO_MANWOMAN>, a wondrous thing connected to all that is natural. You must find the city and the Tree. That is my advice."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch7
  SAY @6 /* ~The spider's silky voice vibrates with uncharacteristic ferocity. "There is only one solution, <PRO_MANWOMAN>. For you to survive, the wizard must die. That is how it must be."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famstatus
  SAY @7 /* ~It looks up with its many eyes, seemingly content to just be near you. It looks away briefly. "We are connected, you and I. If you are well, so am I."~ */
  IF ~HPPercentLT(Myself,100)!HPPercentLT(Myself,50)~ THEN GOTO famhurt_light
  IF ~HPPercentLT(Myself,50)~ THEN GOTO famhurt_bad
  IF ~!HPPercentLT(Myself,100)RandomNum(5,1)~ THEN GOTO famokay1
  IF ~!HPPercentLT(Myself,100)RandomNum(5,2)~ THEN GOTO famokay2
  IF ~!HPPercentLT(Myself,100)RandomNum(5,3)~ THEN GOTO famokay3
  IF ~!HPPercentLT(Myself,100)RandomNum(5,4)~ THEN GOTO famokay4
END

IF ~~ THEN BEGIN famhurt_light
  SAY #58375 /* ~"But I, myself, have a few insignificant injuries. I am strengthened because you are stronger than I. If you could treat my wounds, it would please me."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famhurt_bad
  SAY @31 /* ~"But I, myself, am hurt very badly.  I bleed, <PRO_MANWOMAN>.  I may survive, or I may not... we shall see."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famokay1
  SAY @8 /* ~But since you ask, I am rather hungry.  I used to hunt and catch food in my webs but now that we are constantly on the move, keeping me fed becomes your task, <PRO_MANWOMAN>.~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famokay2
  SAY #58378 /* ~"But I think you are a good enough traveling companion. I am pleased with the progress we make. Perhaps I shall remain with you for some time to come, we shall see."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famokay3
  SAY @9 /* ~The large spider seems to ponder saying something else, but eventually its attention drifts and it finds something more interesting than you elsewhere.~ */
  IF ~~ THEN DO ~RunAwayFrom(LastTalkedToBy,10)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famokay4
  SAY #58380 /* ~"But all is well enough, <PRO_MANWOMAN>.  Why?  Are you not well?  You will not sicken and die on me, <PRO_MANWOMAN>, would you?  If you did it would sadden me, for a while."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famneutral
  SAY @10 /* ~The familiar spins on its legs and looks disinterestedly at the path before you.  "I would prefer to choose our path, myself, but you'll no doubt want to be stubborn."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN tob_advice
  SAY #72593 /* ~The animal looks at you, fairly close to bewildered. "Me? I suppose I have thoughts that it would amuse me to share, but would you even regard them, <PRO_MANWOMAN>?"~ */
  IF ~True()~ THEN EXIT
  IF ~Global("chapter","GLOBAL",%bg2_chapter_8%)~ THEN GOTO tob_advice_ch8
  IF ~Global("chapter","GLOBAL",%bg2_chapter_9%)~ THEN GOTO tob_advice_ch9
  IF ~Global("chapter","GLOBAL",%bg2_chapter_10%)~ THEN GOTO tob_advice_ch10
END

IF ~~ THEN BEGIN tob_advice_ch8
  SAY @13 /* ~The large spider looks uninterested.  "I do not know what advice to give.  The wizard is dead, you have your soul... can you not just leave?"~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN tob_advice_ch9
  SAY @14 /* ~It seems to concentrate, thinking hard.  "It...seems to me that there is a reason that all the children of Bhaal are coming together.  You must end it, I think."  It continues after a short pause.  "And, of course, you must win!"~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN tob_advice_ch10
  SAY @15 /* ~"The only answer must be obvious...you must find this female who has lied to you and kill her!  You must travel to the Abyss and her life must be ended!"  Its fangs twitch and pinch before your eyes.  "Or, at least, that's what I would do."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famfeed_full
  SAY @11 /* ~You scrounge up some food from your pack and offer it to the creature.  It seems pleased and nibbles away contentedly. "Thank you, <PRO_MANWOMAN>."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famfeed_hurt
  SAY @12 /* ~Your familiar seems ravenous and digs into the food you offer immediately.  Its wounds begin to close before your eyes.  "Many thanks, <PRO_MANWOMAN>!"~ */
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
  SAY @16 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch1
  SAY @17 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch2
  SAY @18 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch3
  SAY @19 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch4
  SAY @20 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch5bg
  SAY @21 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch5
  SAY @22 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch6
  SAY @24 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch6teth
  SAY @25 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch7
  SAY @26 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famnotpack
  SAY @30 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famclose
  SAY @34 /* ~~ */
  IF ~~ THEN DO ~SetGlobal("#GAFTER","GLOBAL",1)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famroam
  SAY @35 /* ~~ */
  IF ~~ THEN DO ~SetGlobal("#GAFTER","GLOBAL",0)RunAwayFrom(%famsummoner%,45)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famlevelup
  SAY @37 /* ~~ */
  IF ~~ THEN DO ~SetGlobal("#GAFTER","GLOBAL",0)SetGlobal("#GFLVUP","GLOBAL",1)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN fam1complain
  SAY @41 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN fam1hurt_intopack
  SAY @43 /* ~~ */
  IF ~~ THEN DO ~SetGlobal("#GEMPCHA","GLOBAL",1)SetGlobal("#GSKIRES","GLOBAL",1)GivePartyAllEquipment()GiveItemCreate("wtpfmspd",%famsummoner%,0,0,0)SetGlobalTimer("#GWANOUT","GLOBAL",300)SetGlobalTimer("","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~~ THEN BEGIN fam1happy
  SAY @44 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famfight
  SAY @46 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famhurt_notpack
  SAY @47 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

