<cfoutput>
<table class="tbl">
<colgroup>
    <col width="150">
    <col width="390">
</colgroup>

        
<cfform action="#action("update")#" method="post">



<!--- Memory Monitor --->
<cfloop index="monitorName" list="#req.monitorNames#">
<cfif StructKeyExists(req,'has'&monitorName) and req['has'&monitorName]>
    <input type="hidden" name="#monitorName#_name" value="#req[monitorName].name#" />
    <input type="hidden" name="#monitorName#_type" value="#req[monitorName].type#" />
    <input type="hidden" name="#monitorName#_class" value="#req[monitorName].class#" />
<cfif not StructKeyExists(req,'disable'&monitorName) or req['disable'&monitorName]>
	<input type="hidden" name="#monitorName#_enabled" value="false"/>
<cfelse>
<tr>
	<td class="tblHead" width="150">#lang[monitorName & "Label"]#</td>
	<td class="tblContent">
    	<input type="checkbox" name="#monitorName#_enabled" value="true" <cfif req[monitorName].logEnabled>checked="checked"</cfif> /> #lang.enabled#<br />
		<span class="comment">#lang[monitorName & "Desc"]#</span><br>
		
	</td>
</tr>
</cfif>
</cfif>
</cfloop>

<tr>
	<td colspan="2">
		<input class="submit" type="submit" class="submit" name="mainAction" value="#lang.btnUpdate#">
		<input class="submit" type="reset" class="reset" name="cancel" value="#lang.btnCancel#">
	</td>
</tr>

</cfform></cfoutput>
</table>

