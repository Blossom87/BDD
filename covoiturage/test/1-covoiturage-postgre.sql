CREATE TABLE _user_(
   id_user SERIAL,
   last_name VARCHAR(50)  NOT NULL,
   first_name VARCHAR(50)  NOT NULL,
   email VARCHAR(120)  NOT NULL,
   password VARCHAR(50)  NOT NULL,
   phone_number VARCHAR(11)  NOT NULL,
   profil_picture VARCHAR(50) ,
   status BOOLEAN,
   PRIMARY KEY(id_user)
);

CREATE TYPE vehicule_type AS ENUM ('compact', 'berline', 'break', '4x4', 'monospace', 'utilitaire');
CREATE TABLE vehicule(
   id_vehicule SERIAL,
   model VARCHAR(50)  NOT NULL,
   "type" vehicule_type NOT NULL,
   consumption INTEGER,
   seats INTEGER NOT NULL,
   PRIMARY KEY(id_vehicule)
);

CREATE TABLE route(
   id_route SERIAL,
   starting_point VARCHAR(120)  NOT NULL,
   departure_time TIME NOT NULL,
   arrival_point VARCHAR(120)  NOT NULL,
   price SMALLINT NOT NULL,
   route_description VARCHAR(1000) ,
   id_user INTEGER NOT NULL,
   id_vehicule INTEGER NOT NULL,
   PRIMARY KEY(id_route),
   FOREIGN KEY(id_user) REFERENCES _user_(id_user),
   FOREIGN KEY(id_vehicule) REFERENCES vehicule(id_vehicule)
);

CREATE TABLE intern(
   id_intern SERIAL,
   formation VARCHAR(50)  NOT NULL,
   id_user INTEGER NOT NULL,
   PRIMARY KEY(id_intern),
   UNIQUE(id_user),
   FOREIGN KEY(id_user) REFERENCES _user_(id_user)
);

CREATE TYPE role_type AS ENUM ('formateur', 'administratif', 'externe', 'autre');
CREATE TABLE employee(
   id_employee SERIAL,
   contract_duration DATE,
   "type" role_type NOT NULL,
   is_admin BOOLEAN NOT NULL,
   contract_cdi BOOLEAN NOT NULL,
   id_user INTEGER NOT NULL,
   PRIMARY KEY(id_employee),
   UNIQUE(id_user),
   FOREIGN KEY(id_user) REFERENCES _user_(id_user)
);

CREATE TYPE notification_type AS ENUM ('app', 'mail', 'sms');
CREATE TABLE notification(
   id_notification SERIAL,
   "type" notification_type NOT NULL,
   _date_ DATE,
   PRIMARY KEY(id_notification)
);

CREATE TABLE formation_center(
   id_center SERIAL,
   _name_ VARCHAR(50)  NOT NULL,
   adress VARCHAR(120)  NOT NULL,
   opening_hours TIME NOT NULL,
   PRIMARY KEY(id_center)
);

CREATE TYPE fuel_type AS ENUM ('Essence', 'Gazole', 'GPL', 'Electrique');
CREATE TABLE fuel_information(
   id_fuel SERIAL,
   "type" fuel_type NOT NULL,
   price INTEGER NOT NULL,
   id_vehicule INTEGER,
   PRIMARY KEY(id_fuel),
   FOREIGN KEY(id_vehicule) REFERENCES vehicule(id_vehicule)
);

CREATE TYPE day_type AS ENUM ('monday' , 'tuesday' , 'wednesday' , 'thursday' , 'friday');
CREATE TABLE regular(
   id_regular SERIAL,
   "type" day_type NOT NULL,
   id_route INTEGER NOT NULL,
   PRIMARY KEY(id_regular),
   UNIQUE(id_route),
   FOREIGN KEY(id_route) REFERENCES route(id_route)
);

CREATE TABLE punctual(
   id_punctual SERIAL,
   _date_ DATE NOT NULL,
   id_route INTEGER NOT NULL,
   PRIMARY KEY(id_punctual),
   UNIQUE(id_route),
   FOREIGN KEY(id_route) REFERENCES route(id_route)
);

CREATE TABLE formation_course(
   id_course SERIAL,
   name VARCHAR(50)  NOT NULL,
   PRIMARY KEY(id_course)
);

CREATE TABLE comment(
   id_comment SERIAL,
   id_user INTEGER NOT NULL,
   id_user_1 INTEGER NOT NULL,
   id_route INTEGER NOT NULL,
   PRIMARY KEY(id_comment),
   FOREIGN KEY(id_user) REFERENCES _user_(id_user),
   FOREIGN KEY(id_user_1) REFERENCES _user_(id_user),
   FOREIGN KEY(id_route) REFERENCES route(id_route)
);

CREATE TABLE general_condition(
   id_condition SERIAL,
   "description" text,
   PRIMARY KEY(id_condition)
);

CREATE TABLE register(
   id_user INTEGER,
   id_vehicule INTEGER,
   PRIMARY KEY(id_user, id_vehicule),
   FOREIGN KEY(id_user) REFERENCES _user_(id_user),
   FOREIGN KEY(id_vehicule) REFERENCES vehicule(id_vehicule)
);

CREATE TABLE belong(
   id_employee INTEGER,
   id_center INTEGER,
   PRIMARY KEY(id_employee, id_center),
   FOREIGN KEY(id_employee) REFERENCES employee(id_employee),
   FOREIGN KEY(id_center) REFERENCES formation_center(id_center)
);

CREATE TABLE inherit(
   id_route INTEGER,
   id_center INTEGER,
   PRIMARY KEY(id_route, id_center),
   FOREIGN KEY(id_route) REFERENCES route(id_route),
   FOREIGN KEY(id_center) REFERENCES formation_center(id_center)
);

CREATE TABLE assign(
   id_employee INTEGER,
   id_course INTEGER,
   is_referent BOOLEAN NOT NULL,
   PRIMARY KEY(id_employee, id_course),
   FOREIGN KEY(id_employee) REFERENCES employee(id_employee),
   FOREIGN KEY(id_course) REFERENCES formation_course(id_course)
);

CREATE TABLE learn(
   id_intern INTEGER,
   id_course INTEGER,
   PRIMARY KEY(id_intern, id_course),
   FOREIGN KEY(id_intern) REFERENCES intern(id_intern),
   FOREIGN KEY(id_course) REFERENCES formation_course(id_course)
);

CREATE TABLE send(
   id_user INTEGER,
   id_notification INTEGER,
   PRIMARY KEY(id_user, id_notification),
   FOREIGN KEY(id_user) REFERENCES _user_(id_user),
   FOREIGN KEY(id_notification) REFERENCES notification(id_notification)
);

CREATE TABLE reserve(
   id_user INTEGER,
   id_route INTEGER,
   PRIMARY KEY(id_user, id_route),
   FOREIGN KEY(id_user) REFERENCES _user_(id_user),
   FOREIGN KEY(id_route) REFERENCES route(id_route)
);
