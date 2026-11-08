CREATE TABLE users (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE professional_profiles (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL UNIQUE,

    full_name VARCHAR(255) NOT NULL,
    professional_email VARCHAR(255),
    phone_number VARCHAR(30),
    location VARCHAR(255),
    headline VARCHAR(255),
    summary TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_profile_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE cv_documents (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,

    original_filename VARCHAR(255) NOT NULL,
    storage_path VARCHAR(1024) NOT NULL,
    file_type ENUM('pdf', 'docx') NOT NULL,
    file_size_bytes BIGINT UNSIGNED NOT NULL,

    status ENUM(
        'uploaded',
        'processing',
        'processed',
        'failed'
    ) DEFAULT 'uploaded',

    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_cv_document_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



CREATE TABLE experiences (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    profile_id BIGINT UNSIGNED NOT NULL,

    type ENUM(
        'full_time',
        'part_time',
        'organization',
        'volunteer',
        'apprenticeship',
        'freelance'
    ) NOT NULL,

    position VARCHAR(255) NOT NULL,
    company_org VARCHAR(255) NOT NULL,
    start_date DATE,
    end_date DATE,
    description TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_experience_profile
        FOREIGN KEY (profile_id)
        REFERENCES professional_profiles(id)
        ON DELETE CASCADE,

    CHECK (end_date IS NULL OR start_date IS NULL OR end_date >= start_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE educations (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    profile_id BIGINT UNSIGNED NOT NULL,

    institution VARCHAR(255) NOT NULL,
    degree VARCHAR(255),
    field_of_study VARCHAR(255),
    start_date DATE,
    end_date DATE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_education_profile
        FOREIGN KEY (profile_id)
        REFERENCES professional_profiles(id)
        ON DELETE CASCADE,

    CHECK (end_date IS NULL OR start_date IS NULL OR end_date >= start_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE skills (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    profile_id BIGINT UNSIGNED NOT NULL,

    name VARCHAR(255) NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_skill_profile
        FOREIGN KEY (profile_id)
        REFERENCES professional_profiles(id)
        ON DELETE CASCADE,

    UNIQUE KEY uq_profile_skill (profile_id, name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE projects (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    profile_id BIGINT UNSIGNED NOT NULL,

    title VARCHAR(255) NOT NULL,
    description TEXT,
    link VARCHAR(2048),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_project_profile
        FOREIGN KEY (profile_id)
        REFERENCES professional_profiles(id)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE achievements (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    profile_id BIGINT UNSIGNED NOT NULL,

    title VARCHAR(255) NOT NULL,
    issued_date DATE,
    issuer VARCHAR(255),
    link VARCHAR(2048),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_achievement_profile
        FOREIGN KEY (profile_id)
        REFERENCES professional_profiles(id)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE certifications (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    profile_id BIGINT UNSIGNED NOT NULL,

    title VARCHAR(255) NOT NULL,
    issuer VARCHAR(255),
    issued_date DATE,
    expiration_date DATE,
    link VARCHAR(2048),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_certification_profile
        FOREIGN KEY (profile_id)
        REFERENCES professional_profiles(id)
        ON DELETE CASCADE,

    CHECK (
        expiration_date IS NULL
        OR issued_date IS NULL
        OR expiration_date >= issued_date
    )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE profile_links (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    profile_id BIGINT UNSIGNED NOT NULL,

    platform VARCHAR(100) NOT NULL,
    link VARCHAR(2048) NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_profile_link
        FOREIGN KEY (profile_id)
        REFERENCES professional_profiles(id)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
