BEGIN ~WTPFAMP4~

IF ~Global("#GHARAS","GLOBAL",2)~ THEN BEGIN 45 // from:
   SAY @38
   IF ~Global("#GMIRPEN","GLOBAL",0)~ THEN DO ~IncrementGlobal("#GHARAS","GLOBAL",1)SetGlobal("#GMIRPEN","GLOBAL",1)SetGlobalTimer("#GFAMHAR","GLOBAL",7200)~ EXIT
   IF ~GlobalGT("#GMIRPEN","GLOBAL",0)~ THEN DO ~IncrementGlobal("#GHARAS","GLOBAL",1)SetGlobalTimer("#GFAMHAR","GLOBAL",7200)~ EXIT
END

IF ~Global("#GHARAS","GLOBAL",5)~ THEN BEGIN 46 // from:
   SAY @39
   IF ~GlobalLT("#GMIRPEN","GLOBAL",2)~ THEN DO ~IncrementGlobal("#GHARAS","GLOBAL",1)SetGlobal("#GMIRPEN","GLOBAL",2)SetGlobalTimer("#GFAMHAR","GLOBAL",14400)~ EXIT
   IF ~Global("#GMIRPEN","GLOBAL",2)~ THEN DO ~IncrementGlobal("#GHARAS","GLOBAL",1)SetGlobalTimer("#GFAMHAR","GLOBAL",14400)~ EXIT
END

IF ~Global("#GHARAS","GLOBAL",8)~ THEN BEGIN 47 // from:
   SAY @40
   IF ~~ THEN DO ~ChangeEnemyAlly(Myself,NEUTRAL)SetGlobal("#GFAMGO","GLOBAL",1)~ EXIT
END

IF ~Global("#GINPACK","GLOBAL",1)~ THEN BEGIN 38 // from:
   SAY @27
   IF ~~ THEN DO ~IncrementGlobal("#GINPACK","GLOBAL",1)SetGlobalTimer("#GWANOUT","GLOBAL",120)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~Global("#GINPACK","GLOBAL",3)~ THEN BEGIN 39 // from:
   SAY @28
   IF ~~ THEN DO ~IncrementGlobal("#GINPACK","GLOBAL",1)SetGlobalTimer("#GWANOUT","GLOBAL",90)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~Global("#GINPACK","GLOBAL",5)~ THEN BEGIN 40 // from:
   SAY @29
   IF ~~ THEN DO ~IncrementGlobal("#GINPACK","GLOBAL",1)SetGlobalTimer("#GWANOUT","GLOBAL",60)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~!InPartySlot(LastTalkedToBy,0)~ THEN BEGIN 0 // from:
  SAY @0 /* ~The bulbous creature looks at you with its unblinking eyes, and after a moment's inspection, it turns and scuttles back to <CHARNAME>.~ */
  IF ~~ THEN DO ~MoveToObject(%famsummoner%)ClearActions(Myself)~ EXIT
END

IF ~InPartySlot(LastTalkedToBy,0)~ THEN BEGIN 1 // from:
  SAY @23 /* ~The familiar turns and stares at you, its fangs twitching slightly with curiosity. "What is it now, <PRO_MANWOMAN>?"~ */
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!GlobalsEqual("#GFAMLVL","#GPLALVL")~ THEN REPLY @36 GOTO 44
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)!GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #58358 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO 2
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #58358 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO 41
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,30)%IsInBG1%~ THEN REPLY @42 GOTO 49
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,45)%IsInSoA%~ THEN REPLY @42 GOTO 49
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,60)%IsInToB%~ THEN REPLY @42 GOTO 49
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)HPPercentGT(Myself,50)HPPercentGT(%famsummoner%,30)%IsInBG1%~ THEN REPLY @42 GOTO 52
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)HPPercentGT(Myself,50)HPPercentGT(%famsummoner%,45)%IsInSoA%~ THEN REPLY @42 GOTO 52
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)HPPercentGT(Myself,50)HPPercentGT(%famsummoner%,60)%IsInToB%~ THEN REPLY @42 GOTO 52
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))~ THEN REPLY #58360 /* ~(pet the familiar)~ */ GOTO 3
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!HPPercentLT(Myself,100)~ THEN REPLY #73442 /* ~(feed the familiar)~ */ GOTO 25
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))HPPercentLT(Myself,100)~ THEN REPLY #73443 /* ~(feed the familiar)~ */ GOTO 26
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))%IsInBG1%~ THEN REPLY #58383 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO 27
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))%IsInSoA%~ THEN REPLY #58383 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO 4
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))%IsInToB%~ THEN REPLY #58383 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO 21
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))~ THEN REPLY #58384 /* ~How are you?  Everything okay down there?~ */ GOTO 13
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))Global("#GAFTER","GLOBAL",0)~ THEN REPLY @32 GOTO 42
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))Global("#GAFTER","GLOBAL",1)~ THEN REPLY @33 GOTO 43
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))OR(2)ReputationGT(%famsummoner%,16)ReputationLT(%famsummoner%,5)~ THEN REPLY #58385 /* ~Perhaps later.  Let's just keep going.~ */ GOTO 48
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))ReputationLT(%famsummoner%,12)ReputationGT(%famsummoner%,8)~ THEN REPLY #58385 /* ~Perhaps later.  Let's just keep going.~ */ GOTO 50
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!ReputationGT(%famsummoner%,16)!ReputationLT(%famsummoner%,5)!Reputation(%famsummoner%,9)!Reputation(%famsummoner%,10)!Reputation(%famsummoner%,11)~ THEN REPLY #58385 /* ~Perhaps later.  Let's just keep going.~ */ GOTO 20
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))~ THEN REPLY @45 GOTO 51
END

IF ~~ THEN BEGIN 2 // from:
  SAY #58359 /* ~The familiar eyes your pack, and then reluctantly crawls inside. "Very well. It is better that you carry me. Do not bump me around so much this time."~ */
  IF ~~ THEN DO ~SetGlobal("#GEMPCHA","GLOBAL",1)SetGlobal("#GSKIRES","GLOBAL",1)GivePartyAllEquipment()ReallyForceSpellRES("wtpclear",Myself)GiveItemCreate("wtpfmspd",%famsummoner%,0,0,0)SetGlobalTimer("#GWANOUT","GLOBAL",300)SetGlobalTimer("","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~~ THEN BEGIN 3 // from:
  SAY @1 /* ~"Aahhhh..."  The familiar hums with contentment, its fangs twitching.  "Yes, this is good.  Food would also be nice."~ */
  IF ~!GlobalsEqual("#GFAMLVL","#GPLALVL")~ THEN REPLY @36 GOTO 44
  IF ~!InventoryFull(%famsummoner%)!GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #58362 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO 2
  IF ~!InventoryFull(%famsummoner%)GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #58362 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO 41
  IF ~%IsInBG1%~ THEN REPLY #58363 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO 27
  IF ~%IsInSoA%~ THEN REPLY #58363 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO 4
  IF ~%IsInToB%~ THEN REPLY #58363 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO 21
  IF ~~ THEN REPLY #58373 /* ~How are you?  Everything okay down there?~ */ GOTO 13
  IF ~Global("#GAFTER","GLOBAL",0)~ THEN REPLY @32 GOTO 42
  IF ~Global("#GAFTER","GLOBAL",1)~ THEN REPLY @33 GOTO 43
  IF ~OR(2)ReputationGT(%famsummoner%,16)ReputationLT(%famsummoner%,5)~ THEN REPLY #58381 /* ~Let's just keep going, then.~ */ GOTO 48
  IF ~ReputationLT(%famsummoner%,12)ReputationGT(%famsummoner%,8)~ THEN REPLY #58381 /* ~Let's just keep going, then.~ */ GOTO 50
  IF ~!ReputationGT(%famsummoner%,16)!ReputationLT(%famsummoner%,5)!Reputation(%famsummoner%,9)!Reputation(%famsummoner%,10)!Reputation(%famsummoner%,11)~ THEN REPLY #58381 /* ~Let's just keep going, then.~ */ GOTO 20
END

IF ~~ THEN BEGIN 4 // from:
  SAY #58364 /* ~The animal looks at you, fairly close to bewildered. "Me? I suppose I have thoughts that it would amuse me to share, but would you even regard them, <PRO_MANWOMAN>?"~ */
  IF ~Global("chapter","GLOBAL",%bg2_chapter_1%)AreaType(DUNGEON)~ THEN GOTO 5
  IF ~Global("chapter","GLOBAL",%bg2_chapter_1%)!AreaType(DUNGEON)~ THEN GOTO 6
  IF ~Global("chapter","GLOBAL",%bg2_chapter_2%)~ THEN GOTO 7
  IF ~Global("chapter","GLOBAL",%bg2_chapter_3%)~ THEN GOTO 8
  IF ~Global("chapter","GLOBAL",%bg2_chapter_4%)~ THEN GOTO 9
  IF ~Global("chapter","GLOBAL",%bg2_chapter_5%)~ THEN GOTO 10
  IF ~Global("chapter","GLOBAL",%bg2_chapter_6%)~ THEN GOTO 11
  IF ~Global("chapter","GLOBAL",%bg2_chapter_7%)~ THEN GOTO 12
END

IF ~~ THEN BEGIN 5 // from:
  SAY @2 /* ~Looking about at the darkness, the familiar turns back to face you. "I would say let us be off to the surface, <PRO_MANWOMAN>. Surely food is more plentiful there."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 6 // from:
  SAY #58366 /* ~It looks about for several moments, watching various city animals and people. It finally turns back, almost startled. "What? Advice? Ah...no. No advice."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 7 // from:
  SAY @3 /* ~The spider thinks to itself for a few moments and then scurries off after a small prey.  Apparently, its animal instincts took over.~ */
  IF ~~ THEN DO ~RunAwayFrom(LastTalkedToBy,5)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 8 // from:
  SAY @4 /* ~It thinks for a long moment and then seems to drift off. At long last it speaks. "Before you continue your journey make sure you won't need to rely on me for decisions, <PRO_MANWOMAN>. That is my advice."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 9 // from:
  SAY #58369 /* ~"Let's see...the wizard is behind all your trials, yes? Then it is easy, <PRO_MANWOMAN>. Find him, kill him, and your troubles are no more. Now will you feed me, yes?"~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 10 // from:
  SAY @5 /* ~It looks about balefully, its hairy abdomen quivering in distress. "I do not like this place. We should leave immediately."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 11 // from:
  SAY #58371 /* ~"Hmm, the elven city has the Tree of Life within, <PRO_MANWOMAN>, a wondrous thing connected to all that is natural. You must find the city and the Tree. That is my advice."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 12 // from:
  SAY @6 /* ~The spider's silky voice vibrates with uncharacteristic ferocity. "There is only one solution, <PRO_MANWOMAN>. For you to survive, the wizard must die. That is how it must be."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 13 // from:
  SAY @7 /* ~It looks up with its many eyes, seemingly content to just be near you. It looks away briefly. "We are connected, you and I. If you are well, so am I."~ */
  IF ~HPPercentLT(Myself,100)!HPPercentLT(Myself,50)~ THEN GOTO 14
  IF ~HPPercentLT(Myself,50)~ THEN GOTO 15
  IF ~!HPPercentLT(Myself,100)RandomNum(5,1)~ THEN GOTO 16
  IF ~!HPPercentLT(Myself,100)RandomNum(5,2)~ THEN GOTO 17
  IF ~!HPPercentLT(Myself,100)RandomNum(5,3)~ THEN GOTO 18
  IF ~!HPPercentLT(Myself,100)RandomNum(5,4)~ THEN GOTO 19
END

IF ~~ THEN BEGIN 14 // from:
  SAY #58375 /* ~"But I, myself, have a few insignificant injuries. I am strengthened because you are stronger than I. If you could treat my wounds, it would please me."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 15 // from:
  SAY @31 /* ~"But I, myself, am hurt very badly.  I bleed, <PRO_MANWOMAN>.  I may survive, or I may not... we shall see."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 16 // from:
  SAY @8 /* ~But since you ask, I am rather hungry.  I used to hunt and catch food in my webs but now that we are constantly on the move, keeping me fed becomes your task, <PRO_MANWOMAN>.~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 17 // from:
  SAY #58378 /* ~"But I think you are a good enough traveling companion. I am pleased with the progress we make. Perhaps I shall remain with you for some time to come, we shall see."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 18 // from:
  SAY @9 /* ~The large spider seems to ponder saying something else, but eventually its attention drifts and it finds something more interesting than you elsewhere.~ */
  IF ~~ THEN DO ~RunAwayFrom(LastTalkedToBy,10)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 19 // from:
  SAY #58380 /* ~"But all is well enough, <PRO_MANWOMAN>.  Why?  Are you not well?  You will not sicken and die on me, <PRO_MANWOMAN>, would you?  If you did it would sadden me, for a while."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 20 // from:
  SAY @10 /* ~The familiar spins on its legs and looks disinterestedly at the path before you.  "I would prefer to choose our path, myself, but you'll no doubt want to be stubborn."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 21 // from:
  SAY #72593 /* ~The animal looks at you, fairly close to bewildered. "Me? I suppose I have thoughts that it would amuse me to share, but would you even regard them, <PRO_MANWOMAN>?"~ */
  IF ~True()~ THEN EXIT
  IF ~Global("chapter","GLOBAL",%bg2_chapter_8%)~ THEN GOTO 22
  IF ~Global("chapter","GLOBAL",%bg2_chapter_9%)~ THEN GOTO 23
  IF ~Global("chapter","GLOBAL",%bg2_chapter_10%)~ THEN GOTO 24
END

IF ~~ THEN BEGIN 22 // from:
  SAY @13 /* ~The large spider looks uninterested.  "I do not know what advice to give.  The wizard is dead, you have your soul... can you not just leave?"~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 23 // from:
  SAY @14 /* ~It seems to concentrate, thinking hard.  "It...seems to me that there is a reason that all the children of Bhaal are coming together.  You must end it, I think."  It continues after a short pause.  "And, of course, you must win!"~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 24 // from:
  SAY @15 /* ~"The only answer must be obvious...you must find this female who has lied to you and kill her!  You must travel to the Abyss and her life must be ended!"  Its fangs twitch and pinch before your eyes.  "Or, at least, that's what I would do."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 25 // from:
  SAY @11 /* ~You scrounge up some food from your pack and offer it to the creature.  It seems pleased and nibbles away contentedly. "Thank you, <PRO_MANWOMAN>."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 26 // from:
  SAY @12 /* ~Your familiar seems ravenous and digs into the food you offer immediately.  Its wounds begin to close before your eyes.  "Many thanks, <PRO_MANWOMAN>!"~ */
  IF ~~ THEN DO ~ApplySpell(Myself,CLERIC_CURE_MEDIUM_WOUNDS)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 27 // from:
  SAY #58364 /* ~The animal looks at you, fairly close to bewildered. "Me? I suppose I have thoughts that it would amuse me to share, but would you even regard them, <PRO_MANWOMAN>?"~ */
  IF ~Global("chapter","GLOBAL",%bg1_chapter_0%)~ THEN GOTO 28
  IF ~Global("chapter","GLOBAL",%bg1_chapter_1%)~ THEN GOTO 29
  IF ~Global("chapter","GLOBAL",%bg1_chapter_2%)~ THEN GOTO 30
  IF ~Global("chapter","GLOBAL",%bg1_chapter_3%)~ THEN GOTO 31
  IF ~Global("chapter","GLOBAL",%bg1_chapter_4%)~ THEN GOTO 32
  IF ~Global("chapter","GLOBAL",%bg1_chapter_5%)%InBGAreaCheck%~ THEN GOTO 33
  IF ~Global("chapter","GLOBAL",%bg1_chapter_5%)%NotInBGAreaCheck%~ THEN GOTO 34
  IF ~Global("chapter","GLOBAL",%bg1_chapter_6%)!Global("Teth","Global",1)~ THEN GOTO 35
  IF ~Global("chapter","GLOBAL",%bg1_chapter_6%)Global("Teth","Global",1)~ THEN GOTO 36
  IF ~Global("chapter","GLOBAL",%bg1_chapter_7%)~ THEN GOTO 37
END

IF ~~ THEN BEGIN 28 // from:
  SAY @16 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 29 // from:
  SAY @17 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 30 // from:
  SAY @18 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 31 // from:
  SAY @19 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 32 // from:
  SAY @20 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~EXIT
END

IF ~~ THEN BEGIN 33 // from:
  SAY @21 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 34 // from:
  SAY @22 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 35 // from:
  SAY @24 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 36 // from:
  SAY @25 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 37 // from:
  SAY @26 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 41 // from:
  SAY @30 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 42 // from:
  SAY @34 /* ~~ */
  IF ~~ THEN DO ~SetGlobal("#GAFTER","GLOBAL",1)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 43 // from:
  SAY @35 /* ~~ */
  IF ~~ THEN DO ~SetGlobal("#GAFTER","GLOBAL",0)RunAwayFrom(%famsummoner%,45)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 44 // from:
  SAY @37 /* ~~ */
  IF ~~ THEN DO ~SetGlobal("#GAFTER","GLOBAL",0)SetGlobal("#GFLVUP","GLOBAL",1)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 48 // from:
  SAY @41 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 49 // from:
  SAY @43 /* ~~ */
  IF ~~ THEN DO ~SetGlobal("#GEMPCHA","GLOBAL",1)SetGlobal("#GSKIRES","GLOBAL",1)GivePartyAllEquipment()GiveItemCreate("wtpfmspd",%famsummoner%,0,0,0)SetGlobalTimer("#GWANOUT","GLOBAL",300)SetGlobalTimer("","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~~ THEN BEGIN 50 // from:
  SAY @44 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 51 // from:
  SAY @46 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 52 // from:
  SAY @47 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END
