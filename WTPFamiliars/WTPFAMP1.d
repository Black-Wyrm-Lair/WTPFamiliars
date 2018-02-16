BEGIN ~WTPFAMP1~

IF ~ReputationLT(%famsummoner%,3)~ THEN BEGIN 49 // from:
   SAY @24
   IF ~~ THEN DO ~ChangeEnemyAlly(Myself,NEUTRAL)SetGlobal("#GFAMGO","GLOBAL",1)~ EXIT
END

IF ~Global("#GHARAS","GLOBAL",2)~ THEN BEGIN 46 // from:
   SAY @21
   IF ~Global("#GMIRPEN","GLOBAL",0)~ THEN DO ~IncrementGlobal("#GHARAS","GLOBAL",1)SetGlobal("#GMIRPEN","GLOBAL",1)SetGlobalTimer("#GFAMHAR","GLOBAL",7200)~ EXIT
   IF ~GlobalGT("#GMIRPEN","GLOBAL",0)~ THEN DO ~IncrementGlobal("#GHARAS","GLOBAL",1)SetGlobalTimer("#GFAMHAR","GLOBAL",7200)~ EXIT
END

IF ~Global("#GHARAS","GLOBAL",5)~ THEN BEGIN 47 // from:
   SAY @22
   IF ~GlobalLT("#GMIRPEN","GLOBAL",2)~ THEN DO ~IncrementGlobal("#GHARAS","GLOBAL",1)SetGlobal("#GMIRPEN","GLOBAL",2)SetGlobalTimer("#GFAMHAR","GLOBAL",14400)~ EXIT
   IF ~Global("#GMIRPEN","GLOBAL",2)~ THEN DO ~IncrementGlobal("#GHARAS","GLOBAL",1)SetGlobalTimer("#GFAMHAR","GLOBAL",14400)~ EXIT
END

IF ~Global("#GHARAS","GLOBAL",8)~ THEN BEGIN 48 // from:
   SAY @23
   IF ~~ THEN DO ~ChangeEnemyAlly(Myself,NEUTRAL)SetGlobal("#GFAMGO","GLOBAL",1)~ EXIT
END

IF ~Global("#GINPACK","GLOBAL",1)~ THEN BEGIN 39 // from:
   SAY @12
   IF ~~ THEN DO ~IncrementGlobal("#GINPACK","GLOBAL",1)SetGlobalTimer("#GWANOUT","GLOBAL",120)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~Global("#GINPACK","GLOBAL",3)~ THEN BEGIN 40 // from:
   SAY @13
   IF ~~ THEN DO ~IncrementGlobal("#GINPACK","GLOBAL",1)SetGlobalTimer("#GWANOUT","GLOBAL",90)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~Global("#GINPACK","GLOBAL",5)~ THEN BEGIN 41 // from:
   SAY @14
   IF ~~ THEN DO ~IncrementGlobal("#GINPACK","GLOBAL",1)SetGlobalTimer("#GWANOUT","GLOBAL",60)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~!InPartySlot(LastTalkedToBy,0)~ THEN BEGIN 0 // from:
  SAY #58296 /* ~The small dragon-like creature purrs quizzically with wide eyes. Nervously it backs away towards <CHARNAME>. Obviously it doesn't want to talk to you.~ */
  IF ~~ THEN DO ~MoveToObject(%famsummoner%)ClearActions(Myself)~ EXIT
END

IF ~InPartySlot(LastTalkedToBy,0)~ THEN BEGIN 1 // from:
  SAY #58297 /* ~The small dragon-like creature flutters its wings happily, looking at you with almost kaleidoscopic eyes. "You wish something?" It awaits your attention, tail flicking.~ */
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!GlobalsEqual("#GFAMLVL","#GPLALVL")~ THEN REPLY @19 GOTO 45
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMNG","GLOBAL",2)!GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #58298 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO 2
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMCG","GLOBAL",2)!GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #58866 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO 21
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #58298 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO 42
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMNG","GLOBAL",2)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,30)%IsInBG1%~ THEN REPLY @25 GOTO 50
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMNG","GLOBAL",2)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,45)%IsInSoA%~ THEN REPLY @25 GOTO 50
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMNG","GLOBAL",2)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,60)%IsInToB%~ THEN REPLY @25 GOTO 50
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMCG","GLOBAL",2)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,30)%IsInBG1%~ THEN REPLY @25 GOTO 51
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMCG","GLOBAL",2)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,45)%IsInSoA%~ THEN REPLY @25 GOTO 51
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMCG","GLOBAL",2)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,60)%IsInToB%~ THEN REPLY @25 GOTO 51
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)HPPercentGT(Myself,50)HPPercentGT(%famsummoner%,30)%IsInBG1%~ THEN REPLY @25 GOTO 54
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)HPPercentGT(Myself,50)HPPercentGT(%famsummoner%,45)%IsInSoA%~ THEN REPLY @25 GOTO 54
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)HPPercentGT(Myself,50)HPPercentGT(%famsummoner%,60)Global("INTOB","GLOBAL",1)~ THEN REPLY @25 GOTO 54
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))~ THEN REPLY #72070 /* ~(pet and play with it)~ */ GOTO 3
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!HPPercentLT(Myself,100)~ THEN REPLY #73426 /* ~(feed the familiar)~ */ GOTO 26
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))HPPercentLT(Myself,100)~ THEN REPLY #73432 /* ~(feed the familiar)~ */ GOTO 27
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))%IsInBG1%~ THEN REPLY #58300 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO 28
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))%IsInSoA%~ THEN REPLY #58300 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO 4
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))%IsInToB%~ THEN REPLY #58300 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO 22
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))~ THEN REPLY #58307 /* ~How are you?  Everything okay down there?~ */ GOTO 13
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))Global("#GAFTER","GLOBAL",0)~ THEN REPLY @15 GOTO 43
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))Global("#GAFTER","GLOBAL",1)~ THEN REPLY @16 GOTO 44
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))ReputationGT(%famsummoner%,16)~ THEN REPLY #58304 /* ~No, it's alright.  Let's just keep going.~ */ GOTO 52
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!ReputationGT(%famsummoner%,16)~ THEN REPLY #58304 /* ~No, it's alright.  Let's just keep going.~ */ GOTO 20
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))~ THEN REPLY @28 GOTO 53
END

IF ~~ THEN BEGIN 2 // from: 3.0 1.0
  SAY #58302 /* ~Its eyes brighten, and it practically leaps into your arms, ready to be stowed amongst your belongings where it can sleep and occasionally poke its head out.~ */
  IF ~~ THEN DO ~GivePartyAllEquipment()ReallyForceSpellRES("wtpclear",Myself)Wait(1)GiveItemCreate("wtpfamps",%famsummoner%,0,0,0)SetGlobalTimer("#GWANOUT","GLOBAL",300)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~~ THEN BEGIN 3 // from: 1.1
  SAY #58303 /* ~The dragon coos with delight, its multicolored eyes whirling as you pat its warm, leathery hide. "You are very kind to me, my <PRO_LADYLORD>," it purrs.~ */
  IF ~!GlobalsEqual("#GFAMLVL","#GPLALVL")~ THEN REPLY @19 GOTO 45
  IF ~!InventoryFull(%famsummoner%)Global("WTPFAMNG","GLOBAL",2)!GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #58305 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO 2
  IF ~!InventoryFull(%famsummoner%)Global("WTPFAMCG","GLOBAL",2)!GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #59477 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO 21
  IF ~!InventoryFull(%famsummoner%)GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #58298 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO 42
  IF ~%IsInBG1%~ THEN REPLY #58300 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO 28
  IF ~%IsInSoA%~ THEN REPLY #58300 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO 4
  IF ~%IsInToB%~ THEN REPLY #58300 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO 22
  IF ~~ THEN REPLY #58307 /* ~How are you?  Everything okay down there?~ */ GOTO 13
  IF ~Global("#GAFTER","GLOBAL",0)~ THEN REPLY @15 GOTO 43
  IF ~Global("#GAFTER","GLOBAL",1)~ THEN REPLY @16 GOTO 44
  IF ~ReputationGT(%famsummoner%,16)~ THEN REPLY #58308 /* ~Let's just keep going, then.~ */ GOTO 52
  IF ~!ReputationGT(%famsummoner%,16)~ THEN REPLY #58308 /* ~Let's just keep going, then.~ */ GOTO 20
END

IF ~~ THEN BEGIN 4 // from: 3.1 1.2
  SAY #58309 /* ~The familiar cranes its neck back and looks up at you with a slightly bewildered expression.  "You wish to ask *me* for advice, my <PRO_LADYLORD>?"~ */
  IF ~Global("chapter","GLOBAL",%bg2_chapter_1%)AreaType(DUNGEON)~ THEN GOTO 5
  IF ~Global("chapter","GLOBAL",%bg2_chapter_1%)!AreaType(DUNGEON)~ THEN GOTO 6
  IF ~Global("chapter","GLOBAL",%bg2_chapter_2%)~ THEN GOTO 7
  IF ~Global("chapter","GLOBAL",%bg2_chapter_3%)~ THEN GOTO 8
  IF ~Global("chapter","GLOBAL",%bg2_chapter_4%)~ THEN GOTO 9
  IF ~Global("chapter","GLOBAL",%bg2_chapter_5%)~ THEN GOTO 10
  IF ~Global("chapter","GLOBAL",%bg2_chapter_6%)~ THEN GOTO 11
  IF ~Global("chapter","GLOBAL",%bg2_chapter_7%)~ THEN GOTO 12
END

IF ~~ THEN BEGIN 5 // from: 4.0
  SAY #58310 /* ~It looks at the darkness for a long moment before turning its colorful eyes back at you. "Let us be away from this dark place, my <PRO_LADYLORD>. That is my advice."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 6 // from: 4.1
  SAY #58311 /* ~The dragon looks about quizzically before turnings its multi-faceted eyes back upon you.  "We go to the place of the poor?  The slums, my <PRO_LADYLORD>?  I do not know."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 7 // from: 4.2
  SAY #58312 /* ~The little dragon chuckles to itself musically.  "You must collect gold, my <PRO_LADYLORD>.  Coins and coins enough to find your answers."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 8 // from: 4.3
  SAY #58313 /* ~It almost seems to frown, its whirling eyes settling on a baleful yellow before continuing. "I do not know, my <PRO_LADYLORD>. You must continue these tasks, no?"~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 9 // from: 4.4
  SAY @11 /* ~It ponders for a long moment, flicking its tail absently, before turning back again. "We must stop this wizard. Save you, and the little sister. That is my advice."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 10 // from: 4.5
  SAY #58315 /* ~It looks around for a moment, its eyes dimming with fear as its tail curls up under its belly.  "We must be away from this place soon, my <PRO_LADYLORD>, please?"~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 11 // from: 4.6
  SAY #58316 /* ~It thinks for a moment and then its eyes brighten dramatically. "We must find the sacred elven city, my <PRO_LADYLORD>. Your wizard lies therein, I am certain."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 12 // from: 4.7
  SAY #58317 /* ~It growls menacingly, but not at you. It flicks its tail wickedly several times. "The wizard, my <PRO_LADYLORD>. He must die and you must live."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 13 // from: 3.2 1.3
  SAY #58318 /* ~The dragon flicks its tail with pleasure and gazes up at you with colorful eyes.  "So long as you are well, my <PRO_LADYLORD>, then I am well."~ */
  IF ~HPPercentLT(Myself,100)!HPPercentLT(Myself,50)~ THEN GOTO 15
  IF ~HPPercentLT(Myself,50)~ THEN GOTO 16
  IF ~!HPPercentLT(Myself,100)RandomNum(4,1)~ THEN GOTO 14
  IF ~!HPPercentLT(Myself,100)RandomNum(4,2)~ THEN GOTO 17
  IF ~!HPPercentLT(Myself,100)RandomNum(4,3)~ THEN GOTO 18
  IF ~!HPPercentLT(Myself,100)RandomNum(4,4)~ THEN GOTO 19
END

IF ~~ THEN BEGIN 14 // from: 13.2
  SAY #58319 /* ~"But since you are asking, I could use a snack.  Perhaps a nice gopher.  Or some pie... ooooh, yes, I *like* pie!"~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 15 // from: 13.0
  SAY #58320 /* ~"I... I am a little hurt, though, my <PRO_LADYLORD>.  The cuts sting, and I am bleeding.  It... it is not pleasant."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 16 // from: 13.1
  SAY #58321 /* ~"I...I am hurt badly, my <PRO_LADYLORD>. I don't want to die, my <PRO_LADYLORD>. I want to stay with you." The dragon whimpers a little and curls its tail around your leg.~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 17 // from: 13.3
  SAY #58322 /* ~"I do like traveling with you.  Very much, my <PRO_LADYLORD>.  Do you have an apple?  I could roast the apple a little and then eat it down.  Apples are good!"~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 18 // from: 13.4
  SAY #58323 /* ~I am amazed at all the new places I see with you.  Everything is so wonderful and so colorful!  Is all of the world like this, my <PRO_LADYLORD>?"~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 19 // from: 13.5
  SAY #58324 /* ~"I feel wonderful, myself, my <PRO_LADYLORD>.  My hide is clean and I stand ready to aid you against danger!"~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 20 // from: 3.3 1.4
  SAY #58325 /* ~The dragon flicks its tail contentedly and then turns its eyes back to the path before you. "As you wish, my <PRO_LADYLORD>."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 21 // from: 3.4 1.5
  SAY #58867 /* ~Its eyes brighten, and it practically leaps into your arms, ready to be stowed amongst your belongings where it can sleep and occasionally poke its head out.~ */
  IF ~~ THEN DO ~GivePartyAllEquipment()ReallyForceSpellRES("wtpclear",Myself)Wait(1)GiveItemCreate("wtpfmfae",%famsummoner%,0,0,0)SetGlobalTimer("#GWANOUT","GLOBAL",300)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~~ THEN BEGIN 22 // from:
  SAY #72074 /* ~The familiar cranes its neck back and looks up at you with a slightly bewildered expression.  "You wish to ask *me* for advice, my <PRO_LADYLORD>?"~ */
  IF ~True()~ THEN EXIT
  IF ~Global("chapter","GLOBAL",%bg2_chapter_8%)~ THEN GOTO 23
  IF ~Global("chapter","GLOBAL",%bg2_chapter_9%)~ THEN GOTO 24
  IF ~Global("chapter","GLOBAL",%bg2_chapter_10%)~ THEN GOTO 25
END

IF ~~ THEN BEGIN 23 // from:
  SAY #72694 /* ~The little dragon looks up at you for a moment, its eyes shimmering.  "You must survive, my <PRO_LADYLORD>.  Your heritage places you in great danger!"  It whips its tail about agitatedly.~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 24 // from:
  SAY #72695 /* ~Its bright eyes look piercingly into yours.  "There has been so much death, my <LADYLORD>.  So much destruction.  But I trust you will find the way to do what is right."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 25 // from:
  SAY #72696 /* ~For a moment, the dragon growls fiercely.  "The imposter must die, my <LADYLORD>!  You must somehow go into the Throne of Bhaal and confront her!"~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 26 // from:
  SAY #73428 /* ~You offer the little dragon some nuts and berries that you have stored, and the dragon nibbles on a few of them but doesn't really seem all that hungry.~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 27 // from:
  SAY #73430 /* ~The dragon's eyes swirl with pleasure as it noisily gulps down a large quantity of nuts and berries that you have collected.  It's wounds visibly start healing immediately.~ */
  IF ~~ THEN DO ~ApplySpell(Myself,CLERIC_CURE_MEDIUM_WOUNDS)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 28 // from:
  SAY #58309 /* ~The familiar cranes its neck back and looks up at you with a slightly bewildered expression.  "You wish to ask *me* for advice, my <PRO_LADYLORD>?"~ */
  IF ~Global("chapter","GLOBAL",%bg1_chapter_0%)~ THEN GOTO 29
  IF ~Global("chapter","GLOBAL",%bg1_chapter_1%)~ THEN GOTO 30
  IF ~Global("chapter","GLOBAL",%bg1_chapter_2%)~ THEN GOTO 31
  IF ~Global("chapter","GLOBAL",%bg1_chapter_3%)~ THEN GOTO 32
  IF ~Global("chapter","GLOBAL",%bg1_chapter_4%)~ THEN GOTO 33
  IF ~Global("chapter","GLOBAL",%bg1_chapter_5%)%InBGAreaCheck%~ THEN GOTO 34
  IF ~Global("chapter","GLOBAL",%bg1_chapter_5%)%NotInBGAreaCheck%~ THEN GOTO 35
  IF ~Global("chapter","GLOBAL",%bg1_chapter_6%)!Global("Teth","Global",1)~ THEN GOTO 36
  IF ~Global("chapter","GLOBAL",%bg1_chapter_6%)Global("Teth","Global",1)~ THEN GOTO 37
  IF ~Global("chapter","GLOBAL",%bg1_chapter_7%)~ THEN GOTO 38
END

IF ~~ THEN BEGIN 29 // from:
  SAY @0 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 30 // from:
  SAY @1 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 31 // from:
  SAY @2 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 32 // from:
  SAY @3 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 33 // from:
  SAY @4 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 34 // from:
  SAY @5 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 35 // from:
  SAY @6 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 36 // from:
  SAY @7 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 37 // from:
  SAY @8 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 38 // from:
  SAY @9 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 42 // from:
  SAY @10 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 43 // from:
  SAY @17 /* ~~ */
  IF ~~ THEN DO ~SetGlobal("#GAFTER","GLOBAL",1)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 44 // from:
  SAY @18 /* ~~ */
  IF ~~ THEN DO ~SetGlobal("#GAFTER","GLOBAL",0)RunAwayFrom(%famsummoner%,45)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 45 // from:
  SAY @20 /* ~~ */
  IF ~~ THEN DO ~SetGlobal("#GAFTER","GLOBAL",0)SetGlobal("#GFLVUP","GLOBAL",1)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 50 // from:
  SAY @26 /* ~~ */
  IF ~~ THEN DO ~GivePartyAllEquipment()ReallyForceSpellRES("wtpclear",Myself)Wait(1)GiveItemCreate("wtpfamps",%famsummoner%,0,0,0)SetGlobalTimer("#GWANOUT","GLOBAL",300)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~~ THEN BEGIN 51 // from:
  SAY @26 /* ~~ */
  IF ~~ THEN DO ~GivePartyAllEquipment()ReallyForceSpellRES("wtpclear",Myself)Wait(1)GiveItemCreate("wtpfmfae",%famsummoner%,0,0,0)SetGlobalTimer("#GWANOUT","GLOBAL",300)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~~ THEN BEGIN 52 //
  SAY @27 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 53 //
  SAY @29 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN 54 //
  SAY @30 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END
