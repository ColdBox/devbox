<cfset NOW_PH="----- now -----">

<cffunction name="formatDate" output="no">
	<cfargument name="req" type="struct" required="yes">
    <cfargument name="name" type="string" required="yes">
    <cfargument name="default" type="date" required="yes">
    <cfif StructKeyExists(req,name) and IsDate(req[name])>
    	<cfset var date=req[name]>
    <cfelse>
    	<cfset var date=default>
    </cfif>
    <cfif year(date) EQ 3000> <cfreturn NOW_PH></cfif>
    <cfreturn DateFormat(date,"yyyy-mm-dd") &" "& timeFormat(date,"HH:mm")>
    
    
</cffunction>


<cfif req.timerange LTE 60 and req.timetype EQ "last">
<cfset admin=createObject('component','railo-context.Admin')>

<cfajaxproxy 
    cfc = "#getMetaData(admin).fullname#" 
    jsclassname = "admin"> 
<cfoutput>

<script language="javascript">
var range=#int(req.timerange)#;
var show="#req.show#";
var maxrows=#int(req.maxrows)#;
var chartHeight=#int(req.chartHeight)#;


var type='#request.adminType#';
var pw='#JSStringFormat(encrypt(session["password"&request.adminType],getRailoId()[request.adminType].securityKey,'cfmx_compat','hex'))#';
var a = new admin();
a.setErrorHandler(function(error,code){});

refreshRate=5000;
if(range>5)  refreshRate=10000;
if(range>=15) refreshRate=20000;
if(range>=30) refreshRate=30000;
if(range>=60) refreshRate=60000;

function refresh() {
	//alert("refresh");
	var data=a.plugin({type:type,password:pw,plugin:'MonitorMemory',action:'jsreload',urlCollection:{range:range,show:show,maxrows:maxrows,chartHeight:chartHeight}});
	
	//images
	var images=data.images;
	for(var key in images) {
		var el=document.getElementById(key);
		if(el){
			el.src=images[key];
		}
	}
	
	// usage
	var usage=data.usage;
	//alert(usage.heap);
	//alert(usage);
	for(var _type in usage) {
		var el=document.getElementById(_type);
		if(el && el.innerHTML){
			el.innerHTML=usage[_type];
		}
	}
	
	
	
	setTimeout("refresh()",refreshRate);
}
setTimeout("refresh()",refreshRate);
function onAjayxError(e){
   //console.log;
}
</script>
</cfoutput>
</cfif>

<cfif not req.monitor.logEnabled>
	<cfoutput><br /><br /><br /><center><span class="CheckError">#lang.logDisabled#</span></center><br /><br /></cfoutput>
<cfelse>


<cfset surveillance=new Surveillance()>
<cfif req.timetype EQ "last">
	<cfset from=DateAdd("n",-req.timerange,now())>
	<cfset to=CreateDate(3000,1,1)>
<cfelse>
	<cfset from=req.timeFrom>
	<cfset to=req.timeTo>
</cfif>
<cfset images=surveillance.getMemoryCharts(from,to,req.show,req.maxrows,req.chartHeight)>
<cfset hasRecords=StructCount(images) GT 0>
<cfoutput>
<script language="javascript">
<cfinclude template="datetimepicker.cfm">
</script>
<script>
var HOUR=3600000;
function switchType(field) {
	var value=field[field.selectedIndex].value;
	var last=document.getElementById('div_last');
	var from_to=document.getElementById('div_from_to');
	
	if(value=='last') {
		for(var i=0;i<field.form.timerange.length;i++){
			if(field.form.timerange[i].value==60)
				field.form.timerange.selectedIndex=i;
		}
		last.style.display='';
		from_to.style.display='none';
	}
	else {
		
		var from=document.getElementById('timefrom');
		var to=document.getElementById('timeto');
		var now=new Date();
		to.value=formatDate(now);
		from.value=formatDate(new Date(now.getTime()-HOUR));
		
		
		last.style.display='none';
		from_to.style.display='';
		
	}
	setSubmitRed();
}


function setSubmitRed() {
	var submitTD=document.getElementById('submitTD');
	if(submitTD) submitTD.style.backgroundColor='##9c0000';
}

function formatDate(date) {
	// month
	var month=(date.getMonth()+1)+"";
	if(month.length==1)month="0"+month;
	
	// day
	var day=date.getDate()+"";
	if(day.length==1)day="0"+day;
	
	// hours
	var hours=date.getHours()+"";
	if(hours.length==1)hours="0"+hours;
	
	// minutes
	var minutes=date.getMinutes()+"";
	if(minutes.length==1)minutes="0"+minutes;
	
	
	
	return date.getFullYear()+"-"+month+"-"+day+" "+hours+":"+minutes;
}


</script>
<cfform action="#action('update')#" method="post">


<table class="tbl" width="590">
<colgroup>
    <col width="150">
    <col width="400">
    <col width="90">
</colgroup>
<tr>
	<td class="tblHead" height="45">
        <select name="timetype" onchange="switchType(this)">
			<option value="last" <cfif req.timetype EQ "last">selected</cfif>>#lang.the_last#</option>
			<option value="from_to" <cfif req.timetype EQ "from_to">selected</cfif>>#lang.from_to#</option>
		</select>
    </td>
	<td class="tblContent" valign="bottom">
		<!--- The last ... --->
		<div id="div_last" <cfif req.timetype NEQ "last">style="display:none;"</cfif>>
        <select name="timerange" id="timerange" onchange="setSubmitRed();">
			<cfloop query="req.ranges"><option <cfif req.timerange EQ req.ranges.value>selected</cfif> value="#req.ranges.value#">#req.ranges.label#</option></cfloop>
		</select>
        </div>
        
		<!--- From/To --->
		<div id="div_from_to" <cfif req.timetype NEQ "from_to">style="display:none;"</cfif>>
        	<input type="Text" name="timefrom" id="timefrom" maxlength="20" size="20"  onchange="setSubmitRed();" onclick="NewCssCal('timefrom','yyyyMMdd','dropdown',true,'24',false)" value="#formatDate(req,'timefrom',DateAdd("h",-1,now()))#"/>
		- <input type="Text" name="timeto"  id="timeto" maxlength="20" size="20"  onchange="setSubmitRed();" onclick="NewCssCal('timeto','yyyyMMdd','dropdown',true,'24',false)" value="#formatDate(req,'timeto',now())#"/>
        	<!--- <input class="submit" type="button" value="now"  onclick="this.form.timeto.value='#NOW_PH#'"/>
            <img src="data:image/gif;base64,R0lGODlhEAAQAKIAAKVNSkpNpUpNSqWmpdbT1v///////wAAACH5BAEAAAYALAAAAAAQABAAAANEaLrcNjDKKUa4OExYM95DVRTEWJLmKKLseVZELMdADcSrOwK7OqQsXkEIm8lsN0IOqCssW8Cicar8Qa/P5kvA7Xq/ggQAOw==" border="0" />--->
        </div>
        <span class="comment">#lang.historyRangeDesc#</span>
	</td>
	<td class="tblHead" id="submitTD" align="center">
		<input class="submit" type="submit" class="submit" name="mainAction" value="#lang.btnUpdate#">
	</td>
</tr>
</table>

</cfform>


<cfif hasRecords>

<cfloop list="heap,non_heap" index="_name">
	<cfset usage=req.usage[_name]>
    <cfset total=querySlice(usage,usage.recordcount,1)>
    
	<cfset names[_name]=valueList(usage.name)>
<cfsavecontent variable="body" trim="true">

<!---
<tr>
	<td colspan="2" class="tblHead" width="100">
    <b>#lang[_name]# (last #req.sctRanges[req.timerange]#)</b>
	
	<cfif StructKeyExists(lang,req.keys[usage.name])><br /><span class="comment">#lang[req.keys[usage.name]]#</span></cfif>
    </td>
</tr> 
--->      
<tr>
	<td class="tblContent" width="550">
    <img id="#"total_"&_name#" 
    src="#images["total_"&_name]#" width="580" height="120"/>
    <cfmodule template="/railo-context/admin/img.cfm" src="tp.gif" height="4" width="1"/>
    
    
	<td class="tblContent" width="130">
        <b>#lang.currently#</b><br />
        <cfset m=byteFormatShort(total.max)>
        <cfset preference=right(m,2)>
        <!--- Max: #m#<br />--->
        <div id="#lcase(replace(_name,' ','_','all'))#_total">
        #total.text#
        </div>
        </td>
</tr>
<tr>
	<td colspan="2" class="tblHead" >
		<cfset showDetail=ListFindNoCase(req.showTypes,_name)>

<table class="tbl" width="100%">
	<tr>
    	<td style="background-color:white;padding-top:6px;padding-bottom:6px" class="tblContent"><a href="#action(showDetail?'removeShow':'addShow',"type=#_name#")#"><cfmodule template="/railo-context/admin/img.cfm" src="#showDetail?'minus':'plus'#.png" hspace="4" border="0"/></a>      
        #lang[_name& '_devided']#
    
    <cfif showDetail>
    	<br />
        <table class="tbl" width="100%" style="margin-left:16px">
	<cfloop query="usage">
	
     <cfif usage.name EQ "total" or (req.show NEQ "all" and !ListContainsNoCase(req.show,req.keys[usage.name]))>
     	<cfcontinue>
     </cfif>
	
    <tr>
        <td >
         <b>#usage.name#</b>
        
        <cfif StructKeyExists(lang,req.keys[usage.name])><br /><span class="comment">#lang[req.keys[usage.name]]#</span></cfif>
        
        <img id="#req.keys[usage.name]#" src="#images[req.keys[usage.name]]#" width="550" height="80"/>
        <cfmodule template="/railo-context/admin/img.cfm" src="tp.gif" height="4" width="1"/>
        
        <td width="130">
            <b>#lang.currently#</b><br />
            <cfset m=byteFormatShort(usage.max)>
            <cfset preference=right(m,2)>
            <!--- Max: #m#<br />--->
            <div id="#lcase(replace(_name,' ','_','all'))#_#lcase(replace(usage.name,' ','_','all'))#">
            #usage.text#
            </div>
            </td>
    </tr>  
</cfloop>
			</table> </cfif>
		</td>   
	</tr> 
        
	</table> 
	</td>
</tr>

</cfsavecontent>


<cfif len(body)>

<table class="tbl" width="740">
<tr>
	<td colspan="2"><h2>#lang[_name]#</h2>
#lang[_name& "_desc"]#</td>
</tr>
#body#
</table>
</cfif>
</cfloop>
<cfelse>
	<span class="CheckError">#lang.error_hasRecords#</span>

</cfif>



</cfoutput>
</cfif>