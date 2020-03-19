(function(e){var d=e.seriesTypes,a=e.Chart.prototype,c=e.getOptions(),g=e.extend;g(c.lang,{noData:"No data to display"});c.noData={position:{x:0,y:0,align:"center",verticalAlign:"middle"},attr:{},style:{fontWeight:"bold",fontSize:"12px",color:"#60606a"}};function b(){return !!this.points.length}if(d.pie){d.pie.prototype.hasData=b}if(d.gauge){d.gauge.prototype.hasData=b}if(d.waterfall){d.waterfall.prototype.hasData=b}e.Series.prototype.hasData=function(){return this.dataMax!==undefined&&this.dataMin!==undefined};a.showNoData=function(l){var j=this,i=j.options,k=l||i.lang.noData,h=i.noData;if(!j.noDataLabel){j.noDataLabel=j.renderer.label(k,0,0,null,null,null,null,null,"no-data").attr(h.attr).css(h.style).add();j.noDataLabel.align(g(j.noDataLabel.getBBox(),h.position),false,"plotBox")}};a.hideNoData=function(){var h=this;if(h.noDataLabel){h.noDataLabel=h.noDataLabel.destroy()}};a.hasData=function(){var k=this,j=k.series,h=j.length;while(h--){if(j[h].hasData()&&!j[h].options.isInternal){return true}}return false};function f(){var h=this;if(h.hasData()){h.hideNoData()}else{h.showNoData()}}a.callbacks.push(function(h){e.addEvent(h,"load",f);e.addEvent(h,"redraw",f)})}(Highcharts));