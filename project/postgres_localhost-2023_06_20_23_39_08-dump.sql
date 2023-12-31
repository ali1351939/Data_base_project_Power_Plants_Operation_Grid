--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

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

--
-- Name: power_plants; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA power_plants;


ALTER SCHEMA power_plants OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: country; Type: TABLE; Schema: power_plants; Owner: postgres
--

CREATE TABLE power_plants.country (
    country_id integer NOT NULL,
    name text NOT NULL,
    pick_demand_gw numeric(10,2) NOT NULL,
    pick_supply_gw numeric(10,2) NOT NULL,
    CONSTRAINT country_pick_demand_gw_check CHECK ((pick_demand_gw > (0)::numeric)),
    CONSTRAINT country_pick_supply_gw_check CHECK ((pick_supply_gw > (0)::numeric))
);


ALTER TABLE power_plants.country OWNER TO postgres;

--
-- Name: country_country_id_seq; Type: SEQUENCE; Schema: power_plants; Owner: postgres
--

ALTER TABLE power_plants.country ALTER COLUMN country_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME power_plants.country_country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: country_powerplant; Type: TABLE; Schema: power_plants; Owner: postgres
--

CREATE TABLE power_plants.country_powerplant (
    country_pp_id integer NOT NULL,
    powerplant_id integer NOT NULL,
    country_id integer NOT NULL
);


ALTER TABLE power_plants.country_powerplant OWNER TO postgres;

--
-- Name: country_powerplant_country_pp_id_seq; Type: SEQUENCE; Schema: power_plants; Owner: postgres
--

ALTER TABLE power_plants.country_powerplant ALTER COLUMN country_pp_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME power_plants.country_powerplant_country_pp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: demand_hourly; Type: TABLE; Schema: power_plants; Owner: postgres
--

CREATE TABLE power_plants.demand_hourly (
    hourly_id integer NOT NULL,
    country_id integer NOT NULL,
    local_time integer NOT NULL,
    utc_time integer NOT NULL,
    demand_gw numeric(10,2) NOT NULL
);


ALTER TABLE power_plants.demand_hourly OWNER TO postgres;

--
-- Name: demand_hourly_hourly_id_seq; Type: SEQUENCE; Schema: power_plants; Owner: postgres
--

ALTER TABLE power_plants.demand_hourly ALTER COLUMN hourly_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME power_plants.demand_hourly_hourly_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: power_plant; Type: TABLE; Schema: power_plants; Owner: postgres
--

CREATE TABLE power_plants.power_plant (
    p_id integer NOT NULL,
    name text NOT NULL,
    country_id integer NOT NULL,
    capacity_mw numeric(6,2) NOT NULL,
    t_id integer NOT NULL
);


ALTER TABLE power_plants.power_plant OWNER TO postgres;

--
-- Name: power_plant_p_id_seq; Type: SEQUENCE; Schema: power_plants; Owner: postgres
--

ALTER TABLE power_plants.power_plant ALTER COLUMN p_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME power_plants.power_plant_p_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: power_plant_type; Type: TABLE; Schema: power_plants; Owner: postgres
--

CREATE TABLE power_plants.power_plant_type (
    t_id integer NOT NULL,
    name text NOT NULL,
    "installation_cost_$permw" numeric(12,2) NOT NULL,
    "tax_return_$pergw" numeric(12,2),
    co_tonpergw numeric(12,2),
    co2_tonpergw numeric(12,2),
    so2_tonpergw numeric(12,2),
    nox_tonpergw numeric(12,2),
    steam_tonpergw numeric(12,2)
);


ALTER TABLE power_plants.power_plant_type OWNER TO postgres;

--
-- Name: power_plant_type_t_id_seq; Type: SEQUENCE; Schema: power_plants; Owner: postgres
--

ALTER TABLE power_plants.power_plant_type ALTER COLUMN t_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME power_plants.power_plant_type_t_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: powerplant_conversion_cost; Type: TABLE; Schema: power_plants; Owner: postgres
--

CREATE TABLE power_plants.powerplant_conversion_cost (
    base_type text NOT NULL,
    next_type text NOT NULL,
    base_id integer NOT NULL,
    next_id integer NOT NULL,
    "conversion_cos_$pergw" numeric(12,2)
);


ALTER TABLE power_plants.powerplant_conversion_cost OWNER TO postgres;

--
-- Name: powerplant_type_tax; Type: TABLE; Schema: power_plants; Owner: postgres
--

CREATE TABLE power_plants.powerplant_type_tax (
    pptt_id integer NOT NULL,
    t_id integer NOT NULL,
    tax_pollution_id integer
);


ALTER TABLE power_plants.powerplant_type_tax OWNER TO postgres;

--
-- Name: powerplant_type_tax_pptt_id_seq; Type: SEQUENCE; Schema: power_plants; Owner: postgres
--

ALTER TABLE power_plants.powerplant_type_tax ALTER COLUMN pptt_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME power_plants.powerplant_type_tax_pptt_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tax_pollution; Type: TABLE; Schema: power_plants; Owner: postgres
--

CREATE TABLE power_plants.tax_pollution (
    tax_pollution_id integer NOT NULL,
    name text NOT NULL,
    "tax_$perton" numeric(10,2) DEFAULT 0 NOT NULL
);


ALTER TABLE power_plants.tax_pollution OWNER TO postgres;

--
-- Name: tax_pollution_tax_pollution_id_seq; Type: SEQUENCE; Schema: power_plants; Owner: postgres
--

ALTER TABLE power_plants.tax_pollution ALTER COLUMN tax_pollution_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME power_plants.tax_pollution_tax_pollution_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: country; Type: TABLE DATA; Schema: power_plants; Owner: postgres
--

COPY power_plants.country (country_id, name, pick_demand_gw, pick_supply_gw) FROM stdin;
1	Belgium	9.47	8.02
2	Bulgaria	3.82	3.52
3	Czechia	7.45	6.11
4	Denmark 	4.04	2.35
5	Germany 	58.96	41.75
6	Estonia 	0.91	0.65
7	Ireland 	3.96	2.26
8	Greece 	5.59	3.89
9	Spain 	27.02	25.43
10	France 	45.99	48.47
11	Croatia 	2.14	1.78
12	Italy 	29.43	23.94
13	Moldova	0.67	0.98
14	Latvia 	0.77	0.25
15	Lithuania 	1.38	0.47
16	Turkey	34.79	31.40
17	Hungary 	5.04	3.21
18	Luxembourg	0.50	0.14
19	Netherlands 	12.04	5.59
20	Austria 	5.76	7.23
21	Poland 	19.50	15.41
22	Portugal 	5.38	3.69
23	Romania 	6.45	5.88
24	Slovenia 	1.46	1.85
25	Slovakia 	3.03	3.15
26	Finland 	8.18	8.03
27	Sweden 	13.07	14.15
28	United Kingdom 	34.66	20.03
29	Kosovo	0.62	0.58
30	Norway 	13.18	14.77
31	Switzerland	7.37	4.12
32	Georgia	1.44	1.70
33	Bosnia-Herzegovina	1.28	1.58
34	Serbia	3.76	3.46
35	Montengro	0.24	0.34
\.


--
-- Data for Name: country_powerplant; Type: TABLE DATA; Schema: power_plants; Owner: postgres
--

COPY power_plants.country_powerplant (country_pp_id, powerplant_id, country_id) FROM stdin;
1	1	5
2	1	19
3	1	10
4	2	5
5	2	19
6	2	10
7	3	5
8	3	19
9	3	10
10	4	5
11	4	19
12	4	10
13	5	5
14	5	19
15	5	10
16	6	5
17	6	19
18	6	10
19	7	34
20	7	23
21	7	29
22	8	34
23	8	23
24	8	29
25	9	34
26	9	23
27	9	29
28	10	34
29	10	23
30	10	29
31	11	34
32	11	23
33	11	29
34	12	34
35	12	23
36	12	29
37	13	34
38	13	23
39	13	29
40	14	5
41	14	21
42	14	20
43	15	5
44	15	21
45	15	20
46	16	5
47	16	21
48	16	20
49	17	5
50	17	21
51	17	20
52	18	5
53	18	21
54	18	20
55	19	5
56	19	21
57	19	20
58	20	5
59	20	21
60	20	20
61	21	5
62	21	21
63	21	20
64	22	5
65	22	21
66	22	20
67	23	19
68	23	5
69	24	19
70	24	5
71	25	19
72	25	5
73	26	19
74	26	5
75	27	19
76	27	5
77	28	19
78	28	5
79	29	4
80	29	3
81	29	1
82	29	19
83	30	4
84	30	3
85	30	1
86	30	19
87	31	4
88	31	3
89	31	1
90	31	19
91	32	4
92	32	3
93	32	1
94	32	19
95	33	4
96	33	3
97	33	1
98	33	19
99	34	4
100	34	3
101	34	1
102	34	19
103	35	4
104	35	3
105	35	1
106	35	19
107	36	4
108	36	3
109	36	1
110	36	19
111	37	14
112	37	26
113	38	14
114	38	26
115	39	14
116	39	26
117	40	14
118	40	26
119	41	14
120	41	26
121	42	28
122	43	28
123	44	28
124	45	28
125	46	28
126	47	16
127	47	2
128	48	16
129	48	2
130	49	16
131	49	2
132	50	16
133	50	2
134	51	16
135	51	2
136	52	22
137	52	10
138	53	22
139	53	10
140	54	22
141	54	10
142	55	22
143	55	10
144	56	22
145	56	10
146	57	22
147	57	10
148	58	22
149	58	10
150	59	22
151	59	10
152	60	22
153	60	10
154	61	19
155	61	1
156	61	31
157	62	19
158	62	1
159	62	31
160	63	19
161	63	1
162	63	31
163	64	19
164	64	1
165	64	31
166	65	19
167	65	1
168	65	31
169	66	19
170	66	1
171	66	31
172	67	19
173	67	1
174	67	31
175	68	19
176	68	1
177	68	31
178	69	17
179	70	17
180	71	17
181	72	17
182	73	17
183	74	17
184	75	17
185	76	31
186	77	31
187	78	31
188	79	31
189	80	31
190	81	31
191	82	31
192	83	31
193	84	23
194	85	23
195	86	15
196	87	15
197	88	15
198	89	15
199	90	15
200	91	14
201	92	14
202	93	14
203	94	14
204	95	14
205	96	8
206	97	8
207	98	8
208	99	8
209	100	8
210	101	8
211	102	8
212	103	8
213	104	23
214	104	11
215	105	23
216	105	11
217	106	23
218	106	11
219	107	23
220	107	11
221	108	23
222	108	11
223	109	23
224	109	11
225	110	23
226	110	11
227	111	23
228	111	11
229	120	28
230	120	5
231	120	1
232	121	28
233	121	5
234	121	1
235	122	28
236	122	5
237	122	1
238	123	28
239	123	5
240	123	1
241	124	28
242	124	5
243	124	1
244	125	28
245	125	5
246	125	1
247	126	28
248	126	5
249	126	1
250	127	3
251	127	31
252	128	3
253	128	31
254	129	3
255	129	31
256	130	3
257	130	31
258	131	3
259	131	31
260	132	3
261	132	31
262	133	5
263	133	15
264	134	5
265	134	15
266	135	5
267	135	15
268	136	5
269	136	15
270	137	5
271	137	15
272	138	5
273	138	15
274	139	5
275	139	15
276	140	1
277	140	9
278	141	1
279	141	9
280	142	1
281	142	9
282	143	1
283	143	9
284	144	1
285	144	9
286	145	1
287	145	9
288	146	13
289	146	17
290	146	2
291	147	13
292	147	17
293	147	2
294	148	13
295	148	17
296	148	2
297	149	13
298	149	17
299	149	2
300	150	13
301	150	17
302	150	2
303	151	13
304	151	17
305	151	2
306	152	13
307	152	17
308	152	2
309	153	17
310	153	20
311	154	17
312	154	20
313	155	17
314	155	20
315	156	17
316	156	20
317	157	17
318	157	20
319	158	17
320	158	20
321	159	3
322	159	17
323	160	3
324	160	17
325	161	3
326	161	17
327	162	3
328	162	17
329	163	3
330	163	17
331	164	3
332	164	17
333	165	3
334	165	17
335	166	3
336	166	17
337	167	27
338	168	27
339	169	27
340	170	27
341	171	27
342	172	27
343	173	27
344	174	27
345	175	26
346	175	30
347	176	26
348	176	30
349	177	26
350	177	30
351	178	26
352	178	30
353	179	26
354	179	30
355	180	7
356	180	19
357	181	7
358	181	19
359	182	7
360	182	19
361	183	7
362	183	19
363	184	7
364	184	19
365	185	7
366	185	19
367	186	7
368	186	19
369	187	7
370	187	19
371	188	2
372	188	34
373	188	27
374	189	27
375	190	27
376	191	27
377	192	27
378	193	27
379	194	10
380	194	12
381	194	20
382	195	10
383	195	12
384	195	20
385	196	10
386	196	12
387	196	20
388	204	11
389	204	29
390	204	34
391	205	11
392	205	29
393	205	34
394	206	11
395	206	29
396	206	34
397	207	2
398	207	23
399	207	33
400	208	2
401	208	23
402	208	33
403	209	2
404	209	23
405	209	33
406	210	2
407	210	23
408	210	33
409	211	2
410	211	23
411	211	33
412	212	24
413	212	17
414	213	24
415	213	17
416	214	24
417	214	17
418	118	10
419	118	1
420	118	5
421	118	31
422	113	10
423	113	1
424	113	5
425	113	31
426	115	10
427	115	1
428	115	5
429	115	31
430	116	10
431	116	1
432	116	5
433	116	31
434	200	16
435	201	16
436	61	18
437	62	18
438	63	18
439	64	18
440	65	18
441	66	18
442	67	18
443	68	18
444	1	18
445	2	18
446	3	18
447	4	18
448	5	18
449	6	18
450	29	18
451	30	18
452	31	18
453	32	18
454	33	18
455	34	18
456	35	18
457	36	18
458	194	18
459	195	18
460	196	18
461	96	32
462	97	32
463	98	32
464	99	32
465	100	32
466	101	32
467	102	32
468	103	32
\.


--
-- Data for Name: demand_hourly; Type: TABLE DATA; Schema: power_plants; Owner: postgres
--

COPY power_plants.demand_hourly (hourly_id, country_id, local_time, utc_time, demand_gw) FROM stdin;
1	1	0	22	7.07
2	1	1	23	7.09
3	1	2	0	7.01
4	1	3	1	7.20
5	1	4	2	7.78
6	1	5	3	8.39
7	1	6	4	8.81
8	1	7	5	9.14
9	1	8	6	9.26
10	1	9	7	9.47
11	1	10	8	9.43
12	1	11	9	9.35
13	1	12	10	9.13
14	1	13	11	9.00
15	1	14	12	8.88
16	1	15	13	8.93
17	1	16	14	8.98
18	1	17	15	8.94
19	1	18	16	8.74
20	1	19	17	8.54
21	1	20	18	8.54
22	1	21	19	8.14
23	1	22	20	7.62
24	1	23	21	7.32
25	2	0	21	2.69
26	2	1	22	2.70
27	2	2	23	2.79
28	2	3	0	3.05
29	2	4	1	3.33
30	2	5	2	3.52
31	2	6	3	3.57
32	2	7	4	3.52
33	2	8	5	3.52
34	2	9	6	3.47
35	2	10	7	3.48
36	2	11	8	3.44
37	2	12	9	3.44
38	2	13	10	3.45
39	2	14	11	3.50
40	2	15	12	3.70
41	2	16	13	3.78
42	2	17	14	3.81
43	2	18	15	3.82
44	2	19	16	3.19
45	2	20	17	3.42
46	2	21	18	3.07
47	2	22	19	2.84
48	2	23	20	2.74
49	3	0	22	5.29
50	3	1	23	5.25
51	3	2	0	5.30
52	3	3	1	5.53
53	3	4	2	6.40
54	3	5	3	6.93
55	3	6	4	7.22
56	3	7	5	7.40
57	3	8	6	7.37
58	3	9	7	7.44
59	3	10	8	7.45
60	3	11	9	7.37
61	3	12	10	7.16
62	3	13	11	7.10
63	3	14	12	6.97
64	3	15	13	6.83
65	3	16	14	6.69
66	3	17	15	6.69
67	3	18	16	6.53
68	3	19	17	6.41
69	3	20	18	6.14
70	3	21	19	5.75
71	3	22	20	5.42
72	3	23	21	5.39
73	4	0	22	2.96
74	4	1	23	2.90
75	4	2	0	2.86
76	4	3	1	2.94
77	4	4	2	3.27
78	4	5	3	3.65
79	4	6	4	3.87
80	4	7	5	3.94
81	4	8	6	3.99
82	4	9	7	4.00
83	4	10	8	4.04
84	4	11	9	4.04
85	4	12	10	3.93
86	4	13	11	3.84
87	4	14	12	3.79
88	4	15	13	3.97
89	4	16	14	3.95
90	4	17	15	3.82
91	4	18	16	3.67
92	4	19	17	3.55
93	4	20	18	3.44
94	4	21	19	3.26
95	4	22	20	3.13
96	4	23	21	3.05
97	5	0	22	41.37
98	5	1	23	41.21
99	5	2	0	41.80
100	5	3	1	43.38
101	5	4	2	48.27
102	5	5	3	52.93
103	5	6	4	55.93
104	5	7	5	57.04
105	5	8	6	58.14
106	5	9	7	58.96
107	5	10	8	58.61
108	5	11	9	57.39
109	5	12	10	55.88
110	5	13	11	54.92
111	5	14	12	54.04
112	5	15	13	54.46
113	5	16	14	54.86
114	5	17	15	54.84
115	5	18	16	53.46
116	5	19	17	51.57
117	5	20	18	49.65
118	5	21	19	46.44
119	5	22	20	44.16
120	5	23	21	42.43
121	6	0	21	0.62
122	6	1	22	0.61
123	6	2	23	0.64
124	6	3	0	0.75
125	6	4	1	0.83
126	6	5	2	0.86
127	6	6	3	0.87
128	6	7	4	0.87
129	6	8	5	0.88
130	6	9	6	0.89
131	6	10	7	0.91
132	6	11	8	0.90
133	6	12	9	0.88
134	6	13	10	0.86
135	6	14	11	0.86
136	6	15	12	0.88
137	6	16	13	0.90
138	6	17	14	0.88
139	6	18	15	0.81
140	6	19	16	0.77
141	6	20	17	0.72
142	6	21	18	0.67
143	6	22	19	0.64
144	6	23	20	0.63
145	7	0	23	2.93
146	7	1	0	2.82
147	7	2	1	2.78
148	7	3	2	2.77
149	7	4	3	2.78
150	7	5	4	3.01
151	7	6	5	3.45
152	7	7	6	3.79
153	7	8	7	3.92
154	7	9	8	3.87
155	7	10	9	3.85
156	7	11	10	3.81
157	7	12	11	3.80
158	7	13	12	3.71
159	7	14	13	3.75
160	7	15	14	3.83
161	7	16	15	3.93
162	7	17	16	3.96
163	7	18	17	3.85
164	7	19	18	3.76
165	7	20	19	3.66
166	7	21	20	3.56
167	7	22	21	3.27
168	7	23	22	3.05
169	8	0	21	3.77
170	8	1	22	3.77
171	8	2	23	3.85
172	8	3	0	4.00
173	8	4	1	4.39
174	8	5	2	4.79
175	8	6	3	5.12
176	8	7	4	5.28
177	8	8	5	5.39
178	8	9	6	5.52
179	8	10	7	5.59
180	8	11	8	5.41
181	8	12	9	5.21
182	8	13	10	5.11
183	8	14	11	5.09
184	8	15	12	5.17
185	8	16	13	5.21
186	8	17	14	5.37
187	8	18	15	5.47
188	8	19	16	5.03
189	8	20	17	4.61
190	8	21	18	4.22
191	8	22	19	3.95
192	8	23	20	3.83
193	9	0	22	20.58
194	9	1	23	20.11
195	9	2	0	19.90
196	9	3	1	20.16
197	9	4	2	21.50
198	9	5	3	23.38
199	9	6	4	25.15
200	9	7	5	26.01
201	9	8	6	26.41
202	9	9	7	26.54
203	9	10	8	26.73
204	9	11	9	27.02
205	9	12	10	26.85
206	9	13	11	26.10
207	9	14	12	25.66
208	9	15	13	25.64
209	9	16	14	25.78
210	9	17	15	26.19
211	9	18	16	26.04
212	9	19	17	27.59
213	9	20	18	26.86
214	9	21	19	24.64
215	9	22	20	22.89
216	9	23	21	21.62
217	10	0	22	35.65
218	10	1	23	33.79
219	10	2	0	32.99
220	10	3	1	33.87
221	10	4	2	36.01
222	10	5	3	39.15
223	10	6	4	41.48
224	10	7	5	45.00
225	10	8	6	44.16
226	10	9	7	44.90
227	10	10	8	46.30
228	10	11	9	45.99
229	10	12	10	45.11
230	10	13	11	43.64
231	10	14	12	42.45
232	10	15	13	41.91
233	10	16	14	42.71
234	10	17	15	43.38
235	10	18	16	42.16
236	10	19	17	40.83
237	10	20	18	41.80
238	10	21	19	41.97
239	10	22	20	40.36
240	10	23	21	37.37
241	11	0	22	1.41
242	11	1	23	1.39
243	11	2	0	1.41
244	11	3	1	1.44
245	11	4	2	1.68
246	11	5	3	1.90
247	11	6	4	2.01
248	11	7	5	2.05
249	11	8	6	2.03
250	11	9	7	2.08
251	11	10	8	2.08
252	11	11	9	2.04
253	11	12	10	1.98
254	11	13	11	1.94
255	11	14	12	1.94
256	11	15	13	1.96
257	11	16	14	1.98
258	11	17	15	2.05
259	11	18	16	2.11
260	11	19	17	2.14
261	11	20	18	2.03
262	11	21	19	1.83
263	11	22	20	1.61
264	11	23	21	1.48
265	12	0	22	22.62
266	12	1	23	22.36
267	12	2	0	22.57
268	12	3	1	23.33
269	12	4	2	26.40
270	12	5	3	31.13
271	12	6	4	34.65
272	12	7	5	33.59
273	12	8	6	35.12
274	12	9	7	34.78
275	12	10	8	33.30
276	12	11	9	32.88
277	12	12	10	33.52
278	12	13	11	33.93
279	12	14	12	34.05
280	12	15	13	33.52
281	12	16	14	33.47
282	12	17	15	33.85
283	12	18	16	33.67
284	12	19	17	32.85
285	12	20	18	30.07
286	12	21	19	27.51
287	12	22	20	25.25
288	12	23	21	23.79
289	13	0	21	0.53
290	13	1	22	0.49
291	13	2	23	0.47
292	13	3	0	0.46
293	13	4	1	0.46
294	13	5	2	0.46
295	13	6	3	0.51
296	13	7	4	0.59
297	13	8	5	0.64
298	13	9	6	0.67
299	13	10	7	0.67
300	13	11	8	0.66
301	13	12	9	0.65
302	13	13	10	0.66
303	13	14	11	0.66
304	13	15	12	0.66
305	13	16	13	0.66
306	13	17	14	0.66
307	13	18	15	0.67
308	13	19	16	0.67
309	13	20	17	0.67
310	13	21	18	0.71
311	13	22	19	0.69
312	13	23	20	0.61
313	14	0	21	0.50
314	14	1	22	0.49
315	14	2	23	0.51
316	14	3	0	0.59
317	14	4	1	0.68
318	14	5	2	0.75
319	14	6	3	0.77
320	14	7	4	0.76
321	14	8	5	0.75
322	14	9	6	0.72
323	14	10	7	0.74
324	14	11	8	0.74
325	14	12	9	0.73
326	14	13	10	0.73
327	14	14	11	0.73
328	14	15	12	0.73
329	14	16	13	0.74
330	14	17	14	0.73
331	14	18	15	0.71
332	14	19	16	0.68
333	14	20	17	0.64
334	14	21	18	0.57
335	14	22	19	0.54
336	14	23	20	0.52
337	15	0	21	0.95
338	15	1	22	0.94
339	15	2	23	0.98
340	15	3	0	1.14
341	15	4	1	1.29
342	15	5	2	1.38
343	15	6	3	1.38
344	15	7	4	1.37
345	15	8	5	1.37
346	15	9	6	1.36
347	15	10	7	1.37
348	15	11	8	1.35
349	15	12	9	1.34
350	15	13	10	1.32
351	15	14	11	1.31
352	15	15	12	1.33
353	15	16	13	1.34
354	15	17	14	1.30
355	15	18	15	1.28
356	15	19	16	1.24
357	15	20	17	1.13
358	15	21	18	1.04
359	15	22	19	0.99
360	15	23	20	0.96
361	16	0	21	32.90
362	16	1	22	31.42
363	16	2	23	30.29
364	16	3	0	29.58
365	16	4	1	29.26
366	16	5	2	28.37
367	16	6	3	27.96
368	16	7	4	30.28
369	16	8	5	35.53
370	16	9	6	38.26
371	16	10	7	39.30
372	16	11	8	40.16
373	16	12	9	38.74
374	16	13	10	39.37
375	16	14	11	40.08
376	16	15	12	39.62
377	16	16	13	39.30
378	16	17	14	38.59
379	16	18	15	37.26
380	16	19	16	37.09
381	16	20	17	38.44
382	16	21	18	38.19
383	16	22	19	36.79
384	16	23	20	34.93
385	17	0	22	3.74
386	17	1	23	3.69
387	17	2	0	3.72
388	17	3	1	3.84
389	17	4	2	4.27
390	17	5	3	4.40
391	17	6	4	4.36
392	17	7	5	4.28
393	17	8	6	4.19
394	17	9	7	4.17
395	17	10	8	4.18
396	17	11	9	4.15
397	17	12	10	4.19
398	17	13	11	4.31
399	17	14	12	4.45
400	17	15	13	4.58
401	17	16	14	4.76
402	17	17	15	4.93
403	17	18	16	5.04
404	17	19	17	4.98
405	17	20	18	4.71
406	17	21	19	4.48
407	17	22	20	4.16
408	17	23	21	3.94
409	18	0	22	0.39
410	18	1	23	0.39
411	18	2	0	0.40
412	18	3	1	0.41
413	18	4	2	0.46
414	18	5	3	0.51
415	18	6	4	0.54
416	18	7	5	0.57
417	18	8	6	0.58
418	18	9	7	0.59
419	18	10	8	0.59
420	18	11	9	0.58
421	18	12	10	0.57
422	18	13	11	0.56
423	18	14	12	0.55
424	18	15	13	0.55
425	18	16	14	0.56
426	18	17	15	0.55
427	18	18	16	0.52
428	18	19	17	0.50
429	18	20	18	0.49
430	18	21	19	0.46
431	18	22	20	0.43
432	18	23	21	0.41
433	19	0	22	10.52
434	19	1	23	10.43
435	19	2	0	10.42
436	19	3	1	10.38
437	19	4	2	10.32
438	19	5	3	9.93
439	19	6	4	9.05
440	19	7	5	7.63
441	19	8	6	5.90
442	19	9	7	4.60
443	19	10	8	3.80
444	19	11	9	3.53
445	19	12	10	3.77
446	19	13	11	4.05
447	19	14	12	5.04
448	19	15	13	6.73
449	19	16	14	8.24
450	19	17	15	9.82
451	19	18	16	11.19
452	19	19	17	11.89
453	19	20	18	12.04
454	19	21	19	11.72
455	19	22	20	11.34
456	19	23	21	10.98
457	20	0	22	4.80
458	20	1	23	4.69
459	20	2	0	4.78
460	20	3	1	5.18
461	20	4	2	5.89
462	20	5	3	6.35
463	20	6	4	6.52
464	20	7	5	6.46
465	20	8	6	6.38
466	20	9	7	6.32
467	20	10	8	6.10
468	20	11	9	6.00
469	20	12	10	5.93
470	20	13	11	5.97
471	20	14	12	6.09
472	20	15	13	6.30
473	20	16	14	6.48
474	20	17	15	6.53
475	20	18	16	6.41
476	20	19	17	6.15
477	20	20	18	5.92
478	20	21	19	5.45
479	20	22	20	5.14
480	20	23	21	4.84
481	21	0	22	14.30
482	21	1	23	14.23
483	21	2	0	14.14
484	21	3	1	14.59
485	21	4	2	16.76
486	21	5	3	18.58
487	21	6	4	19.42
488	21	7	5	19.50
489	21	8	6	19.14
490	21	9	7	19.20
491	21	10	8	19.17
492	21	11	9	19.08
493	21	12	10	18.79
494	21	13	11	18.94
495	21	14	12	19.01
496	21	15	13	19.06
497	21	16	14	19.15
498	21	17	15	19.46
499	21	18	16	19.59
500	21	19	17	19.20
501	21	20	18	17.90
502	21	21	19	16.39
503	21	22	20	15.40
504	21	23	21	14.56
505	22	0	22	4.69
506	22	1	23	4.52
507	22	2	0	4.43
508	22	3	1	4.40
509	22	4	2	4.41
510	22	5	3	4.53
511	22	6	4	5.00
512	22	7	5	5.64
513	22	8	6	5.88
514	22	9	7	5.93
515	22	10	8	6.03
516	22	11	9	5.94
517	22	12	10	5.84
518	22	13	11	5.93
519	22	14	12	5.84
520	22	15	13	5.88
521	22	16	14	5.82
522	22	17	15	5.88
523	22	18	16	6.16
524	22	19	17	6.25
525	22	20	18	6.23
526	22	21	19	5.87
527	22	22	20	5.35
528	22	23	21	4.96
529	23	0	21	4.70
530	23	1	22	4.72
531	23	2	23	4.72
532	23	3	0	4.99
533	23	4	1	5.55
534	23	5	2	5.90
535	23	6	3	5.96
536	23	7	4	5.90
537	23	8	5	5.80
538	23	9	6	5.77
539	23	10	7	5.80
540	23	11	8	5.75
541	23	12	9	5.75
542	23	13	10	5.81
543	23	14	11	5.90
544	23	15	12	6.01
545	23	16	13	6.14
546	23	17	14	6.27
547	23	18	15	6.45
548	23	19	16	6.10
549	23	20	17	5.57
550	23	21	18	5.17
551	23	22	19	4.95
552	23	23	20	4.82
553	24	0	22	1.07
554	24	1	23	1.08
555	24	2	0	1.09
556	24	3	1	1.16
557	24	4	2	1.37
558	24	5	3	1.48
559	24	6	4	1.46
560	24	7	5	1.42
561	24	8	6	1.41
562	24	9	7	1.41
563	24	10	8	1.41
564	24	11	9	1.37
565	24	12	10	1.32
566	24	13	11	1.30
567	24	14	12	1.32
568	24	15	13	1.34
569	24	16	14	1.41
570	24	17	15	1.48
571	24	18	16	1.50
572	24	19	17	1.46
573	24	20	18	1.36
574	24	21	19	1.25
575	24	22	20	1.15
576	24	23	21	1.10
577	25	0	22	2.26
578	25	1	23	2.26
579	25	2	0	2.29
580	25	3	1	2.37
581	25	4	2	2.69
582	25	5	3	2.88
583	25	6	4	2.98
584	25	7	5	3.03
585	25	8	6	2.98
586	25	9	7	3.00
587	25	10	8	3.02
588	25	11	9	2.98
589	25	12	10	2.91
590	25	13	11	2.85
591	25	14	12	2.86
592	25	15	13	2.86
593	25	16	14	2.88
594	25	17	15	2.92
595	25	18	16	2.93
596	25	19	17	2.84
597	25	20	18	2.68
598	25	21	19	2.53
599	25	22	20	2.41
600	25	23	21	2.30
601	26	0	21	6.76
602	26	1	22	6.71
603	26	2	23	6.85
604	26	3	0	7.37
605	26	4	1	7.76
606	26	5	2	7.96
607	26	6	3	8.07
608	26	7	4	8.12
609	26	8	5	8.17
610	26	9	6	8.18
611	26	10	7	8.13
612	26	11	8	8.05
613	26	12	9	8.00
614	26	13	10	8.00
615	26	14	11	8.00
616	26	15	12	7.99
617	26	16	13	8.03
618	26	17	14	7.96
619	26	18	15	7.67
620	26	19	16	7.70
621	26	20	17	7.59
622	26	21	18	7.26
623	26	22	19	7.00
624	26	23	20	6.87
625	27	0	22	10.71
626	27	1	23	10.62
627	27	2	0	10.31
628	27	3	1	10.78
629	27	4	2	11.71
630	27	5	3	12.65
631	27	6	4	12.91
632	27	7	5	13.01
633	27	8	6	13.07
634	27	9	7	12.97
635	27	10	8	12.94
636	27	11	9	12.84
637	27	12	10	12.75
638	27	13	11	12.70
639	27	14	12	12.70
640	27	15	13	12.98
641	27	16	14	12.88
642	27	17	15	12.89
643	27	18	16	12.83
644	27	19	17	12.55
645	27	20	18	12.10
646	27	21	19	11.47
647	27	22	20	11.01
648	27	23	21	10.82
649	28	0	23	23.27
650	28	1	0	22.28
651	28	2	1	21.50
652	28	3	2	20.79
653	28	4	3	20.15
654	28	5	4	20.64
655	28	6	5	24.57
656	28	7	6	29.87
657	28	8	7	33.24
658	28	9	8	34.66
659	28	10	9	30.30
660	28	11	10	30.68
661	28	12	11	31.11
662	28	13	12	35.39
663	28	14	13	33.38
664	28	15	14	32.45
665	28	16	15	33.10
666	28	17	16	34.02
667	28	18	17	33.66
668	28	19	18	32.84
669	28	20	19	31.44
670	28	21	20	30.18
671	28	22	21	27.92
672	28	23	22	25.29
673	29	0	22	0.34
674	29	1	23	0.32
675	29	2	0	0.33
676	29	3	1	0.32
677	29	4	2	0.37
678	29	5	3	0.46
679	29	6	4	0.55
680	29	7	5	0.61
681	29	8	6	0.62
682	29	9	7	0.62
683	29	10	8	0.59
684	29	11	9	0.59
685	29	12	10	0.58
686	29	13	11	0.58
687	29	14	12	0.59
688	29	15	13	0.58
689	29	16	14	0.57
690	29	17	15	0.58
691	29	18	16	0.60
692	29	19	17	0.59
693	29	20	18	0.59
694	29	21	19	0.58
695	29	22	20	0.50
696	29	23	21	0.40
697	30	0	22	11.37
698	30	1	23	11.29
699	30	2	0	11.20
700	30	3	1	11.34
701	30	4	2	12.07
702	30	5	3	12.90
703	30	6	4	13.16
704	30	7	5	13.18
705	30	8	6	13.09
706	30	9	7	13.01
707	30	10	8	13.00
708	30	11	9	12.97
709	30	12	10	12.96
710	30	13	11	12.99
711	30	14	12	13.02
712	30	15	13	12.93
713	30	16	14	12.90
714	30	17	15	12.93
715	30	18	16	12.93
716	30	19	17	12.82
717	30	20	18	12.68
718	30	21	19	12.33
719	30	22	20	11.87
720	30	23	21	11.49
721	31	0	22	6.18
722	31	1	23	6.18
723	31	2	0	6.40
724	31	3	1	6.20
725	31	4	2	6.23
726	31	5	3	6.63
727	31	6	4	7.02
728	31	7	5	7.06
729	31	8	6	7.08
730	31	9	7	7.37
731	31	10	8	7.11
732	31	11	9	7.17
733	31	12	10	7.12
734	31	13	11	7.01
735	31	14	12	6.93
736	31	15	13	7.03
737	31	16	14	6.85
738	31	17	15	6.50
739	31	18	16	6.31
740	31	19	17	6.33
741	31	20	18	6.12
742	31	21	19	6.02
743	31	22	20	6.11
744	31	23	21	6.02
745	32	0	5	1.14
746	32	1	6	1.13
747	32	2	7	1.15
748	32	3	8	1.23
749	32	4	9	1.38
750	32	5	10	1.52
751	32	6	11	1.60
752	32	7	12	1.63
753	32	8	13	1.63
754	32	9	14	1.60
755	32	10	15	1.61
756	32	11	16	1.62
757	32	12	17	1.61
758	32	13	18	1.60
759	32	14	19	1.57
760	32	15	20	1.53
761	32	16	21	1.56
762	32	17	22	1.61
763	32	18	23	1.55
764	32	19	0	1.44
765	32	20	1	1.33
766	32	21	2	1.23
767	32	22	3	1.17
768	32	23	4	1.15
769	33	0	22	0.72
770	33	1	23	0.71
771	33	2	0	0.73
772	33	3	1	0.76
773	33	4	2	0.94
774	33	5	3	1.11
775	33	6	4	1.22
776	33	7	5	1.17
777	33	8	6	1.11
778	33	9	7	1.08
779	33	10	8	1.08
780	33	11	9	1.07
781	33	12	10	1.13
782	33	13	11	1.08
783	33	14	12	1.06
784	33	15	13	1.09
785	33	16	14	1.14
786	33	17	15	1.20
787	33	18	16	1.28
788	33	19	17	1.27
789	33	20	18	1.13
790	33	21	19	0.98
791	33	22	20	0.85
792	33	23	21	0.80
793	34	0	22	2.60
794	34	1	23	2.51
795	34	2	0	2.49
796	34	3	1	2.57
797	34	4	2	2.92
798	34	5	3	3.31
799	34	6	4	3.52
800	34	7	5	3.61
801	34	8	6	3.61
802	34	9	7	3.64
803	34	10	8	3.65
804	34	11	9	3.63
805	34	12	10	3.56
806	34	13	11	3.52
807	34	14	12	3.49
808	34	15	13	3.45
809	34	16	14	3.47
810	34	17	15	3.54
811	34	18	16	3.74
812	34	19	17	3.76
813	34	20	18	3.57
814	34	21	19	3.35
815	34	22	20	3.09
816	34	23	21	2.80
817	35	0	22	0.16
818	35	1	23	0.14
819	35	2	0	0.14
820	35	3	1	0.14
821	35	4	2	0.17
822	35	5	3	0.22
823	35	6	4	0.25
824	35	7	5	0.27
825	35	8	6	0.27
826	35	9	7	0.27
827	35	10	8	0.28
828	35	11	9	0.28
829	35	12	10	0.27
830	35	13	11	0.27
831	35	14	12	0.26
832	35	15	13	0.26
833	35	16	14	0.27
834	35	17	15	0.27
835	35	18	16	0.29
836	35	19	17	0.29
837	35	20	18	0.27
838	35	21	19	0.25
839	35	22	20	0.21
840	35	23	21	0.18
\.


--
-- Data for Name: power_plant; Type: TABLE DATA; Schema: power_plants; Owner: postgres
--

COPY power_plants.power_plant (p_id, name, country_id, capacity_mw, t_id) FROM stdin;
1	Belgium 1	1	2.95	1
2	Belgium 2	1	1.61	2
3	Belgium 3	1	0.47	3
4	Belgium 4	1	1.79	5
5	Belgium 5	1	1.18	6
6	Belgium 6	1	0.26	8
7	Bulgaria 1	2	1.43	1
8	Bulgaria 2	2	0.15	2
9	Bulgaria 3	2	0.85	4
10	Bulgaria 4	2	0.42	5
11	Bulgaria 5	2	0.11	6
12	Bulgaria 6	2	0.54	7
13	Bulgaria 7	2	0.02	8
14	Czechia 1	3	2.85	1
15	Czechia 2	3	0.27	2
16	Czechia 3	3	0.10	3
17	Czechia 4	3	1.57	4
18	Czechia 5	3	0.52	5
19	Czechia 6	3	0.06	6
20	Czechia 7	3	0.19	7
21	Czechia 8	3	0.29	8
22	Czechia 9	3	0.26	9
23	Denmark 1	4	0.12	2
24	Denmark 2	4	0.03	3
25	Denmark 3	4	0.13	4
26	Denmark 4	4	0.80	5
27	Denmark 5	4	1.27	6
28	Denmark 6	4	0.42	8
29	Germany 1	5	4.93	2
30	Germany 2	5	0.44	3
31	Germany 3	5	7.64	4
32	Germany 4	5	12.68	5
33	Germany 5	5	9.16	6
34	Germany 6	5	1.72	7
35	Germany 7	5	5.07	8
36	Germany 8	5	0.11	9
37	Estonia1	6	0.07	3
38	Estonia2	6	0.29	4
39	Estonia3	6	0.17	5
40	Estonia4	6	0.07	6
41	Estonia5	6	0.05	8
42	Ireland 1	7	1.26	2
43	Ireland 2	7	0.33	3
44	Ireland 3	7	0.19	4
45	Ireland 4	7	0.46	6
46	Ireland 5	7	0.02	7
47	Greece1	8	1.52	2
48	Greece2	8	0.25	4
49	Greece3	8	0.90	5
50	Greece4	8	0.81	6
51	Greece5	8	0.41	7
52	Spain1	9	5.09	1
53	Spain2	9	6.93	2
54	Spain3	9	0.06	3
55	Spain4	9	0.41	4
56	Spain5	9	5.12	5
57	Spain6	9	4.87	6
58	Spain7	9	2.25	7
59	Spain8	9	0.61	8
60	Spain9	9	0.09	9
61	France1 	10	31.52	1
62	France2	10	1.55	2
63	France3 	10	0.17	3
64	France4	10	0.02	4
65	France5	10	3.58	5
66	France6	10	4.43	6
67	France7 	10	6.75	7
68	France8 	10	0.45	8
69	Croatia 1	11	0.25	2
70	Croatia 2	11	0.09	4
71	Croatia 3	11	0.02	5
72	Croatia 4	11	0.26	6
73	Croatia 5	11	1.06	7
74	Croatia 6	11	0.07	8
75	Croatia 7	11	0.03	9
76	Italy1 	12	7.87	2
77	Italy2 	12	1.59	3
78	Italy3	12	1.52	4
79	Italy4	12	3.55	5
80	Italy5	12	1.47	6
81	Italy6	12	6.52	7
82	Italy7	12	0.81	8
83	Italy8	12	0.61	9
84	Moldova1	13	1.98	3
85	Moldova2	13	0.04	7
86	Latvia1 	14	0.01	2
87	Latvia2	14	0.02	3
88	Latvia3	14	0.01	6
89	Latvia4	14	0.19	7
90	Latvia5	14	0.02	8
91	Lithuania1 	15	0.07	2
92	Lithuania2 	15	0.16	5
93	Lithuania3	15	0.15	6
94	Lithuania4	15	0.01	7
95	Lithuania5	15	0.08	8
96	Turkey1	16	4.69	2
97	Turkey2	16	0.09	3
98	Turkey3	16	11.47	4
99	Turkey4	16	0.49	5
100	Turkey5	16	2.86	6
101	Turkey6	16	9.79	7
102	Turkey7	16	0.88	8
103	Turkey8	16	1.13	9
104	Hungary1	17	1.41	1
105	Hungary2	17	0.55	2
106	Hungary3	17	0.05	3
107	Hungary4	17	0.28	4
108	Hungary5	17	0.75	5
109	Hungary6	17	0.03	6
110	Hungary7	17	0.04	7
111	Hungary8	17	0.09	8
112	Hungary9	17	0.01	9
113	Luxembourg1 	18	0.01	2
114	Luxembourg2	18	0.00	4
115	Luxembourg3	18	0.06	5
116	Luxembourg4	18	0.04	6
117	Luxembourg5	18	0.00	7
118	Luxembourg6	18	0.03	8
119	Luxembourg7	18	0.00	9
120	Netherlands1	19	0.48	1
121	Netherlands2	19	3.18	2
122	Netherlands3	19	0.26	3
123	Netherlands4	19	0.27	4
124	Netherlands5	19	0.08	5
125	Netherlands6	19	1.28	6
126	Netherlands7	19	0.04	8
127	Austria1 	20	0.12	2
128	Austria2	20	0.02	3
129	Austria3	20	0.45	5
130	Austria4	20	0.49	6
131	Austria5	20	5.96	7
132	Austria6	20	0.19	8
133	Poland1 	21	0.99	2
134	Poland2 	21	0.20	3
135	Poland3 	21	9.66	4
136	Poland4 	21	2.71	5
137	Poland5 	21	1.28	6
138	Poland6 	21	0.39	7
139	Poland7 	21	0.18	8
140	Portugal1 	22	1.30	2
141	Portugal2	22	0.03	3
142	Portugal3	22	0.45	5
143	Portugal4	22	1.10	6
144	Portugal5	22	0.48	7
145	Portugal6	22	0.33	8
146	Romania1	23	0.69	1
147	Romania2	23	0.41	2
148	Romania3	23	0.88	4
149	Romania4	23	0.23	5
150	Romania5	23	0.56	6
151	Romania6	23	3.07	7
152	Romania7	23	0.04	8
153	Slovenia1	24	0.69	1
154	Slovenia2	24	0.03	2
155	Slovenia3	24	0.32	4
156	Slovenia4	24	0.05	5
157	Slovenia5	24	0.74	7
158	Slovenia6	24	0.02	8
159	Slovakia1 	25	1.96	1
160	Slovakia2	25	0.23	2
161	Slovakia3	25	0.12	3
162	Slovakia4	25	0.06	4
163	Slovakia5	25	0.09	5
164	Slovakia6	25	0.55	7
165	Slovakia7	25	0.09	8
166	Slovakia8	25	0.05	9
167	Finland1 	26	3.92	1
168	Finland2	26	0.17	2
169	Finland3	26	0.04	3
170	Finland4	26	0.11	4
171	Finland5	26	0.20	5
172	Finland6	26	1.58	6
173	Finland7	26	1.65	7
174	Finland8	26	0.36	8
175	Sweden1 	27	4.06	1
176	Sweden2	27	0.50	3
177	Sweden3	27	0.39	5
178	Sweden4	27	3.54	6
179	Sweden5	27	5.66	7
180	United Kingdom1	28	4.84	1
181	United Kingdom2	28	9.04	2
182	United Kingdom3	28	0.22	3
183	United Kingdom4	28	0.03	4
184	United Kingdom5	28	2.79	5
185	United Kingdom6	28	2.23	6
186	United Kingdom7	28	0.27	7
187	United Kingdom8	28	0.61	8
188	Kosovo1	29	0.58	4
189	Norway1 	30	0.04	2
190	Norway2	30	1.45	6
191	Norway3	30	13.22	7
192	Norway4	30	0.04	8
193	Norway5	30	0.02	9
194	Switzerland1	31	1.42	1
195	Switzerland2	31	0.64	5
196	Switzerland3	31	2.06	7
197	Georgia1 	32	0.25	2
198	Georgia2	32	0.00	4
199	Georgia3	32	0.00	5
200	Georgia4	32	0.01	6
201	Georgia5	32	1.69	7
202	Georgia6	32	0.00	8
203	Georgia7	32	0.00	9
204	Bosnia-Herzegovina1	33	0.76	4
205	Bosnia-Herzegovina2	33	0.01	6
206	Bosnia-Herzegovina3	33	0.81	7
207	Serbia1	34	0.03	3
208	Serbia2	34	1.58	4
209	Serbia3	34	0.06	6
210	Serbia4	34	1.76	7
211	Serbia5	34	0.03	8
212	Montengro1	35	0.08	4
213	Montengro2	35	0.02	6
214	Montengro3	35	0.24	7
\.


--
-- Data for Name: power_plant_type; Type: TABLE DATA; Schema: power_plants; Owner: postgres
--

COPY power_plants.power_plant_type (t_id, name, "installation_cost_$permw", "tax_return_$pergw", co_tonpergw, co2_tonpergw, so2_tonpergw, nox_tonpergw, steam_tonpergw) FROM stdin;
1	nuclear	536600000.00	0.00	0.00	0.00	0.00	0.00	30000.00
2	natural_gas	455000000.00	0.00	246840.00	3878928.00	46750.00	100.00	1586834.00
3	oil	400000000.00	0.00	283866.00	4460767.00	53760.00	110.00	1824860.00
4	coal	450000000.00	0.00	320892.00	5042606.00	60775.00	130.00	2062884.00
5	solar	90000000.00	110000000.00	0.00	0.00	0.00	0.00	0.00
6	wind	130000000.00	170000000.00	0.00	0.00	0.00	0.00	0.00
7	hydro	213500000.00	0.00	0.00	0.00	0.00	0.00	0.00
8	boimass	410000000.00	50000000.00	25000.00	30000.00	0.00	0.00	0.00
9	other_renewables	208375000.00	60000000.00	10000.00	5000.00	0.00	0.00	10000.00
\.


--
-- Data for Name: powerplant_conversion_cost; Type: TABLE DATA; Schema: power_plants; Owner: postgres
--

COPY power_plants.powerplant_conversion_cost (base_type, next_type, base_id, next_id, "conversion_cos_$pergw") FROM stdin;
nuclear	natural_gas	1	2	1738400000.00
nuclear	oil	1	3	1463400000.00
nuclear	coal	1	4	1713400000.00
nuclear	solar	1	5	363400000.00
nuclear	wind	1	6	113400000.00
nuclear	hydro	1	7	1598400000.00
nuclear	boimass	1	8	3453400000.00
nuclear	other_renewables	1	9	1547150000.00
natural_gas	nuclear	2	1	4911000000.00
natural_gas	oil	2	3	1545000000.00
natural_gas	coal	2	4	1795000000.00
natural_gas	solar	2	5	445000000.00
natural_gas	wind	2	6	845000000.00
natural_gas	hydro	2	7	3545000000.00
natural_gas	boimass	2	8	3445000000.00
natural_gas	other_renewables	2	9	1628750000.00
oil	nuclear	3	1	4966000000.00
oil	natural_gas	3	2	1875000000.00
oil	coal	3	4	1850000000.00
oil	solar	3	5	500000000.00
oil	wind	3	6	900000000.00
oil	hydro	3	7	1735000000.00
oil	boimass	3	8	3600000000.00
oil	other_renewables	3	9	1683750000.00
coal	nuclear	4	1	4916000000.00
coal	natural_gas	4	2	1825000000.00
coal	oil	4	3	1550000000.00
coal	solar	4	5	450000000.00
coal	wind	4	6	850000000.00
coal	hydro	4	7	1685000000.00
coal	boimass	4	8	3550000000.00
coal	other_renewables	4	9	1633750000.00
\.


--
-- Data for Name: powerplant_type_tax; Type: TABLE DATA; Schema: power_plants; Owner: postgres
--

COPY power_plants.powerplant_type_tax (pptt_id, t_id, tax_pollution_id) FROM stdin;
1	1	5
2	1	\N
3	1	\N
4	1	\N
5	1	\N
6	2	1
7	2	2
8	2	3
9	2	4
10	2	5
11	3	1
12	3	2
13	3	3
14	3	4
15	3	5
16	4	1
17	4	2
18	4	3
19	4	4
20	4	5
21	5	\N
22	5	\N
23	5	\N
24	5	\N
25	5	\N
26	6	\N
27	6	\N
28	6	\N
29	6	\N
30	6	\N
31	7	\N
32	7	\N
33	7	\N
34	7	\N
35	7	\N
36	8	1
37	8	2
38	8	\N
39	8	\N
40	8	\N
41	9	1
42	9	2
43	9	3
44	9	\N
45	9	\N
\.


--
-- Data for Name: tax_pollution; Type: TABLE DATA; Schema: power_plants; Owner: postgres
--

COPY power_plants.tax_pollution (tax_pollution_id, name, "tax_$perton") FROM stdin;
1	tax_co	60.00
2	tax_co2	40.00
3	tax_so2	70.00
4	tax_nox	100.00
5	tax_steam	10.00
\.


--
-- Name: country_country_id_seq; Type: SEQUENCE SET; Schema: power_plants; Owner: postgres
--

SELECT pg_catalog.setval('power_plants.country_country_id_seq', 1, false);


--
-- Name: country_powerplant_country_pp_id_seq; Type: SEQUENCE SET; Schema: power_plants; Owner: postgres
--

SELECT pg_catalog.setval('power_plants.country_powerplant_country_pp_id_seq', 1, false);


--
-- Name: demand_hourly_hourly_id_seq; Type: SEQUENCE SET; Schema: power_plants; Owner: postgres
--

SELECT pg_catalog.setval('power_plants.demand_hourly_hourly_id_seq', 1, false);


--
-- Name: power_plant_p_id_seq; Type: SEQUENCE SET; Schema: power_plants; Owner: postgres
--

SELECT pg_catalog.setval('power_plants.power_plant_p_id_seq', 1, false);


--
-- Name: power_plant_type_t_id_seq; Type: SEQUENCE SET; Schema: power_plants; Owner: postgres
--

SELECT pg_catalog.setval('power_plants.power_plant_type_t_id_seq', 1, false);


--
-- Name: powerplant_type_tax_pptt_id_seq; Type: SEQUENCE SET; Schema: power_plants; Owner: postgres
--

SELECT pg_catalog.setval('power_plants.powerplant_type_tax_pptt_id_seq', 1, false);


--
-- Name: tax_pollution_tax_pollution_id_seq; Type: SEQUENCE SET; Schema: power_plants; Owner: postgres
--

SELECT pg_catalog.setval('power_plants.tax_pollution_tax_pollution_id_seq', 5, true);


--
-- Name: country country_pkey; Type: CONSTRAINT; Schema: power_plants; Owner: postgres
--

ALTER TABLE ONLY power_plants.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (country_id);


--
-- Name: country_powerplant country_powerplant_pkey; Type: CONSTRAINT; Schema: power_plants; Owner: postgres
--

ALTER TABLE ONLY power_plants.country_powerplant
    ADD CONSTRAINT country_powerplant_pkey PRIMARY KEY (country_pp_id);


--
-- Name: demand_hourly demand_hourly_pkey; Type: CONSTRAINT; Schema: power_plants; Owner: postgres
--

ALTER TABLE ONLY power_plants.demand_hourly
    ADD CONSTRAINT demand_hourly_pkey PRIMARY KEY (hourly_id);


--
-- Name: power_plant power_plant_pkey; Type: CONSTRAINT; Schema: power_plants; Owner: postgres
--

ALTER TABLE ONLY power_plants.power_plant
    ADD CONSTRAINT power_plant_pkey PRIMARY KEY (p_id);


--
-- Name: power_plant_type power_plant_type_pkey; Type: CONSTRAINT; Schema: power_plants; Owner: postgres
--

ALTER TABLE ONLY power_plants.power_plant_type
    ADD CONSTRAINT power_plant_type_pkey PRIMARY KEY (t_id);


--
-- Name: powerplant_conversion_cost powerplant_conversion_cost_pkey; Type: CONSTRAINT; Schema: power_plants; Owner: postgres
--

ALTER TABLE ONLY power_plants.powerplant_conversion_cost
    ADD CONSTRAINT powerplant_conversion_cost_pkey PRIMARY KEY (base_id, next_id);


--
-- Name: powerplant_type_tax powerplant_type_tax_pkey; Type: CONSTRAINT; Schema: power_plants; Owner: postgres
--

ALTER TABLE ONLY power_plants.powerplant_type_tax
    ADD CONSTRAINT powerplant_type_tax_pkey PRIMARY KEY (pptt_id);


--
-- Name: tax_pollution tax_pollution_pkey; Type: CONSTRAINT; Schema: power_plants; Owner: postgres
--

ALTER TABLE ONLY power_plants.tax_pollution
    ADD CONSTRAINT tax_pollution_pkey PRIMARY KEY (tax_pollution_id);


--
-- Name: power_plant power_plant_country_id_fkey; Type: FK CONSTRAINT; Schema: power_plants; Owner: postgres
--

ALTER TABLE ONLY power_plants.power_plant
    ADD CONSTRAINT power_plant_country_id_fkey FOREIGN KEY (country_id) REFERENCES power_plants.country(country_id);


--
-- Name: power_plant power_plant_t_id_fkey; Type: FK CONSTRAINT; Schema: power_plants; Owner: postgres
--

ALTER TABLE ONLY power_plants.power_plant
    ADD CONSTRAINT power_plant_t_id_fkey FOREIGN KEY (t_id) REFERENCES power_plants.power_plant_type(t_id);


--
-- Name: powerplant_type_tax powerplant_type_tax_t_id_fkey; Type: FK CONSTRAINT; Schema: power_plants; Owner: postgres
--

ALTER TABLE ONLY power_plants.powerplant_type_tax
    ADD CONSTRAINT powerplant_type_tax_t_id_fkey FOREIGN KEY (t_id) REFERENCES power_plants.power_plant_type(t_id);


--
-- PostgreSQL database dump complete
--

