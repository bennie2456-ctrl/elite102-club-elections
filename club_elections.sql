-- ── Club Members ────────────────────────────────────
-- Drop first so you can re-run this script cleanly.
DROP TABLE IF EXISTS votes;
DROP TABLE IF EXISTS clubMembers;

CREATE TABLE clubMembers (
    id            INTEGER PRIMARY KEY,
    name          TEXT    NOT NULL,
    grade         INTEGER NOT NULL,
    favoriteColor TEXT
);

INSERT INTO clubMembers (id, name, grade, favoriteColor) VALUES
    (1, 'Alice',  10, 'red'),
    (2, 'Beth',   11, 'blue'),
    (3, 'Carlos', 10, 'green'),
    (4, 'Dana',   12, 'blue'),
    (5, 'Eli',    11, NULL),
    (6, 'Fay',    10, 'red'),
    (7, 'Grace',  12, 'purple'),
    (8, 'Hank',   11, NULL);

-- ── Votes ───────────────────────────────────────────
-- voterId     = the member casting the vote
-- candidateId = the member they voted for
-- Grace (7) and Hank (8) did not vote.
CREATE TABLE votes (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    voterId     INTEGER NOT NULL,
    candidateId INTEGER NOT NULL,
    FOREIGN KEY (voterId)     REFERENCES clubMembers(id),
    FOREIGN KEY (candidateId) REFERENCES clubMembers(id)
);

INSERT INTO votes (voterId, candidateId) VALUES
    (1, 2),  -- Alice  -> Beth
    (2, 2),  -- Beth   -> Beth
    (3, 4),  -- Carlos -> Dana
    (4, 4),  -- Dana   -> Dana
    (5, 2),  -- Eli    -> Beth
    (6, 7);  -- Fay    -> Grace

SELECT * FROM clubMembers;
SELECT * FROM votes;

-- Question 1. Who is member #5?
SELECT name FROM clubMembers
    WHERE id = 5;
-- Question 2. What is their favorite color?
SELECT favoritecolor FROM clubMembers
Where name = 'Eli';
 -- Questions 3. Whose favorite color is blue? 
SELECT name FROM clubMembers
    WHERE favoritecolor = 'blue';
-- Question 4. Who doesn't have a favorite color?
SELECT name FROM clubMembers
Where favoritecolor IS NULL;
-- Question 5. How many members are there?
SELECT COUNT(*) FROM clubMembers;
-- Question 6. How many are in 10th grade?
SELECT COUNT(*) FROM clubMembers

    
-- Question 7. Who did member #6 vote for? 
SELECT candidateId FROM votes
WHErE voterID = 6;
-- Question 8. Who did Beth vote for?
SELECT candidateid FROM votes
WHERE id = 2;
-- Question 9. Who voted for Beth? 
SELECT voterid FROM votes
WHERE candidateid = 2;
-- Question 10. Who voted for themselves?
SELECT voterid FROM votes
WHERE voterid = candidateid;
Where grade = 10;
-- Question 11. Who didn't vote?
SELECT name FROM clubMembers
LEFT JOIN votes on clubMembers.id = votes.voterId
WHERE votes.voterId IS NULL;
-- Question 12. What are the election results (candidate + vote count)?
SELECT candidateid, COUNT(*) AS total_votes FROM votes
GROUP BY candidateid;
-- Question 13. Who won?
SELECT candidateid, COUNT(*) AS total_votes FROM votes
GROUP BY candidateid
ORDER BY total_votes DESC
LIMIT 1;


-- Question 14. Add Isabel (id 9, grade 8, favorite color purple)
INSERT INTO clubMembers (id, name, grade, favoritecolor) VALUES
(9, 'Isabel', 8, 'purple');
SELECT * FROM clubMembers;
-- Question 15. Record that Isabel voted for Beth
INSERT INTO votes (voterId, candidateId) VALUES
    (9, 2); -- Isabel   -> Beth
SELECT candidateid FROM votes
WHERE voterid = 9;
-- Question 16. Change Isabel's vote to Dana.
UPDATE votes SET candidateid = 4
WHERE voterid = 9;
SELECT candidateid FROM votes
WHERE voterid = 9;
-- Question 17. Remove Isabel's vote
DELETE FROM votes 
WHERE voterId = 9;
SELECT candidateid FROM votes
WHERE voterId = 9;
