-- create database if not exists todo_db;
use todo_db;

-- create table if not exists city(
--                id int,
--                name varchar(17),
--                country_code varchar(3),
--                district varchar(20),
--                population int,
--                constraint pk primary key (id)
-- );

-- insert into city values (6,'Rotterdam','NLD','Zuid-Holland', null);
-- insert into city values (19,'Zaanstad','NLD','Noord-Holland',135621);
-- insert into city values (214,'Porto Alegre','BRA','Rio Grande do Sul', 1314032);
-- insert into city values (397,'Lauro de Freitas','BRA','Bahia', 109236);
-- insert into city values (547,'Dobric','BGR','Varna', 100399);
-- insert into city values (552,'Bujumbura','BDI','Bujumbura', 300000);
-- insert into city values (554,'Santiago de Chile','CHL','Santiago', 4703954);
-- insert into city values (626,'al-Minya','EGY','al-Minya', 201360);
-- insert into city values (646,'Santa Ana','SLV','Santa Ana', 139389);
-- insert into city values (762,'Bahir','Dar','ETH Amhara', 96140);
-- insert into city values (796,'Baguio','PHL','CAR', 252386);
-- insert into city values (896,'Malungon','PHL','Southern Mindanao',93232);
-- insert into city values (904,'Banjul','GMB','Banjul', 42326);

-- insert into city values (924,'Villa', 'GTM', 'Nueva', 101295);
-- insert into city values (990,'Waru','IDN','East Java', 124300);
-- insert into city values (1155,'Latur','IND','Maharashtra', 197408);
-- insert into city values (1222,'Tenali','IND','Andhra Pradesh', 143726);
-- insert into city values (1235,'Tirunelveli','IND','Tamil Nadu', 135825);
-- insert into city values (1256,'Alandur','IND','Tamil Nadu', 125244);
-- insert into city values (1279,'Neyveli','IND','Tamil Nadu', 118080);
-- insert into city values (1293,'Pallavaram','IND','Tamil Nadu', 111866);
-- insert into city values (1350,'Dehri','IND','Bihar', 94526);
-- insert into city values (1383,'Tabriz','IRN','East Azerbaidzan', 1191043);
-- insert into city values (1385,'Karaj','IRN','Teheran',940968);
-- insert into city values (1508,'Bolzano','ITA','Trentino-Alto Adige', 97232);
-- insert into city values (1520,'Cesena','ITA','Emilia-Romagna', 89852);
-- insert into city values (1613,'Neyagawa','JPN','Osaka', 257315);
-- insert into city values (1630,'Ageo','JPN','Saitama', 209442);
-- insert into city values (1661,'Sayama','JPN','Saitama', 162472);
-- insert into city values (1681,'Omuta','JPN','Fukuoka', 142889);
-- insert into city values (1739,'Tokuyama','JPN','Yamaguchi', 107078);
-- insert into city values (1793,'Novi Sad','YUG','Vojvodina', 179626);
-- insert into city values (1857,'Kelowna','CAN','British Colombia', 89442);
-- insert into city values (1895,'Harbin','CHN','Heilongjiang', 4289800);
-- insert into city values (1900,'Changchun','CHN','Jilin', 2812000);
-- insert into city values (1913,'Lanzhou','CHN','Gansu', 1565800);
-- insert into city values (1947,'Changzhou','CHN','Jiangsu', 530000);
-- insert into city values (2070,'Dezhou','CHN','Shandong', 195485);
-- insert into city values (2081,'Heze','CHN','Shandong', 189293);
-- insert into city values (2111,'Chenzhou','CHN','Hunan', 169400);
-- insert into city values (2153,'Xianning','CHN','Hubei', 136811);
-- insert into city values (2192,'Lhasa','CHN','Tibet', 120000);
-- insert into city values (2193,'Lianyuan','CHN','Hunan', 118858);
-- insert into city values (2227,'Xingcheng','CHN','Liaoning', 102384);
-- insert into city values (2273,'Villavicencio','COL','Meta', 273140);
-- insert into city values (2384,'Tong-yong','KOR','Kyongsangnam', 131717);
-- insert into city values (2386,'Yongju','KOR','Kyongsangbuk', 131097);
-- insert into city values (2387,'Chinhae','KOR','Kyongsangnam', 125997);
-- insert into city values (2388,'Sangju','KOR','Kyongsangbuk', 124116);
-- insert into city values (2406,'Herakleion','GRC','Crete', 116178);
-- insert into city values (2440,'Monrovia','LBR','Montserrado', 850000);
-- insert into city values (2462,'Lilongwe','MWI','Lilongwe', 435964);
-- insert into city values (2505,'Taza','MAR','Taza-Al Hoceima-Taou', 92700);
-- insert into city values (2555,'Xalapa','MEX','Veracruz', 390058);
-- insert into city values (2602,'Ocosingo','MEX','Chiapas', 171495);
-- insert into city values (2609,'Nogales','MEX','Sonora', 159103);
-- insert into city values (2670,'San Pedro Cholula','MEX','Puebla', 99734);
-- insert into city values (2689,'Palikir','FSM','Pohnpei', 8600);
-- insert into city values (2706,'Tete','MOZ','Tete', 101984);
-- insert into city values (2716,'Sittwe (Akyab)','MMR','Rakhine', 137600);
-- insert into city values (2922,'Carolina','PRI','Carolina', 186076);
-- insert into city values (2967,'Grudziadz','POL','Kujawsko-Pomorskie', 102434);
-- insert into city values (2972,'Malabo','GNQ','Bioko', 40000);
-- insert into city values (3073,'Essen','DEU','Nordrhein-Westfalen', 599515);
-- insert into city values (3169,'Apia','WSM','Upolu', 35900);
-- insert into city values (3198,'Dakar','SEN','Cap-Vert', 785071);
-- insert into city values (3253,'Hama','SYR','Hama', 343361);
-- insert into city values (3288,'Luchou','TWN','Taipei', 160516);
-- insert into city values (3309,'Tanga','TZA','Tanga', 137400);
-- insert into city values (3353,'Sousse','TUN','Sousse', 145900);
-- insert into city values (3377,'Kahramanmaras','TUR','Kahramanmaras', 245772);
-- insert into city values (3430,'Odesa','UKR','Odesa', 1011000);
-- insert into city values (3581,'St Petersburg','RUS','Pietari', 4694000);
-- insert into city values (3770,'Hanoi','VNM','Hanoi', 1410000);
-- insert into city values (3815,'El Paso','USA','Texas', 563662);
-- insert into city values (3878,'Scottsdale','USA','Arizona', 202705);
-- insert into city values (3965,'Corona','USA','California', 124966);
-- insert into city values (3973,'Concord','USA','California', 121780);
-- insert into city values (3977,'Cedar Rapids','USA','Iowa',120758);
-- insert into city values (3982,'Coral Springs','USA','Florida', 117549);
-- insert into city values (4054,'Fairfield','USA','California', 92256);
-- insert into city values (4058,'Boulder','USA','Colorado',91238);
-- insert into city values (4061,'Fall River','USA','Massachusetts',90555);

-- select * from city;

-- create table if not exists station (
--       id int,
--       city varchar(21),
--       state varchar(2),
--       lat_n int,
--       long_n int,
--       constraint pk primary key (id)
-- );

-- INSERT INTO station (id, city, state, lat_n, long_w) VALUES
-- (1, 'Pfeifer', 'KS', 37, 65),
-- (3, 'Hesperia', 'CA', 106, 71),
-- (4, 'South Britain', 'CT', 65, 33),
-- (11, 'Crescent City', 'FL', 58, 117),
-- (14, 'Forest', 'MS', 120, 50),
-- (15, 'Ducor', 'CA', 140, 102),
-- (16, 'Beaufort', 'MO', 71, 85),
-- (17, 'Fredericktown', 'MO', 105, 112),
-- (23, 'Honolulu', 'HI', 110, 139),
-- (25, 'New Century', 'KS', 135, 79),
-- (26, 'Church Creek', 'MD', 39, 91),
-- (29, 'South Carrollton', 'KY', 57, 116),
-- (31, 'Novinger', 'MO', 108, 111),
-- (33, 'Saint Elmo', 'AL', 27, 50),
-- (34, 'McBrides', 'MI', 74, 35),
-- (35, 'Richmond Hill', 'GA', 39, 113),
-- (44, 'Kismet', 'KS', 99, 156),
-- (45, 'Rives Junction', 'MI', 94, 116),
-- (49, 'Osborne', 'KS', 70, 139),
-- (53, 'Shasta', 'CA', 99, 155),
-- (55, 'Coalgood', 'KY', 57, 149),
-- (57, 'Clifton', 'AZ', 30, 135),
-- (59, 'Whitewater', 'MO', 82, 71),
-- (61, 'Brilliant', 'AL', 86, 159),
-- (62, 'Monroe', 'AR', 131, 150),
-- (65, 'Buffalo Creek', 'CO', 47, 148),
-- (67, 'Reeds', 'MO', 30, 42),
-- (69, 'Kingsland', 'AR', 78, 85),
-- (70, 'Norphlet', 'AR', 144, 61),
-- (76, 'Pico Rivera', 'CA', 143, 116),
-- (80, 'Bridgton', 'ME', 93, 140),
-- (81, 'Cowgill', 'MO', 136, 27),
-- (82, 'Many', 'LA', 36, 94),
-- (84, 'Cobalt', 'CT', 87, 26),
-- (88, 'Eros', 'LA', 95, 58),
-- (92, 'Watkins', 'CO', 83, 96),
-- (93, 'Dale', 'IN', 69, 34),
-- (95, 'Dupo', 'IL', 41, 29),
-- (96, 'Raymondville', 'MO', 70, 148),
-- (98, 'Hackleburg', 'AL', 119, 120),
-- (99, 'Woodstock Valley', 'CT', 117, 162),
-- (100, 'North Monmouth', 'ME', 130, 78),
-- (102, 'Kirksville', 'MO', 140, 143),
-- (104, 'Yalaha', 'FL', 120, 119),
-- (105, 'Weldon', 'CA', 134, 118),
-- (106, 'Yuma', 'AZ', 111, 153),
-- (108, 'North Berwick', 'ME', 70, 27),
-- (109, 'Bridgeport', 'MI', 50, 79),
-- (110, 'Mesick', 'MI', 82, 108),
-- (113, 'Prescott', 'IA', 39, 65),
-- (116, 'McHenry', 'MD', 93, 112),
-- (117, 'West Grove', 'IA', 127, 99),
-- (119, 'Wildie', 'KY', 69, 111),
-- (122, 'Robertsdale', 'AL', 97, 85),
-- (124, 'Pine City', 'MN', 119, 129),
-- (127, 'Oshtemo', 'MI', 100, 135),
-- (130, 'Hayneville', 'AL', 109, 157),
-- (136, 'Bass Harbor', 'ME', 137, 61),
-- (143, 'Renville', 'MN', 142, 99),
-- (144, 'Eskridge', 'KS', 107, 63),
-- (154, 'Baker', 'CA', 31, 148),
-- (155, 'Casco', 'MI', 138, 109),
-- (156, 'Heyburn', 'ID', 82, 121),
-- (157, 'Blue River', 'KY', 116, 161),
-- (160, 'Grosse Pointe', 'MI', 102, 91),
-- (161, 'Alanson', 'MI', 90, 72),
-- (162, 'Montgomery City', 'MO', 70, 44),
-- (165, 'Baileyville', 'IL', 82, 61),
-- (166, 'McComb', 'MS', 74, 42),
-- (167, 'Equality', 'AL', 106, 116),
-- (171, 'Springerville', 'AZ', 124, 150),
-- (172, 'Atlantic Mine', 'MI', 131, 99),
-- (174, 'Onaway', 'MI', 108, 55),
-- (175, 'Lydia', 'LA', 41, 39),
-- (176, 'Grapevine', 'AR', 92, 84),
-- (180, 'Napoleon', 'IN', 32, 160),
-- (181, 'Fairview', 'KS', 80, 164),
-- (182, 'Winter Park', 'FL', 133, 32),
-- (183, 'Jordan', 'MN', 68, 35),
-- (188, 'Prairie Du Rocher', 'IL', 75, 70),
-- (189, 'West Somerset', 'KY', 73, 45),
-- (190, 'Oconee', 'GA', 92, 119),
-- (193, 'Corcoran', 'CA', 81, 139),
-- (196, 'Compton', 'IL', 106, 99),
-- (197, 'Milledgeville', 'IL', 90, 113),
-- (199, 'Linden', 'MI', 53, 32),
-- (200, 'Franklin', 'LA', 82, 31),
-- (202, 'Hope', 'MN', 140, 43),
-- (204, 'Alba', 'MI', 91, 103),
-- (207, 'Olmitz', 'KS', 29, 38);

-- INSERT INTO station (id, city, state, lat_n, long_w) VALUES
-- (208, 'Lottie', 'LA', 109, 82),
-- (213, 'Calpine', 'CA', 46, 43),
-- (215, 'Kensett', 'IA', 55, 139),
-- (218, 'Round Pond', 'ME', 127, 124),
-- (223, 'Losantville', 'IN', 112, 106),
-- (224, 'West Hyannisport', 'MA', 58, 96),
-- (225, 'Garden City', 'IA', 54, 119),
-- (226, 'Decatur', 'MS', 71, 117),
-- (228, 'Rydal', 'GA', 35, 78),
-- (231, 'Arispe', 'IA', 31, 137),
-- (232, 'Grandville', 'MI', 38, 70),
-- (233, 'Pierre Part', 'LA', 52, 90),
-- (234, 'Rogers', 'CT', 140, 33),
-- (235, 'Haubstadt', 'IN', 27, 32),
-- (237, 'Winchester', 'ID', 38, 80),
-- (240, 'Saint Paul', 'KS', 66, 163),
-- (241, 'Woodsboro', 'MD', 76, 141),
-- (242, 'Macy', 'IN', 138, 152),
-- (243, 'Hazlehurst', 'MS', 49, 108),
-- (246, 'Ludington', 'MI', 30, 120),
-- (249, 'Acme', 'LA', 73, 67),
-- (250, 'Hampden', 'MA', 76, 26),
-- (252, 'Childs', 'MD', 92, 104),
-- (253, 'Winsted', 'MN', 68, 72),
-- (255, 'Brighton', 'IL', 107, 32),
-- (257, 'Eureka Springs', 'AR', 72, 34),
-- (259, 'Baldwin', 'MD', 81, 40),
-- (260, 'Sizerock', 'KY', 116, 112),
-- (261, 'Fulton', 'KY', 111, 51),
-- (263, 'Irvington', 'IL', 96, 68),
-- (266, 'Cahone', 'CO', 116, 127),
-- (269, 'Jack', 'AL', 49, 85),
-- (270, 'Shingletown', 'CA', 61, 102),
-- (271, 'Hillside', 'CO', 99, 68),
-- (273, 'Rosie', 'AR', 72, 161),
-- (278, 'Cromwell', 'MN', 128, 53),
-- (283, 'Clipper Mills', 'CA', 113, 56),
-- (286, 'Five Points', 'AL', 45, 122),
-- (287, 'Madisonville', 'LA', 112, 53),
-- (288, 'Daleville', 'AL', 121, 136),
-- (291, 'Clarkdale', 'AZ', 58, 73),
-- (294, 'Orange Park', 'FL', 59, 137),
-- (299, 'Goodman', 'MS', 101, 117),
-- (301, 'Monona', 'IA', 144, 81),
-- (302, 'Saint Petersburg', 'FL', 51, 119),
-- (303, 'Cascade', 'ID', 31, 157),
-- (305, 'Bennington', 'KS', 93, 83),
-- (306, 'Bainbridge', 'GA', 62, 56),
-- (311, 'South Haven', 'MN', 30, 87),
-- (312, 'Bentonville', 'AR', 36, 78),
-- (315, 'Ravenna', 'KY', 79, 106),
-- (321, 'Bowdon Junction', 'GA', 85, 33),
-- (322, 'White Horse Beach', 'MA', 54, 59),
-- (323, 'Barrigada', 'GU', 60, 147),
-- (324, 'Norwood', 'MN', 144, 34),
-- (325, 'Monument', 'KS', 70, 141),
-- (326, 'Rocheport', 'MO', 114, 64),
-- (327, 'Ridgway', 'CO', 77, 110),
-- (328, 'Monroe', 'LA', 28, 108),
-- (329, 'Caseville', 'MI', 102, 98),
-- (331, 'Cranks', 'KY', 55, 27),
-- (332, 'Elm Grove', 'LA', 45, 29),
-- (336, 'Dumont', 'MN', 57, 129),
-- (337, 'Mascotte', 'FL', 121, 146),
-- (339, 'Kirk', 'CO', 141, 136),
-- (342, 'Chignik Lagoon', 'AK', 103, 153),
-- (343, 'Mechanic Falls', 'ME', 71, 71),
-- (344, 'Zachary', 'LA', 60, 152),
-- (345, 'Yoder', 'IN', 83, 143),
-- (350, 'Cannonsburg', 'MI', 91, 120),
-- (351, 'Fredericksburg', 'IN', 44, 78),
-- (352, 'Clutier', 'IA', 61, 127),
-- (354, 'Larkspur', 'CA', 107, 65),
-- (355, 'Weldona', 'CO', 32, 58),
-- (356, 'Ludlow', 'CA', 110, 87),
-- (357, 'Yellville', 'AR', 35, 42),
-- (361, 'Arrowsmith', 'IL', 28, 109),
-- (362, 'Magnolia', 'MS', 112, 31),
-- (363, 'Reasnor', 'IA', 41, 162),
-- (364, 'Howard Lake', 'MN', 125, 78),
-- (365, 'Payson', 'IL', 81, 92),
-- (366, 'Norvell', 'MI', 125, 93),
-- (370, 'Palm Desert', 'CA', 106, 145),
-- (373, 'Pawnee', 'IL', 85, 81),
-- (375, 'Culdesac', 'ID', 47, 78),
-- (376, 'Gorham', 'KS', 111, 64),
-- (377, 'Koleen', 'IN', 137, 110),
-- (378, 'Clio', 'IA', 46, 115),
-- (380, 'Crane Lake', 'MN', 72, 43);

-- INSERT INTO station (id, city, state, lat_n, long_w) VALUES
-- (382, 'Leavenworth', 'IN', 100, 121),
-- (383, 'Newbury', 'MA', 128, 85),
-- (384, 'Amo', 'IN', 103, 159),
-- (387, 'Ojai', 'CA', 68, 119),
-- (389, 'Midpines', 'CA', 106, 59),
-- (391, 'Berryton', 'KS', 60, 139),
-- (392, 'Delano', 'CA', 126, 91),
-- (394, 'Centertown', 'MO', 133, 93),
-- (396, 'Dryden', 'MI', 69, 47),
-- (399, 'Republic', 'MI', 75, 130),
-- (400, 'New Ross', 'IN', 134, 120),
-- (401, 'Tennessee', 'IL', 55, 155),
-- (403, 'Zionsville', 'IN', 57, 36),
-- (404, 'Farmington', 'IL', 91, 72),
-- (405, 'Susanville', 'CA', 128, 80),
-- (406, 'Carver', 'MN', 45, 122),
-- (409, 'Columbus', 'GA', 67, 46),
-- (410, 'Calhoun', 'KY', 95, 56),
-- (411, 'Negreet', 'LA', 98, 105),
-- (413, 'Linthicum Heights', 'MD', 127, 67),
-- (414, 'Manchester', 'MD', 73, 37),
-- (417, 'New Liberty', 'IA', 139, 94),
-- (419, 'Lindsay', 'MT', 143, 67),
-- (420, 'Frankfort Heights', 'IL', 71, 30),
-- (423, 'Soldier', 'KS', 77, 152),
-- (426, 'Millville', 'CA', 32, 145),
-- (428, 'Randall', 'KS', 47, 135),
-- (429, 'Lucerne Valley', 'CA', 35, 48),
-- (430, 'Rumsey', 'KY', 70, 50),
-- (433, 'Canton', 'ME', 98, 105),
-- (435, 'Albion', 'IN', 44, 121),
-- (436, 'West Hills', 'CA', 68, 73),
-- (438, 'Bowdon', 'GA', 88, 78),
-- (439, 'Reeves', 'LA', 35, 51),
-- (440, 'Grand Terrace', 'CA', 37, 126),
-- (441, 'Hanna City', 'IL', 50, 136),
-- (442, 'Elkton', 'MD', 103, 156),
-- (444, 'Richland', 'GA', 105, 113),
-- (446, 'Mid Florida', 'FL', 110, 50),
-- (447, 'Arkadelphia', 'AR', 98, 49),
-- (448, 'Canton', 'MN', 123, 151),
-- (451, 'Fort Atkinson', 'IA', 142, 140),
-- (453, 'Sedgwick', 'AR', 68, 75),
-- (455, 'Granger', 'IA', 33, 102),
-- (457, 'Chester', 'CA', 69, 123),
-- (459, 'Harmony', 'IN', 135, 70),
-- (460, 'Leakesville', 'MS', 107, 72),
-- (464, 'Gales Ferry', 'CT', 104, 37),
-- (465, 'Jerome', 'AZ', 121, 34),
-- (467, 'Roselawn', 'IN', 87, 51),
-- (470, 'Healdsburg', 'CA', 111, 54),
-- (471, 'Cape Girardeau', 'MO', 73, 90),
-- (473, 'Highwood', 'IL', 27, 150),
-- (474, 'Grayslake', 'IL', 61, 33),
-- (476, 'Julian', 'CA', 130, 101),
-- (478, 'Tipton', 'IN', 33, 97),
-- (479, 'Cuba', 'MO', 63, 87),
-- (482, 'Jolon', 'CA', 66, 52),
-- (486, 'Delta', 'LA', 136, 49),
-- (489, 'Madden', 'MS', 81, 99),
-- (492, 'Regina', 'KY', 131, 90),
-- (493, 'Groveoak', 'AL', 53, 87),
-- (494, 'Palatka', 'FL', 94, 52),
-- (495, 'Upperco', 'MD', 114, 29),
-- (497, 'Hills', 'MN', 137, 134),
-- (498, 'Glen Carbon', 'IL', 60, 140),
-- (499, 'Delavan', 'MN', 32, 64);

-- INSERT INTO station (id, city, state, lat_n, long_w) VALUES
-- (501, 'Tefft', 'IN', 93, 150),
-- (502, 'Bellevue', 'KY', 127, 121),
-- (503, 'Northfield', 'MN', 61, 37),
-- (504, 'Melber', 'KY', 37, 55),
-- (505, 'Williams', 'AZ', 73, 111),
-- (506, 'Firebrick', 'KY', 49, 95),
-- (510, 'Eastlake', 'MI', 134, 38),
-- (512, 'Garland', 'ME', 108, 134),
-- (515, 'Waresboro', 'GA', 144, 153),
-- (518, 'Vulcan', 'MO', 108, 91),
-- (519, 'Rio Oso', 'CA', 29, 105),
-- (520, 'Delray Beach', 'FL', 27, 158),
-- (521, 'Gowrie', 'IA', 130, 127),
-- (522, 'Harmony', 'MN', 124, 126),
-- (524, 'Montrose', 'CA', 136, 119),
-- (526, 'Tarzana', 'CA', 135, 81),
-- (527, 'Auburn', 'IA', 95, 137),
-- (528, 'Crouseville', 'ME', 36, 81),
-- (531, 'North Middletown', 'KY', 42, 141),
-- (536, 'Henderson', 'IA', 77, 77),
-- (537, 'Hagatna', 'GU', 97, 151),
-- (538, 'Cheswold', 'DE', 31, 59),
-- (539, 'Montreal', 'MO', 129, 127),
-- (540, 'Mosca', 'CO', 89, 141),
-- (541, 'Siloam', 'GA', 105, 92),
-- (543, 'Lapeer', 'MI', 128, 114),
-- (545, 'Byron', 'CA', 136, 120),
-- (547, 'Sandborn', 'IN', 55, 93),
-- (551, 'San Simeon', 'CA', 37, 28),
-- (554, 'Brownsdale', 'MN', 52, 50),
-- (555, 'Westphalia', 'MI', 32, 143),
-- (557, 'Woodbury', 'GA', 102, 93),
-- (560, 'Osage City', 'KS', 110, 89),
-- (566, 'Marine On Saint Croix', 'MN', 126, NULL),
-- (570, 'Greenview', 'CA', 80, 57),
-- (571, 'Tyler', 'MN', 133, 58),
-- (572, 'Athens', 'IN', 75, 120),
-- (573, 'Alton', 'MO', 79, 112),
-- (581, 'Carlos', 'MN', 114, 66),
-- (582, 'Curdsville', 'KY', 84, 150),
-- (583, 'Channing', 'MI', 117, 56),
-- (586, 'Ottertail', 'MN', 100, 44),
-- (588, 'Glencoe', 'KY', 46, 136),
-- (591, 'Baton Rouge', 'LA', 129, 71),
-- (593, 'Aliso Viejo', 'CA', 67, 131),
-- (595, 'Grimes', 'IA', 42, 74),
-- (596, 'Brownstown', 'IL', 48, 63),
-- (598, 'Middleboro', 'MA', 108, 149),
-- (599, 'Esmond', 'IL', 75, 90),
-- (600, 'Shreveport', 'LA', 136, 38);

-- INSERT INTO station (id, city, state, lat_n, long_w) VALUES
-- (603, 'Sandy Hook', 'CT', 72, 148),
-- (604, 'Forest Lakes', 'AZ', 144, 114),
-- (605, 'Notasulga', 'AL', 66, 115),
-- (606, 'Morenci', 'AZ', 104, 110),
-- (608, 'Busby', 'MT', 104, 29),
-- (609, 'Marysville', 'MI', 85, 132),
-- (610, 'Archie', 'MO', 40, 28),
-- (611, 'Richmond', 'IL', 113, 163),
-- (612, 'Sturdivant', 'MO', 93, 86),
-- (613, 'East China', 'MI', 108, 42),
-- (614, 'Benedict', 'KS', 138, 95),
-- (615, 'Libertytown', 'MD', 144, 111),
-- (617, 'Sturgis', 'MS', 36, 126),
-- (619, 'Arlington', 'CO', 75, 92),
-- (621, 'Flowood', 'MS', 64, 149),
-- (623, 'Jackson', 'AL', 111, 67),
-- (624, 'Knobel', 'AR', 95, 62),
-- (625, 'Bristol', 'ME', 87, 95),
-- (630, 'Prince Frederick', 'MD', 104, 57),
-- (631, 'Urbana', 'IA', 142, 29),
-- (633, 'Bertha', 'MN', 39, 105),
-- (636, 'Ukiah', 'CA', 86, 89),
-- (637, 'Beverly', 'KY', 57, 126),
-- (638, 'Clovis', 'CA', 92, 138),
-- (640, 'Walnut', 'MS', 40, 76),
-- (642, 'Lynnville', 'KY', 25, 146),
-- (643, 'Wellington', 'KY', 100, 31),
-- (644, 'Seward', 'AK', 120, 35),
-- (646, 'Greens Fork', 'IN', 133, 135),
-- (647, 'Portland', 'AR', 83, 44),
-- (649, 'Pengilly', 'MN', 25, 154),
-- (650, 'Clancy', 'MT', 45, 164),
-- (651, 'Clopton', 'AL', 40, 84),
-- (654, 'Lee', 'IL', 27, 51),
-- (656, 'Pattonsburg', 'MO', 138, 32),
-- (657, 'Gridley', 'KS', 118, 55),
-- (661, 'Payson', 'AZ', 126, 154),
-- (662, 'Skanee', 'MI', 70, 129),
-- (665, 'Chelsea', 'IA', 98, 59),
-- (666, 'West Baden Springs', 'IN', 30, 96),
-- (667, 'Hawarden', 'IA', 90, 46),
-- (668, 'Rockton', 'IL', 116, 86),
-- (672, 'Lismore', 'MN', 58, 103),
-- (673, 'Showell', 'MD', 44, 163),
-- (675, 'Dent', 'MN', 70, 136),
-- (677, 'Hayesville', 'IA', 119, 42),
-- (678, 'Bennington', 'IN', 35, 26),
-- (679, 'Gretna', 'LA', 75, 142),
-- (682, 'Pheba', 'MS', 90, 127),
-- (684, 'Mineral Point', 'MO', 91, 41),
-- (685, 'Anthony', 'KS', 45, 161),
-- (690, 'Ravenden Springs', 'AR', 67, 108),
-- (692, 'Yellow Pine', 'ID', 83, 150),
-- (694, 'Ozona', 'FL', 144, 120),
-- (695, 'Amazonia', 'MO', 45, 148),
-- (696, 'Chilhowee', 'MO', 79, 49),
-- (698, 'Albany', 'CA', 49, 80),
-- (699, 'North Branford', 'CT', 37, 95),
-- (700, 'Pleasant Grove', 'AR', 135, 145);

-- INSERT INTO station (id, city, state, lat_n, long_w) VALUES
-- (701, 'Seaton', 'IL', 128, 78),
-- (702, 'Everton', 'MO', 119, 51),
-- (704, 'Climax', 'MI', 127, 107),
-- (705, 'Hotchkiss', 'CO', 69, 71),
-- (706, 'Little Rock', 'AR', 122, 121),
-- (709, 'Nubieber', 'CA', 132, 49),
-- (710, 'Turners Falls', 'MA', 31, 125),
-- (711, 'Turner', 'AR', 50, 101),
-- (712, 'Dundee', 'IA', 61, 105),
-- (715, 'Hyde Park', 'MA', 65, 156),
-- (716, 'Schleswig', 'IA', 119, 51),
-- (718, 'Taft', 'CA', 107, 146),
-- (722, 'Marion Junction', 'AL', 53, 31),
-- (725, 'Alpine', 'AR', 116, 114),
-- (727, 'Winslow', 'IL', 113, 38),
-- (728, 'Roy', 'MT', 41, 51),
-- (731, 'Emmett', 'ID', 57, 31),
-- (733, 'Pelahatchie', 'MS', 38, 28),
-- (735, 'Wilton', 'ME', 56, 157),
-- (738, 'Philipsburg', 'MT', 95, 72),
-- (739, 'Fort Meade', 'FL', 43, 35),
-- (740, 'Siler', 'KY', 137, 117),
-- (741, 'Jemison', 'AL', 62, 25),
-- (743, 'De Tour Village', 'MI', 25, 25),
-- (745, 'Windom', 'KS', 114, 126),
-- (746, 'Orange City', 'IA', 93, 162),
-- (750, 'Neon', 'KY', 101, 147),
-- (751, 'Agency', 'MO', 59, 95),
-- (752, 'East Irvine', 'CA', 106, 115),
-- (753, 'Algonac', 'MI', 118, 80),
-- (754, 'South Haven', 'MI', 144, 52),
-- (755, 'Sturgis', 'MI', 117, 135),
-- (756, 'Garden City', 'AL', 96, 105),
-- (757, 'Lakeville', 'CT', 59, 94),
-- (766, 'Gustine', 'CA', 111, 140),
-- (767, 'Pomona Park', 'FL', 100, 163),
-- (774, 'Manchester', 'IA', 129, 123),
-- (775, 'Eleele', 'HI', 80, 152),
-- (777, 'Edgewater', 'MD', 130, 72),
-- (778, 'Pine Bluff', 'AR', 60, 145),
-- (779, 'Del Mar', 'CA', 59, 95),
-- (780, 'Cherry', 'IL', 68, 46),
-- (781, 'Hoffman Estates', 'IL', 129, 53),
-- (783, 'Strawn', 'IL', 29, 51),
-- (784, 'Biggsville', 'IL', 85, 138),
-- (789, 'Hopkinsville', 'KY', 27, 47),
-- (791, 'Scotts Valley', 'CA', 119, 90),
-- (794, 'Kissee Mills', 'MO', 139, 73),
-- (799, 'Corriganville', 'MD', 141, 153),
-- (801, 'Pocahontas', 'IL', 109, 83),
-- (804, 'Fort Lupton', 'CO', 38, 93),
-- (805, 'Tamms', 'IL', 59, 75),
-- (811, 'Dorrance', 'KS', 102, 121),
-- (813, 'Verona', 'MO', 109, 152),
-- (814, 'Wickliffe', 'KY', 80, 46),
-- (815, 'Pomona', 'MO', 52, 50),
-- (819, 'Peaks Island', 'ME', 59, 110),
-- (820, 'Chokio', 'MN', 81, 134),
-- (821, 'Sanders', 'AZ', 130, 96),
-- (824, 'Loma Mar', 'CA', 48, 130),
-- (825, 'Addison', 'MI', 96, 142),
-- (826, 'Norris', 'MT', 47, 37),
-- (827, 'Greenville', 'IL', 50, 153),
-- (829, 'Seward', 'IL', 72, 90),
-- (830, 'Greenway', 'AR', 119, 35),
-- (833, 'Hoskinston', 'KY', 65, 65),
-- (834, 'Bayville', 'ME', 106, 143),
-- (836, 'Kenner', 'LA', 91, 126),
-- (838, 'Strasburg', 'CO', 89, 47),
-- (839, 'Slidell', 'LA', 85, 151),
-- (841, 'Freeport', 'MI', 113, 50),
-- (842, 'Decatur', 'MI', 63, 161),
-- (843, 'Talbert', 'KY', 39, 58),
-- (844, 'Aguanga', 'CA', 79, 65),
-- (845, 'Tina', 'MO', 131, 28),
-- (849, 'Harbor Springs', 'MI', 141, 148);

-- INSERT INTO station (id, city, state, lat_n, long_w) VALUES
-- (851, 'Gatewood', 'MO', 76, 145),
-- (853, 'Coldwater', 'KS', 47, 26),
-- (854, 'Kirkland', 'AZ', 86, 57),
-- (861, 'Peabody', 'KS', 75, 152),
-- (866, 'Haverhill', 'IA', 61, 109),
-- (867, 'Beaver Island', 'MI', 81, 164),
-- (868, 'Sherrill', 'AR', 79, 152),
-- (871, 'Clarkston', 'MI', 93, 80),
-- (878, 'Rantoul', 'KS', 31, 118),
-- (884, 'Southport', 'CT', 59, 63),
-- (885, 'Deerfield', 'MO', 40, 35),
-- (886, 'Pony', 'MT', 99, 162),
-- (888, 'Bono', 'AR', 133, 150),
-- (889, 'Lena', 'LA', 78, 129),
-- (890, 'Eufaula', 'AL', 140, 103),
-- (891, 'Humeston', 'IA', 74, 122),
-- (892, 'Effingham', 'KS', 132, 97),
-- (896, 'Yazoo City', 'MS', 95, 85),
-- (897, 'Samantha', 'AL', 75, 35),
-- (899, 'Fremont', 'MI', 54, 150),
-- (901, 'Manchester', 'MN', 71, 84),
-- (904, 'Ermine', 'KY', 119, 62),
-- (905, 'Newark', 'IL', 72, 129),
-- (906, 'Hayfork', 'CA', 35, 116),
-- (907, 'Veedersburg', 'IN', 78, 94),
-- (908, 'Bullhead City', 'AZ', 94, 30),
-- (909, 'Carlock', 'IL', 117, 84),
-- (910, 'Salem', 'KY', 86, 113),
-- (914, 'Hanscom Afb', 'MA', 129, 136),
-- (919, 'Knob Lick', 'KY', 135, 33),
-- (920, 'Eustis', 'FL', 42, 39),
-- (921, 'Lee Center', 'IL', 95, 77),
-- (922, 'Kell', 'IL', 70, 58),
-- (923, 'Union Star', 'MO', 79, 132),
-- (927, 'Quinter', 'KS', 59, 25),
-- (928, 'Coaling', 'AL', 144, 52),
-- (938, 'Andersonville', 'GA', 141, 72),
-- (940, 'Paron', 'AR', 59, 104),
-- (941, 'Allerton', 'IA', 61, 112),
-- (944, 'Ledyard', 'CT', 134, 143),
-- (946, 'Newton Center', 'MA', 48, 144),
-- (948, 'Lupton', 'MI', 139, 53),
-- (949, 'Norway', 'ME', 83, 88),
-- (950, 'Peachtree City', 'GA', 80, 155),
-- (953, 'Udall', 'KS', 112, 59),
-- (955, 'Netawaka', 'KS', 109, 119),
-- (957, 'South El Monte', 'CA', 74, 79),
-- (959, 'Waipahu', 'HI', 106, 33),
-- (960, 'Deep River', 'IA', 75, 38),
-- (963, 'Eriline', 'KY', 93, 65),
-- (965, 'Griffin', 'GA', 38, 151),
-- (968, 'Norris City', 'IL', 53, 76),
-- (969, 'Dixie', 'GA', 27, 36),
-- (970, 'East Haddam', 'CT', 115, 132),
-- (971, 'Graettinger', 'IA', 94, 150),
-- (973, 'Andover', 'CT', 51, 52),
-- (975, 'Panther Burn', 'MS', 116, 164),
-- (977, 'Odin', 'IL', 53, 115),
-- (981, 'Lakota', 'IA', 56, 92),
-- (982, 'Holbrook', 'AZ', 134, 103),
-- (983, 'Patriot', 'IN', 82, 46),
-- (985, 'Winslow', 'AR', 126, 126),
-- (987, 'Hartland', 'MI', 136, 107),
-- (988, 'Mullan', 'ID', 143, 154),
-- (990, 'Bison', 'KS', 132, 74),
-- (994, 'Kanorado', 'KS', 65, 85),
-- (996, 'Keyes', 'CA', 76, 85),
-- (998, 'Oakfield', 'ME', 47, 132);


-- alter table station rename column long_n to long_w;
select * from station;
select * from city;
select * from station order by lat_n, long_w;

select country_code, count(*) as count
from city
group by country_code;

select country_code, count(*) as count
from city
where population is not null
group by country_code;
##################################################################################################################################
use noob_db;

create table if not exists A(
		id int);

create table if not exists B(
		sl int);

insert into a values (1), (2), (3), (4), (5), (6);
insert into b values (1), (3), (6), (7);

select * from a;
select * from b;

SELECT COUNT( a.id ) AS C1, COUNT( b.sl ) AS C2
FROM a LEFT JOIN b
ON a.id = b.sl;

create table if not exists c(
		id int);

create table if not exists d(
		sl int);

insert into c values (1), (2), (3), (4), (5), (6), (2), (1), (2), (3);
insert into d values (1), (3), (6), (7), (6), (7), (1);

select * from c
order by id;

select * from d
order by sl;

SELECT COUNT( c.id ) AS C1, COUNT( d.sl ) AS C2
FROM c LEFT JOIN d
ON c.id = d.sl;

SELECT c.id, d.sl
FROM c LEFT JOIN d
ON c.id = d.sl;

###############################################################################################################################





    





