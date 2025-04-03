CREATE TABLE IF NOT EXISTS public.company (
  ID SERIAL PRIMARY KEY,
  NAME VARCHAR(62) NOT NULL,
  EMAIL VARCHAR(50) NOT NULL,
  STATUS INT NOT NULL
);

CREATE TABLE IF NOT EXISTS public.rule (
  ID SERIAL PRIMARY KEY,
  ID_COMPANY INT NOT NULL,
  STRING VARCHAR(60) NOT NULL,
  FILTER TEXT NOT NULL,
  SCORE VARCHAR(10) NOT NULL,
  DESCRIPTION VARCHAR(64) NOT NULL,
  STATUS INT NOT NULL,
  CONSTRAINT FK_company_rule FOREIGN KEY (ID_COMPANY) REFERENCES public.company (ID) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS public.alert (
  ID SERIAL PRIMARY KEY,
  ID_COMPANY INT NOT NULL,
  DATETIME TIMESTAMP NOT NULL DEFAULT current_timestamp,
  STATUS INT NOT NULL,
  NOTIFICATION INT NOT NULL,
  HASH CHAR(32) NOT NULL,
  CONSTRAINT FK_company_alert FOREIGN KEY (ID_COMPANY) REFERENCES public.company (ID) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS public.history (
  ID SERIAL PRIMARY KEY,
  ID_COMPANY INT NOT NULL,
  SOURCE VARCHAR(255),
  DATETIME TIMESTAMP NOT NULL DEFAULT current_timestamp,
  STATUS INT NOT NULL,
  CONSTRAINT FK_company_history FOREIGN KEY (ID_COMPANY) REFERENCES public.company (ID) ON DELETE NO ACTION ON UPDATE NO ACTION
);
