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