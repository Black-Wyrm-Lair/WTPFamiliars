BEGIN ~WTPFAMP4~

IF ~Global("#GHARAS","GLOBAL",2)~ THEN BEGIN famharas1
   SAY @11
   IF ~Global("#GMIRPEN","GLOBAL",0)~ THEN DO ~IncrementGlobal("#GHARAS","GLOBAL",1)SetGlobal("#GMIRPEN","GLOBAL",1)SetGlobalTimer("#GFAMHAR","GLOBAL",7200)~ EXIT
   IF ~GlobalGT("#GMIRPEN","GLOBAL",0)~ THEN DO ~IncrementGlobal("#GHARAS","GLOBAL",1)SetGlobalTimer("#GFAMHAR","GLOBAL",7200)~ EXIT
END

IF ~Global("#GHARAS","GLOBAL",5)~ THEN BEGIN famharas2
   SAY @12
   IF ~GlobalLT("#GMIRPEN","GLOBAL",2)~ THEN DO ~IncrementGlobal("#GHARAS","GLOBAL",1)SetGlobal("#GMIRPEN","GLOBAL",2)SetGlobalTimer("#GFAMHAR","GLOBAL",14400)~ EXIT
   IF ~Global("#GMIRPEN","GLOBAL",2)~ THEN DO ~IncrementGlobal("#GHARAS","GLOBAL",1)SetGlobalTimer("#GFAMHAR","GLOBAL",14400)~ EXIT
END

IF ~Global("#GHARAS","GLOBAL",8)~ THEN BEGIN famgo_haras
   SAY @13
   IF ~~ THEN DO ~ChangeEnemyAlly(Myself,NEUTRAL)SetGlobal("#GFAMGO","GLOBAL",1)~ EXIT
END

IF ~Global("#GINPACK","GLOBAL",1)~ THEN BEGIN faminpack1
   SAY @2
   IF ~~ THEN DO ~IncrementGlobal("#GINPACK","GLOBAL",1)SetGlobalTimer("#GWANOUT","GLOBAL",120)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~Global("#GINPACK","GLOBAL",3)~ THEN BEGIN faminpack2
   SAY @3
   IF ~~ THEN DO ~IncrementGlobal("#GINPACK","GLOBAL",1)SetGlobalTimer("#GWANOUT","GLOBAL",90)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~Global("#GINPACK","GLOBAL",5)~ THEN BEGIN faminpack3
   SAY @4
   IF ~~ THEN DO ~IncrementGlobal("#GINPACK","GLOBAL",1)SetGlobalTimer("#GWANOUT","GLOBAL",60)SetGlobalTimer("#GSTAOUT","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~!InPartySlot(LastTalkedToBy,0)~ THEN BEGIN famshy
  SAY @40
  IF ~~ THEN DO ~MoveToObject(%famsummoner%)ClearActions(Myself)~ EXIT
END

IF ~InPartySlot(LastTalkedToBy,0)~ THEN BEGIN famtalk
  SAY @41
  // Level up familiar
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!GlobalsEqual("#GFAMLVL","#GPLALVL")~ THEN REPLY @9 GOTO famlevelup
  // Ask familiar to go into backpack, familiar accepts
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)!GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY @42 GOTO fam1intopack
  // Ask familiar to go into backpack, familiar rejects
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY @42 GOTO famnotpack
  // Ask hurt familiar to seek safety into backpack, familiar accepts
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,30)%IsInBG1%~ THEN REPLY @15 GOTO fam1hurt_intopack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,45)%IsInSoA%~ THEN REPLY @15 GOTO fam1hurt_intopack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,60)%IsInToB%~ THEN REPLY @15 GOTO fam1hurt_intopack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)OR(2)HPPercentLT(Myself,50)HPPercentLT(%famsummoner%,45)%IsInIWD%~ THEN REPLY @15 GOTO fam1hurt_intopack
  // Ask hurt familiar to seek safety into backpack, familiar rejects
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)HPPercentGT(Myself,50)HPPercentGT(%famsummoner%,30)%IsInBG1%~ THEN REPLY @15 GOTO famhurt_notpack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)HPPercentGT(Myself,50)HPPercentGT(%famsummoner%,45)%IsInSoA%~ THEN REPLY @15 GOTO famhurt_notpack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)HPPercentGT(Myself,50)HPPercentGT(%famsummoner%,60)%IsInToB%~ THEN REPLY @15 GOTO famhurt_notpack
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))!InventoryFull(%famsummoner%)HPPercentGT(Myself,50)HPPercentGT(%famsummoner%,45)%IsInIWD%~ THEN REPLY @15 GOTO famhurt_notpack
  // Pet familiar
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))~ THEN REPLY @43 GOTO fampet
  // Feed familiar
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!HPPercentLT(Myself,100)~ THEN REPLY @44 GOTO famfeed_full
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))HPPercentLT(Myself,100)~ THEN REPLY @44 GOTO famfeed_hurt
  // Ask for advice
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))%IsInBG1%~ THEN REPLY @45 GOTO bg1_advice
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))%IsInSoA%~ THEN REPLY @45 GOTO soa_advice
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))%IsInToB%~ THEN REPLY @45 GOTO tob_advice
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))%IsInIWD%~ THEN REPLY @45 GOTO iwd_advice
  // Ask familiar how it is
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))~ THEN REPLY @47 GOTO famstatus
  // Ask familiar to stay close
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))Global("#GAFTER","GLOBAL",0)~ THEN REPLY @5 GOTO famclose
  // Tell familiar that he can roam freely
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))Global("#GAFTER","GLOBAL",1)~ THEN REPLY @6 GOTO famroam
  // Say goodbye
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))OR(2)ReputationGT(%famsummoner%,16)ReputationLT(%famsummoner%,5)~ THEN REPLY @27 GOTO fam1complain
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))ReputationLT(%famsummoner%,12)ReputationGT(%famsummoner%,8)~ THEN REPLY @27 GOTO fam1happy
  IF ~CombatCounterLT(1)!TriggerOverride(%famsummoner%,Detect([ENEMY]))!ReputationGT(%famsummoner%,16)!ReputationLT(%famsummoner%,5)!Reputation(%famsummoner%,9)!Reputation(%famsummoner%,10)!Reputation(%famsummoner%,11)~ THEN REPLY @27 GOTO famneutral
  // Ask help for fight
  IF ~OR(2)!CombatCounterLT(1)TriggerOverride(%famsummoner%,Detect([ENEMY]))~ THEN REPLY @18 GOTO famfight
END

IF ~~ THEN BEGIN fampet
  SAY @31
  // Level up familiar
  IF ~!GlobalsEqual("#GFAMLVL","#GPLALVL")~ THEN REPLY @9 GOTO famlevelup
  // Ask familiar to go into backpack, familiar accepts
  IF ~!InventoryFull(%famsummoner%)!GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY @42 GOTO fam1intopack
  // Ask hurt familiar to seek safety into backpack, familiar rejects
  IF ~!InventoryFull(%famsummoner%)GlobalTimerNotExpired("#GSTAOUT","GLOBAL")~ THEN REPLY @42 GOTO famnotpack
  // Ask for advice
  IF ~%IsInBG1%~ THEN REPLY @45 GOTO bg1_advice
  IF ~%IsInSoA%~ THEN REPLY @45 GOTO soa_advice
  IF ~%IsInToB%~ THEN REPLY @45 GOTO tob_advice
  IF ~%IsInIWD%~ THEN REPLY @45 GOTO iwd_advice
  // Ask familiar how it is
  IF ~~ THEN REPLY @47 GOTO famstatus
  // Ask familiar to stay close
  IF ~Global("#GAFTER","GLOBAL",0)~ THEN REPLY @5 GOTO famclose
  // Tell familiar that he can roam freely
  IF ~Global("#GAFTER","GLOBAL",1)~ THEN REPLY @6 GOTO famroam
  // Say goodbye
  IF ~OR(2)ReputationGT(%famsummoner%,16)ReputationLT(%famsummoner%,5)~ THEN REPLY @48 GOTO fam1complain
  IF ~ReputationLT(%famsummoner%,12)ReputationGT(%famsummoner%,8)~ THEN REPLY @48 GOTO fam1happy
  IF ~!ReputationGT(%famsummoner%,16)!ReputationLT(%famsummoner%,5)!Reputation(%famsummoner%,9)!Reputation(%famsummoner%,10)!Reputation(%famsummoner%,11)~ THEN REPLY @48 GOTO famneutral
END

IF ~~ THEN BEGIN famstatus
  SAY @32
  IF ~HPPercentLT(Myself,100)!HPPercentLT(Myself,50)~ THEN GOTO famhurt_light
  IF ~HPPercentLT(Myself,50)~ THEN GOTO famhurt_bad
  IF ~!HPPercentLT(Myself,100)RandomNum(4,1)~ THEN GOTO famokay1
  IF ~!HPPercentLT(Myself,100)RandomNum(4,2)~ THEN GOTO famokay2
  IF ~!HPPercentLT(Myself,100)RandomNum(4,3)~ THEN GOTO famokay3
  IF ~!HPPercentLT(Myself,100)RandomNum(4,4)~ THEN GOTO famokay4
END

IF ~~ THEN BEGIN famhurt_light
  SAY @33
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famhurt_bad
  SAY @34
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famokay1
  SAY @35
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famokay2
  SAY @36
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famokay3
  SAY @37
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famokay4
  SAY @38
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famneutral
  SAY @39
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN fam1intopack
  SAY @30
  IF ~~ THEN DO ~SetGlobal("#GEMPCHA","GLOBAL",1)SetGlobal("#GSKIRES","GLOBAL",1)GivePartyAllEquipment()ReallyForceSpellRES("wtpclear",Myself)GiveItemCreate("wtpfmspd",%famsummoner%,0,0,0)SetGlobalTimer("#GWANOUT","GLOBAL",300)SetGlobalTimer("","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~~ THEN BEGIN famfeed_full
  SAY @28
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famfeed_hurt
  SAY @29
  IF ~~ THEN DO ~ApplySpell(Myself,CLERIC_CURE_MEDIUM_WOUNDS)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famnotpack
  SAY @0
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famclose
  SAY @7
  IF ~~ THEN DO ~SetGlobal("#GAFTER","GLOBAL",1)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famroam
  SAY @8
  IF ~~ THEN DO ~SetGlobal("#GAFTER","GLOBAL",0)RunAwayFrom(%famsummoner%,45)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famlevelup
  SAY @10
  IF ~~ THEN DO ~SetGlobal("#GAFTER","GLOBAL",0)SetGlobal("#GFLVUP","GLOBAL",1)ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN fam1hurt_intopack
  SAY @16
  IF ~~ THEN DO ~SetGlobal("#GEMPCHA","GLOBAL",1)SetGlobal("#GSKIRES","GLOBAL",1)GivePartyAllEquipment()GiveItemCreate("wtpfmspd",%famsummoner%,0,0,0)SetGlobalTimer("#GWANOUT","GLOBAL",300)SetGlobalTimer("","GLOBAL",1200)DestroySelf()~ EXIT
END

IF ~~ THEN BEGIN fam1happy
  SAY @17
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famfight
  SAY @19
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN famhurt_notpack
  SAY @20
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN fam1complain
  SAY @23
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bg1_advice
  SAY @46
  // BG1 in BGT
  IF ~%IsBGT%Global("chapter","GLOBAL",%bg1_chapter_0%)~ THEN GOTO bgt1_advice_prologue
  IF ~%IsBGT%Global("chapter","GLOBAL",%bg1_chapter_1%)~ THEN GOTO bgt1_advice_ch1
  IF ~%IsBGT%Global("chapter","GLOBAL",%bg1_chapter_2%)~ THEN GOTO bgt1_advice_ch2
  IF ~%IsBGT%Global("chapter","GLOBAL",%bg1_chapter_3%)~ THEN GOTO bgt1_advice_ch3
  IF ~%IsBGT%Global("chapter","GLOBAL",%bg1_chapter_4%)~ THEN GOTO bgt1_advice_ch4
  IF ~%IsBGT%Global("chapter","GLOBAL",%bg1_chapter_5%)%InBGAreaCheck%~ THEN GOTO bgt1_advice_ch5bg
  IF ~%IsBGT%Global("chapter","GLOBAL",%bg1_chapter_5%)%NotInBGAreaCheck%~ THEN GOTO bgt1_advice_ch5
  IF ~%IsBGT%Global("chapter","GLOBAL",%bg1_chapter_6%)!Global("Teth","Global",1)~ THEN GOTO bgt1_advice_ch6
  IF ~%IsBGT%Global("chapter","GLOBAL",%bg1_chapter_6%)Global("Teth","Global",1)~ THEN GOTO bgt1_advice_ch6teth
  IF ~%IsBGT%Global("chapter","GLOBAL",%bg1_chapter_7%)~ THEN GOTO bgt1_advice_ch7
  // SoD
  IF ~!%IsBGT%Global("CHAPTER","GLOBAL",7)GlobalGT("bd_plot","GLOBAL",0)GlobalLT("bd_plot","GLOBAL",50)~ THEN GOTO bg1ee_advice_ch7b
  IF ~!%IsBGT%Global("CHAPTER","GLOBAL",7)GlobalGT("bd_plot","GLOBAL",51)~ THEN GOTO bg1ee_advice_ch7c
  IF ~!%IsBGT%Global("CHAPTER","GLOBAL",8)~ THEN GOTO bg1ee_advice_ch8
  IF ~!%IsBGT%Global("CHAPTER","GLOBAL",9)~ THEN GOTO bg1ee_advice_ch9
  IF ~!%IsBGT%Global("CHAPTER","GLOBAL",10)GlobalGT("bd_plot","global",304)~ THEN GOTO bg1ee_advice_ch10
  IF ~!%IsBGT%Global("CHAPTER","GLOBAL",11)~ THEN GOTO bg1ee_advice_ch11
  IF ~!%IsBGT%Global("CHAPTER","GLOBAL",12)~ THEN GOTO bg1ee_advice_ch12
  IF ~!%IsBGT%Global("CHAPTER","GLOBAL",13)~ THEN GOTO bg1ee_advice_ch13
  // BG1 in EET or BGEE
  IF ~!%IsBGT%Global("CHAPTER","GLOBAL",0)~ THEN GOTO bg1ee_advice_prologue
  IF ~!%IsBGT%Global("CHAPTER","GLOBAL",1)~ THEN GOTO bg1ee_advice_ch1
  IF ~!%IsBGT%Global("CHAPTER","GLOBAL",2)~ THEN GOTO bg1ee_advice_ch2
  IF ~!%IsBGT%Global("CHAPTER","GLOBAL",3)~ THEN GOTO bg1ee_advice_ch3
  IF ~!%IsBGT%Global("CHAPTER","GLOBAL",4)~ THEN GOTO bg1ee_advice_ch4
  IF ~!%IsBGT%Global("CHAPTER","GLOBAL",5)~ THEN GOTO bg1ee_advice_ch5
  IF ~!%IsBGT%Global("CHAPTER","GLOBAL",6)~ THEN GOTO bg1ee_advice_ch6
  IF ~!%IsBGT%Global("CHAPTER","GLOBAL",7)GlobalGT("bd_plot","GLOBAL",0)GlobalLT("bd_plot","GLOBAL",50)~ THEN GOTO bg1ee_advice_ch7a
END

IF ~~ THEN BEGIN bgt1_advice_prologue
  SAY @50
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch1
  SAY @51
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch2
  SAY @52
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch3
  SAY @53
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch4
  SAY @54
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch5bg
  SAY @55
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch5
  SAY @56
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch6
  SAY @57
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch6teth
  SAY @58
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bgt1_advice_ch7
  SAY @59
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bg1ee_advice_prologue
  SAY @60
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bg1ee_advice_ch1
  SAY @61
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bg1ee_advice_ch2
  SAY @62
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bg1ee_advice_ch3
  SAY @63
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bg1ee_advice_ch4
  SAY @64
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bg1ee_advice_ch5
  SAY @65
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bg1ee_advice_ch6
  SAY @66
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bg1ee_advice_ch7a
  SAY @67
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bg1ee_advice_ch7b
  SAY @68
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bg1ee_advice_ch7c
  SAY @69
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bg1ee_advice_ch8
  SAY @70
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bg1ee_advice_ch9
  SAY @71
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bg1ee_advice_ch10
  SAY @72
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bg1ee_advice_ch11
  SAY @73
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bg1ee_advice_ch12
  SAY @74
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN bg1ee_advice_ch13
  SAY @75
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice
  SAY @46
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
  SAY @76
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch1_promenade
  SAY @77
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch2
  SAY @78
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch3
  SAY @79
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch4
  SAY @80
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch5
  SAY @81
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch6
  SAY @82
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN soa_advice_ch7
  SAY @83
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN tob_advice
  SAY @46
  IF ~True()~ THEN EXIT
  IF ~Global("chapter","GLOBAL",%bg2_chapter_8%)~ THEN GOTO tob_advice_ch8
  IF ~Global("chapter","GLOBAL",%bg2_chapter_9%)~ THEN GOTO tob_advice_ch9
  IF ~Global("chapter","GLOBAL",%bg2_chapter_10%)~ THEN GOTO tob_advice_ch10
END

IF ~~ THEN BEGIN tob_advice_ch8
  SAY @84
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN tob_advice_ch9
  SAY @85
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN tob_advice_ch10
  SAY @86
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN iwd_advice
  SAY @46
  IF ~Global("AR2000_visited","GLOBAL",0)Global("Chapter","GLOBAL",0)~ THEN GOTO iwd_advice_prologue1
  IF ~Global("AR2000_visited","GLOBAL",1)Global("Chapter","GLOBAL",0)~ THEN GOTO iwd_advice_prologue2
  IF ~Global("AR2100_visited","GLOBAL",1)Global("Chapter","GLOBAL",1)~ THEN GOTO iwd_advice_ch1
  IF ~Global("Chapter","GLOBAL",2)~ THEN GOTO iwd_advice_ch2
  IF ~Global("Chapter","GLOBAL",3)~ THEN GOTO iwd_advice_ch3
  IF ~GlobalGT("Chapter","GLOBAL",3)~ THEN GOTO iwd_advice_ch4_part1
  IF ~GlobalGT("Chapter","GLOBAL",3)OR(6)PartyHasItem("Marketh")PartyHasItem("Krilag")PartyHasItem("Maiden")PartyHasItem("Malavon")PartyHasItem("Joril")PartyHasItem("Perdiem")~ THEN GOTO iwd_advice_ch4_part2
  IF ~GlobalGT("Chapter","GLOBAL",3)Global("ALL_KEYS","GLOBAL",6)~ THEN GOTO iwd_advice_ch4_part3
  IF ~GlobalGT("Hjollder_Quest","GLOBAL",2)!Global("HOW_COMPLETED","GLOBAL",1)!Global("Exp_Pause","GLOBAL",1)~ THEN GOTO iwd_advice_how
  IF ~GlobalGT("Master_Quest","GLOBAL",0)GlobalLT("Master_Quest","GLOBAL",7)~ THEN GOTO iwd_advice_totl
END

IF ~~ THEN BEGIN iwd_advice_prologue1
  SAY @87
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN iwd_advice_prologue2
  SAY @88
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN iwd_advice_ch1
  SAY @89
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN iwd_advice_ch2
  SAY @90
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN iwd_advice_ch3
  SAY @91
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN iwd_advice_ch4_part1
  SAY @92
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN iwd_advice_ch4_part2
  SAY @93
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN iwd_advice_ch4_part3
  SAY @94
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN iwd_advice_how
  SAY @95
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END

IF ~~ THEN BEGIN iwd_advice_totl
  SAY @96
  IF ~~ THEN DO ~ClearActions(Myself)~ EXIT
END
