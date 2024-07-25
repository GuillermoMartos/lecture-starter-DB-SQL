CREATE DATABASE movies_exercise_db;

\c movies_exercise_db

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TYPE mime_type AS ENUM (
    'image/jpeg',
    'image/png',
    'application/pdf',
    'text/plain',
    'video/mp4'
);

CREATE TYPE movie_role_type AS ENUM (
    'leading',
    'supporting',
    'background'
);

CREATE TYPE persona_role_type AS ENUM (
    'actor',
    'director',
    'other'
);

CREATE TYPE file_type AS ENUM (
    'primaryPhoto',
    'moviePoster',
    'other'
);

CREATE TYPE gender_type AS ENUM (
    'male',
    'female',
    'other',
    'not specified'
);

CREATE TABLE APP_USER (
    id UUID PRIMARY KEY,
    userName VARCHAR(255) UNIQUE NOT NULL,
    firstName VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE COUNTRY (
    code CHAR(3) PRIMARY KEY UNIQUE NOT NULL,
    name VARCHAR(255),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE PERSONA (
    id UUID PRIMARY KEY,
    firstName VARCHAR(255),
    lastName VARCHAR(255),
    completeName VARCHAR(255) UNIQUE NOT NULL,
    biography TEXT,
    dateOfBirth DATE,
    gender gender_type,
    countryCode CHAR(3),
    role persona_role_type NOT NULL,
    CONSTRAINT fk_countryCode FOREIGN KEY(countryCode) REFERENCES COUNTRY(code),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE MOVIE (
    id UUID PRIMARY KEY,
    title VARCHAR(255) UNIQUE NOT NULL,
    description TEXT,
    budget NUMERIC,
    releaseDate DATE,
    duration INTEGER,
    countryCode CHAR(3),
    posterURL VARCHAR(255),
    director_id UUID,
    CONSTRAINT fk_countryCode_movie FOREIGN KEY(countryCode) REFERENCES COUNTRY(code),
    CONSTRAINT fk_director FOREIGN KEY(director_id) REFERENCES PERSONA(id),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE FILE (
    id UUID PRIMARY KEY,
    MIMEType mime_type NOT NULL,
    key VARCHAR(255) NOT NULL,
    fileType file_type NOT NULL,
    publicURL VARCHAR(255) NOT NULL,
    user_id UUID,
    persona_id UUID,
    movie_id UUID,
    CONSTRAINT fk_user_id FOREIGN KEY(user_id) REFERENCES APP_USER(id),
    CONSTRAINT fk_persona_id FOREIGN KEY(persona_id) REFERENCES PERSONA(id),
    CONSTRAINT fk_movie_id FOREIGN KEY(movie_id) REFERENCES MOVIE(id),
    CONSTRAINT check_single_relationship CHECK (
        (user_id IS NOT NULL AND persona_id IS NULL AND movie_id IS NULL) OR
        (user_id IS NULL AND persona_id IS NOT NULL AND movie_id IS NULL) OR
        (user_id IS NULL AND persona_id IS NULL AND movie_id IS NOT NULL)
    ),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE GENRE (
    id UUID PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE CHARACTER (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    role movie_role_type NOT NULL,
    movie_id UUID,
    CONSTRAINT fk_movie_id FOREIGN KEY(movie_id) REFERENCES MOVIE(id) ON DELETE CASCADE,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE MOVIE_GENRE (
    movie_id UUID,
    genre_id UUID,
    CONSTRAINT fk_movie_id FOREIGN KEY(movie_id) REFERENCES MOVIE(id) ON DELETE CASCADE,
    CONSTRAINT fk_genre_id FOREIGN KEY(genre_id) REFERENCES GENRE(id),
    PRIMARY KEY (movie_id, genre_id),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE MOVIE_PERSONA (
    movie_id UUID,
    persona_id UUID,
    CONSTRAINT fk_movie_id_persona FOREIGN KEY(movie_id) REFERENCES MOVIE(id) ON DELETE CASCADE,
    CONSTRAINT fk_persona_id_movie FOREIGN KEY(persona_id) REFERENCES PERSONA(id),
    PRIMARY KEY (movie_id, persona_id),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE MOVIE_CHARACTER (
    movie_id UUID,
    character_id UUID,
    CONSTRAINT fk_movie_id_character FOREIGN KEY(movie_id) REFERENCES MOVIE(id) ON DELETE CASCADE,
    CONSTRAINT fk_character_id_movie FOREIGN KEY(character_id) REFERENCES CHARACTER(id),
    PRIMARY KEY (movie_id, character_id),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updatedAt = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_app_user_update
BEFORE UPDATE ON APP_USER
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER trigger_country_update
BEFORE UPDATE ON COUNTRY
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER trigger_persona_update
BEFORE UPDATE ON PERSONA
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER trigger_movie_update
BEFORE UPDATE ON MOVIE
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER trigger_genre_update
BEFORE UPDATE ON GENRE
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER trigger_character_update
BEFORE UPDATE ON CHARACTER
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER trigger_file_update
BEFORE UPDATE ON FILE
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();
