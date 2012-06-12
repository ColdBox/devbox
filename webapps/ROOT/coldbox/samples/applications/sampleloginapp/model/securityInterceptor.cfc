<!-----------------------------------------------------------------------
********************************************************************************
Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author     :	Luis Majano
Date        :	9/28/2007
Description :
	A simple security interceptor

	extends="coldbox.system.interceptor" by default because the framework
	knows its an interceptor by convension.
----------------------------------------------------------------------->
<cfcomponent name="securityInterceptor"
			 hint="This is a simple security interceptor"
			 output="false">

<!------------------------------------------- CONSTRUCTOR ------------------------------------------->

	<cffunction name="Configure" access="public" returntype="void" hint="This is the configuration method for your interceptors" output="false" >
		<!--- Nothing --->

	</cffunction>

<!------------------------------------------- INTERCEPTION POINTS ------------------------------------------->

	<!--- Pre execution process --->
	<cffunction name="preProcess" access="public" returntype="void" hint="Executes before any event execution occurs" output="false" >
		<!--- ************************************************************* --->
		<cfargument name="event" required="true" type="any" hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		<!--- ************************************************************* --->
		<cfscript>
			var rc = Event.getCollection();
			var loggingIn = false;
			var oSession = getPlugin("SessionStorage");

			//Are we logging In
			if ( event.getCurrentEvent() eq "General.doLogin" )
				loggingIn = true;

			//Login Check
			if ( (not oSession.exists("loggedin") or not oSession.getVar("loggedin") ) and not loggingIn ){
				//Override the incoming event.
				Event.overrideEvent("General.Login");
				getPlugin("MessageBox").setMessage("warning", "Interceptor Says: Please log in first");
			}
		</cfscript>
	</cffunction>

</cfcomponent>