
<cfoutput>
<form action="index.cfm" method="post">
<table border="1" cellspacing="0" cellpadding="1" bgcolor="##eaeaea" align="center" style="border-bottom:2px solid ##ddd;border-right:2px solid ##ddd; border-left:1px solid ##eaeaea; border-top: 1px solid ##eaeaea;background: ##f5f5f5">
	<tr valign="top" bgcolor="##dddddd">
	
		<td align="right" valign="top"><b>choose locale</b>:</td>
	
		<td>
		<select name="thisLocale" size="1">
		<cfloop index="i" from="1" to="#arrayLen(prc.locales)#">
			<option value="#prc.locales[i].toString()#" <cfif getPlugin("i18n").getfwLocale() eq prc.locales[i].toString()>selected</cfif>>#prc.locales[i].toString()#</option>
		</cfloop>
		</select>
		</td>
		
		<td align="right" valign="top"><b>time format:</b></td>
		<td>
		<select name="timeF" size="1">
		       <option value="0" <cfif prc.timeF eq 0>selected</cfif>>Long</option>
		       <option value="1" <cfif prc.timeF eq 1>selected</cfif>>Full</option>
		       <option value="2" <cfif prc.timeF eq 2>selected</cfif>>Medium</option>
		       <option value="3" <cfif prc.timeF eq 3>selected</cfif>>Short</option>
		</select>
		</td>
		
		<td align="right" valign="top"><b>date format:</b></td>
		
		<td>
		<select name="dateF" size="1">
		       <option value="0" <cfif prc.dateF eq 0>selected</cfif>>Long</option>
		       <option value="1" <cfif prc.dateF eq 1>selected</cfif>>Full</option>
		       <option value="2" <cfif prc.dateF eq 2>selected</cfif>>Medium</option>
		       <option value="3" <cfif prc.dateF eq 3>selected</cfif>>Short</option>
		</select>
		</td>
		
		<td align="center">&nbsp;&nbsp;<input type="submit" value="Change Locale">&nbsp;&nbsp;</td>
	
	</tr>
	</form>
	
	<tr valign="top">
	<td align="center" colspan="10" bgcolor="##fffff0">&nbsp;<b>Results</b>&nbsp;</td>
	</tr>
	<tr valign="top">
	<td align="right" valign="top"><b>Locale:</b></td>
	<td colspan="10" bgcolor="##b6e7ff">#rc.thisLocale#</td>
	</tr>
	<tr valign="top">
	<td align="right" valign="top"><b>isBidi:</b></td>
	<td colspan="10" bgcolor="##b6e7ff">#getPlugin("i18n").isBIDI()#</td>
	</tr>
	<tr valign="top">
	<td align="right" valign="top"><b>showLanguage:</b></td>
	<td colspan="10" bgcolor="##b6e7ff">#prc.lang#</td>
	</tr>
	<tr valign="top">
	<td align="right" valign="top"><b>showCountry:</b></td>
	<td colspan="10" bgcolor="##b6e7ff"><cfif len(trim(prc.country))>#prc.country#<cfelse>&nbsp;</cfif></td>
	</tr>
	<tr valign="top">
	<td align="right" valign="top"><b>server timezone:</b></td>
	<td colspan="10" bgcolor="##b6e7ff">#prc.serverTZ#</td>
	</tr>
	<tr valign="top">
	<td align="right" valign="top"><b>Timezone(s):</b></td>
	<td colspan="10" bgcolor="##b6e7ff">
	<select name="tz" size="1">
	<cfloop index="i" from="1" to="#arrayLen(prc.timezones)#">
	       <option value="#prc.timezones[i]#">#prc.timezones[i]#</option>
	</cfloop>
	</select>
	</td>
	</tr>
	<tr valign="top">
	<td align="right" valign="top"><b>using timezone:</b></td>
	<td colspan="10" bgcolor="##b6e7ff"> #prc.thisTZ# <font size="-1">(randomly chosen)</font></td>
	</tr>
	<tr valign="top">
	<td align="right" valign="top"><b>timezone offset:</b></td>
	<td colspan="10" bgcolor="##b6e7ff">#prc.tzOffset# hours</td>
	</tr>
	<tr valign="top">
	<td align="right" valign="top"><b>uses DST:</b></td>
	<td colspan="10" bgcolor="##b6e7ff">#prc.usesDST#</td>
	</tr>
	<cfif prc.usesDST>
	<tr valign="top">
	<td align="right" valign="top"><b>in DST:</b></td>
	<td colspan="10" bgcolor="##b6e7ff">#prc.inDST#</td>
	</tr>
	</cfif>
	<tr valign="top">
	<td align="right" valign="top"><b>i18nDateTimeFormat:</b></td>
	<td colspan="10" bgcolor="##b6e7ff">#getPlugin("i18n").i18nDateTimeFormat(prc.now,prc.dateF,prc.timeF,prc.thisTZ)#</td>
	</tr>
	<tr valign="top">
	<td align="right" valign="top"><b>i18nDateFormat:</b></td>
	<td colspan="10" bgcolor="##b6e7ff">#getPlugin("i18n").i18nDateFormat(prc.now,prc.dateF,prc.thisTZ)#</td>
	</tr>
	<tr valign="top">
	<td align="right" valign="top"><b>i18nTimeFormat:</b></td>
	<td colspan="10" bgcolor="##b6e7ff">#getPlugin("i18n").i18nTimeFormat(prc.now,prc.timeF,prc.thisTZ)#</td>
	</tr>
	<tr valign="top">
	<td align="right" valign="top"><b>i18nDateParse:</b></td>
	<td colspan="10" bgcolor="##b6e7ff">#getPlugin("i18n").i18nDateParse(prc.tDate)# (original date: #prc.tDate#)</td>
	</tr>
	<tr valign="top">
	<td align="right" valign="top"><b>i18nDateTimeParse:</b></td>
	<td colspan="10" bgcolor="##b6e7ff">#getPlugin("i18n").i18nDateTimeParse(prc.tDateTime)# (original datetime: #prc.tDateTime#)</td>
	</tr>
	<tr valign="top">
	<td align="right" valign="top"><b>getDateTimePattern:</b></td>
	<td colspan="10" bgcolor="##b6e7ff">#getPlugin("i18n").getDateTimePattern()#</td>
	</tr>
	<tr valign="top">
	<td align="right" valign="top"><b>formatDateTime:</b></td>
	<td colspan="10" bgcolor="##b6e7ff">#getPlugin("i18n").formatDateTime(prc.now,"d MMMM yyyy")# (using "d MMMM yyyy")</td>
	</tr>
	<tr valign="top">
	<td align="right" valign="top"><b>i18nDateDiff:</b></td>
	<td colspan="10" bgcolor="##b6e7ff">#getPlugin("i18n").i18nDateDiff(prc.now,prc.laterOn,"day",prc.thisTZ)# day(s) (#prc.laterOn# #prc.now#, randomly generated end date)</td>
	</tr>
	<tr valign="top">
	<td align="right" valign="top"><b>version:</b></td>
	<td colspan="10" bgcolor="##b6e7ff">
	I18NUtilVersion:=#prc.version.I18NUtilVersion#<br>
	I18NUtilDate:=#prc.version.I18NUtilDate#<br>
	Java version:=#prc.version.javaVersion#<br>
	JRE version:=#prc.version.javaRuntimeVersion#<br>
	</td>
	</tr>
</table>
</cfoutput>