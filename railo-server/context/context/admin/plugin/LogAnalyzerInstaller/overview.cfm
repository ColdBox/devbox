<!---
/*
 * overview.cfm, enhanced by Paul Klinkenberg
 * Originally written by Gert Franz
 * http://www.railodeveloper.com/post.cfm/railo-admin-log-analyzer
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
<!--- get the installed locations log --->
<cfset var sep = server.separator.file />
<cfset var installedLocations = {} />
<cfset var line = "" />
<cfif fileExists(arguments.req.installedlocationsFile)>
	<cfloop file="#arguments.req.installedlocationsFile#" index="line">
		<cfset installedLocations[trim(line)] = "" />
	</cfloop>
</cfif>

<!--- form submitted? --->
<cfif structKeyExists(form, "installDirs") and len(form.installDirs)>
	<cfloop list="#form.installDirs#" index="line">
		<cfzip action="unzip" file="#getdirectoryFromPath(GetCurrentTemplatePath())#Loganalyzer.zip"
			destination="#line#" overwrite="yes" storepath="no" />
		<cfset installedLocations[line] = "" />
	</cfloop>
	<!--- save new installation paths log--->
	<cffile action="write" file="#arguments.req.installedlocationsFile#" output="#structKeyList(installedLocations, chr(10))#" />
	<cfoutput><p class="checkOk">The Log analyzer is installed/updated in #listLen(form.installDirs)# locations.
		<br />You need to logout and login to the web admin again, before you can see the plugin in the navigation.
	</p></cfoutput>
</cfif>
<cfif structKeyExists(form, "UNinstallDirs") and len(form.UNinstallDirs)>
	<cfloop list="#form.UNinstallDirs#" index="line">
		<cftry>
			<cfdirectory action="delete" directory="#line#" recurse="yes" />
			<cfcatch>Error while deleting directory: #cfcatch.message# #cfcatch.Detail#<br /></cfcatch>
		</cftry>
		<cfset structDelete(installedLocations, line, false) />
	</cfloop>
	<!--- save new installation paths log--->
	<cffile action="write" file="#arguments.req.installedlocationsFile#" output="#structKeyList(installedLocations, chr(10))#" />
	<cfoutput><p class="checkOk">The Log analyzer has been uninstalled from #listLen(form.UNinstallDirs)# locations.
		<br />You need to logout and login again to remove the plugin from the navigation in the web admin.
	</p></cfoutput>
</cfif>

<script type="text/javascript">
	function checkemAll(_do, cls)
	{
		var els = document.getElementsByTagName("INPUT");
		for (var i=0; i<els.length; i++)
		{
			if (els[i].className == cls)
				els[i].checked = _do;
		}
	}
</script>
<cfset frmaction = rereplace(action('overview'), "^[[:space:]]+", "") />
<cfoutput>
	<p>Use the form underneath to install or update the <a href="http://www.railodeveloper.com/post.cfm/railo-admin-log-analyzer" target="_blank" title="More info; links opens new window">Log analyzer plugin</a> into your websites.</p>
	<form action="#frmaction#" method="post">
		<table class="tbl" width="650">
			<tr>
				<td class="tblHead" style="vertical-align:top">Install / update
					<cfif arguments.req.qWebContexts.recordcount>
						<br /><input type="checkbox" name="checkall" id="checkall" onclick="checkemAll(this.checked, 'chk')" />
					</cfif>
				</td>
				<td class="tblHead" style="vertical-align:top">Installed</td>
				<td class="tblHead" style="vertical-align:top">Uninstall
					<cfif arguments.req.qWebContexts.recordcount>
						<br /><input type="checkbox" name="checkall2" id="checkall2" onclick="checkemAll(this.checked, 'chk2')" />
					</cfif>
				</td>
				<td class="tblHead" style="vertical-align:top">Website path</td>
			</tr>
			<!--- make it possible to install the plugin in the server admin --->
			<cfset var installPath = "" />
			<cfadmin type="server" action="getPluginDirectory" password="#session.passwordserver#"
				returnVariable="installPath" />
			<cfset installPath = rereplace(installPath, '[/\\]$', '') & "#sep#Log analyzer#sep#" />
			<tr>
				<td class="tblContent"><input type="checkbox" name="installDirs" class="chk" value="#htmlEditFormat(installPath)#" /></td>
				<td class="tblContent"><cfif structKeyExists(installedLocations, installpath)><strong>YES</strong><cfelse><em>no</em></cfif></td>
				<td class="tblContent"><cfif structKeyExists(installedLocations, installpath)><input type="checkbox" name="UNinstallDirs" class="chk2" value="#htmlEditFormat(installPath)#" /><cfelse>&nbsp;</cfif></td>
				<td class="tblContent">SERVER CONTEXT: #expandPath("{railo-server}")#</td>
			</tr>
			<cfset var sep = server.separator.file />
			<cfset var q = arguments.req.qWebContexts />
			<cfloop query="q">
				<cfset var installPath = rereplace(q.config_file, "[^/\\]+$", "") & "context#sep#admin#sep#plugin#sep#Log analyzer#sep#" />
				<tr>
					<td class="tblContent"><input type="checkbox" name="installDirs" class="chk" value="#htmlEditFormat(installPath)#" /></td>
					<td class="tblContent"><cfif structKeyExists(installedLocations, installpath)><strong>YES</strong><cfelse><em>no</em></cfif></td>
					<td class="tblContent"><cfif structKeyExists(installedLocations, installpath)><input type="checkbox" name="UNinstallDirs" class="chk2" value="#htmlEditFormat(installPath)#" /><cfelse>&nbsp;</cfif></td>
					<td class="tblContent">#q.path#</td>
				</tr>
			</cfloop>
		</table>
		<input type="submit" class="button" value="Install/update" />
	</form>
</cfoutput>