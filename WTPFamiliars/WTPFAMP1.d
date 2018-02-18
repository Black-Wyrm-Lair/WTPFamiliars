BEGIN ~WTPFAMP1~

IF ~ReputationLT(%famsummoner%,3)~ THEN BEGIN famgo_rept
   SAY @24
   IF ~~ THEN DO ~ChangeEnemyAlly(Myself,NEUTRAL)SetGlobal("#GFAMGO","GLOBAL",1)~ EXIT
END

IF ~Global("#GHARAS","GLOBAL",2)~ THEN BEGIN famharas1
   SAY @21
   IF ~Global("#GMIRPEN","GLOBAL",0)~ THEN DO ~IncrementGlobal("#GHARAS","GLOBAL",1)SetGlobal("#GMIRPEN","GLOBAL",1)SetGlobalTimer("#GFAMHAR","GLOBAL",7200)~ EXIT
   IF ~GlobalGT("#GMIRPEN","GLOBAL",0)~ THEN DO ~IncrementGlobal("#GHARAS","GLOBAL",1)SetGlobalTimer("#GFAMHAR","GLOBAL",7200)~ EXIT
END

IF ~Global("#GHARAS","GLOBAL",5)~ THEN BEGIN famharas2
   SAY @22
   IF ~GlobalLT("#GMIRPEN","GLOBAL",2)~ THEN DO ~IncrementGlobal("#GHARAS","GLOBAL",1)SetGlobal("#GMIRPEN","GLOBAL",2)SetGlobalTimer("#GFAMHAR","GLOBAL",14400)~ EXIT
   IF ~Global("#GMIRPEN","GLOBAL",2)~ THEN DO ~IncrementGlobal("#GHARAS","GLOBAL",1)SetGlobalTimer("#GFAMHAR","GLOBAL",14400)~ EXIT
END

IF ~Global("#GHARAS","GLOBAL",8)~ THEN BEGIN famgo_haras
   SAY @23
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
  SAY #58296 /* ~The small dragon-like creature purrs quizzically with wide eyes. Nervously it backs away towards <CHARNAME>. Obviously it doesn't want to talk to you.~ */
  IF ~~ THEN DO ~MoveToObject(%famsummoner%)ClearActions(Myself)~ EXIT
END

IF ~InPartySlot(LastTalkedToBy,0)~ THEN BEGIN famtalk
  SAY #58297 /* ~The small dragon-like creature flutters its wings happily, looking at you with almost kaleidoscopic eyes. "You wish something?" It awaits your attention, tail flicking.~ */
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!GlobalsEqual("#GFAMLVL","#GPLALVL")~ THEN REPLY @19 GOTO famlevelup
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMNG","GLOBAL",2)!GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #58298 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO fam1intopack
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMCG","GLOBAL",2)!GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #58866 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO fam2intopack
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #58298 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO famnotpack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMNG","GLOBAL",2)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,30)%IsInBG1%~ THEN REPLY @25 GOTO fam1hurt_intopack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMNG","GLOBAL",2)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,45)%IsInSoA%~ THEN REPLY @25 GOTO fam1hurt_intopack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMNG","GLOBAL",2)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,60)%IsInToB%~ THEN REPLY @25 GOTO fam1hurt_intopack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMCG","GLOBAL",2)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,30)%IsInBG1%~ THEN REPLY @25 GOTO fam2hurt_intopack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMCG","GLOBAL",2)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,45)%IsInSoA%~ THEN REPLY @25 GOTO fam2hurt_intopack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)Global("WTPFAMCG","GLOBAL",2)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,60)%IsInToB%~ THEN REPLY @25 GOTO fam2hurt_intopack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)HPPercentGT(Myself,50)HPPercentGT(%famsummoner%,30)%IsInBG1%~ THEN REPLY @25 GOTO famhurt_notpack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)HPPercentGT(Myself,50)HPPercentGT(%famsummoner%,45)%IsInSoA%~ THEN REPLY @25 GOTO famhurt_notpack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)HPPercentGT(Myself,50)HPPercentGT(%famsummoner%,60)Global("INTOB","GLOBAL",1)~ THEN REPLY @25 GOTO famhurt_notpack
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))~ THEN REPLY #72070 /* ~(pet and play with it)~ */ GOTO fampet
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!HPPercentLT(Myself,100)~ THEN REPLY #73426 /* ~(feed the familiar)~ */ GOTO famfeed_full
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))HPPercentLT(Myself,100)~ THEN REPLY #73432 /* ~(feed the familiar)~ */ GOTO famfeed_hurt
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))%IsInBG1%~ THEN REPLY #58300 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO bg1_advice
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))%IsInSoA%~ THEN REPLY #58300 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO soa_advice
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))%IsInToB%~ THEN REPLY #58300 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO tob_advice
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))~ THEN REPLY #58307 /* ~How are you?  Everything okay down there?~ */ GOTO famstatus
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))Global("#GAFTER","GLOBAL",0)~ THEN REPLY @15 GOTO famclose
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))Global("#GAFTER","GLOBAL",1)~ THEN REPLY @16 GOTO famroam
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))ReputationGT(%famsummoner%,16)~ THEN REPLY #58304 /* ~No, it's alright.  Let's just keep going.~ */ GOTO fam1happy
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!ReputationGT(%famsummoner%,16)~ THEN REPLY #58304 /* ~No, it's alright.  Let's just keep going.~ */ GOTO famneutral
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))~ THEN REPLY @28 GOTO famfight
END

IF ~~ THEN BEGIN fam1intopack
  SAY #58302 /* ~Its eyes brighten, and it practically leaps into your arms, ready to be stowed amongst your belongings where it can sleep and occasionally poke its head out.~ */
  IF ~~ THEN DO ~GivePartyAllEquipment()ReallyForceSpellRES("wtpclear",Myself)Wait(1)GiveItemCreate("wtpfamps",%famsummoner%,0,0,0)SetGlobalTimer("#GWANOUT","GLOBAL",300)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~~ THEN BEGIN fampet
  SAY #58303 /* ~The dragon coos with delight, its multicolored eyes whirling as you pat its warm, leathery hide. "You are very kind to me, my <PRO_LADYLORD>," it purrs.~ */
  IF ~!GlobalsEqual("#GFAMLVL","#GPLALVL")~ THEN REPLY @19 GOTO famlevelup
  IF ~!InventoryFull(%famsummoner%)Global("WTPFAMNG","GLOBAL",2)!GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #58305 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO fam1intopack
  IF ~!InventoryFull(%famsummoner%)Global("WTPFAMCG","GLOBAL",2)!GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #59477 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO fam2intopack
  IF ~!InventoryFull(%famsummoner%)GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY #58298 /* ~Come here.  I want to pick you up and put you in my pack where it's a bit safer.~ */ GOTO famnotpack
  IF ~%IsInBG1%~ THEN REPLY #58300 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO bg1_advice
  IF ~%IsInSoA%~ THEN REPLY #58300 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO soa_advice
  IF ~%IsInToB%~ THEN REPLY #58300 /* ~You wouldn't happen to have any advice, would you?~ */ GOTO tob_advice
  IF ~~ THEN REPLY #58307 /* ~How are you?  Everything okay down there?~ */ GOTO famstatus
  IF ~Global("#GAFTER","GLOBAL",0)~ THEN REPLY @15 GOTO famclose
  IF ~Global("#GAFTER","GLOBAL",1)~ THEN REPLY @16 GOTO famroam
  IF ~ReputationGT(%famsummoner%,16)~ THEN REPLY #58308 /* ~Let's just keep going, then.~ */ GOTO fam1happy
  IF ~!ReputationGT(%famsummoner%,16)~ THEN REPLY #58308 /* ~Let's just keep going, then.~ */ GOTO famneutral
END

IF ~~ THEN BEGIN soa_advice
  SAY #58309 /* ~The familiar cranes its neck back and looks up at you with a slightly bewildered expression.  "You wish to ask *me* for advice, my <PRO_LADYLORD>?"~ */
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
  SAY #58310 /* ~It looks at the darkness for a long moment before turning its colorful eyes back at you. "Let us be away from this dark place, my <PRO_LADYLORD>. That is my advice."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch1_promenade
  SAY #58311 /* ~The dragon looks about quizzically before turnings its multi-faceted eyes back upon you.  "We go to the place of the poor?  The slums, my <PRO_LADYLORD>?  I do not know."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch2
  SAY #58312 /* ~The little dragon chuckles to itself musically.  "You must collect gold, my <PRO_LADYLORD>.  Coins and coins enough to find your answers."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch3
  SAY #58313 /* ~It almost seems to frown, its whirling eyes settling on a baleful yellow before continuing. "I do not know, my <PRO_LADYLORD>. You must continue these tasks, no?"~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch4
  SAY @11 /* ~It ponders for a long moment, flicking its tail absently, before turning back again. "We must stop this wizard. Save you, and the little sister. That is my advice."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch5
  SAY #58315 /* ~It looks around for a moment, its eyes dimming with fear as its tail curls up under its belly.  "We must be away from this place soon, my <PRO_LADYLORD>, please?"~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch6
  SAY #58316 /* ~It thinks for a moment and then its eyes brighten dramatically. "We must find the sacred elven city, my <PRO_LADYLORD>. Your wizard lies therein, I am certain."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch7
  SAY #58317 /* ~It growls menacingly, but not at you. It flicks its tail wickedly several times. "The wizard, my <PRO_LADYLORD>. He must die and you must live."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famstatus
  SAY #58318 /* ~The dragon flicks its tail with pleasure and gazes up at you with colorful eyes.  "So long as you are well, my <PRO_LADYLORD>, then I am well."~ */
  IF ~HPPercentLT(Myself,100)!HPPercentLT(Myself,50)~ THEN GOTO famhurt_light
  IF ~HPPercentLT(Myself,50)~ THEN GOTO famhurt_bad
  IF ~!HPPercentLT(Myself,100)RandomNum(4,1)~ THEN GOTO famokay1
  IF ~!HPPercentLT(Myself,100)RandomNum(4,2)~ THEN GOTO famokay2
  IF ~!HPPercentLT(Myself,100)RandomNum(4,3)~ THEN GOTO famokay3
  IF ~!HPPercentLT(Myself,100)RandomNum(4,4)~ THEN GOTO famokay4
END

IF ~~ THEN BEGIN famhurt_light
  SAY #58320 /* ~"I... I am a little hurt, though, my <PRO_LADYLORD>.  The cuts sting, and I am bleeding.  It... it is not pleasant."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famhurt_bad
  SAY #58321 /* ~"I...I am hurt badly, my <PRO_LADYLORD>. I don't want to die, my <PRO_LADYLORD>. I want to stay with you." The dragon whimpers a little and curls its tail around your leg.~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famokay1
  SAY #58319 /* ~"But since you are asking, I could use a snack.  Perhaps a nice gopher.  Or some pie... ooooh, yes, I *like* pie!"~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famokay2
  SAY #58322 /* ~"I do like traveling with you.  Very much, my <PRO_LADYLORD>.  Do you have an apple?  I could roast the apple a little and then eat it down.  Apples are good!"~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famokay3
  SAY #58323 /* ~I am amazed at all the new places I see with you.  Everything is so wonderful and so colorful!  Is all of the world like this, my <PRO_LADYLORD>?"~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famokay4
  SAY #58324 /* ~"I feel wonderful, myself, my <PRO_LADYLORD>.  My hide is clean and I stand ready to aid you against danger!"~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famneutral
  SAY #58325 /* ~The dragon flicks its tail contentedly and then turns its eyes back to the path before you. "As you wish, my <PRO_LADYLORD>."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN fam2intopack
  SAY #58867 /* ~Its eyes brighten, and it practically leaps into your arms, ready to be stowed amongst your belongings where it can sleep and occasionally poke its head out.~ */
  IF ~~ THEN DO ~GivePartyAllEquipment()ReallyForceSpellRES("wtpclear",Myself)Wait(1)GiveItemCreate("wtpfmfae",%famsummoner%,0,0,0)SetGlobalTimer("#GWANOUT","GLOBAL",300)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~~ THEN BEGIN tob_advice
  SAY #72074 /* ~The familiar cranes its neck back and looks up at you with a slightly bewildered expression.  "You wish to ask *me* for advice, my <PRO_LADYLORD>?"~ */
  IF ~True()~ THEN EXIT
  IF ~Global("chapter","GLOBAL",%bg2_chapter_8%)~ THEN GOTO tob_advice_ch8
  IF ~Global("chapter","GLOBAL",%bg2_chapter_9%)~ THEN GOTO tob_advice_ch9
  IF ~Global("chapter","GLOBAL",%bg2_chapter_10%)~ THEN GOTO tob_advice_ch10
END

IF ~~ THEN BEGIN tob_advice_ch8
  SAY #72694 /* ~The little dragon looks up at you for a moment, its eyes shimmering.  "You must survive, my <PRO_LADYLORD>.  Your heritage places you in great danger!"  It whips its tail about agitatedly.~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN tob_advice_ch9
  SAY #72695 /* ~Its bright eyes look piercingly into yours.  "There has been so much death, my <LADYLORD>.  So much destruction.  But I trust you will find the way to do what is right."~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN tob_advice_ch10
  SAY #72696 /* ~For a moment, the dragon growls fiercely.  "The imposter must die, my <LADYLORD>!  You must somehow go into the Throne of Bhaal and confront her!"~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famfeed_full
  SAY #73428 /* ~You offer the little dragon some nuts and berries that you have stored, and the dragon nibbles on a few of them but doesn't really seem all that hungry.~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famfeed_hurt
  SAY #73430 /* ~The dragon's eyes swirl with pleasure as it noisily gulps down a large quantity of nuts and berries that you have collected.  It's wounds visibly start healing immediately.~ */
  IF ~~ THEN DO ~ApplySpell(Myself,CLERIC_CURE_MEDIUM_WOUNDS)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bg1_advice
  SAY #58309 /* ~The familiar cranes its neck back and looks up at you with a slightly bewildered expression.  "You wish to ask *me* for advice, my <PRO_LADYLORD>?"~ */
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
  SAY @10 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famclose
  SAY @17 /* ~~ */
  IF ~~ THEN DO ~SetGlobal("#GAFTER","GLOBAL",1)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famroam
  SAY @18 /* ~~ */
  IF ~~ THEN DO ~SetGlobal("#GAFTER","GLOBAL",0)RunAwayFrom(%famsummoner%,45)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famlevelup
  SAY @20 /* ~~ */
  IF ~~ THEN DO ~SetGlobal("#GAFTER","GLOBAL",0)SetGlobal("#GFLVUP","GLOBAL",1)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN fam1hurt_intopack
  SAY @26 /* ~~ */
  IF ~~ THEN DO ~GivePartyAllEquipment()ReallyForceSpellRES("wtpclear",Myself)Wait(1)GiveItemCreate("wtpfamps",%famsummoner%,0,0,0)SetGlobalTimer("#GWANOUT","GLOBAL",300)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~~ THEN BEGIN fam2hurt_intopack
  SAY @26 /* ~~ */
  IF ~~ THEN DO ~GivePartyAllEquipment()ReallyForceSpellRES("wtpclear",Myself)Wait(1)GiveItemCreate("wtpfmfae",%famsummoner%,0,0,0)SetGlobalTimer("#GWANOUT","GLOBAL",300)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~~ THEN BEGIN fam1happy
  SAY @27 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famfight
  SAY @29 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famhurt_notpack
  SAY @30 /* ~~ */
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

