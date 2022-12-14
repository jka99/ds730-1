--=============================================================================
-- Data
--=============================================================================
b = LOAD 'hdfs:/user/maria_dev/pig/Batting.csv' USING PigStorage(',') AS (playerID:chararray,yearID:int,teamID:chararray,lgID:chararray,G:int,AB:int,R:int,H:int,B2:int,B3:int,HR:int,RBI:int,SB:int,CS:int,BB:int,SO:int,IBB:int,HBP:int,SH:int,SF:int,GIDP:int);
m = LOAD 'hdfs:/user/maria_dev/pig/Master.csv' USING PigStorage(',') AS (playerID:chararray,birthYear:int,birthMonth:int,birthDay:int,birthCountry:chararray,birthState:chararray,birthCity:chararray,deathYear:int,deathMonth:int,deathDay:int,deathCountry:chararray,deathState:chararray,deathCity:chararray,nameFirst:chararray,nameLast:chararray,nameGiven:chararray,weight:int,height:int,bats:chararray,throws:chararray,debut:datetime,finalGame:datetime,retroID:chararray,bbrefID:chararray);
f = LOAD 'hdfs:/user/maria_dev/pig/Fielding.csv' USING PigStorage(',') AS (playerID:chararray,yearID:int,teamID:chararray,lgID:chararray,POS:chararray,G:int,GS:int,InnOuts:int,PO:int,A:int,E:int,DP:int,PB:int,WP:int,SB:int,CS:int,ZR:int);
--=============================================================================
-- Main
--=============================================================================
A = FOREACH f GENERATE playerID, E;
B = GROUP A BY playerID;
C = FOREACH B GENERATE group, SUM(A.E) AS tot;
D = RANK C by tot DESC DENSE;
E = FILTER D BY rank_C == 1;
F = FOREACH E GENERATE group;
DUMP F;
