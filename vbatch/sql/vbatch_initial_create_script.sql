
CREATE SEQUENCE JOB_MASTER_ID_SEQ;

CREATE TABLE vbatch.job_master (
                id NUMBER NOT NULL,
                name VARCHAR2(50) NOT NULL,
                description VARCHAR2(100) NOT NULL,
                CONSTRAINT JOB_MASTER_PK PRIMARY KEY (id)
);


CREATE SEQUENCE VBATCH_LOG_ID_SEQ;

CREATE SEQUENCE LOG_JOB_MASTER_ID_SEQ;

CREATE TABLE vbatch.vbatch_log (
                id NUMBER NOT NULL,
                job_master_id NUMBER NOT NULL,
                batch_seq_nbr NUMBER NOT NULL,
                batch_num NUMBER NOT NULL,
                vbatch_log_status VARCHAR2(50) NOT NULL,
                vbatch_log_end_dt DATE,
                vbatch_log_start_dt DATE,
                CONSTRAINT VBATCH_LOG_PK PRIMARY KEY (id)
);


CREATE SEQUENCE OK_DTL_PK1_SEQ;

CREATE TABLE vbatch.vbatch_log_ok_dtl (
                id NUMBER NOT NULL,
                pk1 NUMBER NOT NULL,
                vbatch_log_id NUMBER NOT NULL,
                pk2 NUMBER NOT NULL,
                pk3 NUMBER NOT NULL,
                ok VARCHAR2(150) NOT NULL,
                CONSTRAINT VBATCH_LOG_OK_DTL_PK PRIMARY KEY (id)
);


CREATE TABLE vbatch.vbatch_log_file_output (
                id NUMBER NOT NULL,
                vbatch_log_id NUMBER NOT NULL,
                filename VARCHAR2(150) NOT NULL,
                num_records NUMBER NOT NULL,
                create_dt DATE NOT NULL,
                log_dtl_seq_nbr NUMBER,
                CONSTRAINT VBATCH_LOG_FILE_OUTPUT_PK PRIMARY KEY (id)
);


CREATE TABLE vbatch.vbatch_log_dtl (
                id NUMBER NOT NULL,
                status VARCHAR2(50) NOT NULL,
                log_dtl_end_dt DATE,
                batch_num NUMBER NOT NULL,
                vbatch_log_id NUMBER NOT NULL,
                log_dtl_start_dt DATE,
                error_msg VARCHAR2(150) NOT NULL,
                job_seq NUMBER,
                job_step_id NUMBER NOT NULL,
                step_name NUMBER NOT NULL,
                step_type VARCHAR2(150) NOT NULL,
                num_records NUMBER NOT NULL,
                extract_sql VARCHAR2(4000) NOT NULL,
                extract_max_recs_per_file NUMBER NOT NULL,
                extract_commit_freq NUMBER NOT NULL,
                description VARCHAR2(150) NOT NULL,
                output_file_format VARCHAR2(15) NOT NULL,
                output_filename_prefix VARCHAR2(150) NOT NULL,
                output_filename_suffix VARCHAR2(150) NOT NULL,
                java_bean_path VARCHAR2(150) NOT NULL,
                param1 VARCHAR2(150) NOT NULL,
                param2 VARCHAR2(150) NOT NULL,
                param3 VARCHAR2(150) NOT NULL,
                min_ok1 VARCHAR2(150) NOT NULL,
                max_ok2 VARCHAR2(150) NOT NULL,
                CONSTRAINT VBATCH_LOG_DTL_PK PRIMARY KEY (id)
);


CREATE SEQUENCE STEPS_ID_SEQ;

CREATE TABLE vbatch.steps (
                id NUMBER NOT NULL,
                type VARCHAR2(50) NOT NULL,
                extract_max_rec_per_file NUMBER NOT NULL,
                extract_commit_freq NUMBER NOT NULL,
                extract_sql VARCHAR2(4000),
                description VARCHAR2(100) NOT NULL,
                output_file_format VARCHAR2(10) NOT NULL,
                output_filename_prefix VARCHAR2(100) NOT NULL,
                output_filename_postfix VARCHAR2(100) NOT NULL,
                java_bean_path VARCHAR2(100) NOT NULL,
                param1 VARCHAR2(100) NOT NULL,
                param2 VARCHAR2(50) NOT NULL,
                param3 VARCHAR2(50) NOT NULL,
                CONSTRAINT ID PRIMARY KEY (id)
);
COMMENT ON COLUMN vbatch.steps.type IS 'Type of step (Extract, Transform, etc)';


CREATE SEQUENCE JOB_STEPS_XREF_ID_SEQ;

CREATE TABLE vbatch.job_steps_xref (
                id NUMBER NOT NULL,
                job_Id_id NUMBER NOT NULL,
                step_id NUMBER NOT NULL,
                job_step_seq NUMBER NOT NULL,
                description VARCHAR2(100) NOT NULL,
                CONSTRAINT JOB_STEPS_XREF_PK PRIMARY KEY (id)
);


CREATE UNIQUE INDEX vbatch.job_steps_xref_idx
 ON vbatch.job_steps_xref
 ( job_Id_id, step_id, job_step_seq );

ALTER TABLE vbatch.job_steps_xref ADD CONSTRAINT JOB_STEPS_XREF_JOB_MASTER_FK
FOREIGN KEY (job_Id_id)
REFERENCES vbatch.job_master (id)
NOT DEFERRABLE;

ALTER TABLE vbatch.vbatch_log ADD CONSTRAINT JOB_MASTER_VBATCH_LOG_FK
FOREIGN KEY (job_master_id)
REFERENCES vbatch.job_master (id)
NOT DEFERRABLE;

ALTER TABLE vbatch.vbatch_log_dtl ADD CONSTRAINT VBATCH_LOG_VBATCH_LOG_DTL_FK
FOREIGN KEY (vbatch_log_id)
REFERENCES vbatch.vbatch_log (id)
NOT DEFERRABLE;

ALTER TABLE vbatch.vbatch_log_file_output ADD CONSTRAINT VBATCH_LOG_VBATCH_LOG_FILE_936
FOREIGN KEY (vbatch_log_id)
REFERENCES vbatch.vbatch_log (id)
NOT DEFERRABLE;

ALTER TABLE vbatch.vbatch_log_ok_dtl ADD CONSTRAINT VBATCH_LOG_VBATCH_LOG_OK_DT859
FOREIGN KEY (vbatch_log_id)
REFERENCES vbatch.vbatch_log (id)
NOT DEFERRABLE;

ALTER TABLE vbatch.job_steps_xref ADD CONSTRAINT JOB_STEPS_XREF_STEPS_FK
FOREIGN KEY (step_id)
REFERENCES vbatch.steps (id)
NOT DEFERRABLE;
