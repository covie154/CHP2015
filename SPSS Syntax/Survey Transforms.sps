*BD3 change to Chinese/Malay/Indian/Others
*Eurasian merge to Others

RECODE BD3(1=0) (2=1) (3=2) (4=3) (5=3) (ELSE=SYSMIS) INTO BD3.1.

VARIABLE LABELS BD3.1 'Race.1'.
VALUE LABELS BD3.1
 0 "Chinese"
 1 "Malay"
 2 "Indian"
 3 "Others".
FORMATS BD3.1(F1).

*BD4 combine Divorced + Separated + Widowed + Others (3,4,5 = 6)

RECODE BD4(1=0) (2=1) (3,4,5=2) (ELSE=SYSMIS) INTO BD4.1.

VARIABLE LABELS BD4.1 'Marital status.1'.
VALUE LABELS BD4.1
 0 "Single"
 1 "Married"
 2 "Others".
FORMATS BD4.1(F1).

*BD5a Employed
*BD5a Unemployed
*BD5a Retired

RECODE BD5A(1,2,3,4=0) (5,6,7=1) (8=2) INTO BD5A.1.

VARIABLE LABELS BD5A.1 'Current Employment.1'.
VALUE LABELS BD5A.1 
 0 "Employed"
 1 "Unemployed"
 2 "Retired".
FORMATS BD5A.1(F1).

*BD5b Merge into yes/no

RECODE BD5B(0=0) (1 THRU 9=1) INTO BD5B.1.

VARIABLE LABELS BD5B.1 'Healthcare worker.1'.
VALUE LABELS BD5B.1 
 0 "No"
 1 "Yes".
FORMATS BD5B.1(F1).

*BD6 Pre-secondary and post-secondary

RECODE BD6(1 THRU 6=0) (7 THRU 10=1) INTO BD6.1.

VARIABLE LABELS BD6.1 'Highest educational level.1'.
VALUE LABELS BD6.1
 0 "Secondary and below"
 1 "Post-secondary education".
FORMATS BD6.1(F1).

*BD7 1,2,3 4,5,E

RECODE BD7(1 THRU 3=0) (4 THRU 6=1) INTO BD7.1.

VARIABLE LABELS BD7.1 'Housing.1'.
VALUE LABELS BD7.1 
 0 "1-3 Rooms"
 1 "4 Rooms and above".
FORMATS BD7.1(F1).

*BD8 1-4, 5-10

RECODE BD8(1 THRU 4=0) (5 THRU 10=1) INTO BD8.1.

VARIABLE LABELS BD8.1 'Household Size.1'.
VALUE LABELS BD8.1 
 0 "1-4 people"
 1 "5 people and above".
FORMATS BD8.1(F1).

* BD9 1-4, 5-8, ELSE=SYSMIS

RECODE BD9 (1 THRU 4=0) (5 THRU 8=1) (9, 10=2) INTO BD9.1.

VARIABLE LABELS BD9.1 'Household Income.1'.
VALUE LABELS BD9.1 
 0 "<$4000"
 1 ">$4000"
 2 "Did not reveal".
FORMATS BD9.1(F1).

*BD10 Keep
***

*BD11, 12
*0, 0 = 0
*1, 0 = 1
*0, 1 = 1
*1, 1 = 1

COMPUTE BD11.12.1=BD11|BD12.

VARIABLE LABELS BD11.12.1 'Heart Disease Family/Friends'.
VALUE LABELS BD11.12.1 
 0 "No"
 1 "Yes".
FORMATS BD11.12.1(F1).

*******************************************************************************

*CA13-18 Combine wrong with don't know

RECODE CA13(0=1) (1=0) (2=0) INTO CA13.1.
RECODE CA14(3=0) (1=1) (2=0) INTO CA14.1.
RECODE CA15(0=0) (1=1) (2=0) INTO CA15.1.
RECODE CA16(0=0) (1=1) (2=0) INTO CA16.1.
RECODE CA17(0=0) (1=1) (2=0) INTO CA17.1.
RECODE CA18(0=0) (1=1) (2,3,4=0) INTO CA18.1.

VARIABLE LABELS CA13.1 'Cardiac arrest is the same as heart attack'.
VARIABLE LABELS CA14.1 'Cardiac arrest is more common in'.
VARIABLE LABELS CA15.1 'Cardiac arrest occurs in teenagers'.
VARIABLE LABELS CA16.1 'Cardiac arrest occurs in people without previous heart problems'.
VARIABLE LABELS CA17.1 'A person in cardiac arrest may not have chest pain'.
VARIABLE LABELS CA18.1 'Cardiac arrest cases usually occur'.
VALUE LABELS CA13.1 to CA18.1 
 0 "Wrong"
 1 "Correct".
FORMATS CA13.1 to CA18.1(F1).

*CA19

COMPUTE CA19.11 = CA19.4=1 & CA19.5=1.

VARIABLE LABELS CA19.11 'Identify if someone is in CA'.
VALUE LABELS CA19.11 
 0 "Incorrect"
 1 "Correct".
FORMATS CA19.11(F1).

*CA20 see if anyone has 3,5,6 in any order
*CA20 see who gets correct sequence (3,5,6)

COMPUTE CA20.11 = CA20.1=3 & CA20.2=5 & CA20.3=6.

VARIABLE LABELS CA20.11 'Collapse order (3, 5, 6)'.
VALUE LABELS CA20.11 
 0 "Wrong order"
 1 "Correct order".
FORMATS CA20.11(F1).

COMPUTE CA20.12 = 
 (CA20.1=3 | CA20.1=5 | CA20.1=6) &
 (CA20.2=3 | CA20.2=5 | CA20.2=6) &
 (CA20.3=3 | CA20.3=5 | CA20.3=6) .
 
VARIABLE LABELS CA20.12 'Any order of 3/5/6'.
VALUE LABELS CA20.12
 0 "Wrong order"
 1 "Correct order".
FORMATS CA20.12(F1). 

*CA21 leave it

**********************************************************************

*CPR22 23 combine into 1, put into a BD22

COMPUTE BD22.1 = CPR22+CPR23.

VARIABLE LABELS BD22.1 "CPR Score".
VALUE LABELS BD22.1 
 0 "Don't know what CPR is, not trained in CPR"
 1 "Know what CPR is, not trained in CPR OR don’t know what CPR is, trained in CPR"
 2 "Know what CPR is, trained in CPR.".
FORMATS BD22.1(F1).

*CPR24 Rename to BD24

RENAME VARIABLES (CPR24=BD24).

*CPR25A-E Recode to right/wrong ans

RECODE CPR25A(1=1) (2 THRU 4 =0) INTO CPR25A.1.
RECODE CPR25B(1,2=0) (3=1) (4,5=0) INTO CPR25B.1.
RECODE CPR25C(1 THRU 4=0) (5=1) (6=0) INTO CPR25C.1.
RECODE CPR25D(1=0) (2=1) (3 THRU 6=0) INTO CPR25D.1.
RECODE CPR25E(0=1) (1,2=0) INTO CPR25E.1.

VARIABLE LABELS CPR25A.1 "CPR should be started".
VARIABLE LABELS CPR25B.1 "# of chest compressions per minute".
VARIABLE LABELS CPR25C.1 "Depth of compressions".
VARIABLE LABELS CPR25D.1 "Site of compression".
VARIABLE LABELS CPR25E.1 "Need for mouth-to-mouth ventilation".
VALUE LABELS CPR25A.1 to CPR25E.1 
 0 "Wrong"
 1 "Correct".
FORMATS CPR25A.1 to CPR25E.1(F1).

*CPR25F Quartiles

RECODE CPR25F(1,2,3=0) (4=1) (5=2) (6,7,8=3) (9=4) INTO CPR25F.1.

VARIABLE LABELS CPR25F.1 "OHCA rate of survival".
VALUE LABELS CPR25F.1 
 0 "0-24%"
 1 "25-49%"
 2 "50-74%"
 3 "75-100%"
 4 "Don't know".
FORMATS CPR25F.1(F1).

*CPR26 right/wrong R/W

RECODE CPR26A1 (0=1) (1,2=0) INTO CPR26A1.1.
RECODE CPR26A2 (0=1) (1,2=0) INTO CPR26A2.1.
RECODE CPR26B1 (0=1) (1,2=0) INTO CPR26B1.1.
RECODE CPR26B2 (0=1) (1,2=0) INTO CPR26B2.1.
RECODE CPR26C1 (1=1) (0,2=0) INTO CPR26C1.1.
RECODE CPR26C2 (1=1) (0,2=0) INTO CPR26C2.1.
RECODE CPR26D1 (1=1) (0,2=0) INTO CPR26D1.1.
RECODE CPR26D2 (1=1) (0,2=0) INTO CPR26D2.1.

VARIABLE LABELS CPR26A1.1 "AMI CA".
VARIABLE LABELS CPR26A2.1 "AMI CPR".
VARIABLE LABELS CPR26B1.1 "Seizure CA".
VARIABLE LABELS CPR26B2.1 "Seizure CPR".
VARIABLE LABELS CPR26C1.1 "CA CA".
VARIABLE LABELS CPR26C2.1 "CA CPR".
VARIABLE LABELS CPR26D1.1 "Agonal CA".
VARIABLE LABELS CPR26D2.1 "Agonal CPR".
VALUE LABELS CPR26A1.1 to CPR26D2.1 
 0 "Wrong"
 1 "Correct".
FORMATS CPR26A1.1 to CPR26D2.1(F1).

*CPR27 combine NA with D OP

RECODE CPR27A (0,3=0) (1=1) (2=2) INTO CPR27A.1.
RECODE CPR27B (0,3=0) (1=1) (2=2) INTO CPR27B.1.
RECODE CPR27C (0,3=0) (1=1) (2=2) INTO CPR27C.1.
RECODE CPR27D (0,3=0) (1=1) (2=2) INTO CPR27D.1.
RECODE CPR27E (0,3=0) (1=1) (2=2) INTO CPR27E.1.
RECODE CPR27F (0,3=0) (1=1) (2=2) INTO CPR27F.1.
RECODE CPR27G (0,3=0) (1=1) (2=2) INTO CPR27G.1.
RECODE CPR27H (0,3=0) (1=1) (2=2) INTO CPR27H.1.

VARIABLE LABELS CPR27A.1 "Barrier to CPR: Not confident".
VARIABLE LABELS CPR27B.1 "Barrier to CPR: Not sure".
VARIABLE LABELS CPR27C.1 "Barrier to CPR: Injury".
VARIABLE LABELS CPR27D.1 "Barrier to CPR: M2M ventilation".
VARIABLE LABELS CPR27E.1 "Barrier to CPR: M2M ID".
VARIABLE LABELS CPR27F.1 "Barrier to CPR: Legal".
VARIABLE LABELS CPR27G.1 "Barrier to CPR: Male chest".
VARIABLE LABELS CPR27H.1 "Barrier to CPR: Female chest".
VALUE LABELS CPR27A.1 to CPR27H.1 
 0 "Disagree"
 1 "Agree"
 2 "Don't know".
FORMATS CPR27A.1 to CPR27H.1(F1).

*CPR28 Combine NA with A OP

RECODE CPR28A (0=0) (1,3=1) (2=2) INTO CPR28A.1.
RECODE CPR28B (0=0) (1,3=1) (2=2) INTO CPR28B.1.
RECODE CPR28C (0=0) (1,3=1) (2=2) INTO CPR28C.1.
RECODE CPR28D (0=0) (1,3=1) (2=2) INTO CPR28D.1.
RECODE CPR28E (0=0) (1,3=1) (2=2) INTO CPR28E.1.
RECODE CPR28F (0=0) (1,3=1) (2=2) INTO CPR28F.1.

VARIABLE LABELS CPR28A.1 "CPR Willingness: Same sex".
VARIABLE LABELS CPR28B.1 "CPR Willingness: Young adult".
VARIABLE LABELS CPR28C.1 "CPR Willingness: Elderly".
VARIABLE LABELS CPR28D.1 "CPR Willingness: Friend/Family".
VARIABLE LABELS CPR28E.1 "CPR Willingness: Someone assisting".
VARIABLE LABELS CPR28F.1 "CPR Willingness: Public place".
VALUE LABELS CPR28A.1 to CPR28F.1 
 0 "Disagree"
 1 "Agree"
 2 "Don't know".
FORMATS CPR28A.1 to CPR28F.1(F1).

**********************************************************************

*DACPR29 Recode to too fast, ok (6-10mins), too slow

RECODE DACPR29 (1,2,3=0) (4=1) (5=2) (6=3) INTO DACPR29.1.

VARIABLE LABELS DACPR29.1 "Ambulance time of arrival".
VALUE LABELS DACPR29.1 
 0 "Too fast"
 1 "Correct"
 2 "Too slow"
 3 "Don't know".
FORMATS DACPR29.1(F1).

*DACPR30 Combine D with don't know R/W

RECODE DACPR30A (0,2=0) (1=1) INTO DACPR30A.1.
RECODE DACPR30B (0,2=0) (1=1) INTO DACPR30B.1.
RECODE DACPR30C (0,2=0) (1=1) INTO DACPR30C.1.
RECODE DACPR30D (1,2=0) (0=1) INTO DACPR30D.1.
RECODE DACPR30E (0,2=0) (1=1) INTO DACPR30E.1.

VARIABLE LABELS DACPR30A.1 "DACPR knowledge: Reassurance".
VARIABLE LABELS DACPR30B.1 "DACPR knowledge: Conscious".
VARIABLE LABELS DACPR30C.1 "DACPR knowledge: Breathing".
VARIABLE LABELS DACPR30D.1 "DACPR knowledge: Cardiac arrest".
VARIABLE LABELS DACPR30E.1 "DACPR knowledge: Perform CPR".
VALUE LABELS DACPR30A.1 to DACPR30E.1 
 0 "Wrong"
 1 "Correct".
FORMATS DACPR30A.1 to DACPR30E.1(F1).

*DACPR31a leave alone

*DACPR31b combine Y and don't know

RECODE DACPR31B (0=1) (1,2=0) INTO DACPR31B.1.

VARIABLE LABELS DACPR31B.1 "DACPR: Delay ambulance arrival".
VALUE LABELS DACPR31B.1 
 0 "Wrong"
 1 "Correct".
FORMATS DACPR31B.1(F1).

*DACPR32 combine NA with D

RECODE DACPR32A (3,0=0) (1=1) (2=2) INTO DACPR32A.1.
RECODE DACPR32B (3,0=0) (1=1) (2=2) INTO DACPR32B.1.
RECODE DACPR32C (3,0=0) (1=1) (2=2) INTO DACPR32C.1.
RECODE DACPR32D (3,0=0) (1=1) (2=2) INTO DACPR32D.1.
RECODE DACPR32E (3,0=0) (1=1) (2=2) INTO DACPR32E.1.
RECODE DACPR32F (3,0=0) (1=1) (2=2) INTO DACPR32F.1.
RECODE DACPR32G (3,0=0) (1=1) (2=2) INTO DACPR32G.1.
RECODE DACPR32H (3,0=0) (1=1) (2=2) INTO DACPR32H.1.

VARIABLE LABELS DACPR32A.1 "DACPR barrier effectiveness: Not confident".
VARIABLE LABELS DACPR32B.1 "DACPR barrier effectiveness: Not sure".
VARIABLE LABELS DACPR32C.1 "DACPR barrier effectiveness: Injury".
VARIABLE LABELS DACPR32D.1 "DACPR barrier effectiveness: M2M ventilation".
VARIABLE LABELS DACPR32E.1 "DACPR barrier effectiveness: M2M ID".
VARIABLE LABELS DACPR32F.1 "DACPR barrier effectiveness: Legal".
VARIABLE LABELS DACPR32G.1 "DACPR barrier effectiveness: Male chest".
VARIABLE LABELS DACPR32H.1 "DACPR barrier effectiveness: Female chest".
VALUE LABELS DACPR32A.1 to DACPR32H.1 
 0 "Disagree"
 1 "Agree"
 2 "Don't know".
FORMATS DACPR32A.1 to DACPR32H.1(F1).

**********************************************************************
*Interventional Combining

*COMPUTE Video1Q1=Intervention1Q1.
*IF MISSING(Intervention1Q1) Video1Q1=Control1Q1.

COMPUTE Study1Q1 = Intervention1Q1.
IF MISSING(Intervention1Q1) Study1Q1=Control1Q1.
COMPUTE Study1Q2 = Intervention1Q2.
IF MISSING(Intervention1Q2) Study1Q2=Control1Q2.

COMPUTE Study2Q1 = Intervention2Q1.
IF MISSING(Intervention2Q1) Study2Q1=Control2Q1.
COMPUTE Study2Q2 = Intervention2Q2.
IF MISSING(Intervention2Q2) Study2Q2=Control2Q2.

COMPUTE Study3Q1 = Intervention3Q1.
IF MISSING(Intervention3Q1) Study3Q1=Control3Q1.
COMPUTE Study3Q2 = Intervention3Q2.
IF MISSING(Intervention3Q2) Study3Q2=Control3Q2.

COMPUTE Study4Q1 = Intervention4Q1.
IF MISSING(Intervention4Q1) Study4Q1=Control4Q1.
COMPUTE Study4Q2 = Intervention4Q2.
IF MISSING(Intervention4Q2) Study4Q2=Control4Q2.

VARIABLE LABELS Study1Q1 "YeenamAsleep - Q1".
VARIABLE LABELS Study1Q2 "YeenamAsleep - Q2".
VARIABLE LABELS Study2Q1 "YeenamSnoring - Q1".
VARIABLE LABELS Study2Q2 "YeenamSnoring - Q2".
VARIABLE LABELS Study3Q1 "BLApnoea - Q1".
VARIABLE LABELS Study3Q2 "BLApnoea - Q2".
VARIABLE LABELS Study4Q1 "YeenamAgonalGasps - Q1".
VARIABLE LABELS Study4Q2 "YeenamAgonalGasps - Q2".
VALUE LABELS Study1Q1 to Study4Q2
 0 "No"
 1 "Yes"
 2 "Don't know".
FORMATS Study1Q1 to Study4Q2(F1).

**********************************************************************
*Interventional Computing

COMPUTE Baseline1s = (Baseline1Q1=0) & (Baseline1Q2=0).
COMPUTE Baseline2s = (Baseline2Q1=0) & (Baseline2Q2=0).
COMPUTE Baseline3s = (Baseline3Q1=1) & (Baseline3Q2=1).
COMPUTE Baseline4s = (Baseline2Q1=1) & (Baseline2Q2=0).

COMPUTE Study1s = (Study1Q1=1) & (Study1Q2=1).
COMPUTE Study2s = (Study2Q1=1) & (Study2Q2=1).
COMPUTE Study3s = (Study3Q1=0) & (Study3Q2=0).
COMPUTE Study4s = (Study4Q1=0) & (Study4Q2=0).

VARIABLE LABELS Baseline1s "DanielAgonalGasps - Correct".
VARIABLE LABELS Baseline2s "YeenamApnoea - Correct".
VARIABLE LABELS Baseline3s "YeenamChewing - Correct".
VARIABLE LABELS Baseline4s "YeenamTachypnoea - Correct".

VARIABLE LABELS Study1s "YeenamAsleep - Correct".
VARIABLE LABELS Study2s "YeenamSnoring - Correct".
VARIABLE LABELS Study3s "BLApnoea - Correct".
VARIABLE LABELS Study4s "YeenamAgonalGasps - Correct".

VALUE LABELS Baseline1s to Study4s
 0 "No"
 1 "Yes".
FORMATS Baseline1s to Study4s(F1).

**********************************************************************

Execute.
