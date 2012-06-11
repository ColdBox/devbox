<cfcomponent extends="railo-context.admin.plugin.Plugin">
	
	<cffunction name="init"
		hint="this function will be called to initalize">
		<cfargument name="lang" type="struct">
		<cfargument name="app" type="struct">
		
		
	</cffunction>

	<cffunction name="overview" output="no">
		<cfargument name="lang" type="struct">
		<cfargument name="app" type="struct">
		<cfargument name="req" type="struct">
		
		<!--- maxrows --->
        <cfparam name="session.memMaxrows" default="100" type="numeric">
        <cfif StructKeyExists(url,"maxrows")>
            <cfset session.memMaxrows=url.maxrows>
        </cfif>
        <cfset req.maxrows=session.memMaxrows>
        
        <!--- selectd timerange --->
        <cfparam name="session.timerange" default="60" type="numeric">
        <cfset req.timerange=session.timerange>
        <cfparam name="session.timetype" default="last" type="string">
        <cfset req.timetype=session.timetype>
        <cfif StructKeyExists(session,"timefrom")>
			<cfset req.timefrom=session.timefrom>
		</cfif>
        <cfif StructKeyExists(session,"timeto")>
			<cfset req.timeto=session.timeto>
		</cfif>
        
        
        
        <!--- memoryShow --->
        <cfparam name="session.memoryShow" default="" type="string">
        <cfset req.showTypes=session.memoryShow>
        
       	<!--- chartHeight ---> 
		<cfset req.chartHeight=120>
        
        
        <!--- all timeranges --->
        <cfset req.ranges=query(
			label:[lang.time5m,lang.time15m,lang.time30m,lang.time1h,lang.time2h,lang.time4h,lang.time12h,lang.time1d,lang.time2d,lang.time3d,lang.time4d,lang.time5d,lang.time6d,lang.time7d],
			value:[5,15,30,60,120,240,720,1440,2880,4320,5760,7200,8640,10080]
		)>
		<cfset req.sctRanges={}>
		<cfloop query="req.ranges">
			<cfset req.sctRanges[req.ranges.value]=req.ranges.label>
		</cfloop>
        
        <cfset initKeysAndTypes()>
        
        <cfset req.show=createShow()>
        
        
        <cfset req.keys=session.memoryKeys>
        <cfset req.types=session.memoryTypes>
        
        
        
        <!--- usage --->
        <cfset req.usage=getUsage(lang)>
        <cftry>
         <cfadmin 
            action="getMonitor"
            type="#request.adminType#"
            password="#session["password"&request.adminType]#"
            monitorType="intervall"
            name="MonitorMemory"
            returnVariable="req.monitor">>
        
            <cfcatch>
            	<cfreturn "redirect:error">
            </cfcatch>
         
         </cftry>
        
	</cffunction>
    
    
    
    

        
    
    
    
	<cffunction name="jsreload" output="no">
		<cfargument name="lang" type="struct">
		<cfargument name="app" type="struct">
		<cfargument name="req" type="struct">
		
		<!--- maxrows --->
        <cfparam name="session.memMaxrows" default="100" type="numeric">
        <cfif StructKeyExists(url,"maxrows")>
            <cfset session.memMaxrows=url.maxrows>
        </cfif>
        <cfset req.maxrows=session.memMaxrows>
        
        <!--- selectd timerange --->
        <cfparam name="session.timerange" default="60" type="numeric">
        <cfset req.timerange=session.timerange>
        <cfparam name="session.timetype" default="last" type="string">
        <cfset req.timetype=session.timetype>
        <cfif StructKeyExists(session,"timefrom")>
			<cfset req.timefrom=session.timefrom>
		</cfif>
        <cfif StructKeyExists(session,"timeto")>
			<cfset req.timeto=session.timeto>
		</cfif>
        
        <!--- memoryShow --->
        <cfparam name="session.memoryShow" default="" type="string">
        
        
       	<!--- chartHeight ---> 
		<cfset req.chartHeight=120>
        
        <cfset initKeysAndTypes()>
        <cfset req.show=createShow()>
        
        
        <!--- usage --->
        <cfset var _usage=getUsage(lang)>
        <cfset req.usage={}>
        <cfloop list="heap,non_heap" index="_name">
        	<cfset var qry=_usage[_name]>
        <cfloop query="qry">
        	<cfset req.usage[qry.key]=qry.text>
        </cfloop>
		</cfloop>
	        
    </cffunction>
    
	<cffunction name="update" output="no"
		hint="update note">
		<cfargument name="lang" type="struct">
		<cfargument name="app" type="struct">
		<cfargument name="req" type="struct">
		
        <!--- time --->
        <cfif StructKeyExists(form,"timerange")><cfset session.timerange=form.timerange></cfif>
        <cfif StructKeyExists(form,"timetype")><cfset session.timetype=form.timetype></cfif>
        
        <cfset var has=0>
		<cfif StructKeyExists(form,"timefrom")>
			<cftry>
        		<cfset session.timefrom=ParseDateTime(form.timefrom)>
                <cfset has++>
				<cfcatch>
                	<cfset session.timefrom=DateAdd("h",-1,now())>
                </cfcatch>
            </cftry>
		</cfif>
        <cfif StructKeyExists(form,"timeto")>
        	<cftry>
        		<cfset session.timeto=ParseDateTime(form.timeto)>
                
                <cfset has++>
				<cfcatch>
                	<cfif FindNoCase("now",form.timeto)>
                    	<cfset session.timeto=CreateDate(3000,1,1)>
                    <cfelse>
                		<cfset session.timeto=now()>
                    </cfif>
                </cfcatch>
            </cftry>
		</cfif>
        
        <!--- check from/to --->
        <cfif has EQ 2>
        	<!--- from bigger than to --->
			<cfif session.timefrom GT session.timeto>
            	<cfset var tmp=session.timefrom>
                <cfset session.timefrom=session.timeto>
                <cfset session.timeto=tmp>
            </cfif>
            <!--- from bigger than now() --->
			<cfif session.timefrom GTE now()>
            	<cfset session.timefrom=DateAdd("n",-60,now())>
            </cfif>
            <!--- range bigger than 7 days --->
			<cfif has EQ 2 and DateDiff("d",session.timefrom,session.timeto) GT 7 and DateDiff("d",session.timefrom,now()) GT 7>
                <cfif session.timeto GT now()>
                    <cfset session.timeFrom=DateAdd("d",-7,now())>
                <cfelse>
                    <cfset session.timeFrom=DateAdd("d",-7,session.timeto)>
                </cfif>
            </cfif>
        </cfif>
        
		<cfreturn "redirect:overview">
	</cffunction>
    
	<cffunction name="addShow" output="no"
		hint="update note">
		<cfargument name="lang" type="struct">
		<cfargument name="app" type="struct">
		<cfargument name="req" type="struct">
        <cfparam name="session.memoryShow" default="">
        <cfif StructKeyExists(url,"type")>
		    <cfif not ListFindNoCase(session.memoryShow,url.type)>
            	<cfset session.memoryShow=ListAppend(session.memoryShow,url.type)>
            </cfif>
		</cfif>
		<cfreturn "redirect:overview">
	</cffunction>
    
	<cffunction name="removeShow" output="no"
		hint="update note">
		<cfargument name="lang" type="struct">
		<cfargument name="app" type="struct">
		<cfargument name="req" type="struct">
		
        <cfparam name="session.memoryShow" default="">
        <cfif StructKeyExists(url,"type")>
            <cfset var pos=ListFindNoCase(session.memoryShow,type)>
			<cfif pos>
            	<cfset session.memoryShow=ListDeleteAt(session.memoryShow,pos)>
            </cfif>
		</cfif>
		<cfreturn "redirect:overview">
	</cffunction>



<cffunction name="initKeysAndTypes" output="no" access="private">
        <!--- define keys for memory labels --->
        <cfif not StructKeyExists(session,"memoryKeys") or not StructKeyExists(session,"memoryTypes")>
        	<cfset var usage=getMemoryUsage()>
            <cfloop query="usage">
            	<cfif FindNoCase("eden space",usage.name)>
                	<cfset session.memoryKeys[usage.name]="PAR_EDEN_SPACE">
                	<cfset session.memoryTypes["PAR_EDEN_SPACE"]=usage.type>
                <cfelseif FindNoCase("survivor space",usage.name)>
                	<cfset session.memoryKeys[usage.name]="PAR_SURVIVOR_SPACE">
                	<cfset session.memoryTypes["PAR_SURVIVOR_SPACE"]=usage.type>
                <cfelseif FindNoCase("perm gen",usage.name)>
                	<cfset session.memoryKeys[usage.name]="CMS_PERM_GEN">
                	<cfset session.memoryTypes["CMS_PERM_GEN"]=usage.type>
                <cfelseif FindNoCase("old gen",usage.name)>
                	<cfset session.memoryKeys[usage.name]="CMS_OLD_GEN">
                	<cfset session.memoryTypes["CMS_OLD_GEN"]=usage.type>
                <cfelseif FindNoCase("tenured gen",usage.name)>
                	<cfset session.memoryKeys[usage.name]="CMS_OLD_GEN">
                	<cfset session.memoryTypes["CMS_OLD_GEN"]=usage.type>
                <cfelseif FindNoCase("code cache",usage.name)>
                	<cfset session.memoryKeys[usage.name]="CODE_CACHE">
                	<cfset session.memoryTypes["CODE_CACHE"]=usage.type>
                </cfif>
            </cfloop>
        </cfif>
    </cffunction>
    
    <cffunction name="getUsage" output="no" access="private">
		<cfargument name="lang" type="struct">
		<cfset var req_usage={}>
        <cfset var usage="">
        <cfset var total={}>
        <cfset var tmp="">
        <cfset var row="">
        <cfloop list="heap,non_heap" index="_name">
        	<cfset usage=getMemoryUsage(_name)>
            
            <cfset tmp={max:0,init:0,used:0}>
            <cfloop query="usage">
            	<cfset tmp.init+=usage.init>
            	<cfset tmp.used+=usage.used>
            	<cfset tmp.max+=usage.max>
            	<cfset tmp.type=usage.type>
            </cfloop>
            <cfset row=QueryAddRow(usage)>
			<cfset QuerySetCell(usage,"max",tmp.max,row)>
			<cfset QuerySetCell(usage,"used",tmp.used,row)>
			<cfset QuerySetCell(usage,"init",tmp.init,row)>
			<cfset QuerySetCell(usage,"name","TOTAL",row)>
			<cfset QuerySetCell(usage,"type",usage.type,row)>
            
			
			<cfset queryAddColumn(usage,"percentUsed")>
            <cfset queryAddColumn(usage,"percentFree")>
            <cfset queryAddColumn(usage,"text")>
            <cfset queryAddColumn(usage,"key")>
            <cfloop query="usage">
                <cfset var _key=_name&"_"&lcase(replace(usage.name,' ','_','all'))>
                <cfset usage.key=_key>
                <cfset usage.percentUsed=int(100/usage.max*usage.used)>
                <cfset usage.percentFree=100-usage.percentUsed>
                
                <cfset var m=byteFormatShort(usage.max)>
        		<cfset var preference=right(m,2)>
				<cfoutput><cfsavecontent variable="local._text" trim="true">
#lang.free#: #byteFormatShort(usage.max-usage.used,preference)# (#usage.percentFree#%)<br />
#lang.used#: #byteFormatShort(usage.used,preference)# (#usage.percentUsed#%)
                </cfsavecontent></cfoutput>
            	<cfset usage.text=_text>
            </cfloop>
            
			<cfset req_usage[_name]=usage>
        </cfloop>
        
        
        
        
        
        
        <cfreturn req_usage>
    </cffunction>
    
    <cffunction name="createShow" output="no" access="private">
    
        <cfset var show="">
        <cfloop collection="#session.memoryTypes#" item="key">
        	<cfif ListFindNoCase(session.memoryShow,session.memoryTypes[key])>
            	<cfset show=ListAppend(show,key)>
            </cfif>
        </cfloop>
        <cfreturn show>
    </cffunction>
    
    
    <cfscript>
	function byteFormatShort(numeric raw, string preference='' ){
	if(raw EQ 0) return "0b";
    
	var b=raw;
    var rtn="";
   	var kb=int(b/1024);
    var mb=0;
    var gb=0;
    var tb=0;
    
    if(kb GT 0) {
    	b-=kb*1024;
        mb=int(kb/1024);
        if(mb GT 0){
        	kb-=mb*1024;
			gb=int(mb/1024);
            if(gb GT 0) {
                mb-=gb*1024;
				tb=int(gb/1024);
                if(tb GT 0) {
                    gb-=tb*1024;
                }
            }
        }
    }
	
	if(preference EQ "tb") return _byteFormatShort(tb,gb,"tb");
	if(preference EQ "gb") return _byteFormatShort(gb,mb,"gb");
	if(preference EQ "mb") return _byteFormatShort(mb,kb,"mb");
	if(preference EQ "kb") return _byteFormatShort(kb,b,"kb");
    
    if(tb) return _byteFormatShort(tb,gb,"tb");
	if(gb) return _byteFormatShort(gb,mb,"gb");
	if(mb) return _byteFormatShort(mb,kb,"mb");
	if(kb) return _byteFormatShort(kb,b,"kb");
	
    return b&"b ";
}

function _byteFormatShort(numeric left,numeric right,string suffix){
	var rtn=left&".";
	right=int(right/1024*1000)&"";
	while(stringlen(right) lt 3) right="0"&right;
	
	right=left(right,2);
	
	return rtn&right&suffix;
}
	</cfscript>
    
    
</cfcomponent>