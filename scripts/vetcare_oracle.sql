CREATE USER vetcare IDENTIFIED BY admin123;
GRANT ALL PRIVILEGES TO vetcare;
CONNECT vetcare/admin123@XE;

CREATE TABLE owners (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    doc_type VARCHAR2(20) NOT NULL,
    doc_number VARCHAR2(30) NOT NULL,
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100) NOT NULL,
    phone VARCHAR2(20),
    email VARCHAR2(150),
    status VARCHAR2(20) DEFAULT 'active',
    CONSTRAINT uq_doc UNIQUE (doc_type, doc_number)
);
/

CREATE TABLE vets (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    doc_type VARCHAR2(20) NOT NULL,
    doc_number VARCHAR2(30) NOT NULL,
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100) NOT NULL,
    phone VARCHAR2(20),
    email VARCHAR2(150),
    status VARCHAR2(20) DEFAULT 'active',
    CONSTRAINT uq_vet_doc UNIQUE (doc_type, doc_number)
);
/

CREATE TABLE pets (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    owner_id NUMBER NOT NULL,
    name VARCHAR2(100) NOT NULL,
    status VARCHAR2(20) DEFAULT 'active',
    CONSTRAINT fk_owner_id FOREIGN KEY (owner_id) REFERENCES owners(id)
);
/

CREATE TABLE vaccines (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    status VARCHAR2(20) DEFAULT 'active'
);
/

CREATE TABLE appointments (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pet_id NUMBER NOT NULL,
    vet_id NUMBER NOT NULL,
    appointment_date DATE NOT NULL,
    subtotal NUMBER(10,2) NOT NULL,
    tax NUMBER(10,2) NOT NULL,
    total NUMBER(10,2) NOT NULL,
    status VARCHAR2(20) DEFAULT 'active',
    CONSTRAINT fk_pet_id FOREIGN KEY (pet_id) REFERENCES pets(id),
    CONSTRAINT fk_vet_id FOREIGN KEY (vet_id) REFERENCES vets(id)
);
/

CREATE TABLE consultations (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    appointment_id NUMBER NOT NULL,
    name VARCHAR2(150) NOT NULL,
    status VARCHAR2(20) DEFAULT 'active',
    CONSTRAINT fk_appointment_id FOREIGN KEY (appointment_id) REFERENCES appointments(id)
);
/

CREATE TABLE prescriptions (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    consultation_id NUMBER NOT NULL,
    name VARCHAR2(150) NOT NULL,
    status VARCHAR2(20) DEFAULT 'active',
    CONSTRAINT fk_consultation_id FOREIGN KEY (consultation_id) REFERENCES consultations(id)
);
/

CREATE TABLE vaccine_applications (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pet_id NUMBER NOT NULL,
    vaccine_id NUMBER NOT NULL,
    name VARCHAR2(150),
    status VARCHAR2(20) DEFAULT 'active',
    CONSTRAINT fk_va_pet_id FOREIGN KEY (pet_id) REFERENCES pets(id),
    CONSTRAINT fk_va_vaccine_id FOREIGN KEY (vaccine_id) REFERENCES vaccines(id)
);
/

CREATE TABLE payments (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    appointment_id NUMBER NOT NULL,
    reference VARCHAR2(100),
    method VARCHAR2(50) NOT NULL,
    amount NUMBER(10,2) NOT NULL,
    payment_date DATE NOT NULL,
    status VARCHAR2(20) DEFAULT 'active',
    CONSTRAINT fk_payment_appointment_id FOREIGN KEY (appointment_id) REFERENCES appointments(id)
);
/

