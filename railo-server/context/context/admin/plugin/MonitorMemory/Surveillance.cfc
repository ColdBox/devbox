<cfcomponent output="no">
	<cffunction name="getMemoryData" access="remote" returntype="query" output="no">
    	<cfargument name="from" type="date" required="yes">
    	<cfargument name="to" type="date" required="yes">
    	<cfargument name="show" type="string" required="yes">
    	<cfargument name="maxrows" type="numeric" required="no" default="200">
		
        <cfmonitormemory from="#arguments.from#" to="#arguments.to#" returnVariable="local.data" maxrows="#arguments.maxrows#" serverPassword="#session["password"&request.adminType]#">
        
		<cfif "all" NEQ show><cfloop list="#data.columnlist#" index="local.col"><cfif not ListFindNoCase("total_heap,total_non_heap,time,"&arguments.show,col)><cfset queryDeleteColumn(data,col)></cfif></cfloop></cfif>
		
		<cfreturn data>
    </cffunction>
    
    
    
    
    <cffunction name="getMemoryCharts" access="remote" returntype="struct" output="no">
        <cfargument name="from" type="date" required="yes">
    	<cfargument name="to" type="date" required="yes">
    	<cfargument name="show" type="string" required="yes">
    	<cfargument name="maxrows" type="numeric" required="no" default="200">
    	<cfargument name="chartHeight" type="numeric" required="no" default="90">
    	<cfargument name="chartWidth" type="numeric" required="no" default="550">
        <cfset local.data=getMemoryData(from,to,show,maxrows)>
        <cfif data.recordcount EQ 0>
        	<cfreturn {}>
		</cfif>
        <cfset local.images={}>
        <cfloop list="total_heap,total_non_heap,#show#" index="local.col">
        	<cfif FindNoCase("total",col)>
				<cfset chartHeight=120>
				<cfset chartWidth=580>
            <cfelse>
				<cfset chartHeight=80>
				<cfset chartWidth=550>
			
			</cfif>
        	<cfset images[col]=showMemoryChart(data,col,chartHeight,chartWidth)>
        </cfloop>
        <cfreturn images>

    </cffunction>
    
    
    <cffunction name="showMemoryChart" access="private" output="no">
        <cfargument name="qry" required="yes" type="query">
        <cfargument name="column" required="yes" type="string">
        <cfargument name="chartHeight" required="no" type="numeric" default="90">
        <cfargument name="chartWidth" required="no" type="numeric" default="550">
        <cfchart showTooltip="#false#" source="local.source"
            showlegend="no"    markersize="4" format="png"  show3d="no" scalefrom="-0.001" scaleto="1" showXGridlines=1 showxlabel="true" showmarkers="false"
            chartWidth="#chartWidth#" chartHeight="#chartHeight#" labelFormat="percent">  
            <cfchartseries type="timeline"  query="qry"  itemcolumn="Time" colorlist="##9c0000" valuecolumn="#column#" serieslabel="#column#"></cfchartseries> 
        </cfchart> 
        <cfreturn source>
    </cffunction>
    
    
</cfcomponent>