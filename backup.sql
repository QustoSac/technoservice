--
-- PostgreSQL database dump
--

-- Dumped from database version 16.6 (Ubuntu 16.6-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.6 (Ubuntu 16.6-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: client; Type: TABLE; Schema: public; Owner: danila
--

CREATE TABLE public.client (
    id integer NOT NULL,
    firstname character varying(100) NOT NULL,
    secondname character varying(100) NOT NULL,
    contact_info text
);


ALTER TABLE public.client OWNER TO danila;

--
-- Name: client_id_seq; Type: SEQUENCE; Schema: public; Owner: danila
--

CREATE SEQUENCE public.client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.client_id_seq OWNER TO danila;

--
-- Name: client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: danila
--

ALTER SEQUENCE public.client_id_seq OWNED BY public.client.id;


--
-- Name: equipment; Type: TABLE; Schema: public; Owner: danila
--

CREATE TABLE public.equipment (
    id integer NOT NULL,
    serial_number character varying(50) NOT NULL,
    equipment_type character varying(50)
);


ALTER TABLE public.equipment OWNER TO danila;

--
-- Name: equipment_id_seq; Type: SEQUENCE; Schema: public; Owner: danila
--

CREATE SEQUENCE public.equipment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.equipment_id_seq OWNER TO danila;

--
-- Name: equipment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: danila
--

ALTER SEQUENCE public.equipment_id_seq OWNED BY public.equipment.id;


--
-- Name: faulttype; Type: TABLE; Schema: public; Owner: danila
--

CREATE TABLE public.faulttype (
    id integer NOT NULL,
    description text
);


ALTER TABLE public.faulttype OWNER TO danila;

--
-- Name: faulttype_id_seq; Type: SEQUENCE; Schema: public; Owner: danila
--

CREATE SEQUENCE public.faulttype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.faulttype_id_seq OWNER TO danila;

--
-- Name: faulttype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: danila
--

ALTER SEQUENCE public.faulttype_id_seq OWNED BY public.faulttype.id;


--
-- Name: request; Type: TABLE; Schema: public; Owner: danila
--

CREATE TABLE public.request (
    id integer NOT NULL,
    creation_date date DEFAULT CURRENT_DATE,
    problem_description text,
    fault_type_id integer,
    client_id integer,
    equipment_id integer,
    status_id integer
);


ALTER TABLE public.request OWNER TO danila;

--
-- Name: request_id_seq; Type: SEQUENCE; Schema: public; Owner: danila
--

CREATE SEQUENCE public.request_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.request_id_seq OWNER TO danila;

--
-- Name: request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: danila
--

ALTER SEQUENCE public.request_id_seq OWNED BY public.request.id;


--
-- Name: requesthistory; Type: TABLE; Schema: public; Owner: danila
--

CREATE TABLE public.requesthistory (
    id integer NOT NULL,
    request_id integer,
    change_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    technician_id integer,
    comment text,
    status_id integer
);


ALTER TABLE public.requesthistory OWNER TO danila;

--
-- Name: requesthistory_id_seq; Type: SEQUENCE; Schema: public; Owner: danila
--

CREATE SEQUENCE public.requesthistory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.requesthistory_id_seq OWNER TO danila;

--
-- Name: requesthistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: danila
--

ALTER SEQUENCE public.requesthistory_id_seq OWNED BY public.requesthistory.id;


--
-- Name: status; Type: TABLE; Schema: public; Owner: danila
--

CREATE TABLE public.status (
    id integer NOT NULL,
    name character varying(30) NOT NULL
);


ALTER TABLE public.status OWNER TO danila;

--
-- Name: status_id_seq; Type: SEQUENCE; Schema: public; Owner: danila
--

CREATE SEQUENCE public.status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.status_id_seq OWNER TO danila;

--
-- Name: status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: danila
--

ALTER SEQUENCE public.status_id_seq OWNED BY public.status.id;


--
-- Name: technician; Type: TABLE; Schema: public; Owner: danila
--

CREATE TABLE public.technician (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    contact_info text
);


ALTER TABLE public.technician OWNER TO danila;

--
-- Name: technician_id_seq; Type: SEQUENCE; Schema: public; Owner: danila
--

CREATE SEQUENCE public.technician_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.technician_id_seq OWNER TO danila;

--
-- Name: technician_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: danila
--

ALTER SEQUENCE public.technician_id_seq OWNED BY public.technician.id;


--
-- Name: client id; Type: DEFAULT; Schema: public; Owner: danila
--

ALTER TABLE ONLY public.client ALTER COLUMN id SET DEFAULT nextval('public.client_id_seq'::regclass);


--
-- Name: equipment id; Type: DEFAULT; Schema: public; Owner: danila
--

ALTER TABLE ONLY public.equipment ALTER COLUMN id SET DEFAULT nextval('public.equipment_id_seq'::regclass);


--
-- Name: faulttype id; Type: DEFAULT; Schema: public; Owner: danila
--

ALTER TABLE ONLY public.faulttype ALTER COLUMN id SET DEFAULT nextval('public.faulttype_id_seq'::regclass);


--
-- Name: request id; Type: DEFAULT; Schema: public; Owner: danila
--

ALTER TABLE ONLY public.request ALTER COLUMN id SET DEFAULT nextval('public.request_id_seq'::regclass);


--
-- Name: requesthistory id; Type: DEFAULT; Schema: public; Owner: danila
--

ALTER TABLE ONLY public.requesthistory ALTER COLUMN id SET DEFAULT nextval('public.requesthistory_id_seq'::regclass);


--
-- Name: status id; Type: DEFAULT; Schema: public; Owner: danila
--

ALTER TABLE ONLY public.status ALTER COLUMN id SET DEFAULT nextval('public.status_id_seq'::regclass);


--
-- Name: technician id; Type: DEFAULT; Schema: public; Owner: danila
--

ALTER TABLE ONLY public.technician ALTER COLUMN id SET DEFAULT nextval('public.technician_id_seq'::regclass);


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: danila
--

COPY public.client (id, firstname, secondname, contact_info) FROM stdin;
1	Иван	Иванов	ivan@example.com
2	Иван	Иванов	ivanov@example.com
3	Анна	Петрова	petrova@example.com
4	Сергей	Сидоров	sidorov@example.com
5	Мария	Смирнова	smirnova@example.com
6	Александр	Кузнецов	kuznetsov@example.com
7	Ольга	Соколова	sokolova@example.com
8	Дмитрий	Лебедев	lebedev@example.com
9	Елена	Козлова	kozlova@example.com
10	Алексей	Новиков	novikov@example.com
11	Наталья	Морозова	morozova@example.com
\.


--
-- Data for Name: equipment; Type: TABLE DATA; Schema: public; Owner: danila
--

COPY public.equipment (id, serial_number, equipment_type) FROM stdin;
1	SN12345	Принтер
2	SN001	Принтер
3	SN002	Компьютер
4	SN003	Сканер
5	SN004	Монитор
6	SN005	Ноутбук
7	SN006	Проектор
8	SN007	Сервер
9	SN008	Маршрутизатор
10	SN009	Камера
11	SN010	Планшет
\.


--
-- Data for Name: faulttype; Type: TABLE DATA; Schema: public; Owner: danila
--

COPY public.faulttype (id, description) FROM stdin;
1	Не включается
2	Не работает
3	Требуется обновление
4	Механическое повреждение
5	Программный сбой
6	Перегрев
7	Нет питания
8	Проблемы с сетью
9	Неисправен дисплей
10	Проблемы с драйверами
11	Другое
\.


--
-- Data for Name: request; Type: TABLE DATA; Schema: public; Owner: danila
--

COPY public.request (id, creation_date, problem_description, fault_type_id, client_id, equipment_id, status_id) FROM stdin;
1	2024-11-13	Принтер не включается	1	1	1	1
2	2024-12-11	не включается	\N	1	\N	\N
4	2024-12-11	Не работает	\N	1	\N	\N
5	2024-12-11	не включается	\N	1	\N	\N
7	2024-12-11	проблемы с включением	\N	1	\N	\N
8	2024-12-11	не включается	\N	1	1	2
6	2024-12-11	ы	\N	1	\N	4
3	2024-12-11	фыфы	\N	1	\N	4
9	2024-12-18	не включается	\N	1	1	1
10	2024-12-18	не включается	\N	1	1	3
11	2023-10-01	Принтер не печатает	1	1	1	1
12	2023-10-02	Компьютер не включается	2	2	2	1
13	2023-10-03	Сканер не сканирует	3	3	3	1
14	2023-10-04	Монитор не показывает изображение	4	4	4	1
15	2023-10-05	Ноутбук перегревается	5	5	5	1
16	2023-10-06	Проектор не проецирует	6	6	6	1
17	2023-10-07	Сервер не отвечает	7	7	7	1
18	2023-10-08	Маршрутизатор не раздает интернет	8	8	8	1
19	2023-10-09	Камера не записывает	9	9	9	1
20	2023-10-10	Планшет не заряжается	10	10	10	1
\.


--
-- Data for Name: requesthistory; Type: TABLE DATA; Schema: public; Owner: danila
--

COPY public.requesthistory (id, request_id, change_date, technician_id, comment, status_id) FROM stdin;
2	1	2024-11-13 14:56:53.079715	1	Начал диагностику.	1
3	1	2023-10-01 10:00:00	1	Начата диагностика	2
4	1	2023-10-01 12:00:00	1	Проблема найдена	3
5	2	2023-10-02 11:00:00	2	Начата диагностика	2
6	2	2023-10-02 13:00:00	2	Проблема найдена	3
7	3	2023-10-03 09:00:00	3	Начата диагностика	2
8	3	2023-10-03 11:00:00	3	Проблема найдена	3
9	4	2023-10-04 14:00:00	4	Начата диагностика	2
10	4	2023-10-04 16:00:00	4	Проблема найдена	3
11	5	2023-10-05 15:00:00	5	Начата диагностика	2
12	5	2023-10-05 17:00:00	5	Проблема найдена	3
13	6	2023-10-06 10:00:00	6	Начата диагностика	2
14	6	2023-10-06 12:00:00	6	Проблема найдена	3
15	7	2023-10-07 11:00:00	7	Начата диагностика	2
16	7	2023-10-07 13:00:00	7	Проблема найдена	3
17	8	2023-10-08 12:00:00	8	Начата диагностика	2
18	8	2023-10-08 14:00:00	8	Проблема найдена	3
19	9	2023-10-09 09:00:00	9	Начата диагностика	2
20	9	2023-10-09 11:00:00	9	Проблема найдена	3
21	10	2023-10-10 13:00:00	10	Начата диагностика	2
22	10	2023-10-10 15:00:00	10	Проблема найдена	3
\.


--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: danila
--

COPY public.status (id, name) FROM stdin;
1	Новая
2	В работе
3	Завершена
4	Отменена
\.


--
-- Data for Name: technician; Type: TABLE DATA; Schema: public; Owner: danila
--

COPY public.technician (id, name, contact_info) FROM stdin;
1	Сергей Сергеев	sergey@example.com
2	Техник1	tech1@example.com
3	Техник2	tech2@example.com
4	Техник3	tech3@example.com
5	Техник4	tech4@example.com
6	Техник5	tech5@example.com
7	Техник6	tech6@example.com
8	Техник7	tech7@example.com
9	Техник8	tech8@example.com
10	Техник9	tech9@example.com
11	Техник10	tech10@example.com
\.


--
-- Name: client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: danila
--

SELECT pg_catalog.setval('public.client_id_seq', 41, true);


--
-- Name: equipment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: danila
--

SELECT pg_catalog.setval('public.equipment_id_seq', 14, true);


--
-- Name: faulttype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: danila
--

SELECT pg_catalog.setval('public.faulttype_id_seq', 11, true);


--
-- Name: request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: danila
--

SELECT pg_catalog.setval('public.request_id_seq', 20, true);


--
-- Name: requesthistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: danila
--

SELECT pg_catalog.setval('public.requesthistory_id_seq', 22, true);


--
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: danila
--

SELECT pg_catalog.setval('public.status_id_seq', 4, true);


--
-- Name: technician_id_seq; Type: SEQUENCE SET; Schema: public; Owner: danila
--

SELECT pg_catalog.setval('public.technician_id_seq', 11, true);


--
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: danila
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id);


--
-- Name: equipment equipment_pkey; Type: CONSTRAINT; Schema: public; Owner: danila
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT equipment_pkey PRIMARY KEY (id);


--
-- Name: equipment equipment_serial_number_key; Type: CONSTRAINT; Schema: public; Owner: danila
--

ALTER TABLE ONLY public.equipment
    ADD CONSTRAINT equipment_serial_number_key UNIQUE (serial_number);


--
-- Name: faulttype faulttype_pkey; Type: CONSTRAINT; Schema: public; Owner: danila
--

ALTER TABLE ONLY public.faulttype
    ADD CONSTRAINT faulttype_pkey PRIMARY KEY (id);


--
-- Name: request request_pkey; Type: CONSTRAINT; Schema: public; Owner: danila
--

ALTER TABLE ONLY public.request
    ADD CONSTRAINT request_pkey PRIMARY KEY (id);


--
-- Name: requesthistory requesthistory_pkey; Type: CONSTRAINT; Schema: public; Owner: danila
--

ALTER TABLE ONLY public.requesthistory
    ADD CONSTRAINT requesthistory_pkey PRIMARY KEY (id);


--
-- Name: status status_pkey; Type: CONSTRAINT; Schema: public; Owner: danila
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);


--
-- Name: technician technician_pkey; Type: CONSTRAINT; Schema: public; Owner: danila
--

ALTER TABLE ONLY public.technician
    ADD CONSTRAINT technician_pkey PRIMARY KEY (id);


--
-- Name: request request_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: danila
--

ALTER TABLE ONLY public.request
    ADD CONSTRAINT request_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: request request_equipment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: danila
--

ALTER TABLE ONLY public.request
    ADD CONSTRAINT request_equipment_id_fkey FOREIGN KEY (equipment_id) REFERENCES public.equipment(id);


--
-- Name: request request_fault_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: danila
--

ALTER TABLE ONLY public.request
    ADD CONSTRAINT request_fault_type_id_fkey FOREIGN KEY (fault_type_id) REFERENCES public.faulttype(id);


--
-- Name: request request_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: danila
--

ALTER TABLE ONLY public.request
    ADD CONSTRAINT request_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.status(id);


--
-- Name: requesthistory requesthistory_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: danila
--

ALTER TABLE ONLY public.requesthistory
    ADD CONSTRAINT requesthistory_request_id_fkey FOREIGN KEY (request_id) REFERENCES public.request(id);


--
-- Name: requesthistory requesthistory_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: danila
--

ALTER TABLE ONLY public.requesthistory
    ADD CONSTRAINT requesthistory_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.status(id);


--
-- Name: requesthistory requesthistory_technician_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: danila
--

ALTER TABLE ONLY public.requesthistory
    ADD CONSTRAINT requesthistory_technician_id_fkey FOREIGN KEY (technician_id) REFERENCES public.technician(id);


--
-- PostgreSQL database dump complete
--

