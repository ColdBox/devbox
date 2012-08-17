<!-----------------------------------------------------------------------
********************************************************************************
Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author     :	Sana Ullah, Curt Gratz
Date        :	Sept 23 2010
Description :
	This proxy is an inherited coldbox remote proxy used for enabling
	coldbox as a model framework.
----------------------------------------------------------------------->
<cfset exceptionBean = event.getValue("ExceptionBean") />

<h3>An Unhandled Exception Occurred</h3>

<cfoutput>
<table>
	<tr>
		<td colspan="2">An unhandled exception has occurred. Please look at the diagnostic information below:</td>
	</tr>
	<tr>
		<td valign="top"><strong>Type</strong></td>
		<td valign="top">#exceptionBean.getType()#</td>
	</tr>
	<tr>
		<td valign="top"><strong>Message</strong></td>
		<td valign="top">#exceptionBean.getMessage()#</td>
	</tr>
	<tr>
		<td valign="top"><strong>Detail</strong></td>
		<td valign="top">#exceptionBean.getDetail()#</td>
	</tr>
	<tr>
		<td valign="top"><strong>Extended Info</strong></td>
		<td valign="top">#exceptionBean.getExtendedInfo()#</td>
	</tr>
	<tr>
		<td valign="top"><strong>Message</strong></td>
		<td valign="top">#exceptionBean.getMessage()#</td>
	</tr>
	<tr>
		<td valign="top"><strong>Tag Context</strong></td>
		<td valign="top">
	       <cfset variables.tagCtxArr = exceptionBean.getTagContext() />
	       <cfloop index="i" from="1" to="#ArrayLen(variables.tagCtxArr)#">
	               <cfset variables.tagCtx = variables.tagCtxArr[i] />
	               #variables.tagCtx['template']# (#variables.tagCtx['line']#)<br>
	       </cfloop>
		</td>
	</tr>
	<tr>
		<td valign="top"><strong>Stack Trace</strong></td>
		<td valign="top">#exceptionBean.getStackTrace()#</td>
	</tr>
</table>
</cfoutput>
