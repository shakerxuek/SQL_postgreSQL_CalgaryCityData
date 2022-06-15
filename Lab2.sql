--Q1：
SELECT status, ST_Multi(ST_Union(geom3776)) AS geom FROM "Lab2"."Calppb" GROUP BY status ORDER BY status ASC;

--Q2：
SELECT ST_Union(ST_Intersection(cs.geom3776, cp.geom3776))
FROM "Lab2"."CalgaryCommunities" AS cs, "Lab2"."Calppb" AS cp
WHERE cs.sector = 'SOUTH' and cp.plan_type='L.R.T. Policy';

--Q3：
SELECT ST_Difference(ST_Union(cs.geom3776), ST_Union(cp.geom3776))
FROM "Lab2"."CalgaryCommunities" AS cs, "Lab2"."Calppb" AS cp
WHERE cs.sector = 'NORTHEAST' and cp.plan_type='Area Structure Plan';

--Q4:
CREATE TABLE "Lab2"."CalgaryBoundaryNW" AS (SELECT ST_Boundary(ST_Union(cs.geom3776))
FROM "Lab2"."CalgaryCommunities" AS cs
WHERE cs.sector = 'NORTHWEST' );

CREATE TABLE "Lab2"."CalgaryBoundaryW" AS (SELECT ST_Boundary(ST_Union(cs.geom3776))
FROM "Lab2"."CalgaryCommunities" AS cs
WHERE cs.sector = 'WEST' );

SELECT ST_Intersection(ST_Union(cnw.st_boundary),ST_Union(cw.st_boundary))
FROM "Lab2"."CalgaryBoundaryNW" as cnw, "Lab2"."CalgaryBoundaryW" as cw);

--Q5:

CREATE TABLE "Lab2"."CalgaryGlENMOREINTER" AS (SELECT ch.geom3776
FROM "Lab2"."CalgaryRoadbyname" as cr, "Lab2"."CalgaryHydrology" as ch
where cr.name='GLENMORE'and ST_intersects(ch.geom3776,cr.geom));

--Q6：
CREATE TABLE "Lab2"."UCalgary" AS(SELECT geom3776
FROM "Lab2"."CalgaryCommunities"
where name='UNIVERSITY OF CALGARY');

CREATE TABLE "Lab2"."UCalgaryNeighbor" AS(SELECT cc.geom3776
FROM "Lab2"."CalgaryCommunities" as cc,"Lab2"."UCalgary" as uc
where ST_touches(uc.geom3776,cc.geom3776))

--Q7：
CREATE TABLE "Lab2"."CalgaryNatureWhole" AS (SELECT ST_union(cn.geom3776)
FROM "Lab2"."CalgaryNature" as cn)

CREATE TABLE "Lab2"."CalgaryCommunitesW" AS (SELECT geom3776
FROM "Lab2"."CalgaryCommunities"
WHERE sector = 'WEST' )

CREATE TABLE "Lab2"."CalgaryWnoNature" AS (SELECT ccw.geom3776
FROM "Lab2"."CalgaryCommunitiesW" as ccw,"Lab2"."CalgaryNatureWhole" as cnw
WHERE ST_Disjoint(cnw.st_union,ccw.geom3776))

--Q8：
CREATE TABLE "Lab2"."CalgaryRiverCross" AS (SELECT cc.geom3776
FROM "Lab2"."CalgaryCommunities" as cc,"Lab2"."CalgaryHydrology" as ch
WHERE ST_Crosses(ch.geom3776,cc.geom3776))

--Q9：
CREATE TABLE "Lab2"."CalgaryVARSITY" AS (SELECT geom3776
FROM "Lab2"."CalgaryCommunities"
WHERE name='VARSITY');

CREATE TABLE "Lab2"."CalgaryOverlapsVAR" AS (SELECT cn.geom3776
FROM "Lab2"."CalgaryVARSITY" as cv,"Lab2"."CalgaryNature" as cn
WHERE ST_overlaps(cn.geom3776,cv.geom3776))

--Q10：
SELECT ST_Relate(cc.geom3776, cn.geom3776)
FROM "Lab2"."CalgaryCommunities" as cc,"Lab2"."CalgaryNature" as cn
WHERE cn.asset_cd='SIL245' and cc.name='SILVER SPRINGS'