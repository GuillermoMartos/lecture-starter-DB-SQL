# lecture-starter-DB-SQL
Binary Studio Code Bootcamp 2024 DB and SQL

PostgreSQL DB Setup: 
create DB run: `psql postgres -f ddl.statements.sql`
populate DB run: `psql movies_exercise_db -f populate.tables.sql`
first query run: `psql movies_exercise_db -f firstQuery.sql`
second query run: `psql movies_exercise_db -f secondQuery.sql`
third query run: `psql movies_exercise_db -f thirdQuery.sql`
fourth query run: `psql movies_exercise_db -f fourthQuery.sql`
fifth query run: `psql movies_exercise_db -f fifthQuery.sql`
sixth query run: `psql movies_exercise_db -f sixthQuery.sql`

```mermaid
erDiagram
    
    USER {
        uuid id PK
        varchar userName
        varchar firstName
        varchar lastName
        varchar email
        varchar password
        datestime hola
    }

    FILE{
        uuid id PK
        enum MIMEType
        enum filePath
        varchar key
        varchar publicURL
        uuid user_id FK
        uuid persona_id FK
    }

    MOVIE {
        uuid id PK
        varchar title
        string description
        varchar budget
        date releaseDate
        varchar duration
        char(3) countryCode FK
        varchar director
        varchar posterURL
    }

    COUNTRY{
        char(3) code PK
        varchar name
    }

    GENRE{
        uuid id PK
        varchar name
    }
    
    CHARACTER{
        uuid id PK
        varchar name
        string description
        enum role
    }
  
    PERSONA{
        uuid id PK
        varchar firstName
        varchar lastName
        string biography
        date dateOfBirth
        enum gender
        char(3) countryCode FK
    }

    MOVIE_GENRE {
        uuid movie_id 
        uuid genre_id
    }

    MOVIE_PERSONA {
        uuid movie_id
        uuid persona_id
    }

    MOVIE_CHARACTER {
        uuid movie_id
        uuid character_id 
    }

    USER ||--o{ FILE : owns
    PERSONA ||--o{ FILE : owns
    MOVIE ||--o{ GENRE : has
    MOVIE ||--o{ CHARACTER : features
    MOVIE ||--o{ PERSONA : features
    MOVIE }o--|| COUNTRY : setIn
    PERSONA }o--|| COUNTRY : bornIn
```