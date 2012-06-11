<cfcomponent hint="MonitorSettings" extends="railo-context.admin.plugin.Plugin">
	
	<cffunction name="init"
		hint="this function will be called to initalize">
		<cfargument name="lang" type="struct">
		<cfargument name="app" type="struct">
		
		
	</cffunction>

	<cffunction name="overview" output="no">
		<cfargument name="lang" type="struct">
		<cfargument name="app" type="struct">
		<cfargument name="req" type="struct">
		
        <cfset req.monitorNames="MonitorMemory,MonitorRequest">
        
		<cfset req.hasMonitorMemory=false>
        <cftry>
         <cfadmin 
            action="getMonitor"
            type="#request.adminType#"
            password="#session["password"&request.adminType]#"
            monitorType="intervall"
            name="MonitorMemory"
            returnVariable="req.MonitorMemory">
         	<cfset req.hasMonitorMemory=true>
            <cfcatch></cfcatch>
         </cftry>
        
        <cfset req.hasMonitorRequest=false>
        <cftry>
         <cfadmin 
            action="getMonitor"
            type="#request.adminType#"
            password="#session["password"&request.adminType]#"
            monitorType="request"
            name="MonitorRequest"
            returnVariable="req.MonitorRequest">
            <cfset req.hasMonitorRequest=true>
            <cfcatch></cfcatch>
         </cftry>
		
        <cfset local.current=GetDirectoryFromPath(getCurrentTemplatePath())>
        <cfset current=GetDirectoryFromPath(mid(current,1,len(current)-1))>
        <cfdirectory directory="#current#" action="list" name="local.dir" recurse="no">
        <cfset local.list=valueList(dir.name)>
        <cfset req.disableMonitorMemory=ListFindNoCase(list,'MonitorMemory') EQ 0>
        <cfset req.disableMonitorRequest=ListFindNoCase(list,'MonitorRequestLog') EQ 0>
	</cffunction>
    
    <cffunction name="update" output="no">
		<cfargument name="lang" type="struct">
		<cfargument name="app" type="struct">
		<cfargument name="req" type="struct">
        
        
        <cfset var mm={}>
        <cfset var rm={}>
        <cfset var arr="">
        <cfset mm.enabled=false>
        <cfset rm.enabled=false>
        <cfloop collection="#form#" item="key">
        	<cfset arr=ListToArray(key,"_")>
            <cfif arrayLen(arr) EQ 2>
            	<cfif arr[1] EQ "MonitorMemory">
                	<cfset mm[arr[2]]=form[key]>
            	<cfelseif arr[1] EQ "MonitorRequest">
                	<cfset rm[arr[2]]=form[key]>
                </cfif>
            </cfif>
            
        </cfloop>
        
        <cfif StructKeyExists(mm,"name")>
        <cfadmin 
            action="updateMonitor"
            type="#request.adminType#"
            password="#session["password"&request.adminType]#"
            class="#mm.class#"
            name="#mm.name#"  
            monitorType="#mm.type#"
            logEnabled="#mm.enabled#">
        </cfif>
        <cfif StructKeyExists(rm,"name")>
        <cfadmin 
            action="updateMonitor"
            type="#request.adminType#"
            password="#session["password"&request.adminType]#"
            class="#rm.class#"
            name="#rm.name#"  
            monitorType="#rm.type#"
            logEnabled="#rm.enabled#">
        </cfif>
        
        
        <cfreturn "redirect:overview">
    </cffunction>
    
    
</cfcomponent>