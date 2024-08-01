# CREATE SCHEMA
CREATE SCHEMA laboratory_model;

# USE MODEL

USE laboratory_model;

# CREATE TABLES

CREATE TABLE PATIENTS(
	patient_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    document_type VARCHAR(30) NOT NULL,
    document_number VARCHAR(30) NOT NULL,
    phone VARCHAR(40),
    PRIMARY KEY(patient_id)
);

CREATE TABLE TECHNICIANS(
	technician_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    document_type VARCHAR(30) NOT NULL,
    document_number VARCHAR(30) NOT NULL,
    phone VARCHAR(40),
    PRIMARY KEY(technician_id)
);

CREATE TABLE ASSISTANCE_RECORDS(
	assistance_id INT NOT NULL AUTO_INCREMENT,
    date_time DATETIME NOT NULL,
    patient_id INT,
    technician_id INT,
    PRIMARY KEY(assistance_id),
    FOREIGN KEY(patient_id) REFERENCES PATIENTS(patient_id),
    FOREIGN KEY(technician_id) REFERENCES TECHNICIANS(technician_id)
);

CREATE TABLE BIOCHEMISTS(
	biochemist_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    document_type VARCHAR(30) NOT NULL,
    document_number VARCHAR(30) NOT NULL,
    phone VARCHAR(40),
    PRIMARY KEY(biochemist_id)
);

CREATE TABLE EXAMS(
	exam_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(60) NOT NULL,
    result VARCHAR(70),
    biochemist_id INT,
    technician_id INT,
    patient_id INT,
    PRIMARY KEY(exam_id),
    FOREIGN KEY(biochemist_id) REFERENCES BIOCHEMISTS(biochemist_id),
    FOREIGN KEY(patient_id) REFERENCES PATIENTS(patient_id),
    FOREIGN KEY(technician_id) REFERENCES TECHNICIANS(technician_id)
);

CREATE TABLE BRANCH_OFFICES(
	branch_office_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    address VARCHAR(40) NOT NULL,
    phone VARCHAR(40) NOT NULL,
    technician_id INT,
    biochemist_id INT,
    PRIMARY KEY(branch_office_id),
    FOREIGN KEY(technician_id) REFERENCES TECHNICIANS(technician_id),
    FOREIGN KEY(biochemist_id) REFERENCES BIOCHEMISTS(biochemist_id)
);

CREATE TABLE PATIENT_VISITS(
	visit_id INT NOT NULL AUTO_INCREMENT,
    patient_id INT,
    branch_office_id INT,
    PRIMARY KEY(visit_id),
    FOREIGN KEY(patient_id) REFERENCES PATIENTS(patient_id),
    FOREIGN KEY(branch_office_id) REFERENCES BRANCH_OFFICES(branch_office_id)
);
