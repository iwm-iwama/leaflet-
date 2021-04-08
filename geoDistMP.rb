#!/usr/bin/env ruby
#coding:utf-8
# > ruby geoDistMP.rb

Signal.trap(:INT) do
	exit
end

#---------------------------------------------------------------------
# [北緯]	[東経]	[その他]
#---------------------------------------------------------------------
# 十進法 ddd.d...
#---------------------------------------------------------------------
Data1 = <<EOD
// (サンプル)
//	35.685187	139.752274	皇居
//	24.449582	122.934340	日本最西端之地

// (参考)
//	https://www.330k.info/essay/precision-of-mathematica-geodistance-and-geographical-distance-formula/
//	https://www.330k.info/essay/precision-of-mathematica-geodistance-and-geographical-distance-formula/makurazaki_wakkanai_reduced.gpx
31.27216	130.29956	枕崎駅
31.33976	130.27063	↓
31.38294	130.31228	↓
31.45631	130.34415	↓
31.58710	130.34180	↓
31.66086	130.32140	↓
31.71886	130.27254	↓
31.75990	130.30652	↓
31.81231	130.30765	↓
31.84331	130.27986	↓
31.85158	130.23748	↓
31.86527	130.22490	↓
31.92860	130.22425	↓
32.02740	130.19569	↓
32.05986	130.22292	↓
32.11650	130.33952	↓
32.17422	130.38257	↓
32.19819	130.38227	↓
32.25715	130.50983	↓
32.33472	130.48537	↓
32.36339	130.50789	↓
32.37484	130.53627	↓
32.42086	130.55128	↓
32.45672	130.59943	↓
32.50328	130.61136	↓
32.50747	130.64885	↓
32.58873	130.70275	↓
32.65366	130.69925	↓
32.68998	130.67069	↓
32.82402	130.72266	↓
32.89552	130.68972	↓
32.96968	130.71602	↓
33.00075	130.68708	↓
33.02791	130.68218	↓
33.10306	130.70025	↓
33.11602	130.68786	↓
33.11307	130.65209	↓
33.13460	130.62086	↓
33.19131	130.61054	↓
33.21966	130.55923	↓
33.31397	130.52229	↓
33.44212	130.53532	↓
33.45249	130.56446	↓
33.50689	130.60107	↓
33.51256	130.63301	↓
33.55673	130.64264	↓
33.59143	130.67364	↓
33.64598	130.67801	↓
33.66647	130.71552	↓
33.75130	130.75641	↓
33.79189	130.74460	↓
33.86573	130.76159	↓
33.86768	130.81787	↓
33.88142	130.83614	↓
33.87258	130.88045	↓
33.89303	130.92202	↓
33.94799	130.96864	↓
33.97642	130.94679	↓
33.99221	130.95232	↓
34.00376	130.99296	↓
34.06037	131.03391	↓
34.04489	131.06879	↓
34.05162	131.19582	↓
34.03629	131.25252	↓
34.04143	131.27890	↓
34.06003	131.29025	↓
34.05707	131.36656	↓
34.08422	131.39656	↓
34.10589	131.39556	↓
34.15606	131.43314	↓
34.20717	131.51493	↓
34.25024	131.52257	↓
34.28446	131.55714	↓
34.34519	131.63228	↓
34.35404	131.67313	↓
34.41413	131.74881	↓
34.44155	131.77275	↓
34.47418	131.77728	↓
34.48511	131.80555	↓
34.54401	131.83453	↓
34.55209	131.83068	↓
34.54495	131.81727	↓
34.56998	131.79227	↓
34.62423	131.80686	↓
34.63737	131.79758	↓
34.64592	131.81214	↓
34.67804	131.81309	↓
34.70833	131.86113	↓
34.74774	131.87338	↓
34.77557	131.96065	↓
34.82374	131.98066	↓
34.86535	132.02724	↓
34.89566	132.10535	↓
34.93643	132.11146	↓
34.99852	132.19486	↓
35.01339	132.23355	↓
35.03471	132.24472	↓
35.03723	132.28156	↓
35.06997	132.32326	↓
35.07125	132.34562	↓
35.18688	132.42729	↓
35.20403	132.49928	↓
35.23630	132.53112	↓
35.24897	132.56902	↓
35.27473	132.58686	↓
35.29587	132.64745	↓
35.33366	132.68066	↓
35.34675	132.72335	↓
35.36931	132.73871	↓
35.37298	132.79000	↓
35.39050	132.81830	↓
35.45009	133.08633	↓
35.42799	133.13184	↓
35.43300	133.24658	↓
35.42482	133.28367	↓
35.40838	133.29836	↓
35.40927	133.32596	↓
35.42741	133.41244	↓
35.46674	133.44513	↓
35.50942	133.52286	↓
35.50877	133.63961	↓
35.48485	133.69113	↓
35.50181	133.72706	↓
35.49587	133.89496	↓
35.51766	133.96873	↓
35.51196	134.00909	↓
35.52838	134.14519	↓
35.52144	134.23435	↓
35.56746	134.29629	↓
35.55688	134.36694	↓
35.52550	134.39883	↓
35.52472	134.42653	↓
35.56568	134.48173	↓
35.49301	134.54081	↓
35.49372	134.56549	↓
35.47117	134.59804	↓
35.41192	134.60040	↓
35.37498	134.64070	↓
35.39786	134.76937	↓
35.37299	134.78917	↓
35.31739	134.88940	↓
35.33466	134.91473	↓
35.31991	134.98540	↓
35.33376	135.09495	↓
35.39405	135.15019	↓
35.39259	135.18012	↓
35.42419	135.20853	↓
35.42966	135.24969	↓
35.45320	135.26569	↓
35.45204	135.34753	↓
35.47645	135.36740	↓
35.48973	135.52341	↓
35.47780	135.65104	↓
35.49061	135.74653	↓
35.46257	135.86101	↓
35.47916	135.87757	↓
35.47875	135.90096	↓
35.58592	135.91037	↓
35.59768	135.92192	↓
35.61310	135.97854	↓
35.63258	136.00405	↓
35.63885	136.08300	↓
35.70332	136.07857	↓
35.72268	136.09934	↓
35.75652	136.10639	↓
35.79934	136.09123	↓
35.84969	136.12614	↓
35.88957	136.19207	↓
35.96105	136.18821	↓
36.01722	136.21089	↓
36.04990	136.24152	↓
36.28876	136.29599	↓
36.34476	136.44836	↓
36.38915	136.49315	↓
36.42353	136.48314	↓
36.47515	136.50073	↓
36.51402	136.57280	↓
36.53943	136.60038	↓
36.56844	136.60161	↓
36.63330	136.70551	↓
36.68492	136.72455	↓
36.67215	136.80055	↓
36.68909	136.86221	↓
36.68596	136.89412	↓
36.76182	137.00545	↓
36.75750	137.06347	↓
36.72641	137.13097	↓
36.73463	137.20904	↓
36.72098	137.25304	↓
36.71967	137.31469	↓
36.78871	137.40655	↓
36.83859	137.42126	↓
36.87137	137.45589	↓
36.91488	137.47441	↓
36.93896	137.51278	↓
36.94798	137.56442	↓
36.97093	137.58841	↓
36.99355	137.70345	↓
37.05869	137.91101	↓
37.12734	138.04818	↓
37.17272	138.09649	↓
37.16073	138.15155	↓
37.16793	138.26336	↓
37.31293	138.42690	↓
37.34953	138.49185	↓
37.36877	138.57680	↓
37.44339	138.63320	↓
37.46300	138.67949	↓
37.56251	138.73300	↓
37.59259	138.77035	↓
37.63742	138.86993	↓
37.77192	138.90211	↓
37.78816	138.92311	↓
37.84504	138.93742	↓
37.93167	139.13773	↓
37.96558	139.24971	↓
37.99055	139.24460	↓
38.07437	139.34672	↓
38.14536	139.40519	↓
38.14568	139.42419	↓
38.18620	139.44732	↓
38.18575	139.46358	↓
38.23906	139.50305	↓
38.26969	139.50492	↓
38.32283	139.55531	↓
38.40567	139.55791	↓
38.43739	139.59159	↓
38.46184	139.57374	↓
38.48853	139.52186	↓
38.50020	139.52157	↓
38.64672	139.59635	↓
38.68556	139.62721	↓
38.71575	139.67726	↓
38.72160	139.71889	↓
38.71171	139.74665	↓
38.76013	139.83237	↓
38.81958	139.83292	↓
38.84014	139.84887	↓
38.88278	139.83798	↓
38.89732	139.85534	↓
38.92997	139.85910	↓
38.95294	139.83711	↓
39.07196	139.88639	↓
39.11331	139.87010	↓
39.17766	139.90869	↓
39.22050	139.90142	↓
39.25122	139.92663	↓
39.27512	139.92511	↓
39.29048	139.97351	↓
39.38573	140.03200	↓
39.42543	140.02743	↓
39.49556	140.04930	↓
39.70086	140.06837	↓
39.72331	140.08769	↓
39.74754	140.06741	↓
39.84763	140.05160	↓
39.88920	140.08955	↓
39.94486	140.11257	↓
39.94495	140.20285	↓
39.95930	140.23087	↓
39.99105	140.24643	↓
40.00333	140.27761	↓
40.03392	140.27518	↓
40.06666	140.29524	↓
40.11973	140.37870	↓
40.17704	140.40089	↓
40.25199	140.38117	↓
40.27930	140.45303	↓
40.27213	140.53108	↓
40.34817	140.60031	↓
40.41502	140.61142	↓
40.42731	140.63640	↓
40.46110	140.63580	↓
40.50639	140.61219	↓
40.52976	140.55497	↓
40.55273	140.55145	↓
40.58602	140.50747	↓
40.64064	140.48979	↓
40.66853	140.51135	↓
40.71051	140.57928	↓
40.76500	140.58829	↓
40.78177	140.62460	↓
40.80128	140.62282	↓
40.83171	140.66296	↓
40.82293	140.74535	↓
40.82983	140.81478	↓
40.84728	140.83660	↓
40.91711	140.87235	↓
40.91844	140.93897	↓
40.93293	140.99256	↓
40.90375	141.06983	↓
40.87306	141.10033	↓
40.87277	141.13462	↓
40.93775	141.20909	↓
41.01692	141.24443	↓
41.09996	141.25151	↓
41.15419	141.28298	↓
41.18053	141.28334	↓
41.27993	141.20937	↓
41.30066	141.22201	↓
41.37187	141.20907	↓
41.39627	141.17397	↓
41.39664	141.15387	↓
41.41286	141.16244	↓
41.46475	141.10580	↓
41.48141	141.06773	↓
41.48537	141.00212	↓
41.52699	140.93774	↓
41.52438	140.89957	↓
41.75257	140.68421	↓
41.78182	140.68459	↓
41.81038	140.71472	↓
41.90217	140.63790	↓
41.96980	140.65151	↓
42.05680	140.59637	↓
42.07894	140.59760	↓
42.20767	140.40268	↓
42.24245	140.29294	↓
42.26427	140.27304	↓
42.30607	140.27232	↓
42.45768	140.33426	↓
42.52100	140.38371	↓
42.57805	140.45371	↓
42.59251	140.45217	↓
42.60211	140.48068	↓
42.59356	140.53436	↓
42.60455	140.56251	↓
42.59114	140.59347	↓
42.60339	140.61638	↓
42.58390	140.72731	↓
42.61234	140.72931	↓
42.61843	140.76694	↓
42.65231	140.79488	↓
42.66851	140.84224	↓
42.69185	140.83422	↓
42.70496	140.85840	↓
42.73792	140.87731	↓
42.75720	140.92583	↓
42.79565	140.93870	↓
42.80135	140.99045	↓
42.84834	141.02581	↓
42.84628	141.08122	↓
42.87149	141.11492	↓
42.87555	141.14656	↓
42.90214	141.11848	↓
42.93042	141.11944	↓
42.96201	141.15935	↓
42.96970	141.20916	↓
42.95558	141.24633	↓
42.96754	141.33122	↓
43.01499	141.34674	↓
43.06054	141.34076	↓
43.07076	141.39598	↓
43.09376	141.42549	↓
43.09500	141.45322	↓
43.11657	141.47082	↓
43.13105	141.50724	↓
43.19031	141.52474	↓
43.21205	141.51812	↓
43.26471	141.59038	↓
43.31566	141.60110	↓
43.36232	141.73306	↓
43.42824	141.81820	↓
43.46746	141.84986	↓
43.54583	141.88487	↓
43.58899	141.86815	↓
43.66067	141.89507	↓
43.73561	141.87605	↓
43.76817	141.88190	↓
43.79619	141.83838	↓
43.84670	141.82205	↓
43.85322	141.78418	↓
43.84608	141.76329	↓
43.88505	141.73457	↓
43.90817	141.69254	↓
43.91968	141.69585	↓
43.91999	141.67583	↓
43.96137	141.64284	↓
44.03005	141.66835	↓
44.30977	141.65418	↓
44.42645	141.74799	↓
44.54555	141.76696	↓
44.55967	141.78596	↓
44.62337	141.80358	↓
44.79147	141.79018	↓
44.89567	141.74657	↓
44.97043	141.76426	↓
45.00096	141.84433	↓
45.05006	141.82385	↓
45.08409	141.78798	↓
45.10466	141.79712	↓
45.20012	141.77631	↓
45.22762	141.74642	↓
45.24091	141.75248	↓
45.28981	141.72318	↓
45.33368	141.72053	↓
45.35275	141.73673	↓
45.39518	141.70627	↓
45.40446	141.67576	↓
45.41726	141.67677	稚内駅
EOD
#---------------------------------------------------------------------
# 度分秒 dddmmss.s...
#---------------------------------------------------------------------
Data2 = <<EOD
// (サンプル)
354106.6732	1394508.1864	皇居
242658.4952	1225603.6240	日本最西端之地
EOD
#---------------------------------------------------------------------

#-------------------
# 度分秒 => 十進法
#-------------------
def
rtnGeoIBLto10B(
	ddmmss # ddmmss.s...
)
	ddmmss = ddmmss.to_f

	sign = 1

	if ddmmss < 0
		sign = -1
		ddmmss = -ddmmss
	end

	sec = ddmmss % 100
	min = ((ddmmss / 100).to_i) % 100
	deg = (ddmmss / 10000).to_i

	return sign * (deg + (min / 60.0) + (sec / 3600.0)).to_f
end

#-------------------------------
# Vincenty法による２点間の距離
#-------------------------------
def
rtnGeoVincentry(
	lat1, # 開始～緯度
	lng1, # 開始～経度
	lat2, # 終了～緯度
	lng2  # 終了～経度
)
	lat1, lng1, lat2, lng2 = lat1.to_f, lng1.to_f, lat2.to_f, lng2.to_f

	if lat1 == lat2 && lng1 == lng2
		return [0.0, 0.0]
	end

	## _A = 6378137.0
	_B   = 6356752.314140356    # GRS80
	_F   = 0.003352810681182319 # 1 / 298.257222101
	_RAD = 0.017453292519943295 # π / 180

	latR1 = lat1 * _RAD
	lngR1 = lng1 * _RAD
	latR2 = lat2 * _RAD
	lngR2 = lng2 * _RAD

	f1 = 1 - _F

	omega  = lngR2 - lngR1
	tanU1  = f1 * Math.tan(latR1)
	cosU1  = 1 / Math.sqrt(1 + tanU1 * tanU1)
	sinU1  = tanU1 * cosU1
	tanU2  = f1 * Math.tan(latR2)
	cosU2  = 1 / Math.sqrt(1 + tanU2 * tanU2)
	sinU2  = tanU2 * cosU2
	lamda  = omega
	dLamda = 0.0

	sinLamda  = 0.0
	cosLamda  = 0.0
	sin2sigma = 0.0
	sinSigma  = 0.0
	cosSigma  = 0.0
	sigma     = 0.0
	sinAlpha  = 0.0
	cos2alpha = 0.0
	cos2sm    = 0.0
	c = 0.0

	while true
		sinLamda = Math.sin(lamda)
		cosLamda = Math.cos(lamda)
		sin2sigma = (cosU2 * sinLamda) * (cosU2 * sinLamda) + (cosU1 * sinU2 - sinU1 * cosU2 * cosLamda) * (cosU1 * sinU2 - sinU1 * cosU2 * cosLamda)
		if sin2sigma < 0.0
			return [0.0, 0.0]
		end
		sinSigma = Math.sqrt(sin2sigma)
		cosSigma = sinU1 * sinU2 + cosU1 * cosU2 * cosLamda
		sigma = Math.atan2(sinSigma, cosSigma)
		sinAlpha = cosU1 * cosU2 * sinLamda / sinSigma
		cos2alpha = 1 - sinAlpha * sinAlpha
		cos2sm = cosSigma - 2 * sinU1 * sinU2 / cos2alpha
		c = _F / 16 * cos2alpha * (4 + _F * (4 - 3 * cos2alpha))
		dLamda = lamda
		lamda = omega + (1 - c) * _F * sinAlpha * (sigma + c * sinSigma * (cos2sm + c * cosSigma * (-1 + 2 * cos2sm * cos2sm)))

		if (lamda - dLamda).abs <= 1e-12
			break
		end
	end

	u2 = cos2alpha * (1 - f1 * f1) / (f1 * f1)
	a = 1 + u2 / 16384 * (4096 + u2 * (-768 + u2 * (320 - 175 * u2)))
	b = u2 / 1024 * (256 + u2 * (-128 + u2 * (74 - 47 * u2)))
	dSigma = b * sinSigma * (cos2sm + b / 4 * (cosSigma * (-1 + 2 * cos2sm * cos2sm) - b / 6 * cos2sm * (-3 + 4 * sinSigma * sinSigma) * (-3 + 4 * cos2sm * cos2sm)))
	angle = Math.atan2(cosU2 * sinLamda, cosU1 * sinU2 - sinU1 * cosU2 * cosLamda) * 57.29577951308232
	dist = _B * a * (sigma - dSigma)

	# 変換
	if angle < 0
		angle += 360.0 # 360度表記
	end
	dist /= 1000.0 # m => km

	return [dist.to_f, angle.to_f]
end

#-------
# Main
#-------
Separater = "\t"

#---------------
# 計算／十進法
#---------------
def
main_Data1()
	iTotalDist = 0.0
	aOld = []

	Data1.each_line do
		|_s1|
		_s1 = _s1.strip

		if _s1.size > 0 && _s1[0, 2] != "//"
			as1 = _s1.split(Separater)

			dist, angle = (
				aOld[0] ?
				rtnGeoVincentry(aOld[0], aOld[1], as1[0], as1[1]) :
				[0.0, 0.0]
			)

			str = sprintf("%.6fkm%s%.6f度", dist, Separater, angle)
			as1.each do
				|_s2|
				str << Separater + _s2
			end
			puts str

			iTotalDist += dist
			aOld = as1
		end
	end

	printf("%.6fkm\n\n", iTotalDist)
end

#---------------
# 計算／度分秒
#---------------
def
main_Data2()
	iTotalDist = 0.0
	aOld = []

	Data2.each_line do
		|_s1|
		_s1 = _s1.strip

		if _s1.size > 0 && _s1[0, 2] != "//"
			as1 = _s1.split(Separater)
			ad1 = []

			as1[0..1].each do
				|_s2|
				ad1 << rtnGeoIBLto10B(_s2)
			end

			dist, angle = (
				aOld[0] ?
				rtnGeoVincentry(aOld[0], aOld[1], ad1[0], ad1[1]) :
				[0.0, 0.0]
			)

			str = sprintf("%.6fkm%s%.6f度", dist, Separater, angle)
			as1.each do
				|_s2|
				str << Separater + _s2
			end
			puts str

			iTotalDist += dist
			aOld = ad1
		end
	end

	printf("%.6fkm\n\n", iTotalDist)
end

#-------
# Exec
#-------
main_Data1()
main_Data2()
