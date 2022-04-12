DO
$$
    BEGIN
        IF
            NOT EXISTS
                (SELECT 1
                 FROM information_schema.columns
                 WHERE table_schema = 'registration_adm'
                   AND table_name = 'person')
        THEN
            CREATE SEQUENCE registration_adm.person_seq
                INCREMENT 1
                MINVALUE 1
                MAXVALUE 9223372036854775807
                START 1
                CACHE 1;

            CREATE TABLE registration_adm.person
            (
                id_person     bigint       NOT NULL,
                code_person   uuid         NOT NULL,
                name          varchar(255) NOT NULL,
                document      varchar(30)  NOT NULL,
                document_type varchar(50)  NOT NULL,
                email         varchar(50)  NOT NULL,
                phone         varchar(50)  NOT NULL,
                date_creation timestamp    NOT NULL,
                date_update   timestamp    NOT NULL,
                CONSTRAINT person_id_pk PRIMARY KEY (id_person),
                CONSTRAINT document_unique UNIQUE (document),
                CONSTRAINT email_unique UNIQUE (email)
            )
                WITH (
                    OIDS = FALSE
                );

            CREATE INDEX code_person_idx ON registration_adm.person USING btree (code_person);
            CREATE INDEX code_person_date_creation_idx ON registration_adm.person USING btree (code_person, date_creation);

        END IF;
    END;
    $$
LANGUAGE plpgsql;
