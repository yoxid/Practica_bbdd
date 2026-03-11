
USE videogame;

-- 1. HALL OF FAME
CONSISTENCY LOCAL_ONE;

SELECT dungeon_id, dungeon_name, email, user_name, time_minutes, date
FROM hall_of_fame_by_country_dungeon
WHERE country = 'fr_FR' AND dungeon_id = 7
LIMIT 5;

-- 2. USER STATISTICS
CONSISTENCY LOCAL_ONE;

SELECT time_minutes, date
FROM runs_by_user_dungeon
WHERE user_id = 123 AND dungeon_id = 7;

-- 3. TOP HORDE
CONSISTENCY LOCAL_QUORUM;

SELECT user_id, user_name, email, n_killed
FROM top_horde_by_country_event
WHERE country = 'fr_FR' AND event_id = 15
LIMIT 10;




-- 4. USER FINISH DUNGEON
CONSISTENCY LOCAL_ONE;

INSERT INTO runs_by_user_dungeon (user_id, dungeon_id, time_minutes, date)
VALUES (123, 7, 18, '2026-03-11 19:42:00');

CONSISTENCY LOCAL_ONE;

INSERT INTO hall_of_fame_by_country_dungeon
(country, dungeon_id, dungeon_name, email, user_name, time_minutes, date)
VALUES ('fr_FR', 7, 'Dungeon Example', 'laura.martin@example.com', 'laura23', 18, '2026-03-11 19:42:00');

-- 5. USER KILLS MONSTER DURING HORDE EVENT
CONSISTENCY LOCAL_QUORUM;

INSERT INTO horde_kills_by_country_event_user
(country, event_id, user_id, email, user_name, n_killed)
VALUES ('fr_FR', 15, 123, 'laura.martin@example.com', 'laura23', 43);

CONSISTENCY LOCAL_QUORUM;

INSERT INTO top_horde_by_country_event
(country, event_id, n_killed, user_id, user_name, email)
VALUES ('fr_FR', 15, 43, 123, 'laura23', 'laura.martin@example.com');
