bat = LOAD 'hdfs:/user/maria_dev/pigtest/Batting.csv' USING PigStorage(',') AS (playerID:chararray,yearID:int,teamID:chararray,lgID:chararray,G:int,AB:int,R:int,H:int,B2:int,B3:int,HR:int,RBI:int,SB:int,CS:int,BB:int,SO:int,IBB:int,HBP:int,SH:int,SF:int,GIDP:int);
mas = LOAD 'hdfs:/user/maria_dev/pigtest/Master.csv' USING PigStorage(',') AS (playerID:chararray,birthYear:int,birthMonth:int,birthDay:int,birthCountry:chararray,birthState:chararray,birthCity:chararray,deathYear:int,deathMonth:int,deathDay:int,deathCountry:chararray,deathState:chararray,deathCity:chararray,nameFirst:chararray,nameLast:chararray,nameGiven:chararray,weight:int,height:int,bats:chararray,throws:chararray,debut:datetime,finalGame:datetime,retroID:chararray,bbrefID:chararray);
df = JOIN bat BY playerID, mas BY playerID;
df2 = FILTER df BY bats == 'R' AND birthMonth == 10 AND deathYear == 2011;
df3 = GROUP df2 BY mas::playerID;
df4 = FOREACH df3 GENERATE group,  COUNT(df2.H) AS cnt;
df5 = GROUP df4 ALL;
df6 = FOREACH df5 GENERATE MAX(df4.cnt) AS max_cnt;
df7 = JOIN df6 BY max_cnt, df4 BY cnt;
df8 = FOREACH df7 GENERATE df4::group;
DUMP df8;
