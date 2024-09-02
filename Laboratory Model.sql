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

CREATE TABLE PATIENTS(
	patient_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(60) NOT NULL,
    last_name VARCHAR(60) NOT NULL,
    document_type VARCHAR(30) NOT NULL,
    document_number VARCHAR(50) NOT NULL,
    phone VARCHAR(40),
    email VARCHAR(50) NOT NULL,
    country_id INT NOT NULL,
    PRIMARY KEY(patient_id),
    CONSTRAINT fk_patients_countries FOREIGN KEY(country_id) REFERENCES COUNTRIES(country_id) ON UPDATE CASCADE ON DELETE CASCADE
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

CREATE TABLE EXAM_REFERENCES(
	exam_reference_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    unit VARCHAR(20) NOT NULL,
    value VARCHAR(300) NOT NULL,
    method_type VARCHAR(90) NOT NULL,
    sample_type VARCHAR(50) NOT NULL,
    PRIMARY KEY(exam_reference_id)
);

CREATE TABLE EXAMS(
	exam_id INT NOT NULL AUTO_INCREMENT,
    result VARCHAR(70) NOT NULL,
    biochemist_id INT NOT NULL,
    technician_id INT NOT NULL,
    patient_id INT NOT NULL,
    exam_reference_id INT NOT NULL,
    PRIMARY KEY(exam_id),
    CONSTRAINT fk_exams_biochemists FOREIGN KEY(biochemist_id) REFERENCES BIOCHEMISTS(biochemist_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_exams_patients FOREIGN KEY(patient_id) REFERENCES PATIENTS(patient_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_exams_technicians FOREIGN KEY(technician_id) REFERENCES TECHNICIANS(technician_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_exams_exam_references FOREIGN KEY(exam_reference_id) REFERENCES EXAM_REFERENCES(exam_reference_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE PATIENT_VISITS(
	visit_id INT NOT NULL AUTO_INCREMENT,
    patient_id INT NOT NULL,
    branch_office_id INT NOT NULL,
    PRIMARY KEY(visit_id),
    CONSTRAINT fk_patient_visits_patients FOREIGN KEY(patient_id) REFERENCES PATIENTS(patient_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_patient_visits_branch_offices FOREIGN KEY(branch_office_id) REFERENCES BRANCH_OFFICES(branch_office_id) ON UPDATE CASCADE ON DELETE CASCADE
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

INSERT INTO COUNTRIES VALUES
(NULL, 'Argentina'),
(NULL, 'Chile'),
(NULL, 'Venezuela'),
(NULL, 'Uruguay'),
(NULL, 'Colombia'),
(NULL, 'Peru');

INSERT INTO PATIENTS VALUES
(NULL, 'Jorge Luis', 'Diaz Velez', 'dni', '28374920', '+5497366266', 'jgld@test.ar', 1),
(NULL, 'Maria Elisa', 'Lopez', 'dni', '34534543', '+5495355836', 'melopez@test.ar', 1),
(NULL, 'Ernesto', 'West', 'dni', '34536677', '+5494666636', 'ern.west@test.ar', 1),
(NULL, 'Carla', 'Aldina', 'passport', '17237137k', '+5497990342', 'car.al@test.ar', 2),
(NULL, 'Mario', 'Pinola', 'dni', '9928488', '+5494882272', 'pinola@test.ar', 1),
(NULL, 'Teresa', 'Flores', 'dni', '7232766', '+549346566', 'teresa.f@test.ar', 1),
(NULL, 'Maria Fernanda', 'Lopez Gonzalez', 'passport', '29485673', '+5497366721', 'mflg@test.ar', 2),
(NULL, 'Carlos Alberto', 'Ramirez Perez', 'passport', '30294715', '+5497366845', 'carp@test.ar', 3),
(NULL, 'Laura Beatriz', 'Martinez Soto', 'passport', '27845691', '+5497366999', 'lbms@test.ar', 4),
(NULL, 'Fernando Javier', 'Gomez Torres', 'passport', '31567832', '+5497366333', 'fjgt@test.ar', 5),
(NULL, 'Andrea', 'Moreno', 'dni', '28947284', '+5493467890', 'amoreno@test.ar', 1),
(NULL, 'Santiago', 'Nuñez', 'passport', 'M789345', '+5497776655', 'snunez@test.ar', 2),
(NULL, 'Lucia', 'Garcia', 'dni', '35678945', '+5491234567', 'lgarcia@test.ar', 1),
(NULL, 'Gabriel', 'Castro', 'passport', 'X934857', '+5498887766', 'gcastro@test.ar', 3),
(NULL, 'Valeria', 'Ortega', 'dni', '28954322', '+5496543210', 'vortega@test.ar', 1),
(NULL, 'Rodrigo', 'Serrano', 'passport', 'K123456', '+5499998887', 'rserrano@test.ar', 6),
(NULL, 'Juliana', 'Gonzalez', 'passport', 'Y845632', '+5492223334', 'jgonzalez@test.ar', 5),
(NULL, 'Mariano', 'Rojas', 'dni', '30987212', '+5497766554', 'mrojas@test.ar', 1),
(NULL, 'Sofía', 'Blanco', 'dni', '32847623', '+5491239874', 'sblanco@test.ar', 1),
(NULL, 'Sebastian', 'Martinez', 'passport', 'L678934', '+5491112233', 'smartinez@test.ar', 2);

INSERT INTO BRANCH_OFFICES VALUES
(NULL, 'Valdez', 'Av Valdez Georgia 1993', '48817729'),
(NULL, 'Pichincha', 'Pichincha 837', '4912837'),
(NULL, 'Sued', 'Sued 93993', '47172779'),
(NULL, 'Fiordino', 'Fiordino Suarez 138', '47394989');

INSERT INTO TECHNICIANS VALUES
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

INSERT INTO ASSISTANCE_RECORDS VALUES
(NULL, '2024-03-01 08:30:00', 1, 2),
(NULL, '2024-01-01 09:00:00', 2, 3),
(NULL, '2024-08-11 09:30:00', 3, 5),
(NULL, '2024-04-12 10:00:00', 4, 1),
(NULL, '2024-05-28 10:30:00', 5, 4),
(NULL, '2024-06-11 11:00:00', 6, 7),
(NULL, '2024-07-01 11:30:00', 7, 8),
(NULL, '2024-07-01 12:00:00', 8, 10),
(NULL, '2024-08-01 12:30:00', 9, 6),
(NULL, '2024-08-01 13:00:00', 10, 9),
(NULL, '2024-08-02 08:30:00', 11, 1),
(NULL, '2024-08-02 09:00:00', 12, 3),
(NULL, '2024-08-02 09:30:00', 13, 2),
(NULL, '2024-08-03 10:00:00', 14, 4),
(NULL, '2024-08-03 10:30:00', 15, 6),
(NULL, '2024-08-03 11:00:00', 16, 5),
(NULL, '2024-08-04 11:30:00', 17, 7),
(NULL, '2024-08-04 12:00:00', 18, 8),
(NULL, '2024-08-04 12:30:00', 19, 9),
(NULL, '2024-08-05 08:00:00', 20, 10);

INSERT INTO BIOCHEMISTS VALUES
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

INSERT INTO EXAM_REFERENCES VALUES
(NULL, 'Hematíes', '/mm3', '3960000-5210000', 'Impedancia - Citometría de Flujo', 'sangre entera'),
(NULL, 'Hemoglobina', 'g/dL', '11,7-14,9', 'Impedancia - Citometría de Flujo', 'sangre entera'),
(NULL, 'Hematocrito', '%', '35,0-44,0', 'Impedancia - Citometría de Flujo', 'sangre entera'),
(NULL, 'V.C.M.', 'fL', '81,0-95,0', 'Impedancia - Citometría de Flujo', 'sangre entera'),
(NULL, 'H.C.M.', 'pg', '26,7-32,5', 'Impedancia - Citometría de Flujo', 'sangre entera'),
(NULL, 'C.H.C.M.', 'g/dL', '32,0-35,0', 'Impedancia - Citometría de Flujo', 'sangre entera'),
(NULL, 'ADE (RDW)', '%', '11,6-14,8', 'Impedancia - Citometría de Flujo', 'sangre entera'),
(NULL, 'Recuento de Plaquetas', '/mm3', '177000-390000', 'Impedancia - Citometría de Flujo', 'sangre entera'),
(NULL, 'Leucocitos', '/mm3', '4600-10900', 'Impedancia - Citometría de Flujo', 'sangre entera'),
(NULL, 'Neutrófilos', '/mm3', '41-69% 2200-6800/mm3', 'Impedancia - Citometría de Flujo', 'sangre entera'),
(NULL, 'Eosinófilos', '/mm3', '0.5-7.0% 30-530/mm3', 'Impedancia - Citometría de Flujo', 'sangre entera'),
(NULL, 'Basófilos', '/mm3', '0-1% 7-80/mm3', 'Impedancia - Citometría de Flujo', 'sangre entera'),
(NULL, 'Linfocitos', '/mm3', '21-47% 1400-3700/mm3', 'Impedancia - Citometría de Flujo', 'sangre entera'),
(NULL, 'Monocitos', '/mm3', '5-13% 300-1000/mm3', 'Impedancia - Citometría de Flujo', 'sangre entera'),
(NULL, 'Eritrosedimentación 1 Hora', 'mm/hora', 'Hasta 20', 'Westergreen', 'sangre entera'),
(NULL, 'Glucemia (Basal)', 'mg/dL', '74-106', 'Hexoquinasa', 'suero'),
(NULL, 'Urea en sangre', 'mg/dL', '17-49', 'Cinético. UV(Ureasa-Glutamato DH)', 'suero'),
(NULL, 'Creatinina en suero', 'mg/dL', '0,51-0,95', 'Jaffe Cinético', 'suero'),
(NULL, 'Colesterol HDL', 'mg/dL', 'No riesgo > 65. Riesgo moderado: 45 - 65. Riesgo alto < 45', 'Método directo. (Colesterol esterasa-POD)', 'suero'),
(NULL, 'Colesterol LDL', 'mg/dL', 'Óptimo < 100. Limítrofe bajo: 100-129. Limítrofe alto: 130-159. Alto: 160-189. Muy alto > 190', 'Cálculo', 'suero'),
(NULL, 'Triglicéridos', 'mg/dL', 'Normal < 150. Levemente elevados: 150-199. Elevado: 200-500. Muy elevados > 500', 'Enzimático Colorimétrico (LPL-GPO-POD)', 'suero'),
(NULL, 'Tirotrofina (TSH)', 'μUI/mL', '0.28-5.00', 'ECLIA', 'suero'),
(NULL, 'Ac. Anti Peroxidasa (ATPO)', 'UI/mL', 'Hasta 35.0', 'ECLIA', 'suero'),
(NULL, 'Vitamina D 25-OH', 'ng/mL', 'Deficiencia < 20.0. Insuficiencia: 21.0-29.0. Suficiencia > 30.0', 'ECLIA', 'suero');

INSERT INTO EXAMS VALUES
(NULL, '4233001', 3, 2, 1, 1),
(NULL, '82', 3, 2, 1, 16),
(NULL, '21.2', 3, 2, 1, 24),
(NULL, '13,2', 1, 3, 2, 2),
(NULL, '38', 1, 3, 2, 17),
(NULL, '34.4', 1, 3, 2, 23),
(NULL, '42,0', 8, 5, 3, 3),
(NULL, '41', 8, 5, 3, 19),
(NULL, '110', 8, 5, 3, 20),
(NULL, '90,0', 9, 1, 4, 4),
(NULL, '12,7', 9, 1, 4, 7),
(NULL, '235', 9, 1, 4, 21),
(NULL, '21,6', 5, 4, 5, 5),
(NULL, '4.2% 230/mm3', 5, 4, 5, 11),
(NULL, '11% 560/mm3', 5, 4, 5, 14),
(NULL, '33.5', 6, 7, 6, 6),
(NULL, '28,6', 6, 7, 6, 5),
(NULL, '2.39', 6, 7, 6, 22),
(NULL, '14,9', 7, 8, 7, 7),
(NULL, '9% 451/mm3', 7, 8, 7, 13),
(NULL, '0,35', 7, 8, 7, 18),
(NULL, '210800', 2, 10, 8, 8),
(NULL, '9,16', 2, 10, 8, 2),
(NULL, '5809', 2, 10, 8, 9),
(NULL, '6700', 4, 6, 9, 9),
(NULL, '3', 4, 6, 9, 15),
(NULL, '19', 4, 6, 9, 24),
(NULL, '50% 3400/mm3', 10, 9, 10, 10),
(NULL, '2.8% 190/mm3', 10, 9, 10, 11),
(NULL, '1% 66/mm3', 10, 9, 10, 12),
(NULL, '41,7', 1, 1, 11, 3),
(NULL, '30,5', 2, 2, 12, 5),
(NULL, '9,6', 3, 3, 13, 7),
(NULL, '9900', 4, 4, 14, 9),
(NULL, '6.2% 430/mm3', 5, 5, 15, 11),
(NULL, '20% 1200/mm3', 6, 6, 16, 13),
(NULL, '21', 7, 7, 17, 15),
(NULL, '54', 8, 8, 18, 17),
(NULL, '31', 9, 9, 19, 19),
(NULL, '120', 10, 10, 20, 21),
(NULL, '84,1', 1, 2, 11, 4),
(NULL, '33,8', 2, 3, 12, 6),
(NULL, '250300', 3, 4, 13, 8),
(NULL, '58% 5820/mm3', 4, 5, 14, 10),
(NULL, '0,6% 60/mm3', 5, 6, 15, 12),
(NULL, '8% 850/mm3', 6, 7, 16, 14),
(NULL, '107', 7, 8, 17, 16),
(NULL, '0,45', 8, 9, 18, 18),
(NULL, '85', 9, 10, 19, 20),
(NULL, '0.34', 10, 1, 20, 22);

INSERT INTO PATIENT_VISITS VALUES
(NULL, 1, 2),
(NULL, 2, 3),
(NULL, 3, 1),
(NULL, 4, 4),
(NULL, 5, 2),
(NULL, 6, 3),
(NULL, 7, 1),
(NULL, 8, 4),
(NULL, 9, 2),
(NULL, 10, 3),
(NULL, 11, 1),
(NULL, 12, 2),
(NULL, 13, 3),
(NULL, 14, 4),
(NULL, 15, 1),
(NULL, 16, 2),
(NULL, 17, 3),
(NULL, 18, 4),
(NULL, 19, 1),
(NULL, 20, 2);

INSERT INTO AUDIT_NEW_PATIENTS VALUES
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

INSERT INTO AUDIT_REMOVED_PATIENTS VALUES
(NULL, 21, '2024-02-28 08:30:00', 'root@localhost'),
(NULL, 22, '2023-12-31 09:00:00', 'root@localhost');


### CREATE VIEWS

CREATE OR REPLACE VIEW vw_technicians_list AS (SELECT last_name, first_name FROM TECHNICIANS ORDER BY last_name);
SELECT * FROM vw_technicians_list;

CREATE OR REPLACE VIEW vw_biochemists_list AS (SELECT last_name, first_name FROM BIOCHEMISTS ORDER BY last_name);
SELECT * FROM vw_biochemists_list;

CREATE OR REPLACE VIEW vw_branch_offices_list AS (SELECT name, address, phone FROM BRANCH_OFFICES ORDER BY name);
SELECT * FROM vw_branch_offices_list;

CREATE OR REPLACE VIEW vw_exams_list AS (SELECT name FROM EXAM_REFERENCES ORDER BY name);
SELECT * FROM vw_exams_list;

CREATE OR REPLACE VIEW vw_patient_details AS
(SELECT 
    P.patient_id,
    P.first_name AS patient_first_name,
    P.last_name AS patient_last_name,
    P.email AS patient_email,
    A.date_time AS assistance_date_time,
    T.first_name AS technician_first_name,
    T.last_name AS technician_last_name,
    B.first_name AS biochemist_first_name,
    B.last_name AS biochemist_last_name,
    E.result AS exam_result,
    ER.name AS exam_name,
    ER.unit AS exam_unit,
    ER.value AS exam_value,
    ER.method_type AS exam_method_type,
    ER.sample_type AS exam_sample_type,
    PV.branch_office_id AS visit_branch_office_id
FROM PATIENTS P
LEFT JOIN ASSISTANCE_RECORDS A ON P.patient_id = A.patient_id
LEFT JOIN TECHNICIANS T ON A.technician_id = T.technician_id
LEFT JOIN EXAMS E ON P.patient_id = E.patient_id
LEFT JOIN BIOCHEMISTS B ON E.biochemist_id = B.biochemist_id
LEFT JOIN EXAM_REFERENCES ER ON E.exam_reference_id = ER.exam_reference_id
LEFT JOIN PATIENT_VISITS PV ON P.patient_id = PV.patient_id);

SELECT * FROM vw_patient_details;


### CREATE FUNCTIONS

DROP FUNCTION IF EXISTS patients_by_country;

DELIMITER $$
	CREATE FUNCTION patients_by_country(c_name VARCHAR(100)) RETURNS INT
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

SELECT patients_by_country('Argentina') AS 'total_patients';


DROP FUNCTION IF EXISTS staff_by_country;

DELIMITER $$
	CREATE FUNCTION staff_by_country(c_name VARCHAR(100)) RETURNS INT
    READS SQL DATA
    BEGIN
		DECLARE result INT;
        DECLARE lowerCaseName VARCHAR(100);
        DECLARE totalBiochemists INT;
        DECLARE totalTechnicians INT;
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
        
        SET result = totalBiochemists + totalTechnicians;
        RETURN result;
    END
$$

SELECT staff_by_country('Uruguay') AS total_staff;


# CREATE STORE PROCEDURES

DROP PROCEDURE IF EXISTS sp_add_reference_exam;

DELIMITER $$
CREATE PROCEDURE `sp_add_reference_exam` (
	IN e_name VARCHAR(150),
	IN e_unit VARCHAR(20),
	IN e_value VARCHAR(300),
	IN e_method_type VARCHAR(90),
	IN e_sample_type VARCHAR(50)
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
	END IF;
	
	IF @error_message != 'can´t be null or an empty field.' THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @error_message;
	END IF;
        
	SELECT max(exam_reference_id) INTO @last_id FROM EXAM_REFERENCES;
	INSERT INTO EXAM_REFERENCES VALUES
	(@last_id + 1, e_name, e_unit, e_value, e_method_type, e_sample_type);
	
	SELECT * FROM EXAM_REFERENCES ORDER BY exam_reference_id DESC;
END
$$

CALL sp_add_reference_exam('Láctico Deshidrogenasa (LDH)', 'UI', '240-480', 'DGKC. Cinético UV', 'suero');


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

CALL sp_qty_assistances_by_field('date_time');


# CREATE TRIGGERS

DROP TRIGGER IF EXISTS `tr_audit_new_patient`;

DELIMITER $$
CREATE TRIGGER `tr_audit_new_patient`
AFTER INSERT ON PATIENTS
FOR EACH ROW
INSERT INTO AUDIT_NEW_PATIENTS
VALUES (NULL, NEW.patient_id, CURRENT_TIMESTAMP(), USER());
$$

INSERT INTO PATIENTS VALUES
(NULL, 'Mirta', 'Perez', 'passport', '918238', '', 'perezm@testing.com', 6);

SELECT * FROM audit_new_patients ORDER BY audit_id DESC;


DROP TRIGGER IF EXISTS `tr_audit_remove_patient`;

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
