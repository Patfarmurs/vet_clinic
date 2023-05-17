create table patients (
id SERIAL PRIMARY KEY,
name VARCHAR(100),
date_of_birth DATE
);



create table treatments (
id SERIAL PRIMARY KEY,
type VARCHAR(100),
name VARCHAR(100)
);

create table invoices (
id SERIAL PRIMARY KEY,
total_amount DECIMAL,
generated_at TIMESTAMP,
payed_at TIMESTAMP,
CONSTRAINT FK_medical_history FOREIGN KEY (medical_history_id) REFERENCES medical_histories (id)
);



CREATE TABLE treatments_histories (
  treatment_id INT,
  medical_history_id INT,
  PRIMARY KEY (treatment_id, medical_history_id),
  CONSTRAINT FK_treatment FOREIGN KEY (treatment_id) REFERENCES treatments (id) ON DELETE CASCADE,
  CONSTRAINT FK_medical_history FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id) ON DELETE CASCADE
);

