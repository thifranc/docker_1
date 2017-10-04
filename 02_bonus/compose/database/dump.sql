--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;

--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';

CREATE DATABASE monsieurtshirt;

\c monsieurtshirt

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: image; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE image (
    id integer NOT NULL,
    url text
);


ALTER TABLE image OWNER TO postgres;

--
-- Name: image_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE image_id_seq OWNER TO postgres;

--
-- Name: image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE image_id_seq OWNED BY image.id;


--
-- Name: product; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE product (
    id integer NOT NULL,
    name text NOT NULL,
    description text
);


ALTER TABLE product OWNER TO postgres;

--
-- Name: product_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_id_seq OWNER TO postgres;

--
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE product_id_seq OWNED BY product.id;


--
-- Name: product_image; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE product_image (
    id_product integer NOT NULL,
    id_image integer NOT NULL
);


ALTER TABLE product_image OWNER TO postgres;

--
-- Name: image id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY image ALTER COLUMN id SET DEFAULT nextval('image_id_seq'::regclass);


--
-- Name: product id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY product ALTER COLUMN id SET DEFAULT nextval('product_id_seq'::regclass);


--
-- Data for Name: image; Type: TABLE DATA; Schema: public; Owner: root
--

COPY image (id, url) FROM stdin;
1	https://www.monsieurtshirt.com/10396-thickbox_default/sweat-le-gras.jpg
2	https://www.madametshirt.com/11941-thickbox_default/t-shirt-salut-les-moches.jpg
3	https://www.monsieurtshirt.com/10822-thickbox_default/t-shirt-on-en-a-gros.jpg
\.


--
-- Name: image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('image_id_seq', 3, true);


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: root
--

COPY product (id, name, description) FROM stdin;
1	Le gras cest la vie	En reference a Kammelott et notre cher karadoc de Vannes :)
2	Salut les moches	Pour tous les beaux gosses avec une grosse estime de leur personne
3	On en a gros	Entre du Kamelott mais en gros la c est vrai ON EN A GROS
\.


--
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('product_id_seq', 3, true);


--
-- Data for Name: product_image; Type: TABLE DATA; Schema: public; Owner: root
--

COPY product_image (id_product, id_image) FROM stdin;
1	1
2	2
3	3
\.


--
-- Name: image image_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY image
    ADD CONSTRAINT image_pkey PRIMARY KEY (id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: public; Type: ACL; Schema: -; Owner: root
--

REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;


--
-- PostgreSQL database dump complete
--

