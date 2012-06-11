<cfcomponent hint="MonitorSettings" extends="railo-context.admin.plugin.Plugin">
	
	<cffunction name="init"
		hint="this function will be called to initalize">
		<cfargument name="lang" type="struct">
		<cfargument name="app" type="struct">
		
		
	</cffunction>

	<cffunction name="overview" output="yes">
		<cfargument name="lang" type="struct">
		<cfargument name="app" type="struct">
		<cfargument name="req" type="struct">
        
        <cfadmin 
            action="getContexts"
            type="#request.adminType#"
            password="#session["password"&request.adminType]#"
            returnVariable="req.contexts">
		
        <cfset req.sctContext={}>
        <cfloop query="req.contexts">
        	<cfset req.sctContext[req.contexts.label]=req.contexts.path>
        </cfloop>
        
        
        <cfMonitorScope returnVariable="req.info" serverpassword="#session["password"&request.adminType]#">
        
        
        <!--- total scopes --->
        <cfset var qry=queryNew("name,label,count,size,percentCount,percentSize,labelSize")>
        <cfloop list="session,application,server" index="local.key">
        	<cfset QueryAddRow(qry)>
            <cfset local.total=getTotal(req.info[key])>
            <cfset QuerySetCell(qry,"name",key,qry.recordcount)>
            <cfset QuerySetCell(qry,"label",ucFirst(key),qry.recordcount)>
            <cfset QuerySetCell(qry,"count",total.count,qry.recordcount)>
            <cfset QuerySetCell(qry,"size",total.size,qry.recordcount)>
            <cfset QuerySetCell(qry,"labelSize",byteFormat(total.size),qry.recordcount)>
        </cfloop>
        <cfset var totalCount=evaluate(ValueList(qry.count,'+'))>
        <cfset var totalSize=evaluate(ValueList(qry.size,'+'))>
        <cfloop query="qry">
        	<cfset local.pro=toPrecent(totalCount,qry.count)>
        	<cfset QuerySetCell(qry,"percentCount",pro,qry.currentrow)>
        	<cfset local.pro=toPrecent(totalSize,qry.size)>
        	<cfset QuerySetCell(qry,"percentSize",pro,qry.currentrow)>
        </cfloop>
        <cfset req['totalScopes']=qry>
        
        <!------>
        <!--- total contextes --->
        <cfset local.scopes={}>
        <cfset local.totals={}>
        <cfset local.sct={}>
        <cfset total="">
        <cfset local.totalCount=0>
        <cfset local.totalSize=0>
        <cfloop collection="#req.info#" item="local.skey">
        	<cfset local.scp=req.info[skey]>
            <cfif isCountSizeStruct(scp)>
            	<!--- <cfset local.tmp=getTotal(scp)>
            	<cfset totalCount+=tmp.count>
              	<cfset totalSize+=tmp.size>
				<cfset totals[skey]=duplicate(tmp)>
            	<cfset scopes[skey]=duplicate(tmp)>
                <cfif structKeyExists(sct,name)>
					<cfset sct[name].count+=tmp.count>
                    <cfset sct[name].size+=tmp.size>
                <cfelse>
                    <cfset sct[name]=duplicate(tmp)>
                </cfif>--->
                
                
                
            <cfelseif isStruct(scp)>
            	<cfloop collection="#scp#" item="local.key">
                	<cfset local.name=key>
                    
					<cfset local.tmp=getTotal(scp[key])>
              		<cfset totalCount+=tmp.count>
              		<cfset totalSize+=tmp.size>
                	
					<cfif structKeyExists(totals,skey)>
						<cfset totals[skey].count+=tmp.count>
						<cfset totals[skey].size+=tmp.size>
                    <cfelse>
						<cfset totals[skey]=duplicate(tmp)>
                    </cfif>
					
					<cfif structKeyExists(sct,name)>
						<cfset sct[name].count+=tmp.count>
						<cfset sct[name].size+=tmp.size>
                    <cfelse>
						<cfset sct[name]=duplicate(tmp)>
                    </cfif>
                    
                    <cfif structKeyExists(scopes,skey) and structKeyExists(scopes[skey],key)>
						<cfset scopes[skey][key].count+=tmp.count>
						<cfset scopes[skey][key].size+=tmp.size>
                    <cfelse>
						<cfset  scopes[skey][key]=duplicate(tmp)>
                    </cfif>
                    
                    
                </cfloop>
            </cfif>
        </cfloop>
        
        
        
		<!--- total query --->
		<cfset local.qry=queryNew("label,name,count,appCount,sessCount,percentCount,size,appSize,sessSize,percentSize,labelSize")>
        <cfloop collection="#sct#" item="local.key">
        	<cfset local.count=sct[key].count>
            <cfset local.countSession=scopes.session[key].count>
            <cfset local.countApplication=scopes.application[key].count>
            <cfset local.size=sct[key].size>
            <cfset local.sizeSession=scopes.session[key].size>
            <cfset local.sizeApplication=scopes.application[key].size>
            
            
            <cfset local.preCount=toPrecent(totalCount,count)>
            <cfset local.preSize=toPrecent(totalSize,size)>
        
        	<cfset QueryAddRow(qry)>
            <cfset QuerySetCell(qry,"name",key,qry.recordcount)>
            <cfset QuerySetCell(qry,"label","label:"&ucFirst(key))>
            <!--- <cfset QuerySetCell(qry,"label",ucFirst(key)&" ( "&count&" / "&int(pro*100)&"% )",qry.recordcount)>--->
            <cfset QuerySetCell(qry,"count",count,qry.recordcount)>
            <cfset QuerySetCell(qry,"appCount",countApplication,qry.recordcount)>
            <cfset QuerySetCell(qry,"sessCount",countSession,qry.recordcount)>
        	<cfset QuerySetCell(qry,"percentCount",preCount,qry.recordcount)>
            <cfset QuerySetCell(qry,"size",size,qry.recordcount)>
            <cfset QuerySetCell(qry,"labelSize",byteFormat(size),qry.recordcount)>
            <cfset QuerySetCell(qry,"appSize",sizeApplication,qry.recordcount)>
            <cfset QuerySetCell(qry,"sessSize",sizeSession,qry.recordcount)>
        	<cfset QuerySetCell(qry,"percentSize",preSize,qry.recordcount)>
        </cfloop>
        <cfset querySort(qry,"size",'desc')>
        <cfset req['totalContextes']=qry>
        
        
		<!--- application query --->
        <cfloop list="application,session" index="local._scope">
			<cfset local.qry=queryNew("label,name,count,size,percentCount,percentSize,labelSize")>
            <cfset sct=scopes[_scope]>
            <cfloop collection="#sct#" item="local.key">
                <cfset local.count=sct[key].count>
                <cfset local.preCount=toPrecent(totals[_scope].count,count)>
                <cfset local.size=sct[key].size>
                <cfset local.preSize=toPrecent(totals[_scope].size,size)>
                <cfset QueryAddRow(qry)>
                <cfset QuerySetCell(qry,"label","label:"&ucFirst(key),qry.recordcount)>
                <!---<cfset QuerySetCell(qry,"label",ucFirst(key)&" ( "&count&" / "&int(pro*100)&"% )",qry.recordcount)>--->
                <cfset QuerySetCell(qry,"name",key,qry.recordcount)>
                <cfset QuerySetCell(qry,"count",count,qry.recordcount)>
                <cfset QuerySetCell(qry,"percentCount",preCount,qry.recordcount)>
                <cfset QuerySetCell(qry,"size",size,qry.recordcount)>
                <cfset QuerySetCell(qry,"labelSize",byteFormat(size),qry.recordcount)>
                <cfset QuerySetCell(qry,"percentSize",preSize,qry.recordcount)>
            </cfloop>
            <cfset querySort(qry,"size",'desc')>
            <cfset req[_scope&'Contextes']=qry>
        </cfloop>
        
        
        <cfset req.cfc=this>
        
	</cffunction>
    
    
    <cffunction name="getTotal" access="private" returntype="struct">
		<cfargument name="data" type="any" required="yes">
		<cfset local.sct={count:0,size:0}>
        <cfset _getTotal(sct,data)>
        <cfreturn sct>
	</cffunction>
    
    <cffunction name="_getTotal" access="private" returntype="void">
		<cfargument name="rtn" type="struct" required="yes">
		<cfargument name="data" type="any" required="yes">
		<cfif IsNumeric(data)>
        	<cfset rtn.count+=data>
            <cfset rtn.size+=0>
            <cfreturn>
        <cfelseif isCountSizeStruct(data)>
			<cfset rtn.count+=data.count>
            <cfset rtn.size+=data.size>
            <cfreturn>
		</cfif>
        
        
        <cfloop collection="#data#" item="local.key">
        	<cfset _getTotal(rtn,data[key])>
        </cfloop>
        <cfreturn>
	</cffunction>
    
    
    <cffunction name="isCountSizeStruct" access="private" returntype="boolean">
		<cfargument name="data" type="any" required="yes">
		
        <cfif IsStruct(data) and StructCount(data) EQ 2>
			<cfset var names=StructKeyArray(data)>
            <cfif arrayFindNoCase(names,"count") and arrayFindNoCase(names,"size") and IsSimpleValue(data.count) and IsSimpleValue(data.size)>
				<cfreturn true>
            </cfif>
		</cfif>
        <cfreturn false>
	</cffunction>
    
    
	<cffunction name="detail" output="yes">
		<cfargument name="lang" type="struct">
		<cfargument name="app" type="struct">
		<cfargument name="req" type="struct">
        
        <cfset systemOutput('dasdd',true,true)>
        
		<cfset request.return['test']=url.webContext&":"&url.scopeName&":"&url.appContext>
    
    </cffunction>
    
    <!--- <cffunction name="getTotal2" access="private" returntype="numeric">
		<cfargument name="data" type="any" required="yes">
		<cfif IsNumeric(data)>
        	<cfreturn data>
        <cfelseif StructCount(data) EQ 2>
			<cfset var names=StructKeyArray(data)>
            <cfif arrayFindNoCase(names,"count") and arrayFindNoCase(names,"size") and IsSimpleValue(data.count) and IsSimpleValue(data.size)>
            	<cfreturn {count:data.count,size:data.size}>
            </cfif>
		</cfif>
        
        
        <cfset local.total=0>
        <cfloop collection="#data#" item="local.key">
        	<cfset total+=getTotal(data[key])>
        </cfloop>
        <cfreturn total>
	</cffunction>--->
    
    
     <cffunction name="toPrecent" access="private">
        <cfargument name="total" type="numeric" required="yes">
        <cfargument name="part" type="numeric" required="yes">
        <cfif total EQ 0>
            <cfreturn 0>
        <cfelseif total LT part>
            <cfreturn 1>
        </cfif>
        
        <cfreturn decimalFormat(1/total*part)>
     </cffunction>
     
     <cffunction name="byteFormat" output="no">
        <cfargument name="raw" type="numeric">
        <cfif raw EQ 0><cfreturn 0></cfif>
        <cfset var b=raw>
        <cfset var rtn="">
        <cfset var kb=b/1024>
        <cfset var mb=kb/1024>
        <cfset var gb=mb/1024>
        <cfset var tb=gb/1024>
        
        <cfif tb GTE 1><cfreturn numberFormat(tb,'0.000')&"tb"></cfif>
        <cfif gb GTE 1><cfreturn numberFormat(gb,'0.000')&"gb"></cfif>
        <cfif mb GTE 1><cfreturn numberFormat(mb,'0.000')&"mb"></cfif>
        <cfif kb GTE 1><cfreturn numberFormat(kb,'0.000')&"kb"></cfif>
        <cfreturn b&"b ">
        
        
        
    </cffunction>
 
</cfcomponent>