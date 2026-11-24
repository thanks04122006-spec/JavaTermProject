CREATE TABLE Product (
    PDT_id              VARCHAR2(64 CHAR) NOT NULL PRIMARY KEY,
    PDT_name            VARCHAR2(100 CHAR) NOT NULL,
    PDT_unit_weight     NUMBER(18,6) NOT NULL CHECK (PDT_unit_weight > 0),
    PDT_unit_price      NUMBER(18,2) NOT NULL CHECK (PDT_unit_price >= 0),
    PDT_base_qty        INTEGER NOT NULL CHECK (PDT_base_qty > 0)
);

CREATE UNIQUE INDEX ux_product_singleton
    ON Product (CASE WHEN PDT_id IS NOT NULL THEN 1 END);

CREATE TABLE Material (
    MAT_id              VARCHAR2(64 CHAR) NOT NULL PRIMARY KEY,
    MAT_name            VARCHAR2(100 CHAR) NOT NULL,
    MAT_unit            VARCHAR2(20 CHAR) NOT NULL,
    MAT_base_qty        NUMBER(18,6) NOT NULL CHECK (MAT_base_qty > 0)
);

CREATE TABLE Receipt (
    RCV_id              VARCHAR2(64 CHAR) NOT NULL PRIMARY KEY,
    RCV_mat_id          VARCHAR2(64 CHAR) NOT NULL REFERENCES Material (MAT_id),
    RCV_date            DATE NOT NULL,
    RCV_qty             NUMBER(18,6) NOT NULL CHECK (RCV_qty > 0),
    RCV_unit_price      NUMBER(18,2) NOT NULL CHECK (RCV_unit_price >= 0),
    RCV_expiry          DATE NOT NULL
);

CREATE TABLE Production (
    PRD_id              VARCHAR2(64 CHAR) NOT NULL PRIMARY KEY,
    PRD_date            DATE NOT NULL,
    PRD_target_qty      INTEGER NOT NULL CHECK (PRD_target_qty > 0),
    PRD_actual_qty      INTEGER NOT NULL CHECK (PRD_actual_qty >= 0)
);

CREATE TABLE MaterialInput (
    INP_prod_id         VARCHAR2(64 CHAR) NOT NULL REFERENCES Production (PRD_id),
    INP_rcv_id          VARCHAR2(64 CHAR) NOT NULL REFERENCES Receipt (RCV_id),
    INP_qty             NUMBER(18,6) NOT NULL CHECK (INP_qty > 0),
    PRIMARY KEY (INP_prod_id, INP_rcv_id)
);

CREATE TABLE Process (
    PRC_id              VARCHAR2(64 CHAR) NOT NULL PRIMARY KEY,
    PRC_name            VARCHAR2(100 CHAR) NOT NULL,
    PRC_step            INTEGER NOT NULL UNIQUE CHECK (PRC_step BETWEEN 1 AND 7),
    PRC_description     VARCHAR2(1000 CHAR) NOT NULL
);

CREATE TABLE Equipment (
    EQP_id              VARCHAR2(64 CHAR) NOT NULL PRIMARY KEY,
    EQP_proc_id         VARCHAR2(64 CHAR) NOT NULL REFERENCES Process (PRC_id),
    EQP_name            VARCHAR2(100 CHAR) NOT NULL,
    EQP_type            VARCHAR2(100 CHAR) NOT NULL
);

CREATE TABLE Client (
    CLI_id              VARCHAR2(64 CHAR) NOT NULL PRIMARY KEY,
    CLI_name            VARCHAR2(100 CHAR) NOT NULL,
    CLI_phone           VARCHAR2(30 CHAR) NOT NULL,
    CLI_address         VARCHAR2(300 CHAR) NOT NULL
);

CREATE TABLE Packaging (
    PKG_prod_id         VARCHAR2(64 CHAR) NOT NULL REFERENCES Production (PRD_id),
    PKG_id              INTEGER NOT NULL CHECK (PKG_id >= 1),
    PKG_client_id       VARCHAR2(64 CHAR) NOT NULL REFERENCES Client (CLI_id),
    PKG_date            DATE NOT NULL,
    PKG_unit_qty        INTEGER NOT NULL CHECK (PKG_unit_qty > 0),
    PKG_qty             INTEGER NOT NULL CHECK (PKG_qty > 0),
    PRIMARY KEY (PKG_prod_id, PKG_id)
);

CREATE TABLE Shipment (
    SHP_prod_id         VARCHAR2(64 CHAR) NOT NULL,
    SHP_pack_id         INTEGER NOT NULL,
    SHP_client_id       VARCHAR2(64 CHAR) NOT NULL REFERENCES Client (CLI_id),
    SHP_pack_date       DATE NOT NULL,
    SHP_date            DATE NOT NULL,
    SHP_qty             INTEGER NOT NULL,
    PRIMARY KEY (SHP_prod_id, SHP_pack_id),
    FOREIGN KEY (SHP_prod_id, SHP_pack_id) REFERENCES Packaging (PKG_prod_id, PKG_id),
    CHECK (SHP_date >= SHP_pack_date)
);