-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.
-- This is where the database schema will go in the form of SQL create table 
-- commands.
--
-- Give tables names that makes sense to me, and give columns descriptive 
-- names 
DROP DATABASE IF EXISTS tournament;
CREATE DATABASE tournament;
-- Connect to database
\c tournament; 
-- This table includes the player information, such as player id, name, wins,
-- and matches played. 
-- Create player table
CREATE TABLE players (
       id serial PRIMARY KEY,
       name text
       );
-- This table contains the information from each match and the player's id in
-- relation to wins and losses.
Create TABLE matches (
        match_id serial PRIMARY KEY,
        winner int REFERENCES players(id),
        loser int REFERENCES players(id)
        );
-- Create player standing view
CREATE VIEW standings AS 
		SELECT players.id,
		           players.name,
		           (SELECT count(*) FROM matches WHERE players.id = matches.winner) AS wins,
		           (SELECT count(*) FROM matches WHERE players.id = matches.winner OR Players.id =matches.loser) AS matches
		FROM players
		ORDER BY wins DESC;