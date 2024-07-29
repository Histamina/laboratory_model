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
    exam_id INT,
    technician_id INT,
    branch_office_id INT,
    PRIMARY KEY(patient_id)
);

CREATE TABLE EXAMS(
    exam_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(60) NOT NULL,
    result VARCHAR(70),
    biochemist_id INT,
    technician_id INT,
    patient_id INT,
    PRIMARY KEY(exam_id)
);

CREATE TABLE TECHNICIANS(
    technician_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    document_type VARCHAR(30) NOT NULL,
    document_number VARCHAR(30) NOT NULL,
    phone VARCHAR(40),
    exam_id INT,
    patient_id INT,
    branch_office_id INT,
    PRIMARY KEY(technician_id)
);

CREATE TABLE BIOCHEMISTS(
    biochemist_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    document_type VARCHAR(30) NOT NULL,
    document_number VARCHAR(30) NOT NULL,
    phone VARCHAR(40),
    exam_id INT,
    branch_office_id INT,
    PRIMARY KEY(biochemist_id)
);

CREATE TABLE BRANCH_OFFICES(
    branch_office_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL,
    address VARCHAR(40) NOT NULL,
    phone VARCHAR(40) NOT NULL,
    technician_id INT,
    patient_id INT,
    biochemist_id INT,
    PRIMARY KEY(branch_office_id)
);

# ALTER TABLES TO ADD FOREIGN KEYS

ALTER TABLE PATIENTS
ADD CONSTRAINT fk_patients_exam FOREIGN KEY(exam_id) REFERENCES EXAMS(exam_id),
ADD CONSTRAINT fk_patients_technician FOREIGN KEY(technician_id) REFERENCES TECHNICIANS(technician_id),
ADD CONSTRAINT fk_patients_branch_office FOREIGN KEY(branch_office_id) REFERENCES BRANCH_OFFICES(branch_office_id);

ALTER TABLE EXAMS
ADD CONSTRAINT fk_exams_biochemist FOREIGN KEY(biochemist_id) REFERENCES BIOCHEMISTS(biochemist_id),
ADD CONSTRAINT fk_exams_technician FOREIGN KEY(technician_id) REFERENCES TECHNICIANS(technician_id),
ADD CONSTRAINT fk_exams_patient FOREIGN KEY(patient_id) REFERENCES PATIENTS(patient_id);

ALTER TABLE TECHNICIANS
ADD CONSTRAINT fk_technicians_exam FOREIGN KEY(exam_id) REFERENCES EXAMS(exam_id),
ADD CONSTRAINT fk_technicians_patient FOREIGN KEY(patient_id) REFERENCES PATIENTS(patient_id),
ADD CONSTRAINT fj_technicians_branch_office FOREIGN KEY(branch_office_id) REFERENCES BRANCH_OFFICES(branch_office_id);

ALTER TABLE BIOCHEMISTS
ADD CONSTRAINT fk_biochemists_exam FOREIGN KEY(exam_id) REFERENCES EXAMS(exam_id),
ADD CONSTRAINT fk_biochemists_branch_office FOREIGN KEY(branch_office_id) REFERENCES BRANCH_OFFICES(branch_office_id);

ALTER TABLE BRANCH_OFFICES
ADD CONSTRAINT fk_branch_offices_technician FOREIGN KEY(technician_id) REFERENCES TECHNICIANS(technician_id),
ADD CONSTRAINT fk_branch_offices_patient FOREIGN KEY(patient_id) REFERENCES PATIENTS(patient_id),
ADD CONSTRAINT fk_branch_offices_biochemist FOREIGN KEY(biochemist_id) REFERENCES BIOCHEMISTS(biochemist_id);

