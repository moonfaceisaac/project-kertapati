# Kertapati
## Software Requirements Specification (SRS) & Technical Design Document (TDD)

**Version:** 0.3  
**Status:** Revised Draft  
**Scope:** MVP

---

# Part I. Software Requirements Specification (SRS)

## 1. Introduction

### 1.1 Purpose

Kertapati is a web-based career platform designed to help jobseekers organize their professional information and present their qualifications through a structured, ATS-friendly CV.

The MVP focuses on one central feature: a CV Builder powered by a unified Professional Profile.

Users can populate this profile manually or import information from an existing CV. Both methods contribute to the same profile, which users can review, manage, and use to generate a CV.

### 1.2 MVP Objectives

1. Allow users to create and manage a Professional Profile.
2. Support manual entry of professional information.
3. Support importing existing CVs in PDF and DOCX formats.
4. Extract and categorize information from uploaded CVs.
5. Allow users to control how extracted information affects their existing profile.
6. Generate an ATS-friendly CV from the saved profile.
7. Provide an on-screen preview and PDF download.

### 1.3 Scope

**Included in MVP:**
- User registration and authentication.
- Professional Profile creation and management.
- Manual profile entry and editing.
- PDF and DOCX CV uploads.
- Text extraction and section detection.
- Recognition of predictable information such as names, emails, phone numbers, URLs, and dates.
- Extraction review and user-controlled profile updates.
- One ATS-friendly CV template.
- On-screen CV preview.
- PDF generation and download.

**Excluded from MVP:**
- Multiple CV templates or a template marketplace.
- Job vacancy aggregation.
- CV-to-job matching.
- AI-powered CV rewriting and recommendations.
- OCR for scanned or image-based CVs.
- Custom-trained NER or text-classification models.
- Semantic embeddings and advanced skill matching.
- Multiple independently managed CV versions.
- Advanced CV design customization.

---

## 2. System Overview

### 2.1 Professional Profile

The Professional Profile is the central source of information used to generate a user's CV.

Users can populate it through two methods:

**Method A: Manual Entry**
- Users enter information through forms.
- Users can save and update individual profile sections.
- Users do not need to upload a CV to use the CV Builder.

**Method B: CV Import**
- Users upload an existing PDF or DOCX CV.
- The system extracts and categorizes information.
- The system presents the extracted information for review.
- Users decide which information should be added or used to replace existing information.
- Only user-confirmed changes are saved to the Professional Profile.

Both methods use the same profile management functionality and underlying data structure.

### 2.2 Professional Profile Structure

The MVP Professional Profile contains the following sections:

| Section | Fields |
|---|---|
| Header / Personal Information | Full name |
| Contact Information | Email, phone number |
| Profile Links | Platform, URL |
| Professional Summary | Optional summary |
| Experiences | Type, position, company/organization, start date, end date, description |
| Education | Institution, degree, field of study, start date, end date |
| Skills | Skill name |
| Projects | Project title, description, link |
| Achievements | Name, issuer, achievement date, link |
| Certifications | Name, issuer, certification date, expiration date (optional), link |

**Experience types:**
- Full-time
- Part-time
- Organization
- Volunteer
- Apprenticeship
- Freelance

For ongoing experiences or education, the end date can be marked as **Present**.

The Professional Summary is optional. It may be omitted from the generated CV when empty or when the user chooses not to include it.

---

## 3. Functional Requirements

### FR-01: User Authentication

The system shall:
- Allow users to register an account.
- Allow users to log in and log out.
- Associate each Professional Profile with its owner.
- Prevent unauthorized access to another user's information.

### FR-02: Professional Profile Management

The system shall:
- Allow users to create a Professional Profile.
- Allow users to view and edit their profile information.
- Allow users to add and remove profile entries.
- Support multiple entries for experiences, education, projects, skills, achievements, certifications, and profile links.
- Allow incomplete profiles to be saved.
- Preserve existing profile information unless the user explicitly changes or removes it.

### FR-03: Manual Profile Entry

The system shall:
- Provide forms for each Professional Profile section.
- Allow users to add information without uploading a CV.
- Validate required fields and input formats.
- Allow users to edit or delete individual entries.
- Save manually entered information to the same profile structure used by CV imports.

### FR-04: CV Upload

The system shall:
- Accept PDF and DOCX files.
- Validate the uploaded file type and size.
- Associate each uploaded document with its owner.
- Store the uploaded document securely.
- Track the processing status of each document.

### FR-05: CV Text Extraction

The system shall:
- Extract readable text from uploaded PDF and DOCX documents.
- Preserve the original extracted text for review and troubleshooting.
- Detect likely CV sections.
- Recognize predictable information such as names, email addresses, phone numbers, URLs, and dates.
- Categorize extracted information into the corresponding Professional Profile sections.
- Notify users when extraction fails or produces incomplete results.

OCR for scanned documents is excluded from the MVP.

### FR-06: Extraction Review and Profile Update

The system shall compare extracted information with the user's existing Professional Profile and present proposed changes before saving them.

The system must distinguish between single-value fields and repeatable entries.

**A. Single-value fields**

Examples:
- Full name.
- Email.
- Phone number.
- Professional Summary.

When a single-value field already contains information, the system shall:
1. Detect the existing value.
2. Display the existing and extracted values.
3. Ask the user whether the existing value should be replaced.
4. Apply the replacement only after user confirmation.

A single-value field cannot be incremented by adding another value as though it were a list.

If the field is empty, the system may propose adding the extracted value, subject to user confirmation.

**B. Repeatable entries**

Examples:
- Work experiences.
- Education.
- Projects.
- Skills.
- Achievements.
- Certifications.
- Profile links.

For these sections, the system shall:
1. Identify extracted entries.
2. Compare them with existing profile entries where possible.
3. Display which entries are new or potentially duplicated.
4. Ask the user whether each proposed entry should be added.
5. Add only the entries explicitly approved by the user.

**C. User control**

The system shall:
- Never automatically overwrite existing profile information.
- Never automatically add extracted information to the saved profile without confirmation.
- Allow users to accept or reject proposed changes.
- Allow users to review and correct extracted information before applying it.
- Support accepting only selected changes rather than requiring acceptance of the entire extraction.
- Preserve existing information when a user rejects a proposed change.

The system is responsible for detecting and extracting information. The user remains responsible for deciding what happens to their profile.

### FR-07: CV Generation

The system shall:
- Generate a CV using the user's saved Professional Profile.
- Use one predefined ATS-friendly template.
- Follow the specified section order and formatting rules.
- Omit empty sections from the generated CV.
- Allow users to preview the generated CV on screen.
- Allow users to download the generated CV as a PDF.

### FR-08: Profile and CV Data Retrieval

The system shall:
- Retrieve saved profile information for display and editing.
- Retrieve saved profile information for CV generation.
- Ensure the generated CV reflects the latest saved profile data.
- Avoid including unconfirmed extraction results in the generated CV.

---

## 4. Non-Functional Requirements

### 4.1 Usability
- The interface should be understandable to jobseekers with different levels of technical experience.
- Manual entry and CV import should be clearly distinguishable.
- Extraction results should be presented in a way that makes reviewing and correcting information straightforward.

### 4.2 Performance
- Profile information should load within a reasonable time.
- Document processing should provide a visible processing status.
- CV preview and PDF generation should complete within a reasonable time for typical profile sizes.

### 4.3 Security
- User authentication must be implemented securely.
- Passwords must be stored using secure password hashing.
- Users must only access their own profiles and uploaded documents.
- Uploaded files must be validated.
- Uploaded documents must not be stored in publicly accessible directories.
- Sensitive information must not be unnecessarily exposed in application logs.

### 4.4 Data Integrity
- Profile information must remain consistent across manual entry, CV import, and CV generation.
- Unconfirmed extraction results must not modify saved profile data.
- Profile relationships must maintain referential integrity.

### 4.5 Compatibility
- The application should support modern desktop and mobile browsers.
- Generated PDFs should preserve the intended layout and selectable text.

### 4.6 Maintainability
- The application should use modular components and clearly separated responsibilities.
- Document processing should be separated from profile management and CV generation.

### 4.7 Accessibility
- Forms should have clear labels and validation feedback.
- Interface elements should be usable with keyboard navigation.
- Text should maintain sufficient contrast and readability.

---

## 5. ATS-Friendly CV Requirements

The generated CV must follow a predefined, clean, single-column format. Kertapati MVP will provide one template, not a template marketplace.

### 5.1 CV Structure

The header is separate and is not counted as one of the five main sections.

**Header:**
- Full name.
- Target role or professional title, when provided.
- Email.
- Phone number.
- Professional links such as LinkedIn, GitHub, and portfolio.

**Main sections, in this order:**

1. Work Experience
2. Education
3. Projects
4. Skills
5. Achievements & Certifications

The Professional Summary is optional. If included, it should be no longer than three lines. It may be omitted when space is limited.

Achievements and certifications must appear together under one section.

### 5.2 Layout Rules

- Single-column layout.
- Clean spacing and alignment.
- Standard fonts such as Aptos, Arial, or Calibri.
- Text-based PDF output.
- No tables, including invisible layout tables.
- No text boxes.
- No icons or graphics.
- No skill bars or visual proficiency indicators.
- No multiple columns or sidebars.
- Important contact information must remain in the main document body, not in headers or footers.

### 5.3 Typography

| Element | Formatting |
|---|---|
| Name | 20–22 pt, bold |
| Target role | 11–12 pt, regular or semi-bold |
| Section headings | 11–12 pt, bold, uppercase |
| Company / University | 10.5–11 pt, bold |
| Job title / Degree | 10.5–11 pt, italic |
| Bullet points | 10–10.5 pt, regular |
| Skill categories | 10–10.5 pt, bold |
| Skill names | 10–10.5 pt, regular |
| Dates | 10.5–11 pt, bold |

Only job titles, degree titles, and optional technology-stack labels should be italicized.

Bold important numbers and keywords sparingly.

### 5.4 Initial Page Formatting Defaults

The following values are proposed as the initial template defaults:

| Property | Initial default |
|---|---|
| Page size | A4 |
| Margins | 0.6 inch on all sides |
| Body alignment | Left |
| Name alignment | Left |
| Section headings | Left |
| Line spacing | 1.0–1.1 |
| Paragraph spacing before | 0 pt |
| Paragraph spacing after | 3–4 pt |
| Section spacing | 8–12 pt |
| Experience dates | Right-aligned using tab stops, not tables |
| Target length | One page where practical |

These are template defaults, not user-editable layout settings in the MVP. The final visual reference should be checked before implementation.

### 5.5 Content and Writing Rules

The generated CV should prioritize clarity, relevance, and machine readability.

**Keyword matching**
- Preserve exact technical keywords from the user's profile.
- Do not automatically replace job-specific terms with unrelated synonyms.
- Future job-tailoring functionality may suggest keyword changes, but that is outside the MVP.

**Bullet writing**
- Prefer: Strong Verb + Action + Technology + Impact.
- Use compressed STAR or XYZ-style descriptions where relevant.
- Avoid vague phrases such as "Responsible for" or "Worked on".
- Do not invent metrics, achievements, or experience details.

**Quantification**
- Preserve measurable information supplied by the user.
- Do not fabricate numbers to make a CV look more impressive.

**Section content**
- Work Experience: Company, position, dates, and concise descriptions.
- Education: Institution, degree, field of study, and dates.
- Projects: Project title, description, and link.
- Skills: Plain-text skill names, optionally grouped by category.
- Achievements & Certifications: Name, issuer, date, and link where available.

### 5.6 Empty and Incomplete Sections

- Empty sections should be omitted.
- Missing optional fields should not produce empty labels or placeholders.
- Partial Professional Profiles should still be usable for CV generation.
- The system should not fabricate missing information.

---

## 6. Constraints and Assumptions

- One user has one central Professional Profile in the MVP.
- A user may upload multiple CV documents.
- One predefined CV template is available.
- PDF and DOCX are the supported upload formats.
- Scanned-document OCR is excluded.
- Extraction results require user review before becoming saved profile data.
- The MVP does not depend on custom-trained machine learning models.
- The application is initially developed using JavaScript, React, Node.js, HTML, CSS, and MySQL.

---

# Part II. Technical Design Document (TDD)

## 1. Architecture Overview

### 1.1 Architectural Style

The MVP will use a **Modular Monolith with Layered Architecture**.

The application will be organized into modules with distinct responsibilities while remaining within one deployable application.

This approach keeps initial development manageable while leaving room for future expansion.

### 1.2 Application Layers

**1. Presentation Layer**
- React interface.
- Forms and profile management pages.
- CV upload interface.
- Extraction review interface.
- CV preview interface.

**2. Application Layer**
- Handles application use cases.
- Coordinates authentication, profile management, imports, and CV generation.
- Validates requests and controls workflow execution.

**3. Processing Layer**
- Document text extraction.
- Section detection.
- Field recognition.
- Extraction result preparation.
- Comparison between extracted data and existing profile information.

**4. Profile Management Layer**
- Creates and updates Professional Profiles.
- Manages repeatable profile entries.
- Applies user-approved import changes.
- Enforces profile ownership and data integrity.

**5. Data Layer**
- MySQL database.
- Database access and persistence.
- Uploaded document storage.
- Retrieval of profile and extraction data.

---

## 2. Technology Stack

### 2.1 Initial Stack

| Component | Technology |
|---|---|
| Frontend | React.js |
| Programming language | JavaScript |
| Markup | HTML |
| Styling | CSS |
| Backend runtime | Node.js |
| Database | MySQL |

### 2.2 Planned Upgrade

| Component | Planned technology |
|---|---|
| Programming language | TypeScript |
| CSS framework | Tailwind CSS |
| Database | PostgreSQL, optional |
| ORM | To be determined |

The initial implementation should not adopt future technologies prematurely. Migration should happen incrementally and only when there is a concrete reason.

The backend framework, ORM, authentication library, and document-processing libraries remain implementation decisions.

---

## 3. Frontend Design

### 3.1 Main Pages

- Registration and Login.
- Dashboard.
- Professional Profile.
- Manual Profile Entry.
- CV Import.
- Extraction Review.
- CV Builder / Preview.

### 3.2 Main Frontend Modules

| Module | Responsibility |
|---|---|
| Authentication | Registration, login, logout |
| Professional Profile | Display and edit profile information |
| Profile Filling | Manual profile entry |
| CV Import | Upload and monitor document processing |
| Extraction Review | Review, correct, accept, or reject extracted data |
| CV Builder | Display generated CV and provide PDF download |

### 3.3 Frontend Principles

- Keep reusable UI components separate from feature-specific logic.
- Avoid placing API communication directly inside large UI components.
- Keep form state and API state manageable.
- Reuse consistent validation and feedback patterns.
- Keep CV preview styling separate from the rest of the application interface.

---

## 4. Backend Design

### 4.1 Main Backend Modules

**Authentication**
- User registration.
- Login and logout.
- Session or token management.
- Authentication and authorization checks.

**Professional Profile**
- Create and retrieve profiles.
- Update personal and contact information.
- Manage profile links.
- Manage repeatable profile entries.
- Validate ownership.

**CV Import**
- Receive uploaded files.
- Validate documents.
- Store uploaded documents.
- Initiate extraction.
- Retrieve extraction results.

**Document Processing**
- Extract text from PDF and DOCX.
- Detect section headings.
- Recognize predictable fields.
- Categorize extracted information.
- Prepare structured extraction results.

**Profile Import Review**
- Compare extraction results against saved profile information.
- Identify single-value fields and repeatable entries.
- Prepare proposed additions and replacements.
- Receive user decisions.
- Apply only approved changes.

**CV Builder**
- Retrieve the saved Professional Profile.
- Prepare CV data in the required section order.
- Render the predefined template.
- Generate a downloadable PDF.

---

## 5. CV Import and Processing Workflow

### 5.1 Processing Pipeline

1. User uploads a PDF or DOCX file.
2. Backend validates the file.
3. The document is stored securely.
4. Text extraction is performed.
5. The processing module detects CV sections.
6. The field-recognition module identifies relevant information.
7. Extracted information is mapped to Professional Profile fields.
8. The system retrieves the user's existing Professional Profile.
9. The system compares existing and extracted information.
10. The frontend displays proposed changes.
11. The user reviews, corrects, accepts, or rejects individual changes.
12. The backend applies approved changes.
13. The updated Professional Profile becomes available for CV generation.

### 5.2 Import Decision Logic

The system must treat fields according to their cardinality.

**Single-value fields**

Example: Existing email = `old@example.com`, extracted email = `new@example.com`.

The system presents both values and asks whether the existing email should be replaced.

The system must not save the new email until the user confirms.

**Repeatable entries**

Example: Existing experiences include Company A. The imported CV contains Company B.

The system presents Company B as a proposed entry and asks whether it should be added.

If an entry appears to duplicate existing information, the system should flag it for review rather than silently creating a duplicate.

**Important implementation rule:**

Extraction and profile modification must remain separate operations.

The processing module produces proposed data. The profile management module applies approved changes. The frontend provides the user's decision interface.

This separation prevents the extraction process from modifying verified profile information on its own.

### 5.3 Extraction Result Storage

The system should preserve:
- Original extracted text.
- Structured extraction results.
- Processing status.
- User-reviewed corrections.
- User decisions for proposed profile changes.

Unconfirmed extraction data must remain separate from saved Professional Profile data.

---

## 6. Database Design

### 6.1 Proposed Entities

| Entity | Purpose |
|---|---|
| users | User account information |
| cv_documents | Uploaded CV metadata and storage reference |
| cv_extractions | Raw text and structured extraction results |
| professional_profiles | One central profile per user |
| profile_links | Professional links |
| work_experiences | Employment, organization, volunteer, apprenticeship, and freelance entries |
| educations | Education history |
| profile_skills | Skills |
| projects | Project information |
| achievements | Achievement information |
| certifications | Certification information |

### 6.2 Relationships

- One user has one Professional Profile.
- One user can upload multiple CV documents.
- One CV document can have multiple extraction records if reprocessed.
- One Professional Profile can have multiple experiences.
- One Professional Profile can have multiple education entries.
- One Professional Profile can have multiple skills.
- One Professional Profile can have multiple projects.
- One Professional Profile can have multiple achievements.
- One Professional Profile can have multiple certifications.
- One Professional Profile can have multiple profile links.

### 6.3 Data Design Principles

- Use relational tables for verified Professional Profile information.
- Use JSON for flexible, unverified extraction results where appropriate.
- Store uploaded file bytes outside MySQL.
- Use foreign keys to preserve relationships.
- Use cascading deletion where appropriate.
- Ensure profile queries are scoped to the authenticated user.
- Clean up associated uploaded files when their database records are permanently deleted.

### 6.4 Import Review Data

The import workflow should preserve user decisions.

A proposed implementation may use a separate import-review record or structured review data associated with each extraction.

Each proposed change should contain:
- Target profile section.
- Target field or entry.
- Existing value, if any.
- Extracted value.
- Proposed action: add or replace.
- User decision: accepted or rejected.
- Final application status.

This makes the import workflow auditable and prevents unreviewed extraction results from becoming profile data.

---

## 7. Proposed API Design

The following endpoints are initial proposals. Exact request and response schemas will be defined during implementation.

### 7.1 Authentication

| Method | Endpoint | Purpose |
|---|---|---|
| POST | `/api/auth/register` | Register user |
| POST | `/api/auth/login` | Log in |
| POST | `/api/auth/logout` | Log out |

### 7.2 Professional Profile

| Method | Endpoint | Purpose |
|---|---|---|
| GET | `/api/profile` | Retrieve profile |
| POST | `/api/profile` | Create profile |
| PUT | `/api/profile` | Update profile |

Additional endpoints may be introduced for managing individual repeatable entries, depending on the chosen API structure.

### 7.3 CV Import

| Method | Endpoint | Purpose |
|---|---|---|
| POST | `/api/cv/upload` | Upload CV |
| GET | `/api/cv/:id` | Retrieve document information |
| POST | `/api/cv/:id/extract` | Initiate extraction |
| GET | `/api/cv/:id/extraction` | Retrieve extraction results |
| POST | `/api/cv/:id/import` | Submit approved profile changes |

The import endpoint must accept the user's explicit decisions rather than applying all extracted information automatically.

### 7.4 CV Generation

| Method | Endpoint | Purpose |
|---|---|---|
| GET | `/api/cv/preview` | Retrieve data for CV preview |
| GET | `/api/cv/export/pdf` | Generate and download PDF |

The preview may be rendered on the frontend using the saved profile data. The PDF generation implementation will depend on the selected rendering approach.

---

## 8. Security Considerations

- Hash passwords using a suitable password-hashing algorithm.
- Protect authenticated routes.
- Verify resource ownership on every relevant backend operation.
- Validate uploaded file extensions, MIME types, and actual file contents.
- Enforce upload size limits.
- Store documents outside publicly accessible directories.
- Generate safe storage filenames rather than trusting uploaded filenames.
- Prevent unauthorized access to extraction results.
- Validate and sanitize user-provided text.
- Avoid exposing sensitive information in logs.
- Protect against common web vulnerabilities, including SQL injection, cross-site scripting, and cross-site request forgery where applicable.

---

## 9. Engineering Principles

The implementation should follow the established Kertapati engineering guidelines.

### Layer 1: Software Design & Architecture

1. Separation of Concerns.
2. Modularity.
3. Loose Coupling.
4. Framework-Agnostic Design.
5. SOLID Principles.

### Layer 2: Frontend Development Practices

6. Accessibility.
7. DRY Principle.
8. Responsive Design.
9. CSS Architecture.
10. Cross-browser Compatibility.

### Layer 3: Web Application Quality

11. Performance Optimization.
12. SEO Fundamentals.

These principles should be applied pragmatically. The objective is maintainable software, not unnecessary abstraction.

---

## 10. Future Improvements

The following features are intentionally excluded from the MVP:

- Advanced NER and entity extraction.
- Machine-learning-based CV section classification.
- Semantic embeddings and similarity detection.
- Skill taxonomy and skill normalization.
- OCR for scanned CVs.
- AI-powered CV improvement suggestions.
- Job vacancy aggregation.
- CV-to-job matching.
- Job-specific keyword analysis.
- Multiple CV templates.
- Multiple CV versions.
- Advanced visual customization.

These features may be introduced after the core profile and CV generation workflows are stable.

---

# Part III. Remaining Implementation Decisions

The following decisions are still open and should be finalized before or during implementation:

| Item | Decision required |
|---|---|
| Maximum upload size | Define the PDF/DOCX file size limit |
| Authentication | Choose session-based or token-based authentication |
| Backend framework | Select the Node.js framework |
| ORM / database access | Select an ORM or query approach |
| Document extraction | Select PDF and DOCX processing libraries |
| Extraction location | Decide between browser-side and backend-side processing |
| PDF generation | Select the rendering and PDF generation approach |
| Exact field validation | Define required fields, formats, and constraints |
| Template reference | Finalize the visual reference and verify typography and spacing |
| Import review persistence | Finalize how individual user decisions are stored |

---

# Part IV. MVP Completion Criteria

The MVP can be considered functionally complete when:

1. A user can register, log in, and access their own account.
2. A user can create a Professional Profile without uploading a CV.
3. A user can manually add, edit, and delete profile information.
4. A user can upload a supported PDF or DOCX CV.
5. The system can extract and categorize readable CV information.
6. The system can compare extracted information with the existing profile.
7. The system can distinguish between single-value replacements and repeatable additions.
8. The user can review, correct, accept, or reject proposed changes.
9. No profile changes are applied without user confirmation.
10. A user can generate an ATS-friendly CV using the single predefined template.
11. A user can preview the CV on screen.
12. A user can download the CV as a PDF.
13. Empty sections are omitted, and unconfirmed extraction results are never included.

**End of Document**