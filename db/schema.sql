DROP TABLE IF EXISTS words;
DROP TABLE IF EXISTS single_choice_tests;
DROP TABLE IF EXISTS single_choices;
DROP TABLE IF EXISTS tests;
DROP TABLE IF EXISTS single_choice_test_results;
DROP TABLE IF EXISTS test_results;
DROP TABLE IF EXISTS listen_complete_test_results;
DROP TABLE IF EXISTS listen_complete_tests;
DROP TABLE IF EXISTS listen_completes;
DROP TABLE IF EXISTS sound_files;
DROP TABLE IF EXISTS sort_test_results;
DROP TABLE IF EXISTS sort_tests;
DROP TABLE IF EXISTS sorts;

CREATE TABLE words(
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL UNIQUE,
    english_translation TEXT NOT NULL
);

CREATE TABLE single_choices(
    id INTEGER PRIMARY KEY NOT NULL,
    title TEXT NOT NULL,
    choice0 TEXT NOT NULL,
    choice1 TEXT NOT NULL,
    choice2 TEXT NOT NULL,
    choice3 TEXT NOT NULL,
    answer INT NOT NULL 
);

CREATE TABLE tests(
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE single_choice_tests(
    id INTEGER PRIMARY KEY NOT NULL,
    t_id INTEGER REFERENCES tests,
    sc_id INTEGER REFERENCES single_choices
);

CREATE TABLE test_results(
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL UNIQUE,
    t_id INTEGER REFERENCES tests,
    start_at TIMESTAMP NOT NULL,
    end_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE single_choice_test_results(
    id INTEGER PRIMARY KEY NOT NULL,
    tr_id INTEGER REFERENCES test_results,
    sc_id INTEGER REFERENCES single_choices,
    /* -1 means not answered, choice index */
    answer INT NOT NULL
);
 
CREATE TABLE listen_completes(
    id INTEGER PRIMARY KEY NOT NULL,
    story TEXT NOT NULL,
    page INT NOT NULL,
    /* string w/ [[answer(word, phrase, sentense)]] */
    passage TEXT NOT NULL,
    sf_id INTEGER REFERENCES sound_files,
    playback_start INT NOT NULL,
    playback_end INT NOT NULL
);

/* Intermediate table */
CREATE TABLE listen_complete_tests(
    id INTEGER PRIMARY KEY NOT NULL,
    t_id INTEGER REFERENCES tests,
    lc_id INTEGER REFERENCES listen_completes
);

CREATE TABLE listen_complete_test_results(
    id INTEGER PRIMARY KEY NOT NULL,
    tr_id INTEGER REFERENCES test_results,
    lc_id INTEGER REFERENCES listen_completes,
    /* JSON string for hash like {"0"=>"1111", "1"=>"2222222"} */
    answer TEXT
);

CREATE TABLE sound_files(
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    location TEXT NOT NULL,
    uploaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sorts(
    id INTEGER PRIMARY KEY NOT NULL,
    title TEXT NOT NULL UNIQUE,
    content TEXT NOT NULL
);

/* Intermediate table */
CREATE TABLE sort_tests(
    id INTEGER PRIMARY KEY NOT NULL,
    t_id INTEGER REFERENCES tests,
    st_id INTEGER REFERENCES sorts
);

CREATE TABLE sort_test_results(
    id INTEGER PRIMARY KEY NOT NULL,
    tr_id INTEGER REFERENCES test_results,
    st_id INTEGER REFERENCES sorts,
    /* JSON string for hash like {"7"=>"0", "0"=>"6", "5"=>"2", "2"=>"4", "3"=>"5", "1"=>"7", "4" => "1", "6" => "3"} */
    answer TEXT
);
