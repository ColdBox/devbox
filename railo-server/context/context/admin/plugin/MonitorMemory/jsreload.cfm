<cfset surveillance=new Surveillance()>
<cfset from=DateAdd("n",-url.range,now())>
<cfset to=CreateDate(3000,1,1)>
<cfset request.return['images']=surveillance.getMemoryCharts(from,to,url.show,url.maxrows,url.chartHeight)>
<cfset request.return['usage']=req.usage>
