### CREATE SCHEMA
CREATE SCHEMA laboratory_model;


### USE MODEL

USE laboratory_model;


### CREATE TABLES

CREATE TABLE COUNTRIES(
	country_id INT NOT NULL AUTO_INCREMENT,
    country_name VARCHAR(150) NOT NULL,
    PRIMARY KEY(country_id)
);

CREATE TABLE INSURANCE_TYPES(
	insurance_type_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100),
    PRIMARY KEY(insurance_type_id)
);

CREATE TABLE HEALTH_INSURANCES(
	health_insurance_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(80) NOT NULL,
    insurance_type_id INT NOT NULL,
    PRIMARY KEY(health_insurance_id),
    CONSTRAINT fk_health_insurances_types FOREIGN KEY(insurance_type_id) REFERENCES INSURANCE_TYPES(insurance_type_id) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE PATIENTS(
	patient_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(60) NOT NULL,
    last_name VARCHAR(60) NOT NULL,
    document_type VARCHAR(30) NOT NULL,
    document_number VARCHAR(50) NOT NULL,
    phone VARCHAR(40),
    email VARCHAR(50) NOT NULL,
    country_id INT NOT NULL,
    health_insurance_id INT NOT NULL,
    PRIMARY KEY(patient_id),
    CONSTRAINT fk_patients_countries FOREIGN KEY(country_id) REFERENCES COUNTRIES(country_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_patients_health_insurance FOREIGN KEY(health_insurance_id) REFERENCES HEALTH_INSURANCES(health_insurance_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE BRANCH_OFFICES(
	branch_office_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(70) NOT NULL,
    address VARCHAR(80) NOT NULL,
    phone VARCHAR(40) NOT NULL,
    PRIMARY KEY(branch_office_id)
);

CREATE TABLE TECHNICIANS(
	technician_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(60) NOT NULL,
    last_name VARCHAR(60) NOT NULL,
    document_type VARCHAR(30) NOT NULL,
    document_number VARCHAR(50) NOT NULL,
    phone VARCHAR(40),
	email VARCHAR(50) NOT NULL,
    country_id INT NOT NULL,
    branch_office_id INT NOT NULL,
    PRIMARY KEY(technician_id),
    CONSTRAINT fk_technicians_countries FOREIGN KEY(country_id) REFERENCES COUNTRIES(country_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_technicians_branch_offices FOREIGN KEY(branch_office_id) REFERENCES BRANCH_OFFICES(branch_office_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ASSISTANCE_RECORDS(
	assistance_id INT NOT NULL AUTO_INCREMENT,
    date_time DATETIME NOT NULL,
    patient_id INT NOT NULL,
    technician_id INT NOT NULL,
    PRIMARY KEY(assistance_id),
    CONSTRAINT fk_assistance_records_patients FOREIGN KEY(patient_id) REFERENCES PATIENTS(patient_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_assistance_records_technicians FOREIGN KEY(technician_id) REFERENCES TECHNICIANS(technician_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE BIOCHEMISTS(
	biochemist_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(60) NOT NULL,
    last_name VARCHAR(60) NOT NULL,
    document_type VARCHAR(30) NOT NULL,
    document_number VARCHAR(50) NOT NULL,
    phone VARCHAR(40),
    email VARCHAR(50) NOT NULL,
    country_id INT NOT NULL,
    branch_office_id INT NOT NULL,
    PRIMARY KEY(biochemist_id),
    CONSTRAINT fk_biochemists_countries FOREIGN KEY(country_id) REFERENCES COUNTRIES(country_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_biochemists_branch_offices FOREIGN KEY(branch_office_id) REFERENCES BRANCH_OFFICES(branch_office_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE RECEPTIONISTS(
	receptionist_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(60) NOT NULL,
    last_name VARCHAR(60) NOT NULL,
    document_type VARCHAR(30) NOT NULL,
    document_number VARCHAR(50) NOT NULL,
    phone VARCHAR(40),
    email VARCHAR(50) NOT NULL,
    country_id INT NOT NULL,
    branch_office_id INT NOT NULL,
    PRIMARY KEY(receptionist_id),
    CONSTRAINT fk_receptionists_countries FOREIGN KEY(country_id) REFERENCES COUNTRIES(country_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_receptionists_branch_offices FOREIGN KEY(branch_office_id) REFERENCES BRANCH_OFFICES(branch_office_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE EXAM_REFERENCES(
	exam_reference_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    unit VARCHAR(20) NOT NULL,
    value VARCHAR(300) NOT NULL,
    method_type VARCHAR(90) NOT NULL,
    sample_type VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY(exam_reference_id)
);

CREATE TABLE PATIENT_VISITS(
	visit_id INT NOT NULL AUTO_INCREMENT,
    patient_id INT NOT NULL,
    branch_office_id INT NOT NULL,
    receptionist_id INT NOT NULL,
    PRIMARY KEY(visit_id),
    CONSTRAINT fk_patient_visits_patients FOREIGN KEY(patient_id) REFERENCES PATIENTS(patient_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_patient_visits_branch_offices FOREIGN KEY(branch_office_id) REFERENCES BRANCH_OFFICES(branch_office_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_patient_visits_receptionists FOREIGN KEY(receptionist_id) REFERENCES RECEPTIONISTS(receptionist_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE EXAMS(
	exam_id INT NOT NULL AUTO_INCREMENT,
    result VARCHAR(70) NOT NULL,
    biochemist_id INT NOT NULL,
    exam_reference_id INT NOT NULL,
    assistance_id INT NOT NULL,
    visit_id INT NOT NULL,
    PRIMARY KEY(exam_id),
    CONSTRAINT fk_exams_biochemists FOREIGN KEY(biochemist_id) REFERENCES BIOCHEMISTS(biochemist_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_exams_exam_references FOREIGN KEY(exam_reference_id) REFERENCES EXAM_REFERENCES(exam_reference_id) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fk_exams_assistance FOREIGN KEY(assistance_id) REFERENCES ASSISTANCE_RECORDS(assistance_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_exams_patient_visits FOREIGN KEY(visit_id) REFERENCES PATIENT_VISITS(visit_id) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE AUDIT_NEW_PATIENTS(
	audit_id INT NOT NULL AUTO_INCREMENT,
    patient_id INT NOT NULL,
    date DATETIME NOT NULL,
    user VARCHAR(100) NOT NULL,
    PRIMARY KEY(audit_id),
    CONSTRAINT fk_patient_new_audit FOREIGN KEY(patient_id) REFERENCES PATIENTS(patient_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE AUDIT_REMOVED_PATIENTS(
	audit_id INT NOT NULL AUTO_INCREMENT,
    patient_id INT NOT NULL,
    date DATETIME NOT NULL,
    user VARCHAR(100) NOT NULL,
    PRIMARY KEY(audit_id)
);


### POPULATE TABLES

INSERT INTO COUNTRIES (country_id, country_name) VALUES
(NULL, 'Argentina'),
(NULL, 'Chile'),
(NULL, 'Venezuela'),
(NULL, 'Uruguay'),
(NULL, 'Colombia'),
(NULL, 'Peru');

INSERT INTO INSURANCE_TYPES (insurance_type_id, name) VALUES
(NULL, 'Sin cobertura'),
(NULL, 'Prepaga'),
(NULL, 'Obra social');

INSERT INTO HEALTH_INSURANCES (health_insurance_id, name, email, insurance_type_id) VALUES
(NULL, 'Sin Cobertura', 'cobranza-lab@test.com', 1),
(NULL, 'Galeno', 'cobranza-galeno@test.com', 2),
(NULL, 'Omint', 'cobranza-omint@test.com', 2),
(NULL, 'Swiss Medical', 'cobranza-swiss@test.com', 2),
(NULL, 'IOMA', 'cobranza-ioma@test.com', 3),
(NULL, 'OSPE', 'cobranza-ospe@test.com', 3),
(NULL, 'OSECAC', 'cobranza-osecac@test.com', 3);

INSERT INTO PATIENTS (patient_id, first_name, last_name, document_type, document_number, phone, email, country_id, health_insurance_id) VALUES
(NULL, 'Jorge Luis', 'Diaz Velez', 'dni', '28374920', '+5497366266', 'jgld@test.ar', 1, 1),
(NULL, 'Maria Elisa', 'Lopez', 'dni', '34534543', '+5495355836', 'melopez@test.ar', 1, 2),
(NULL, 'Ernesto', 'West', 'dni', '34536677', '+5494666636', 'ern.west@test.ar', 1, 3),
(NULL, 'Carla', 'Aldina', 'passport', '17237137k', '+5497990342', 'car.al@test.ar', 2, 4),
(NULL, 'Mario', 'Pinola', 'dni', '9928488', '+5494882272', 'pinola@test.ar', 1, 5),
(NULL, 'Teresa', 'Flores', 'dni', '7232766', '+549346566', 'teresa.f@test.ar', 1, 6),
(NULL, 'Maria Fernanda', 'Lopez Gonzalez', 'passport', '29485673', '+5497366721', 'mflg@test.ar', 2, 7),
(NULL, 'Carlos Alberto', 'Ramirez Perez', 'passport', '30294715', '+5497366845', 'carp@test.ar', 3, 1),
(NULL, 'Laura Beatriz', 'Martinez Soto', 'passport', '27845691', '+5497366999', 'lbms@test.ar', 4, 2),
(NULL, 'Fernando Javier', 'Gomez Torres', 'passport', '31567832', '+5497366333', 'fjgt@test.ar', 5, 3),
(NULL, 'Andrea', 'Moreno', 'dni', '28947284', '+5493467890', 'amoreno@test.ar', 1, 4),
(NULL, 'Santiago', 'Nuñez', 'passport', 'M789345', '+5497776655', 'snunez@test.ar', 2, 5),
(NULL, 'Lucia', 'Garcia', 'dni', '35678945', '+5491234567', 'lgarcia@test.ar', 1, 6),
(NULL, 'Gabriel', 'Castro', 'passport', 'X934857', '+5498887766', 'gcastro@test.ar', 3, 7),
(NULL, 'Valeria', 'Ortega', 'dni', '28954322', '+5496543210', 'vortega@test.ar', 1, 2),
(NULL, 'Rodrigo', 'Serrano', 'passport', 'K123456', '+5499998887', 'rserrano@test.ar', 6, 3),
(NULL, 'Juliana', 'Gonzalez', 'passport', 'Y845632', '+5492223334', 'jgonzalez@test.ar', 5, 4),
(NULL, 'Mariano', 'Rojas', 'dni', '30987212', '+5497766554', 'mrojas@test.ar', 1, 5),
(NULL, 'Sofía', 'Blanco', 'dni', '32847623', '+5491239874', 'sblanco@test.ar', 1, 6),
(NULL, 'Sebastian', 'Martinez', 'passport', 'L678934', '+5491112233', 'smartinez@test.ar', 2, 7);


INSERT INTO BRANCH_OFFICES (branch_office_id, name, address, phone) VALUES
(NULL, 'Valdez', 'Av Valdez Georgia 1993', '48817729'),
(NULL, 'Pichincha', 'Pichincha 837', '4912837'),
(NULL, 'Sued', 'Sued 93993', '47172779'),
(NULL, 'Fiordino', 'Fiordino Suarez 138', '47394989');

INSERT INTO TECHNICIANS (technician_id, first_name, last_name, document_type, document_number, phone, email, country_id, branch_office_id) VALUES
(NULL, 'Ana Maria', 'Gomez Perez', 'dni', '28456321', '+5497366453', 'amgp@test.ar', 1, 1),
(NULL, 'Carlos Alberto', 'Fernandez Lopez', 'passport', '29567432', '+5497366778', 'calf@test.ar', 2, 2),
(NULL, 'Laura Patricia', 'Rodriguez Morales', 'dni', '30765498', '+5497366879', 'lprm@test.ar', 1, 3),
(NULL, 'Miguel Angel', 'Martinez Gonzalez', 'passport', '31876543', '+5497366990', 'mamag@test.ar', 3, 4),
(NULL, 'Maria Jose', 'Diaz Herrera', 'dni', '32987654', '+5497366101', 'mjd@test.ar', 1, 1),
(NULL, 'Juan Pablo', 'Sanchez Romero', 'passport', '34098765', '+5497366212', 'jpsr@test.ar', 2, 2),
(NULL, 'Sofia Carolina', 'Mendez Ruiz', 'dni', '35109876', '+5497366323', 'scmr@test.ar', 1, 3),
(NULL, 'David Ricardo', 'Perez Castro', 'passport', '36210987', '+5497366434', 'dprc@test.ar', 6, 4),
(NULL, 'Lucia Fernanda', 'Gomez Mendez', 'dni', '37321098', '+5497366545', 'lfgm@test.ar', 1, 1),
(NULL, 'Fernando Andres', 'Lopez Diaz', 'passport', '38432109', '+5497366656', 'fald@test.ar', 2, 2);


INSERT INTO ASSISTANCE_RECORDS (assistance_id, date_time, patient_id, technician_id) VALUES 
(NULL, '2024-01-10 07:30:00', 1, 1),  (NULL, '2024-02-12 08:45:00', 1, 5),
(NULL, '2024-03-15 09:15:00', 2, 9), (NULL, '2024-04-18 10:30:00', 2, 1),
(NULL, '2024-05-20 11:00:00', 3, 5), (NULL, '2024-06-22 07:45:00', 3, 9),
(NULL, '2024-07-25 08:15:00', 4, 1), (NULL, '2024-08-28 09:30:00', 4, 5),
(NULL, '2024-09-05 10:00:00', 5, 9), (NULL, '2024-10-08 11:30:00', 5, 1),
(NULL, '2024-11-02 07:45:00', 6, 2), (NULL, '2024-12-05 08:30:00', 6, 6),
(NULL, '2024-02-09 09:00:00', 7, 10), (NULL, '2024-03-12 10:15:00', 7, 2),
(NULL, '2024-04-16 11:45:00', 8, 6), (NULL, '2024-05-19 07:30:00', 8, 10),
(NULL, '2024-06-23 08:00:00', 9, 2), (NULL, '2024-07-26 09:15:00', 9, 6),
(NULL, '2024-08-30 10:30:00', 10, 10), (NULL, '2024-09-02 11:00:00', 10, 2),
(NULL, '2024-10-07 07:15:00', 11, 3), (NULL, '2024-11-10 08:45:00', 11, 7),
(NULL, '2024-12-14 09:30:00', 12, 3), (NULL, '2024-01-18 10:00:00', 12, 7),
(NULL, '2024-02-21 11:15:00', 13, 3), (NULL, '2024-03-25 07:45:00', 13, 7),
(NULL, '2024-04-29 08:30:00', 14, 3), (NULL, '2024-05-03 09:15:00', 14, 7),
(NULL, '2024-06-07 10:00:00', 15, 3), (NULL, '2024-07-11 11:30:00', 15, 7),
(NULL, '2024-08-15 07:00:00', 16, 4), (NULL, '2024-09-19 08:30:00', 16, 8),
(NULL, '2024-10-23 09:15:00', 17, 4), (NULL, '2024-11-27 10:45:00', 17, 8),
(NULL, '2024-12-01 11:00:00', 18, 4), (NULL, '2024-01-05 07:30:00', 18, 8),
(NULL, '2024-02-09 08:00:00', 19, 4), (NULL, '2024-03-13 09:45:00', 19, 8),
(NULL, '2024-04-17 10:30:00', 20, 4), (NULL, '2024-05-21 11:15:00', 20, 8);


INSERT INTO BIOCHEMISTS (biochemist_id, first_name, last_name, document_type, document_number, phone, email, country_id, branch_office_id) VALUES
(NULL, 'Carlos Alberto', 'Fernandez Lopez', 'passport', '29567432', '+5497366778', 'calf@test.ar', 2, 1),
(NULL, 'Laura Patricia', 'Rodriguez Morales', 'passport', '30765498', '+5497366879', 'lprm@test.ar', 3, 2),
(NULL, 'Miguel Angel', 'Martinez Gonzalez', 'passport', '31876543', '+5497366990', 'mamag@test.ar', 4, 3),
(NULL, 'Maria Jose', 'Diaz Herrera', 'passport', '32987654', '+5497366101', 'mjd@test.ar', 5, 4),
(NULL, 'Juan Pablo', 'Sanchez Romero', 'passport', '34098765', '+5497366212', 'jpsr@test.ar', 6, 1),
(NULL, 'Sofia Carolina', 'Mendez Ruiz', 'dni', '35109876', '+5497366323', 'scmr@test.ar', 1, 2),
(NULL, 'David Ricardo', 'Perez Castro', 'passport', '36210987', '+5497366434', 'dprc@test.ar', 2, 3),
(NULL, 'Lucia Fernanda', 'Gomez Mendez', 'passport', '37321098', '+5497366545', 'lfgm@test.ar', 3, 4),
(NULL, 'Fernando Andres', 'Lopez Diaz', 'passport', '38432109', '+5497366656', 'fald@test.ar', 4, 1),
(NULL, 'Claudia Isabel', 'Ramirez Torres', 'passport', '39543210', '+5497366767', 'cirt@test.ar', 5, 2);


INSERT INTO RECEPTIONISTS (receptionist_id, first_name, last_name, document_type, document_number, phone, email, country_id, branch_office_id) VALUES
(NULL, 'Jorge Luis', 'Diaz Velez', 'dni', '28374920', '+5497366266', 'jgld@test.ar', 1, 1),
(NULL, 'Maria Fernanda', 'Lopez Garcia', 'passport', 'P28374921', '+5497366267', 'mfg@test.ar', 2, 2),
(NULL, 'Carlos Andres', 'Mendez Ruiz', 'passport', 'P3749209', '+5497366268', 'caru@test.ar', 3, 3),
(NULL, 'Laura Isabel', 'Martinez Rios', 'passport', 'P28374922', '+5497366269', 'lir@test.ar', 4, 4),
(NULL, 'Sofia Alejandra', 'Perez Suarez', 'passport', 'P28374923', '+5497366270', 'sap@test.ar', 5, 1),
(NULL, 'Martin Rodrigo', 'Gomez Romero', 'passport', 'P8374920', '+5497366271', 'mgr@test.ar', 6, 2),
(NULL, 'Julieta Paola', 'Ramirez Fernandez', 'dni', '28374924', '+5497366272', 'jpr@test.ar', 1, 3),
(NULL, 'Andres Eduardo', 'Sanchez Velazquez', 'passport', 'P28374925', '+5497366273', 'aev@test.ar', 2, 4),
(NULL, 'Camila Beatriz', 'Morales Rodriguez', 'passport', 'P28374926', '+5497366274', 'cmr@test.ar', 3, 1);


INSERT INTO EXAM_REFERENCES (exam_reference_id, name, unit, value, method_type, sample_type, price) VALUES
(NULL, 'Hematíes', '/mm3', '3960000-5210000', 'Impedancia - Citometría de Flujo', 'sangre entera', 9854.32),
(NULL, 'Hemoglobina', 'g/dL', '11,7-14,9', 'Impedancia - Citometría de Flujo', 'sangre entera', 8456.05),
(NULL, 'Hematocrito', '%', '35,0-44,0', 'Impedancia - Citometría de Flujo', 'sangre entera', 7877.87),
(NULL, 'V.C.M.', 'fL', '81,0-95,0', 'Impedancia - Citometría de Flujo', 'sangre entera', 6448.12),
(NULL, 'H.C.M.', 'pg', '26,7-32,5', 'Impedancia - Citometría de Flujo', 'sangre entera', 6588.03),
(NULL, 'C.H.C.M.', 'g/dL', '32,0-35,0', 'Impedancia - Citometría de Flujo', 'sangre entera', 7145.12),
(NULL, 'ADE (RDW)', '%', '11,6-14,8', 'Impedancia - Citometría de Flujo', 'sangre entera', 7994.23),
(NULL, 'Recuento de Plaquetas', '/mm3', '177000-390000', 'Impedancia - Citometría de Flujo', 'sangre entera', 14566.01),
(NULL, 'Leucocitos', '/mm3', '4600-10900', 'Impedancia - Citometría de Flujo', 'sangre entera', 11547.14),
(NULL, 'Neutrófilos', '/mm3', '41-69% 2200-6800/mm3', 'Impedancia - Citometría de Flujo', 'sangre entera', 7982.02),
(NULL, 'Eosinófilos', '/mm3', '0.5-7.0% 30-530/mm3', 'Impedancia - Citometría de Flujo', 'sangre entera', 7554.03),
(NULL, 'Basófilos', '/mm3', '0-1% 7-80/mm3', 'Impedancia - Citometría de Flujo', 'sangre entera', 7644.15),
(NULL, 'Linfocitos', '/mm3', '21-47% 1400-3700/mm3', 'Impedancia - Citometría de Flujo', 'sangre entera', 7453.21),
(NULL, 'Monocitos', '/mm3', '5-13% 300-1000/mm3', 'Impedancia - Citometría de Flujo', 'sangre entera', 7924.03),
(NULL, 'Eritrosedimentación 1 Hora', 'mm/hora', 'Hasta 20', 'Westergreen', 'sangre entera', 11264.06),
(NULL, 'Glucemia (Basal)', 'mg/dL', '74-106', 'Hexoquinasa', 'suero', 13487.90),
(NULL, 'Urea en sangre', 'mg/dL', '17-49', 'Cinético. UV(Ureasa-Glutamato DH)', 'suero', 10470.26),
(NULL, 'Creatinina en suero', 'mg/dL', '0,51-0,95', 'Jaffe Cinético', 'suero', 8957.65),
(NULL, 'Colesterol HDL', 'mg/dL', 'No riesgo > 65. Riesgo moderado: 45 - 65. Riesgo alto < 45', 'Método directo. (Colesterol esterasa-POD)', 'suero', 11578.32),
(NULL, 'Colesterol LDL', 'mg/dL', 'Óptimo < 100. Limítrofe bajo: 100-129. Limítrofe alto: 130-159. Alto: 160-189. Muy alto > 190', 'Cálculo', 'suero', 12770.87),
(NULL, 'Triglicéridos', 'mg/dL', 'Normal < 150. Levemente elevados: 150-199. Elevado: 200-500. Muy elevados > 500', 'Enzimático Colorimétrico (LPL-GPO-POD)', 'suero', 12677.04),
(NULL, 'Tirotrofina (TSH)', 'μUI/mL', '0.28-5.00', 'ECLIA', 'suero', 9871.65),
(NULL, 'Ac. Anti Peroxidasa (ATPO)', 'UI/mL', 'Hasta 35.0', 'ECLIA', 'suero', 17244.02),
(NULL, 'Vitamina D 25-OH', 'ng/mL', 'Deficiencia < 20.0. Insuficiencia: 21.0-29.0. Suficiencia > 30.0', 'ECLIA', 'suero', 18549.54);


INSERT INTO PATIENT_VISITS (visit_id, patient_id, branch_office_id, receptionist_id) VALUES
(NULL, 1, 1, 1), (NULL, 1, 1, 1),
(NULL, 2, 1, 5), (NULL, 2, 1, 5),
(NULL, 3, 1, 9), (NULL, 3, 1, 9),
(NULL, 4, 1, 5), (NULL, 4, 1, 5),
(NULL, 5, 1, 1), (NULL, 5, 1, 1),
(NULL, 6, 2, 2), (NULL, 6, 2, 2),
(NULL, 7, 2, 6), (NULL, 7, 2, 6),
(NULL, 8, 2, 2), (NULL, 8, 2, 2),
(NULL, 9, 2, 6), (NULL, 9, 2, 6),
(NULL, 10, 2, 2), (NULL, 10, 2, 2),
(NULL, 11, 3, 3), (NULL, 11, 3, 3),
(NULL, 12, 3, 7), (NULL, 12, 3, 7),
(NULL, 13, 3, 3), (NULL, 13, 3, 3),
(NULL, 14, 3, 7), (NULL, 14, 3, 7),
(NULL, 15, 3, 3), (NULL, 15, 3, 3),
(NULL, 16, 4, 4), (NULL, 16, 4, 4),
(NULL, 17, 4, 8), (NULL, 17, 4, 8),
(NULL, 18, 4, 4), (NULL, 18, 4, 4),
(NULL, 19, 4, 8), (NULL, 19, 4, 8),
(NULL, 20, 4, 4), (NULL, 20, 4, 4);


INSERT INTO EXAMS (exam_id, result, biochemist_id, exam_reference_id, assistance_id, visit_id) VALUES 
(NULL, '3960000', 1, 1, 1, 1), (NULL, '18', 1, 15, 1, 1), (NULL, '4.2', 1, 22, 1, 1), (NULL, '14,9', 1, 2, 2, 2),
(NULL, '41,0', 2, 3, 3, 3), (NULL, '95,0', 2, 4, 4, 4), (NULL, '58% 5200/mm3', 2, 10, 4, 4), (NULL, '81', 2, 16, 4, 4),
(NULL, '26,7', 3, 5, 5, 5), (NULL, '200', 3, 21, 5, 5), (NULL, '18', 3, 24, 5, 5), (NULL, '81', 3, 16, 5, 5), (NULL, '32,0', 3, 6, 6, 6), (NULL, '32,0', 3, 5, 6, 6),
(NULL, '11,6', 4, 7, 7, 7), (NULL, '177000', 4, 8, 8, 8),
(NULL, '7600', 5, 9, 9, 9), (NULL, '40% 2200/mm3', 5, 10, 10, 10),
(NULL, '4.0% 230/mm3', 6, 11, 11, 11), (NULL, '1% 20/mm3', 6, 12, 12, 12),
(NULL, '21% 1400/mm3', 7, 13, 13, 13), (NULL, '13% 1000/mm3', 7, 14, 14, 14),
(NULL, '18', 8, 15, 15, 15), (NULL, '106', 8, 16, 16, 16), (NULL, '31,4', 8, 5, 16, 16),
(NULL, '49', 9, 17, 17, 17), (NULL, '0,56', 9, 18, 18, 18),
(NULL, '40', 10, 19, 19, 19), (NULL, '102', 10, 20, 20, 20),
(NULL, '140', 1, 21, 21, 21), (NULL, '0.28', 2, 22, 22, 22),
(NULL, '31', 3, 23, 23, 23), (NULL, '21', 4, 24, 24, 24),
(NULL, '4960000', 5, 1, 25, 25), (NULL, '13,9', 6, 2, 26, 26),
(NULL, '35,3', 7, 3, 27, 27), (NULL, '92,0', 8, 4, 28, 28), (NULL, '112', 8, 16, 28, 28), (NULL, '21,4', 8, 5, 28, 28),
(NULL, '26,7', 9, 5, 29, 29), (NULL, '32,0', 10, 6, 30, 30),
(NULL, '11,8', 1, 7, 31, 31), (NULL, '277000', 2, 8, 32, 32),
(NULL, '10900', 3, 9, 33, 33), (NULL, '59% 3800/mm', 4, 10, 34, 34),
(NULL, '2.0% 130/mm3', 5, 11, 35, 35), (NULL, '0.8% 50/mm3', 6, 12, 36, 36),
(NULL, '37% 2700/mm3', 7, 13, 37, 37), (NULL, '11% 900/mm3', 8, 14, 38, 38),
(NULL, '12', 9, 15, 39, 39), (NULL, '89', 10, 16, 40, 40), (NULL, '98', 10, 21, 40, 40);


INSERT INTO AUDIT_NEW_PATIENTS (audit_id, patient_id, date, user) VALUES
(NULL, 1, '2024-02-28 08:30:00', 'root@localhost'),
(NULL, 2, '2023-12-31 09:00:00', 'root@localhost'),
(NULL, 3, '2024-08-10 09:30:00', 'root@localhost'),
(NULL, 4, '2024-04-11 10:00:00', 'root@localhost'),
(NULL, 5, '2024-05-27 10:30:00', 'root@localhost'),
(NULL, 6, '2024-06-10 11:00:00', 'root@localhost'),
(NULL, 7, '2024-06-30 11:30:00', 'root@localhost'),
(NULL, 8, '2024-06-30 12:00:00', 'root@localhost'),
(NULL, 9, '2024-07-31 12:30:00', 'root@localhost'),
(NULL, 10, '2024-07-31 13:00:00', 'root@localhost'),
(NULL, 11, '2024-08-01 08:00:00', 'root@localhost'),
(NULL, 12, '2024-08-01 08:30:00', 'root@localhost'),
(NULL, 13, '2024-08-01 09:00:00', 'root@localhost'),
(NULL, 14, '2024-08-02 09:30:00', 'root@localhost'),
(NULL, 15, '2024-08-02 10:00:00', 'root@localhost'),
(NULL, 16, '2024-08-02 10:30:00', 'root@localhost'),
(NULL, 17, '2024-08-03 11:00:00', 'root@localhost'),
(NULL, 18, '2024-08-03 11:30:00', 'root@localhost'),
(NULL, 19, '2024-08-03 12:00:00', 'root@localhost'),
(NULL, 20, '2024-08-04 07:30:00', 'root@localhost');

INSERT INTO AUDIT_REMOVED_PATIENTS (audit_id, patient_id, date, user) VALUES
(NULL, 21, '2024-02-28 08:30:00', 'root@localhost'),
(NULL, 22, '2023-12-31 09:00:00', 'root@localhost');


### CREATE VIEWS

CREATE OR REPLACE VIEW vw_branch_offices_list AS (SELECT name, address, phone FROM BRANCH_OFFICES ORDER BY name);
SELECT * FROM vw_branch_offices_list;

CREATE OR REPLACE VIEW vw_health_insurances_list AS (
	SELECT HI.name AS name, IT.name AS type FROM HEALTH_INSURANCES HI
    JOIN INSURANCE_TYPES IT ON HI.insurance_type_id = IT.insurance_type_id
);
SELECT * FROM vw_health_insurances_list;

CREATE OR REPLACE VIEW vw_technicians_by_branch_office AS (
	SELECT b_o.name AS branch_office_name, tech.last_name, tech.first_name
    FROM TECHNICIANS tech
    JOIN BRANCH_OFFICES b_o
    ON tech.branch_office_id = b_o.branch_office_id
    ORDER BY branch_office_name
);
SELECT * FROM vw_technicians_by_branch_office;
 
CREATE OR REPLACE VIEW vw_biochemists_by_branch_office AS (
	SELECT b_o.name AS branch_office_name, bio.last_name, bio.first_name
    FROM BIOCHEMISTS bio
    JOIN BRANCH_OFFICES b_o
    ON bio.branch_office_id = b_o.branch_office_id
    ORDER BY branch_office_name
);
SELECT * FROM vw_biochemists_by_branch_office;

CREATE OR REPLACE VIEW vw_exams_list AS (SELECT name, price FROM EXAM_REFERENCES ORDER BY name);
SELECT * FROM vw_exams_list;

CREATE OR REPLACE VIEW vw_patient_details AS (
	SELECT
		P.last_name AS patient_last_name,
		P.first_name AS patient_first_name,
		P.email AS patient_email,
		P.phone AS patient_phone,
		P.document_type AS patient_document_type,
		P.document_number AS patient_document_number,
        C.country_name AS patient_country,
		H.name AS health_insurance,
		A.date_time AS assistance_date_time,
        T.last_name AS technician_last_name,
        B.last_name AS biochemist_last_name,
        R.last_name AS receptionist_last_name,
        BO.name AS branch_office_name
	FROM PATIENTS P
    LEFT JOIN COUNTRIES C ON P.country_id = C.country_id
    LEFT JOIN HEALTH_INSURANCES H ON P.health_insurance_id = H.health_insurance_id
	LEFT JOIN ASSISTANCE_RECORDS A ON P.patient_id = A.patient_id
    LEFT JOIN TECHNICIANS T ON A.technician_id = T.technician_id
    LEFT JOIN EXAMS E ON A.assistance_id = E.assistance_id
    LEFT JOIN BIOCHEMISTS B ON E.biochemist_id = B.biochemist_id
    LEFT JOIN PATIENT_VISITS PV ON E.visit_id = PV.visit_id
    LEFT JOIN BRANCH_OFFICES BO ON PV.branch_office_id = BO.branch_office_id
    LEFT JOIN RECEPTIONISTS R ON PV.receptionist_id = R.receptionist_id
);

SELECT * FROM vw_patient_details;


### CREATE FUNCTIONS

DROP FUNCTION IF EXISTS fn_amount_by_date;
DELIMITER $$
	CREATE FUNCTION fn_amount_by_date (
		p_id INT,
        start_time DATETIME,
        end_time DATETIME
    )
	RETURNS DECIMAL(10, 2)
    DETERMINISTIC
    BEGIN
		DECLARE final_amount DECIMAL(10, 2);
        
        SELECT SUM(ER.price) INTO final_amount
        FROM EXAM_REFERENCES ER
        JOIN EXAMS E ON ER.exam_reference_id = E.exam_reference_id
        JOIN ASSISTANCE_RECORDS A ON E.assistance_id = A.assistance_id
        WHERE A.patient_id = p_id
        AND A.date_time BETWEEN start_time AND end_time;
        
        IF final_amount IS NULL THEN
			SET final_amount = 0.00;
		END IF;
        
        RETURN final_amount;
    END;
$$

SELECT fn_amount_by_date(1, '2024-01-10 07:30:00', '2024-02-12 08:45:00') AS total_price;


DROP FUNCTION IF EXISTS fn_patients_by_country;
DELIMITER $$
	CREATE FUNCTION fn_patients_by_country(c_name VARCHAR(100)) RETURNS INT
	READS SQL DATA
	BEGIN
	 DECLARE result INT;
     DECLARE lowerCaseName VARCHAR(100);
     SET lowerCaseName = lcase(c_name);
     
     IF lowerCaseName LIKE '%ú' THEN
		SET lowerCaseName = replace(lowerCaseName, 'ú', 'u');
     END IF;
     
     SELECT count(*) INTO result FROM PATIENTS WHERE country_id = (
		SELECT country_id FROM COUNTRIES WHERE country_name = lowerCaseName
	 );
     
     RETURN result;
	END
$$

SELECT fn_patients_by_country('Argentina') AS 'total_patients';


DROP FUNCTION IF EXISTS fn_staff_by_country;

DELIMITER $$
	CREATE FUNCTION fn_staff_by_country(c_name VARCHAR(100)) RETURNS INT
    READS SQL DATA
    BEGIN
		DECLARE result INT;
        DECLARE lowerCaseName VARCHAR(100);
        DECLARE totalBiochemists INT;
        DECLARE totalTechnicians INT;
        DECLARE totalReceptionists INT;
		SET lowerCaseName = lcase(c_name);
     
		IF lowerCaseName LIKE '%ú' THEN
			SET lowerCaseName = replace(lowerCaseName, 'ú', 'u');
		END IF;
        
        SELECT count(*) INTO totalBiochemists FROM BIOCHEMISTS WHERE country_id = (
			SELECT country_id FROM COUNTRIES WHERE country_name = lowerCaseName
		);
        
        SELECT count(*) INTO totalTechnicians FROM TECHNICIANS WHERE country_id = (
			SELECT country_id FROM COUNTRIES WHERE country_name = lowerCaseName
		);
        
        SELECT count(*) INTO totalReceptionists FROM RECEPTIONISTS WHERE country_id = (
			SELECT country_id FROM COUNTRIES WHERE country_name = lowerCaseName
        );
        
        SET result = totalBiochemists + totalTechnicians + totalReceptionists;
        RETURN result;
    END
$$

SELECT fn_staff_by_country('Chile') AS total_staff;


### CREATE STORE PROCEDURES

DROP PROCEDURE IF EXISTS sp_amount_to_insurance;
DELIMITER $$
CREATE PROCEDURE `sp_amount_to_insurance` (
	IN p_id INT,
	IN start_time DATETIME,
	IN end_time DATETIME,
    OUT final_amount DECIMAL(10, 2),
    OUT insurance_email VARCHAR(80),
    OUT insurance_name VARCHAR(150),
    OUT insurance_type VARCHAR(100),
    OUT patient_doc_type VARCHAR(30),
    OUT patient_doc_number VARCHAR(50)
)
BEGIN
	SET @error_message = 'can´t be null or an empty field.';
    SET @is_valid = true;
    
	IF p_id IS NULL OR p_id <= 0 THEN
		SET @error_message = CONCAT('Error: Patient id ', @error_message);
        SET @is_valid = false;
	ELSEIF start_time IS NULL THEN
		SET @error_message = CONCAT('Error: Start time ', @error_message);
        SET @is_valid = false;
	ELSEIF end_time IS NULL THEN
		SET @error_message = CONCAT('Error: End time ', @error_message);
        SET @is_valid = false;
	END IF;
    
    IF NOT @is_valid THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @error_message;
    END IF;
    
    SET final_amount = (SELECT fn_amount_by_date(p_id, start_time, end_time));
    
    IF final_amount IS NULL OR final_amount = 0.00 THEN
		SET @error_message = 'Error: Can´t process amount by dates or patient id.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @error_message;
    END IF;
    
    
    SET insurance_email = (SELECT email FROM HEALTH_INSURANCES WHERE health_insurance_id = (SELECT health_insurance_id FROM PATIENTS WHERE patient_id = p_id));
    SET insurance_name = (SELECT name FROM HEALTH_INSURANCES WHERE health_insurance_id = (SELECT health_insurance_id FROM PATIENTS WHERE patient_id = p_id));
    SET insurance_type = (SELECT IT.name FROM INSURANCE_TYPES IT
						JOIN HEALTH_INSURANCES HI ON IT.insurance_type_id = HI.insurance_type_id
                        JOIN PATIENTS P ON HI.health_insurance_id = P.health_insurance_id
                        WHERE P.patient_id = p_id);
	SET patient_doc_type = (SELECT document_type FROM PATIENTS WHERE patient_id = p_id);
    SET patient_doc_number = (SELECT document_number FROM PATIENTS WHERE patient_id = p_id);
END
$$

CALL sp_amount_to_insurance(3, '2024-05-01 00:00:00', '2024-05-31 23:59:59', @final_amount, @insurance_email, @insurance_name, @insurance_type, @patient_doc_type, @patient_doc_number);
SELECT @final_amount, @insurance_email, @insurance_name, @insurance_type, @patient_doc_type, @patient_doc_number;


DROP PROCEDURE IF EXISTS sp_generate_exams_result;
DELIMITER $$
CREATE PROCEDURE `sp_generate_exams_result` (
	IN p_id INT,
    IN d_time DATETIME
)
BEGIN
	IF NOT EXISTS (SELECT 1 FROM PATIENTS WHERE patient_id = p_id) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Patient Id does not exists.';
	END IF;

	IF NOT EXISTS (
		SELECT 1 FROM ASSISTANCE_RECORDS AR
		WHERE AR.date_time = d_time AND AR.patient_id = p_id 
    ) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: There is not Date Time associated to Patient id.';
	END IF;

	SELECT 
        P.first_name,
        P.last_name,
        P.document_type,
        P.document_number,
        E.result,
        ER.name AS exam_name,
        ER.value AS exam_value_default,
        ER.unit AS exam_unit,
        ER.method_type AS exam_method_type,
        ER.sample_type AS exam_sample_type,
        AR.date_time,
        B.last_name AS biochemist_first_name,
        B.first_name AS biochemist_last_name
    FROM PATIENTS P
    JOIN PATIENT_VISITS PV ON P.patient_id = PV.patient_id
    JOIN EXAMS E ON PV.visit_id = E.visit_id
    JOIN BIOCHEMISTS B ON E.biochemist_id = B.biochemist_id
    JOIN EXAM_REFERENCES ER ON E.exam_reference_id = ER.exam_reference_id
    JOIN ASSISTANCE_RECORDS AR ON E.assistance_id = AR.assistance_id
    WHERE P.patient_id = p_id
    AND AR.date_time = d_time;
END
$$

CALL sp_generate_exams_result(2, '2024-04-18 10:30:00');


DROP PROCEDURE IF EXISTS sp_add_reference_exam;
DELIMITER $$
CREATE PROCEDURE `sp_add_reference_exam` (
	IN e_name VARCHAR(150),
	IN e_unit VARCHAR(20),
	IN e_value VARCHAR(300),
	IN e_method_type VARCHAR(90),
	IN e_sample_type VARCHAR(50),
    IN e_price DECIMAL(10, 2)
)
BEGIN
	SET @error_message = 'can´t be null or an empty field.';
	
	IF e_name IS NULL OR e_name = '' THEN
		SET @error_message = concat('Error: name ', @error_message);
	ELSEIF e_unit IS NULL OR e_unit = '' THEN
		SET @error_message = concat('Error: unit ', @error_message);
	ELSEIF e_value IS NULL OR e_value = '' THEN
		SET @error_message = concat('Error: value ', @error_message);
	ELSEIF e_method_type IS NULL OR e_method_type = '' THEN
		SET @error_message = concat('Error: method_type ', @error_message);
	ELSEIF e_sample_type IS NULL OR e_sample_type = '' THEN
		SET @error_message = concat('Error: sample_type ', @error_message);
	ELSEIF e_price IS NULL OR e_price = '' THEN
		SET @error_message = concat('Error: price ', @error_message);
	END IF;
	
	IF @error_message != 'can´t be null or an empty field.' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @error_message;
	END IF;
        
	SELECT max(exam_reference_id) INTO @last_id FROM EXAM_REFERENCES;
	INSERT INTO EXAM_REFERENCES (exam_reference_id, name, unit, value, method_type, sample_type, price) VALUES
	(@last_id + 1, e_name, e_unit, e_value, e_method_type, e_sample_type, e_price);
	
	SELECT * FROM EXAM_REFERENCES ORDER BY exam_reference_id DESC;
END
$$

CALL sp_add_reference_exam('Láctico Deshidrogenasa (LDH)', 'UI', '240-480', 'DGKC. Cinético UV', 'suero', 16104.97);


DROP PROCEDURE IF EXISTS sp_qty_assistances_by_field;
DELIMITER $$
CREATE PROCEDURE `sp_qty_assistances_by_field` (IN field VARCHAR(50))
BEGIN
	SET @error_message = '';
    
    IF field IS NULL OR field = '' THEN
		SET @error_message = 'Field can´t be null or empty.';
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @error_message;
	ELSEIF field = 'assistance_id' THEN
		SET @error_message = 'Field can´t be grouped by assistance_id because has unique values.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @error_message;
	ELSE
		SET @group_by = concat(' GROUP BY ', field);
    END IF;
    
    SET @clause = concat('SELECT count(*) AS quantity, ', field, ' FROM ASSISTANCE_RECORDS', @group_by);
    PREPARE runSQL FROM @clause;
    EXECUTE runSQL;
    DEALLOCATE PREPARE runSQL;
END
$$

CALL sp_qty_assistances_by_field('technician_id');


### CREATE TRIGGERS

DROP TRIGGER IF EXISTS tr_audit_new_patient;
DELIMITER $$
CREATE TRIGGER `tr_audit_new_patient`
AFTER INSERT ON PATIENTS
FOR EACH ROW
INSERT INTO AUDIT_NEW_PATIENTS
VALUES (NULL, NEW.patient_id, CURRENT_TIMESTAMP(), USER());
$$

INSERT INTO PATIENTS (patient_id, first_name, last_name, document_type, document_number, phone, email, country_id, health_insurance_id) VALUES
(NULL, 'Mirta', 'Perez', 'passport', '918238', '', 'perezm@testing.com', 6, 7);

SELECT * FROM AUDIT_NEW_PATIENTS ORDER BY audit_id DESC;
SELECT * FROM PATIENTS ORDER BY patient_id DESC;


DROP TRIGGER IF EXISTS tr_audit_remove_patient;
DELIMITER $$
CREATE TRIGGER `tr_audit_remove_patient`
AFTER DELETE ON PATIENTS
FOR EACH ROW
INSERT INTO AUDIT_REMOVED_PATIENTS
VALUES (NULL, OLD.patient_id, CURRENT_TIMESTAMP(), USER());
$$

DELETE FROM PATIENTS WHERE patient_id = 12;

SELECT * FROM AUDIT_REMOVED_PATIENTS ORDER BY audit_id DESC;
SELECT * FROM PATIENTS WHERE patient_id = 12;


### GENERATE REPORTS

DROP PROCEDURE IF EXISTS sp_top_exams_performed;
DELIMITER $$
CREATE PROCEDURE sp_top_exams_performed (
    IN start_datetime DATETIME,
    IN end_datetime DATETIME
)
BEGIN
	IF start_datetime IS NULL OR end_datetime IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Start date and End date cannot be null';
	END IF;

    SELECT 
        ER.name,
        COUNT(E.exam_id) AS total_performed
    FROM EXAMS E
    JOIN EXAM_REFERENCES ER ON E.exam_reference_id = ER.exam_reference_id
    JOIN ASSISTANCE_RECORDS AR ON E.assistance_id = AR.assistance_id
    WHERE AR.date_time BETWEEN start_datetime AND end_datetime
    GROUP BY ER.name
    ORDER BY total_performed DESC
    LIMIT 5;
END
$$

CALL sp_top_exams_performed('2024-05-01 00:00:00', '2024-05-31 23:59:59');


DROP PROCEDURE IF EXISTS sp_most_profitable_exam;
DELIMITER $$
CREATE PROCEDURE `sp_most_profitable_exam` (
	IN start_datetime DATETIME,
    IN end_datetime DATETIME
)
BEGIN
	IF start_datetime IS NULL OR end_datetime IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Start date and End date cannot be null';
	END IF;

	SELECT
		ER.name,
		SUM(ER.price) AS total_profit
    FROM EXAMS E
    JOIN EXAM_REFERENCES ER ON E.exam_reference_id = ER.exam_reference_id
    JOIN ASSISTANCE_RECORDS AR ON E.assistance_id = AR.assistance_id
	WHERE AR.date_time BETWEEN start_datetime AND end_datetime
    GROUP BY ER.exam_reference_id
    ORDER BY total_profit DESC
    LIMIT 1;
END
$$

CALL sp_most_profitable_exam('2024-04-01 00:00:00', '2024-04-30 23:59:59');
