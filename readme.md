# Carshare

## Dictionnaire de données

[lien vers le dictionnaire de données](datas_library.csv)

|Table             |Code                |Libellé                                                                   |Type         |Contraintes      |
|------------------|--------------------|--------------------------------------------------------------------------|-------------|-----------------|
|_user_            |id                  |identifiant de l'utilisateur                                              |uuid         |primary, not null|
|_user_            |password            |mot de passe                                                              |VARCHAR(250) |not null         |
|_user_            |surname             |prénom                                                                    |VARCHAR(50)  |not null         |
|_user_            |lastname            |nom                                                                       |VARCHAR(250) |not null         |
|_user_            |email               |email                                                                     |VARCHAR(250) |not null, unique |
|_user_            |is_active           |Est-ce que le compte est active                                           |BOOLEAN      |not null         |
|learner           |id                  |identifiant de l'apprenant                                                |uuid         |primary, not null|
|employee          |id                  |identifiant de l'employé                                                  |uuid         |primary, not null|
|employee          |is_admin            |Est-ce que l'employée est un admin                                        |BOOLEAN      |not null         |
|employee          |start_date          |date de début du contrat                                                  |DATE         |not null         |
|employee          |end_date            |date de fin du contrat (si CDD)                                           |DATE         |                 |
|employee          |position_as_employee|Role dans l'entreprise                                                    |VARCHAR(50)  |not null         |
|training          |id                  |identifiant de la formation                                               |uuid         |primary, not null|
|training          |title               |Titre de la formation                                                     |VARCHAR(250) |not null         |
|vehicle           |id                  |identifiant du véhicule                                                   |uuid         |primary, not null|
|vehicle           |reference           |modèle du véhicule                                                        |VARCHAR(250) |not null         |
|vehicle           |slot_number         |nombre de places                                                          |INTEGER      |not null         |
|vehicle           |consumption         |consommation (en euros)                                                   |NUMERIC(15,2)|not null         |
|address           |id                  |identifiant de l'addresse                                                 |uuid         |primary, not null|
|address           |address_number      |numéro de voie                                                            |VARCHAR(50)  |not null         |
|address           |address_type        |type de voie                                                              |VARCHAR(50)  |not null         |
|address           |address_way_name    |nom de la voie                                                            |VARCHAR(50)  |not null         |
|address           |address_zip         |code postal                                                               |VARCHAR(5)   |not null         |
|facility          |id                  |identifiant du centre                                                     |uuid         |primary, not null|
|facility          |name                |nom du centre                                                             |VARCHAR(50)  |not null         |
|facility          |opening_times       |horaires                                                                  |json         |not null         |
|facility          |default_ref         |Est-ce que c'est le centre à défaut                                       |BOOLEAN      |not null         |
|fuel              |id                  |identifiant du carburant                                                  |uuid         |primary, not null|
|fuel              |fuel_type           |type de carburant                                                         |VARCHAR(50)  |not null         |
|fuel              |price               |prix du carburant                                                         |NUMERIC(15,2)|not null         |
|vehicle_type      |id                  |identifiant du type de vehicule                                           |uuid         |primary, not null|
|vehicle_type      |name                |nom du type de céhicule                                                   |VARCHAR(50)  |not null         |
|message_type      |id                  |identifiant de message                                                    |uuid         |primary, not null|
|message_type      |content             |message préfait                                                           |TEXT         |not null         |
|message_type      |name                |nom du type de message                                                    |VARCHAR(50)  |not null         |
|CGU               |id                  |identifiant des conditions générales d'utilisation                        |uuid         |primary, not null|
|CGU               |content             |texte des CGU                                                             |TEXT         |not null         |
|trainer           |id                  |identifiant du formateur                                                  |uuid         |primary, not null|
|ride              |id                  |identifiant du trajet                                                     |uuid         |primary, not null|
|ride              |schedule_time       |horaire                                                                   |TIME         |not null         |
|ride              |price               |prix de la course                                                         |NUMERIC(15,2)|not null         |
|ride              |description         |description (optionnelle)                                                 |TEXT         |                 |
|session           |id                  |identifiant de la session                                                 |uuid         |primary, not null|
|session           |start_date          |date de début                                                             |DATE         |not null         |
|session           |end_date            |date de fin                                                               |DATE         |not null         |
|periodic          |id                  |identifiant du trajet périodique                                          |uuid         |primary, not null|
|periodic          |start_date          |date de début                                                             |DATE         |not null         |
|periodic          |end_date            |date de fin                                                               |DATE         |not null         |
|periodic          |concerned_days      |jours concernés                                                           |json         |not null         |
|ad_hoc            |id                  |identifiant du trajet ponctuel                                            |uuid         |primary, not null|
|ad_hoc            |date_               |date de la course                                                         |DATE         |not null         |
|notification      |id                  |identifiant du notification                                               |uuid         |primary, not null|
|notification      |description         |description (optionnelle)                                                 |TEXT         |                 |
|send              |request_date_time   |date de la requête                                                        |TIMESTAMP    |not null         |
|send              |description         |description (optionnelle)                                                 |TEXT         |                 |
|send              |status              |statut de la demande                                                      |status       |not null         |
|comment           |comment             |commentaire                                                               |TEXT         |not null         |
|fuel_vehicle_type |consumption_L       |consommation (en L)                                                       |NUMERIC(15,2)|not null         |
|get_notified_via  |website             |Est-ce que l'utilisateur souhaite recevoir ces notifications par le site  |BOOLEAN      |                 |
|get_notified_via  |email               |Est-ce que l'utilisateur souhaite recevoir ces notifications par email    |BOOLEAN      |                 |
|get_notified_via  |phone               |Est-ce que l'utilisateur souhaite recevoir ces notifications par téléphone|BOOLEAN      |                 |

## MCD

[lien vers le fichier looping](carshare.loo)

![MCD](MCD.jpg)

## MLD

[lien vers le fichier looping](carshare.loo)

![MLD](MLD.jpg)

## SCRIPT

[lien vers le fichier du script](PostgreSQL/db/dump/V1.0__carshare-schema.sql)

````SQL
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


CREATE TABLE "user"(
   id uuid NOT NULL DEFAULT uuid_generate_v4(),
   password VARCHAR(250)  NOT NULL,
   surname VARCHAR(50)  NOT NULL,
   lastname VARCHAR(250)  NOT NULL,
   email VARCHAR(250)  NOT NULL,
   is_active BOOLEAN NOT NULL DEFAULT false,
   PRIMARY KEY(id),
   UNIQUE(email)
);


CREATE TABLE learner(
   id uuid NOT NULL DEFAULT uuid_generate_v4(),
   user_id uuid  NOT NULL,
   PRIMARY KEY(id),
   UNIQUE(user_id),
   FOREIGN KEY(user_id) REFERENCES "user"(id)
);

CREATE TABLE employee(
   id uuid NOT NULL DEFAULT uuid_generate_v4(),
   is_admin BOOLEAN NOT NULL DEFAULT false,
   start_date DATE NOT NULL,
   end_date DATE,
   position_as_employee VARCHAR(50)  NOT NULL,
   user_id uuid  NOT NULL,
   PRIMARY KEY(id),
   UNIQUE(user_id),
   FOREIGN KEY(user_id) REFERENCES "user"(id)
);

CREATE TABLE training(
   id uuid NOT NULL DEFAULT uuid_generate_v4(),
   title VARCHAR(250)  NOT NULL,
   PRIMARY KEY(id)
);


CREATE TABLE vehicle(
   id uuid NOT NULL DEFAULT uuid_generate_v4(),
   reference VARCHAR(250)  NOT NULL,
   slot_number INTEGER NOT NULL,
   consumption NUMERIC(15,2)   NOT NULL,
   user_id uuid  NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(user_id) REFERENCES "user"(id)
);



CREATE TABLE address(
   id uuid NOT NULL DEFAULT uuid_generate_v4(),
   address_number VARCHAR(50)  NOT NULL,
   address_type VARCHAR(50)  NOT NULL,
   address_way_name VARCHAR(50)  NOT NULL,
   address_zip VARCHAR(5)  NOT NULL,
   PRIMARY KEY(id)
);


CREATE TABLE facility(
   id uuid NOT NULL DEFAULT uuid_generate_v4(),
   name VARCHAR(50)  NOT NULL,
   opening_times json NOT NULL,
   default_ref BOOLEAN NOT NULL default false,
   address_id uuid  NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(address_id) REFERENCES address(id)
);

CREATE TABLE fuel(
   id uuid NOT NULL DEFAULT uuid_generate_v4(),
   oil_type VARCHAR(50)  NOT NULL,
   price NUMERIC(15,2)  ,
   PRIMARY KEY(id),
   UNIQUE(oil_type)
);

CREATE TABLE vehicle_type(
   id uuid NOT NULL DEFAULT uuid_generate_v4(),
   name VARCHAR(50)  NOT NULL,
   PRIMARY KEY(id)
);


CREATE TABLE message_type(
   id uuid NOT NULL DEFAULT uuid_generate_v4(),
   content TEXT NOT NULL,
   name VARCHAR(50) ,
   PRIMARY KEY(id)
);

CREATE TABLE CGU(
   id uuid,
   content TEXT NOT NULL,
   PRIMARY KEY(id)
);

CREATE TABLE trainer(
   id uuid NOT NULL DEFAULT uuid_generate_v4(),
   employee_id uuid  NOT NULL,
   PRIMARY KEY(id),
   UNIQUE(employee_id),
   FOREIGN KEY(employee_id) REFERENCES employee(id)
);


CREATE TABLE ride(
   id uuid NOT NULL DEFAULT uuid_generate_v4(),
   schedule_time TIME NOT NULL,
   price NUMERIC(15,2)   NOT NULL,
   description TEXT,
   facility_id uuid  NOT NULL,
   vehicle_id uuid  NOT NULL,
   creater_id uuid  NOT NULL,
   departure_adress_id uuid  NOT NULL,
   arrival_adress_id uuid  NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(facility_id) REFERENCES facility(id),
   FOREIGN KEY(vehicle_id) REFERENCES vehicle(id),
   FOREIGN KEY(creater_id) REFERENCES "user"(id),
   FOREIGN KEY(departure_adress_id) REFERENCES address(id),
   FOREIGN KEY(arrival_adress_id) REFERENCES address(id)
);

CREATE TABLE session(
   id uuid NOT NULL DEFAULT uuid_generate_v4(),
   start_date DATE NOT NULL,
   end_date DATE NOT NULL,
   facility_id uuid  NOT NULL,
   training_id uuid  NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(facility_id) REFERENCES facility(id),
   FOREIGN KEY(training_id) REFERENCES training(id)
);


CREATE TABLE periodic(
   id uuid NOT NULL DEFAULT uuid_generate_v4(),
   start_date DATE NOT NULL,
   end_date DATE NOT NULL,
   concerned_days json NOT NULL,
   ride_id uuid  NOT NULL,
   PRIMARY KEY(id),
   UNIQUE(ride_id),
   FOREIGN KEY(ride_id) REFERENCES ride(id)
);


CREATE TABLE ad_hoc(
   id uuid NOT NULL DEFAULT uuid_generate_v4(),
   date_ DATE NOT NULL,
   ride_id uuid  NOT NULL,
   PRIMARY KEY(id),
   UNIQUE(ride_id),
   FOREIGN KEY(ride_id) REFERENCES ride(id)
);

CREATE TABLE notification(
   id uuid NOT NULL DEFAULT uuid_generate_v4(),
   description TEXT,
   sender_id uuid NOT NULL,
   user_id uuid  NOT NULL,
   message_type_id uuid  NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(sender_id) REFERENCES "user"(id),
   FOREIGN KEY(user_id) REFERENCES "user"(id),
   FOREIGN KEY(message_type_id) REFERENCES message_type(id)
);

CREATE TABLE trainer_training(
   trainer_id uuid NOT NULL,
   id uuid NOT NULL,
   PRIMARY KEY(trainer_id, id),
   FOREIGN KEY(trainer_id) REFERENCES trainer(id),
   FOREIGN KEY(id) REFERENCES session(id)
);

CREATE TABLE learner_session(
   learner_id uuid NOT NULL,
   session_id uuid NOT NULL,
   PRIMARY KEY(learner_id, session_id),
   FOREIGN KEY(learner_id) REFERENCES learner(id),
   FOREIGN KEY(session_id) REFERENCES session(id)
);

CREATE TABLE ride_user(
   user_id uuid NOT NULL,
   ride_id uuid NOT NULL,
   PRIMARY KEY(user_id, ride_id),
   FOREIGN KEY(user_id) REFERENCES "user"(id),
   FOREIGN KEY(ride_id) REFERENCES ride(id)
);

CREATE TYPE status AS ENUM ('sent', 'rejected', 'accepted');

CREATE TABLE send(
   user_id uuid NOT NULL,
   id uuid NOT NULL,
   request_date_time TIMESTAMP NOT null default CURRENT_TIMESTAMP,
   description TEXT,
   status status NOT NULL,
   PRIMARY KEY(user_id, id),
   FOREIGN KEY(user_id) REFERENCES "user"(id),
   FOREIGN KEY(id) REFERENCES ride(id)
);

CREATE TABLE comment(
   put_comment_id uuid NOT NULL,
   id uuid NOT NULL,
   comment TEXT NOT NULL,
   PRIMARY KEY(put_comment_id, id),
   FOREIGN KEY(put_comment_id) REFERENCES "user"(id),
   FOREIGN KEY(id) REFERENCES ride(id)
);

CREATE TABLE vehicle_vehicle_type(
   vehicle_id uuid NOT NULL,
   vehicle_type_id uuid NOT NULL,
   PRIMARY KEY(vehicle_id, vehicle_type_id),
   FOREIGN KEY(vehicle_id) REFERENCES vehicle(id),
   FOREIGN KEY(vehicle_type_id) REFERENCES vehicle_type(id)
);

CREATE TABLE fuel_vehicle_type(
   fuel_id uuid NOT NULL,
   vehicle_type_id uuid NOT NULL,
   consumption_L NUMERIC(15,2)   NOT NULL,
   PRIMARY KEY(fuel_id, vehicle_type_id),
   FOREIGN KEY(fuel_id) REFERENCES fuel(id),
   FOREIGN KEY(vehicle_type_id) REFERENCES vehicle_type(id)
);

CREATE TABLE get_notified_via(
   user_id uuid NOT NULL,
   message_type_id uuid NOT NULL,
   website BOOLEAN NOT NULL,
   email BOOLEAN NOT NULL,
   phone BOOLEAN NOT NULL,
   PRIMARY KEY(user_id, message_type_id),
   FOREIGN KEY(user_id) REFERENCES "user"(id),
   FOREIGN KEY(message_type_id) REFERENCES message_type(id)
);
```