BEGIN ~WTPWISH~

IF ~Global("wishjames","LOCALS",0)~ THEN BEGIN 1
  SAY @0
  IF ~~ THEN REPLY @1 DO ~SetGlobal("wishjames","LOCALS",1)ActionOverride("wtpfairy",FaceObject("wtpwish"))~ GOTO 2
  IF ~~ THEN REPLY @2 DO ~SetGlobal("wishjames","LOCALS",1)ActionOverride("wtpfairy",FaceObject("wtpwish"))~ GOTO 3
END

IF ~~ THEN BEGIN 2
  SAY @4
  IF ~CheckStatGT(LastTalkedToBy,9,WIS)~ THEN REPLY @7 GOTO 4
  IF ~CheckStatGT(LastTalkedToBy,11,WIS)~ THEN REPLY @8 GOTO 5
  IF ~CheckStatGT(LastTalkedToBy,9,WIS)~ THEN REPLY @9 GOTO 6
  IF ~~ THEN REPLY @5 GOTO 7
END

IF ~~ THEN BEGIN 3
  SAY @3
  IF ~~ THEN DO ~SetInterrupt(FALSE)
ForceSpell(Myself,DRYAD_TELEPORT)~ EXIT
END

IF ~~ THEN BEGIN 4
  SAY @10
  IF ~~ THEN DO ~ActionOverride(LastTalkedToBy,ReallyForceSpellRES("WTPWIS1",Myself))
SetInterrupt(FALSE)
ForceSpell(Myself,DRYAD_TELEPORT)~ EXIT
END

IF ~~ THEN BEGIN 5
  SAY @11
  IF ~~ THEN DO ~ActionOverride(LastTalkedToBy,ReallyForceSpell(Myself,WISH_GLOBE))
ActionOverride(Player1,ReallyForceSpell(Myself,WISH_GLOBE))
ActionOverride(Player2,ReallyForceSpell(Myself,WISH_GLOBE))
ActionOverride(Player3,ReallyForceSpell(Myself,WISH_GLOBE))
ActionOverride(Player4,ReallyForceSpell(Myself,WISH_GLOBE))
ActionOverride(Player5,ReallyForceSpell(Myself,WISH_GLOBE))
ActionOverride(Player6,ReallyForceSpell(Myself,WISH_GLOBE))
SetInterrupt(FALSE)
ForceSpell(Myself,DRYAD_TELEPORT)~ EXIT
END

IF ~~ THEN BEGIN 6
  SAY @12
  IF ~~ THEN DO ~ActionOverride(LastTalkedToBy,ReallyForceSpell(Myself,CLERIC_NEGATIVE_PLANE_PROTECTION))
ActionOverride(Player1,ReallyForceSpell(Myself,CLERIC_NEGATIVE_PLANE_PROTECTION))
ActionOverride(Player2,ReallyForceSpell(Myself,CLERIC_NEGATIVE_PLANE_PROTECTION))
ActionOverride(Player3,ReallyForceSpell(Myself,CLERIC_NEGATIVE_PLANE_PROTECTION))
ActionOverride(Player4,ReallyForceSpell(Myself,CLERIC_NEGATIVE_PLANE_PROTECTION))
ActionOverride(Player5,ReallyForceSpell(Myself,CLERIC_NEGATIVE_PLANE_PROTECTION))
ActionOverride(Player6,ReallyForceSpell(Myself,CLERIC_NEGATIVE_PLANE_PROTECTION))
SetInterrupt(FALSE)
ForceSpell(Myself,DRYAD_TELEPORT)~ EXIT
END

IF ~~ THEN BEGIN 7
  SAY @6
  IF ~~ THEN DO ~SetInterrupt(FALSE)
ForceSpell(Myself,DRYAD_TELEPORT)~ EXIT
END
