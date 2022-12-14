--=============================================================================
-- Data
--=============================================================================
b = LOAD 'hdfs:/user/maria_dev/pig/Batting.csv' USING PigStorage(',') AS (playerID:chararray,yearID:int,teamID:chararray,lgID:chararray,G:int,AB:int,R:int,H:int,B2:int,B3:int,HR:int,RBI:int,SB:int,CS:int,BB:int,SO:int,IBB:int,HBP:int,SH:int,SF:int,GIDP:int);
m = LOAD 'hdfs:/user/maria_dev/pig/Master.csv' USING PigStorage(',') AS (playerID:chararray,birthYear:int,birthMonth:int,birthDay:int,birthCountry:chararray,birthState:chararray,birthCity:chararray,deathYear:int,deathMonth:int,deathDay:int,deathCountry:chararray,deathState:chararray,deathCity:chararray,nameFirst:chararray,nameLast:chararray,nameGiven:chararray,weight:int,height:int,bats:chararray,throws:chararray,debut:datetime,finalGame:datetime,retroID:chararray,bbrefID:chararray);

--=============================================================================
-- Main
--=============================================================================
A = FOREACH b GENERATE playerID, AB;
B = GROUP A BY playerID;
C = FOREACH B GENERATE group AS playerID, SUM(A.AB) AS tot;
D = RANK C by tot DESC DENSE;
E = FILTER D by rank_C == 1;
F = FOREACH m GENERATE playerID, birthCity;
G = JOIN E BY playerID, F BY playerID;
H = FOREACH G GENERATE F::birthCity;
DUMP H;
