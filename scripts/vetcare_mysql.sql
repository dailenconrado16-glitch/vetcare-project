CREATE DATABASE vetcare;
USE vetcare;

CREATE TABLE owners (
    id INT AUTO_INCREMENT PRIMARY KEY,
    doc_type VARCHAR(20) NOT NULL,
    doc_number VARCHAR(30) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(150),
    status VARCHAR(20) DEFAULT 'active',
    CONSTRAINT uq_doc UNIQUE (doc_type, doc_number)
);

CREATE TABLE vets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    doc_type VARCHAR(20) NOT NULL,
    doc_number VARCHAR(30) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(150),
    status VARCHAR(20) DEFAULT 'active',
    CONSTRAINT uq_vet_doc UNIQUE (doc_type, doc_number)
);

CREATE TABLE pets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    owner_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    status VARCHAR(20) DEFAULT 'active',
    CONSTRAINT fk_owner_id FOREIGN KEY (owner_id) REFERENCES owners(id)
);

CREATE TABLE vaccines (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    status VARCHAR(20) DEFAULT 'active'
);

CREATE TABLE appointments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    pet_id INT NOT NULL,
    vet_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    tax DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'active',
    CONSTRAINT fk_pet_id FOREIGN KEY (pet_id) REFERENCES pets(id),
    CONSTRAINT fk_vet_id FOREIGN KEY (vet_id) REFERENCES vets(id)
);

CREATE TABLE consultations (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    appointment_id BIGINT NOT NULL,
    name VARCHAR(150) NOT NULL,
    status VARCHAR(20) DEFAULT 'active',
    CONSTRAINT fk_appointment_id FOREIGN KEY (appointment_id) REFERENCES appointments(id)
);

CREATE TABLE prescriptions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    consultation_id BIGINT NOT NULL,
    name VARCHAR(150) NOT NULL,
    status VARCHAR(20) DEFAULT 'active',
    CONSTRAINT fk_consultation_id FOREIGN KEY (consultation_id) REFERENCES consultations(id)
);

CREATE TABLE vaccine_applications (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    pet_id INT NOT NULL,
    vaccine_id INT NOT NULL,
    name VARCHAR(150),
    status VARCHAR(20) DEFAULT 'active',
    CONSTRAINT fk_va_pet_id FOREIGN KEY (pet_id) REFERENCES pets(id),
    CONSTRAINT fk_va_vaccine_id FOREIGN KEY (vaccine_id) REFERENCES vaccines(id)
);

CREATE TABLE payments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    appointment_id BIGINT NOT NULL,
    reference VARCHAR(100),
    method VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'active',
    CONSTRAINT fk_payment_appointment_id FOREIGN KEY (appointment_id) REFERENCES appointments(id)
);

