
        
<cfMonitorScope returnVariable="data" serverpassword="#session["password"&request.adminType]#"
	scopeName="#url.scopeName#" webContextName="#url.webContext#" appContextName="#url.appContext#">

<cfoutput>
<cfsavecontent variable="content">

<cfif url.scopeName EQ "session">
	<cfloop collection="#data#" item="key">
    	<b>CFID/CFTOKEN:#key#/0:</b><br />
        <cfdump var="#data[key]#">
    </cfloop>
<cfelse>
	<center><cfdump var="#data#"></center>
</cfif>
</cfsavecontent>
</cfoutput>
<cfset request.return['test']=url.webContext&":"&url.scopeName&":"&url.appContext>
<cfset request.return['content']=content>