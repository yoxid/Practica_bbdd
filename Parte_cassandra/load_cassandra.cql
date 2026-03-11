
CREATE KEYSPACE IF NOT EXISTS videogame
WITH replication = {
  'class': 'NetworkTopologyStrategy',
  'DC1': 2
};

USE videogame;


CREATE TABLE IF NOT EXISTS user_by_email (
    email text,
    user_id int,
    user_name text,
    country text,
    PRIMARY KEY (email)
);

COPY user_by_email (email, user_id, user_name, country)
FROM '/data/user_by_email.csv'
WITH HEADER = TRUE;


CREATE TABLE IF NOT EXISTS dungeon_by_id (
    dungeon_id int,
    dungeon_name text,
    PRIMARY KEY (dungeon_id)
);

COPY dungeon_by_id (dungeon_id, dungeon_name)
FROM '/data/dungeon_by_id.csv'
WITH HEADER = TRUE;


CREATE TABLE IF NOT EXISTS runs_by_user_dungeon (
    user_id int,
    dungeon_id int,
    time_minutes int,
    date timestamp,
    PRIMARY KEY ((user_id, dungeon_id), time_minutes, date)
) WITH CLUSTERING ORDER BY (time_minutes ASC, date ASC);

COPY runs_by_user_dungeon (user_id, dungeon_id, time_minutes, date)
FROM '/data/runs_by_user_dungeon.csv'
WITH HEADER = TRUE;


CREATE TABLE IF NOT EXISTS hall_of_fame_by_country_dungeon (
    country text,
    dungeon_id int,
    dungeon_name text,
    email text,
    user_name text,
    time_minutes int,
    date timestamp,
    PRIMARY KEY ((country, dungeon_id), time_minutes, date, email)
) WITH CLUSTERING ORDER BY (time_minutes ASC, date ASC, email ASC);

COPY hall_of_fame_by_country_dungeon (
    country, dungeon_id, dungeon_name, email, user_name, time_minutes, date
)
FROM '/data/hall_of_fame_by_country_dungeon.csv'
WITH HEADER = TRUE;


CREATE TABLE IF NOT EXISTS horde_kills_by_country_event_user (
    country text,
    event_id int,
    user_id int,
    email text,
    user_name text,
    n_killed int,
    PRIMARY KEY ((country, event_id), user_id)
);

COPY horde_kills_by_country_event_user (
    country, event_id, user_id, email, user_name, n_killed
)
FROM '/data/horde_kills_by_country_event_user.csv'
WITH HEADER = TRUE;


CREATE TABLE IF NOT EXISTS top_horde_by_country_event (
    country text,
    event_id int,
    user_id int,
    user_name text,
    email text,
    n_killed int,
    PRIMARY KEY ((country, event_id), n_killed, user_id)
) WITH CLUSTERING ORDER BY (n_killed DESC, user_id ASC);

COPY top_horde_by_country_event (
    country, event_id, user_id, user_name, email, n_killed
)
FROM '/data/top_horde_by_country_event.csv'
WITH HEADER = TRUE;

