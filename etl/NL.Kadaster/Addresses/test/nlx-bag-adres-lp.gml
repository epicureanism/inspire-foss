SELECT na.identificatie,na.huisnummer,na.huisletter,na.huisnummertoevoeging,na.gerelateerdeopenbareruimte,na.postcode,na.gerelateerdewoonplaats,translate(to_char(na.begindatumtijdvakgeldigheid, 'YYYY-MM-DD HH24:MI:SS'),' ', 'T') as begindatumtijdvakgeldigheid,translate(to_char(na.einddatumtijdvakgeldigheid, 'YYYY-MM-DD HH24:MI:SS'), ' ', 'T') as einddatumtijdvakgeldigheid,ST_Force_2D(ST_Centroid(ao.geovlak)) FROM ligplaatsactueelbestaand as ao INNER JOIN nummeraanduidingactueelbestaand as na ON (ao.hoofdadres = na.identificatie)
<?xml version="1.0" encoding="utf-8" ?>
<ogr:FeatureCollection
     xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
     xsi:schemaLocation="http://ogr.maptools.org/ .xsd"
     xmlns:ogr="http://ogr.maptools.org/"
     xmlns:gml="http://www.opengis.net/gml">
  <ogr:featureMember>
    <ogr:adres gml:id="adres.0">
      <gml:boundedBy><gml:Envelope srsName="urn:ogc:def:crs:EPSG::4258"><gml:lowerCorner>53.321302097806445 6.849894966945724</gml:lowerCorner><gml:upperCorner>53.321302097806445 6.849894966945724</gml:upperCorner></gml:Envelope></gml:boundedBy>
      <ogr:geometryProperty><gml:Point srsName="urn:ogc:def:crs:EPSG::4258"><gml:pos>53.321302097806445 6.849894966945724</gml:pos></gml:Point></ogr:geometryProperty>
      <ogr:identificatie>3200000133986</ogr:identificatie>
      <ogr:huisnummer>5</ogr:huisnummer>
      <ogr:gerelateerdeopenbareruimte>855300000001319</ogr:gerelateerdeopenbareruimte>
      <ogr:postcode>9901AA</ogr:postcode>
      <ogr:begindatumtijdvakgeldigheid>2010-07-20T00:00:00</ogr:begindatumtijdvakgeldigheid>
    </ogr:adres>
  </ogr:featureMember>
</ogr:FeatureCollection>
