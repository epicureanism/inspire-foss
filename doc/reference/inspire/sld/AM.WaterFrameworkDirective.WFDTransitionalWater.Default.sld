<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor version="1.1.0" xsi:schemaLocation="http://www.opengis.net/sld StyledLayerDescriptor.xsd" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:sld="http://www.opengis.net/sld" xmlns:se="http://www.opengis.net/se">          
<sld:NamedLayer>
    <se:Name>Am.WaterFrameworkDirective.WFDTransitionalWater</se:Name>
    <sld:UserStyle>
      <se:Name> AM.WaterFrameworkDirective.WFDTransitionalWater.Default</se:Name>
      <sld:IsDefault>1</sld:IsDefault>
      <se:FeatureTypeStyle version="1.1.0">
        <se:Description>
          <se:Title>WFD Transitional water default style</se:Title>
          <se:Abstract>For reporting purposes WFDTransitionalWater are portrayed by a solid gray-blue (#9999CC) polygon without border. Instances classified as artificial are filled with magenta (#CC0099) horizontal lines with stroke width of 2 pixels; if they are not artificial but heavilyModified will be filled with orange (#FF9900) vertical lines with stroke width of 2 pixels.</se:Abstract>
        </se:Description>
        <se:FeatureTypeName>WaterFrameworkDirective.WFDTransitionalWater</se:FeatureTypeName>
        <se:Rule>
           <ogc:Filter>
            <!--ARTIFICIAL transitional water-->
              <se:PropertyIsEqualTo>
                <ogc:PropertyName>artificial</ogc:PropertyName>
                <ogc:Literal>true</ogc:Literal>
              </se:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PolygonSymbolizer>
            <se:Geometry>
              <ogc:PropertyName>geometry</ogc:PropertyName>
            </se:Geometry>
            <se:Fill>
               <se:GraphicFill>
                 <se:Graphic>
                    <se:ExternalGraphic>
                      <OnlineResource xmlns:xlink="http://www.w3.org/1999/xlink"     xlink:type="simple" 
                        xlink:href="http://.../artificial2.png"/> 
                      <Format>image/png</Format> 
                    </ExternalGraphic> 
                    <se:Size>
			             <se:SvgParameter name="size">10</se:SvgParameter>
                    </se:Size>
                 </se:Graphic>
               </se:GraphicFill>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        <se:Rule>
           <ogc:Filter>
            <!--HEAVILYMODIFIED transitional water-->
             <ogc:and>
              </se:PropertyIsEqualTo>
              <se:PropertyIsEqualTo>
                <ogc:PropertyName>artificial</ogc:PropertyName>
                  <ogc:Literal>false</ogc:Literal>
              </se:PropertyIsEqualTo>
              <se:PropertyIsEqualTo>
                <ogc:PropertyName>heavilyModified</ogc:PropertyName>
                  <ogc:Literal>true</ogc:Literal>
              </se:PropertyIsEqualTo>
              </ogc:and>
          </ogc:Filter>
          <se:PolygonSymbolizer>
            <se:Geometry>
              <ogc:PropertyName>geometry</ogc:PropertyName>
            </se:Geometry>
            <se:Fill>
               <se:GraphicFill>
                 <se:Graphic>
                    <se:ExternalGraphic>
                      <OnlineResource xmlns:xlink="http://www.w3.org/1999/xlink"     xlink:type="simple" 
                        xlink:href="http://.../ heavilyModified2.png"/> 
                      <Format>image/png</Format> 
                    </ExternalGraphic> 
                    <se:Size>
			             <se:SvgParameter name="size">10</se:SvgParameter>
                    </se:Size>
                 </se:Graphic>
               </se:GraphicFill>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        <se:Rule>
           <ogc:Filter>
            <!--Not artificial neither heavilyModified transitional water-->
             <ogc:and>
              <se:PropertyIsEqualTo>
                <ogc:PropertyName>artificial</ogc:PropertyName>
                  <ogc:Literal>false</ogc:Literal>
              </se:PropertyIsEqualTo>
              <se:PropertyIsEqualTo>
                <ogc:PropertyName>heavilyModified</ogc:PropertyName>
                  <ogc:Literal>false</ogc:Literal>
              </se:PropertyIsEqualTo>
              </ogc:and>
          </ogc:Filter>
          <se:PolygonSymbolizer>
            <se:Geometry>
              <ogc:PropertyName>geometry</ogc:PropertyName>
            </se:Geometry>
            <se:Fill>
               <se:SvgParameter name="fill">#9999CC</se:SvgParameter>
            </se:Fill>
          </se:PolygonSymbolizer>
        </se:Rule>
        <se:Rule>
      </se:FeatureTypeStyle>
    </sld:UserStyle>
  </sld:NamedLayer>
</StyledLayerDescriptor>
