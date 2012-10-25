<cffunction name="copyDirectory" output="true" hint="Copies an entire source directory to a destination directory" returntype="void">
	<cfargument name="source" 		required="true" type="string">
	<cfargument name="destination" 	required="true" type="string">
	<cfargument name="nameconflict" required="true" default="overwrite">

	<cfset var contents = "" />

	<cfif not(directoryExists(arguments.destination))>
		<cfdirectory action="create" directory="#arguments.destination#">
	</cfif>

	<cfdirectory action="list" directory="#arguments.source#" name="contents">

	<cfloop query="contents">
		<cfif contents.type eq "file">
			<cffile action="copy" source="#arguments.source#/#name#" destination="#arguments.destination#/#name#" nameconflict="#arguments.nameConflict#">
		<cfelseif contents.type eq "dir">
			<cfset copyDirectory(arguments.source & "/" & name, arguments.destination & "/" & name, arguments.nameconflict) />
		</cfif>
	</cfloop>
</cffunction>
<cfscript>
	root = expandpath("/");
	dirAppName = replace( trim( lcase( form.appname ) ) , " ", "-", "all" );
	dirLocation = root & "/" & dirAppName;
	
	directoryCreate( dirLocation );
	
	switch( form.template ){
		case "advanced" : { templatePath = "Advanced"; break; }
		case "flex" : { templatePath = "FlexAirRemote"; break; }
		case "simple" : { templatePath = "Simple"; break; }
		case "supersimple" : { templatePath = "SuperSimple"; break; }
	}
	templatePath = root & "/" & "coldbox/ApplicationTemplates/" & templatePath;
	
	copyDirectory(source=templatePath, destination=dirLocation);
	
	if( structKeyExists( form, "create_eclipse") ){
		eclipseText = fileRead( root & '/assets/template/.project' );
		eclipseText = replacenocase( eclipseText, "@name@", form.appname );
		if( structKeyExists( form, "create_cfbuilder") ){
			eclipseText = replacenocase( eclipseText, "@nature@", "com.adobe.ide.coldfusion.projectNature" );
			fileCopy( root & "/assets/template/settings.xml", dirLocation & "/settings.xml" );
		}
		fileWrite( dirLocation & "/.eclipse", eclipseText );		
	}	
	location("/index.cfm?createdApp=#URLEncodedFormat( dirAppName )#");
</cfscript>