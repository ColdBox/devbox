<cfcomponent hint="I contain the main functions for the log Analyzer Installer plugin" extends="railo-context.admin.plugin.Plugin">
<!---
/*
 * Action.cfc, created by Paul Klinkenberg
 * The log analyzer plugin was originally written by Gert Franz
 * http://www.railodeveloper.com/post.cfm/railo-admin-log-analyzer (installer version)
 *
 * Date: 2010-12-02 20:12:00 +0100
 * Revision: 2.2.0
 *
 * Copyright (c) 2010 Paul Klinkenberg, railodeveloper.com
 * Licensed under the GPL license.
 *
 *    This program is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation, either version 3 of the License, or
 *    (at your option) any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 *    ALWAYS LEAVE THIS COPYRIGHT NOTICE IN PLACE!
 */
--->		
	<cffunction name="init" hint="this function will be called to initalize">
		<cfargument name="lang" type="struct">
		<cfargument name="app" type="struct">
	</cffunction>
	
	
	<cffunction name="overview" output="yes" hint="Shows">
		<cfargument name="lang" type="struct">
		<cfargument name="app" type="struct">
		<cfargument name="req" type="struct">
		<cfset arguments.req.installedlocationsFile = "installedlocations.log" />
		<!--- get all web contexts --->
		<cfadmin
			action="getContextes"
			type="server"
			password="#session.passwordserver#"
			returnVariable="arguments.req.qWebContexts">	
	</cffunction>
	

</cfcomponent>