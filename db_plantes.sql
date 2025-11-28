Voici un exemple complet d’une base de données MySQL pour gérer des plantes, inspirée des structures de bases de données botaniques.
Elle est prête à être importée dans MySQL pour vos tests ou projets.

1. Script SQL de création et insertion d’exemples
-- Création de la base
CREATE DATABASE IF NOT EXISTS plantes_db
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE plantes_db;

-- Table des familles botaniques
CREATE TABLE familles (
    id_famille INT AUTO_INCREMENT PRIMARY KEY,
    nom_famille VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- Table des genres
CREATE TABLE genres (
    id_genre INT AUTO_INCREMENT PRIMARY KEY,
    nom_genre VARCHAR(100) NOT NULL,
    id_famille INT NOT NULL,
    FOREIGN KEY (id_famille) REFERENCES familles(id_famille)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Table des plantes
CREATE TABLE plantes (
    id_plante INT AUTO_INCREMENT PRIMARY KEY,
    nom_scientifique VARCHAR(150) NOT NULL UNIQUE,
    nom_commun VARCHAR(150),
    id_genre INT NOT NULL,
    habitat VARCHAR(255),
    statut_conservation ENUM('LC','NT','VU','EN','CR','EW','EX') DEFAULT 'LC',
    date_ajout TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_genre) REFERENCES genres(id_genre)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Table des observations
CREATE TABLE observations (
    id_obs INT AUTO_INCREMENT PRIMARY KEY,
    id_plante INT NOT NULL,
    lieu VARCHAR(255) NOT NULL,
    date_obs DATE NOT NULL,
    observateur VARCHAR(100),
    notes TEXT,
    FOREIGN KEY (id_plante) REFERENCES plantes(id_plante)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Insertion de données exemples
INSERT INTO familles (nom_famille, description) VALUES
('Fabaceae', 'Famille des légumineuses'),
('Asteraceae', 'Famille des astéracées');

INSERT INTO genres (nom_genre, id_famille) VALUES
('Acacia', 1),
('Helianthus', 2);

INSERT INTO plantes (nom_scientifique, nom_commun, id_genre, habitat, statut_conservation) VALUES
('Acacia senegal', 'Gommier du Sénégal', 1, 'Zones arides', 'LC'),
('Helianthus annuus', 'Tournesol', 2, 'Champs et jardins', 'LC');

INSERT INTO observations (id_plante, lieu, date_obs, observateur, notes) VALUES
(1, 'Tahoua', '2024-05-12', 'Dr. Issa', 'Arbre en bonne santé'),
(2, 'Niamey', '2024-06-20', 'Mme. Amina', 'Floraison abondante');

2. Points clés
Structure relationnelle : familles → genres → plantes → observations.
Clés étrangères avec ON DELETE CASCADE pour maintenir l’intégrité.
Statut de conservation basé sur la classification UICN (LC, NT, VU, etc.).
Encodage UTF-8 pour supporter les noms scientifiques et communs.
3. Importation
Sauvegardez ce script dans un fichier plantes.sql.
Importez-le dans MySQL :
mysql -u root -p < plantes.sql

Vérifiez :
USE plantes_db;
SELECT * FROM plantes;


