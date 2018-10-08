bat = LOAD 'hdfs:/user/maria_dev/pigtest/Batting.csv' USING PigStorage(',') AS (playerID:chararray,yearID:int,teamID:chararray,lgID:chararray,G:int,AB:int,R:int,H:int,B2:int,B3:int,HR:int,RBI:int,SB:int,CS:int,BB:int,SO:int,IBB:int,HBP:int,SH:int,SF:int,GIDP:int);
mas = LOAD 'hdfs:/user/maria_dev/pigtest/Master.csv' USING PigStorage(',') AS (playerID:chararray,birthYear:int,birthMonth:int,birthDay:int,birthCountry:chararray,birthState:chararray,birthCity:chararray,deathYear:int,deathMonth:int,deathDay:int,deathCountry:chararray,deathState:chararray,deathCity:chararray,nameFirst:chararray,nameLast:chararray,nameGiven:chararray,weight:int,height:int,bats:chararray,throws:chararray,debut:datetime,finalGame:datetime,retroID:chararray,bbrefID:chararray);
df = JOIN bat BY playerID, mas BY playerID;
df2 = GROUP df BY (bat::playerID, bat::yearID);
df3 = FOREACH df2 GENERATE group, COUNT(df.mas::playerID) AS cnt;
df4 = GROUP df3 ALL;
df5 = FOREACH df4 GENERATE MAX(df3.cnt) AS max_cnt;
df6 = JOIN df5 BY max_cnt, df3 BY cnt;