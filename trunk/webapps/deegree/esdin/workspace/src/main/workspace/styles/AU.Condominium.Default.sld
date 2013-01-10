<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor version="1.1.0" xsi:schemaLocation="http://www.opengis.net/sld StyledLayerDescriptor.xsd" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:sld="http://www.opengis.net/sld" xmlns:se="http://www.opengis.net/se">
  <sld:NamedLayer>
    <se:Name>AU.Condominium</se:Name>
    <sld:UserStyle>
      <se:Name> AU.Condominium.Default</se:Name>
      <sld:IsDefault>1</sld:IsDefault>
      <se:FeatureTypeStyle version="1.1.0">
        <se:Description>
          <se:Title> Condominium Default Style</se:Title>
          <se:Abstract>Condominiums are rendered using a violet (#FF99FF) fill.</se:Abstract>
        </se:Description>
        <se:FeatureTypeName>Condominium</se:FeatureTypeName>
        <se:Rule>
          <se:PolygonSymbolizer>
            <se:Geometry>
             <ogc:PropertyName>geometry</ogc:PropertyName>
            </se:Geometry>
            <se:Fill>
		<se:SvgParameter name="fill">#FF99FF</se:SvgParameter>
	    </se:Fill>
            <se:Stroke/>
          </se:PolygonSymbolizer>
        </se:Rule>
      </se:FeatureTypeStyle>
    </sld:UserStyle>
  </sld:NamedLayer>

</StyledLayerDescriptor>
