<cfscript>
	// General Properties
	setEnabled(false);
	setUniqueURLS(false);	
	//setAutoReload(false);
	
	// Base URL
	if( len(getSetting('AppMapping') ) lte 1){
		setBaseURL("http://#cgi.HTTP_HOST#/index.cfm");
	}
	else{
		setBaseURL("http://#cgi.HTTP_HOST#/#getSetting('AppMapping')#/index.cfm");
	}
	
	// Add Module Routing Here
	addModuleRoutes(pattern="/forgebox",module="forgebox");
	
	// Your Application Routes
	addRoute(pattern=":handler/:action?");
</cfscript>