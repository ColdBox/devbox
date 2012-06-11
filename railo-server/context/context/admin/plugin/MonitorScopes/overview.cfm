<cfparam name="url.totalscopes" default="">
<cfparam name="url.totalContextes" default="">
 <cfparam name="url.contextName" default="">
 <cfparam name="url.scopeName" default="">
 
 <cfset request.req=req>
 <cffunction name="toQueryData"> 
 	<cfargument name="sct" type="struct" required="yes">
    <cfset var qry=queryNew("label,name,size,count,percentSize,percentCount,labelSize")>
    <cfloop collection="#sct#" item="key">
    	<cfset QueryAddRow(qry)>
        <cfset local.k=key>
        <cfif len(trim(k)) EQ 0><cfset k="&lt;empty-string&gt;"></cfif>
        <cfset QuerySetCell(qry,"label",k,qry.recordcount)>
        <cfset QuerySetCell(qry,"name",key,qry.recordcount)>
        <cfset QuerySetCell(qry,"count",sct[key].count,qry.recordcount)>
        <cfset QuerySetCell(qry,"size",sct[key].size,qry.recordcount)>
        <cfset QuerySetCell(qry,"labelSize",request.req.cfc.byteFormat(sct[key].size),qry.recordcount)>
    </cfloop>
    <cfset local.totalCount=evaluate(ValueList(qry.count,'+'))>
    <cfset local.totalSize=evaluate(ValueList(qry.size,'+'))>
    <cfloop query="qry">
    	<cfset QuerySetCell(qry,"percentSize",toPrecent(totalSize,qry.size),qry.currentrow)>
    	<cfset QuerySetCell(qry,"percentCount",toPrecent(totalCount,qry.count),qry.currentrow)>
    </cfloop>
    <cfset querySort(qry,'size','desc')>
    <cfreturn qry>
 </cffunction>
 
 <cffunction name="toPrecent">
 	<cfargument name="total" type="numeric" required="yes">
 	<cfargument name="part" type="numeric" required="yes">
    <cfif total EQ 0>
    	<cfreturn 0>
    <cfelseif total LT part>
    	<cfreturn 1>
    </cfif>
    
 	<cfreturn decimalFormat(1/total*part)>
 </cffunction>
 
 
 <cffunction name="getColor"> 
 	<cfargument name="list" type="string" required="yes">
 	<cfargument name="index" type="numeric" required="yes">
 	<cfargument name="defaultColor" type="string" required="no"  default="white">
    <cfif ListLen(list) LT index>
    	<cfreturn defaultColor>
    </cfif>
    <cfreturn ListGetAt(list,index)>
 </cffunction>
 
 <cffunction name="_listLast"> 
 	<cfargument name="list" type="string" required="yes">
 	<cfargument name="max" type="numeric" required="yes">
    <cfset local._len=ListLen(list)>
    <cfif _len LTE max>
    	<cfreturn list>
    </cfif>
   	
    <cfset local.arr=ListToArray(list)>
    <cfset local.rtn="">
    <cfloop from="#_len-max#" to="#_len#" index="i">
    	<cfset rtn=ListAppend(rtn,arr[i])>
    </cfloop>
    
    <cfreturn rtn>
 </cffunction>
 
 
 
 <cffunction name="top"> 
 	<cfargument name="qry" type="query" required="yes">
 	<cfargument name="count" type="numeric" required="yes">
    
    <!--- remove all with 0% --->
    <cfloop query="qry">
    	<cfif qry.percentSize EQ 0>
        	<cfset qry=querySlice(qry,1,qry.currentrow-1)>
            <cfbreak>
        </cfif>
    </cfloop>
    
    <cfif qry.recordcount LTE count>
    	<cfreturn qry>
    </cfif>
    
    <cfset var top=querySlice(qry,1,count)>
    <cfset var other=querySlice(qry,count,qry.recordcount-count+1)>
    <cfset top.label[5]="Other">
    <cfset top.name[5]="other">
    <cfset top.value[5]=evaluate(valueList(other.value,'+'))>
    <cfset top.percentSize[5]=evaluate(valueList(other.percentSize,'+'))>
    
    
    <cfreturn top>
 </cffunction>
 
 <cffunction name="getDetail" output="yes">
 	<cfargument name="req" type="struct" required="yes">
 	<cfargument name="lang" type="struct" required="yes">
 	<cfargument name="scopeName" type="string" required="yes">
 	<cfargument name="contextName" type="string" required="yes">
 	
	<cfif scopeName EQ "application">
	
	<cfset var context=req.info[scopeName][contextName]>
    <cfset var qryContext=toQueryData(context)>
 
 	<table class="tbl" width="100%">
    <tr>
        <td class="tblHead" valign="top" width="200" colspan="2"><b>#lang.appName#</b><br /><span class="comment">#lang.appNameDesc#</span></td>
        <td class="tblHead" valign="top" width="140"><b>#lang.percentage#</b><br /><span class="comment">#replace(lang.percentageDesc,"{scope}",scopeName)#</span></td>
        <td class="tblHead" valign="top" width="140"><b>#lang.size#</b><br /><span class="comment">#replace(lang.sizeDesc,"{scope}",scopeName)#</span></td>
        <td class="tblHead" valign="top" width="140"><b>#lang.count#</b><br /><span class="comment">#replace(lang.countDesc,"{scope}",scopeName)#</span></td>
    </tr>
    
    
    
    <cfset var totalSize=0>
    <cfset var totalCount=0>
    <cfset var isFirst=true>
    <cfloop query="qryContext">
    <tr>
        <td colspan="2" class="tblContent" <cfif len(qryContext.label) GT 20>title="#qryContext.label#"</cfif>>
		<a href="javascript:loadDetail('#contextName#','#scopeName#','#qryContext.name#');"><cfif len(qryContext.label) GT 35>#left(qryContext.label,35)#...<cfelseif len(qryContext.label) EQ 0>&lt;empty-string&gt;<cfelse>#qryContext.label#</cfif></a></td>
        <td class="tblContent">#int(qryContext.percentSize*100)#%</td>
        <td class="tblContent" align="right">#qryContext.labelSize#</td>
        <td class="tblContent" align="right">#qryContext.count#</td>
    </tr>
    <cfset totalSize+=qryContext.size>
    <cfset totalCount+=qryContext.count>
    <cfset isFirst=false>
    </cfloop>
    <cfset var scopeCount=qryContext.recordcount>
    <!--- <cfset var totalScopes+=scopeCount>--->
    <tr>
        <td class="tblHead" colspan="4"><table width="100%" cellpadding="0" cellspacing="0"><tr><td><b>#lang.total#</b></td><td align="right"><b>#req.cfc.byteFormat(totalSize)#</b></td></tr></table></td>
        <td class="tblHead" align="right"><b>#totalCount#</b></td>
    </tr>
    </table>

 	<cfelse>
 
	<cfset var context=req.info[scopeName][contextName]>
    <cfset var scpTotalAll=0>
	<cfset var names=0>
                                        



	<table class="tbl" width="100%">
    <tr>
        <td class="tblHead" valign="top"><b>#lang.appName#</b><br /><span class="comment">#lang.appNameDesc#</span></td>
        <td class="tblHead" valign="top"><b>#lang.scopes#</b><br /><span class="comment">#lang.scopesDesc#</span></td>
        <td class="tblHead" valign="top" width="140"><b>#lang.percentage#</b><br /><span class="comment">#replace(lang.percentageDesc,"{scope}",scopeName)#</span></td>
        <td class="tblHead" valign="top" width="140"><b>#lang.size#</b><br /><span class="comment">#replace(lang.sizeDesc,"{scope}",scopeName)#</span></td>
        <td class="tblHead" valign="top"><b>#lang.counts#</b><br /><span class="comment">#replace(lang.countsDesc,"{scope}","application")#</span></td>
    </tr>
    
    <cfset var totalSize=0>
    <cfset var totalCount=0>
    <cfset var scpTotal=0>
    <cfset var isFirst=true>
    
    <cfset csSize={}>
    <cfset csCount={}>
    <cfloop collection="#context#" item="key">
    	<cfset var scopes=StructCount(context[key])>
		<cfif scopes>
            <cfset s=0>
            <cfset c=0>
            <cfloop collection="#context[key]#" item="k">
                <cfset s+=context[key][k].size>
                <cfset c+=context[key][k].count>
            </cfloop>
        <cfelse>
            <cfset c=0>
        </cfif>
        <cfset csCount[key]=c>
        <cfset csSize[key]=s>
        <cfset totalSize+=s>
        <cfset totalCount+=c>
    </cfloop>
    
    <cfloop collection="#context#" item="key">
    
    <cfset scopes=StructCount(context[key])>
    <cfset scpTotal+=scopes>
    <cfset scpTotalAll+=scopes>
    <tr>
        <td class="tblContent" <cfif len(key) GT 20>title="#key#"</cfif>>
		<a href="javascript:loadDetail('#contextName#','#scopeName#','#key#');"><cfif len(key) GT 20>#left(key,20)#...<cfelse>#key#</cfif></a></td>
        <td class="tblContent" align="right">#scopes#</td>
        <td class="tblContent" align="right">#int(100/totalSize*csSize[key])#%</td>
        <td class="tblContent" align="right">#req.cfc.byteFormat(csSize[key])#</td>
        <td class="tblContent" align="right">#csCount[key]#</td>
    </tr>
    
    <cfset isFirst=false>
    </cfloop>
    <cfset tmp=structCount(context)>
    <cfset names+=tmp>
    <tr>
        <td class="tblHead" align="right" colspan="2"><table cellpadding="0" cellspacing="0" width="100%"><tr><td><b>#lang.total#</b></td><td align="right"><b>#scpTotal#</b></td></tr></table></td>
        <td class="tblHead" align="right" colspan="2"><b>#req.cfc.byteFormat(totalSize)#</b></td>
        <td class="tblHead" align="right" colspan="1"><b>#totalCount#</b></td>
    </tr>
    </table>
 	</cfif>
 
 </cffunction>
 
 
    
<cfoutput>

<cfset qry=query(label:["Aaa","Bbb"],item:["a","b"],value:[1,1])>

<cfset colors.context.session="##33ffff,##66ffff,##99ffff,##ccffff,##f2f2f2">
<cfset colorlist="##ffffcc,##ccffff,##ccffcc,##ffccff,##ccccff,##ffcccc,##ffcc99">
<cfset colorlist="##ffffcc,##ffffff,##ffff66,##ffccff,##ccccff,##ffcccc,##ffcc99">
<cfset colorlistScopes="##ccffcc,##ffffcc,##ffffff">
<cfset colors.context.session="##33ff33,##66ff66,##99ff99,##ccffcc">
<cfset colors.context.application="##ffff33,##ffff66,##ffff99,##ffffcc">
<cfset colorlistContexts="##ffcc99,##ffcccc,##ffccff,##ccccff,##f2f2f2">



<cfset admin=createObject('component','railo-context.Admin')>

<cfajaxproxy 
    cfc = "#getMetaData(admin).fullname#" 
    jsclassname = "admin"> 


<script language="javascript" src="http://www.javascripttoolbox.com/libsource.php/popup/combined/popup.js"></script>
<script language="javascript">

var type='#request.adminType#';
var pw='#JSStringFormat(encrypt(session["password"&request.adminType],getRailoId()[request.adminType].securityKey,'cfmx_compat','hex'))#';
var a = new admin();
a.setErrorHandler(function(error,code){});

function loadDetail(webContext,scopeName,appContext) {
	var data=a.plugin({type:type,password:pw,plugin:'MonitorScopes',action:'detail',urlCollection:{webContext:webContext,scopeName:scopeName,appContext:appContext}});
	
	
	Popup.show(null,null,null,{'content':data.content,
                                                'width':900,'height':500,
                                                'style':{'border':'1px solid black','backgroundColor':'white','padding':'4px'}});
	
	
}

</script>




<h2><a name="byType">#lang.byType#</a></h2>
#lang.byTypeDesc#
<table class="tbl" width="100%">
<!--- Scopes Graph --->
<tr>
	<td class="tblContent" valign="top">
    <cfchart showTooltip="#false#"  showlegend="no" 
        format="png"  show3d="yes"  
        chartWidth="#600#" chartHeight="#180#" labelFormat="percent" >  
        <cfchartseries type="pie" colorlist="#colorlistScopes#" query="req.totalScopes"   itemcolumn="label" valuecolumn="percentSize"></cfchartseries> 
    </cfchart> 
    </td>
</tr>
		
<!--- Scopes Data --->
<cfset qry=req.totalScopes>
<cfloop query="qry">
	<cfset showDetail=url.totalscopes EQ qry.name>
    <cfset color=ListGetAt(colorlistScopes,qry.currentrow)>
    <cfset scopeName=qry.name>

<tr>
	<td class="tblHead" valign="top"  style="background-color:#color#;"><a name="#scopename#"></a>
    	<table class="tbl" width="100%">
        

        <tr>
        	<td style="padding-top:6px;" width="10" valign="top">	
            	<cfif scopename NEQ "server">
                	<a name="e#scopename#" href="#action('overview',!showDetail?"totalscopes=#qry.name#":"totalscopes=none")####showDetail?'byType':scopename#"><cfmodule template="/railo-context/admin/img.cfm" src="#showDetail?'minus':'plus'#.png" hspace="4" border="0"/></a>
				<cfelse>
                	<cfmodule template="/railo-context/admin/img.cfm" src="tp.gif" width="18" height="1" border="0"/>
				</cfif>
            </td>
        	<td style="background-color:white;padding-top:6px;padding-bottom:6px" class="tblContent">
            	
            <h3 style="margin-bottom: 0px;padding-bottom: 0px;">#qry.label# Scope</h3>
            #lang.percentage#: #int(qry.percentSize*100)#%<br />
            #lang.size#: #qry.labelSize#<br />
            #lang.counts#: #qry.count# <!---(#int(qry.percentCount*100)#%)--->
            
			<cfif showDetail>
            	<!--- Application ---->
                <cfif qry.name EQ "application" or qry.name EQ "session">
                    <cfset totalScopes=0>
                   	<cfset appConQry=req[scopeName&"Contextes"]>
                    <cfif appConQry.recordcount GT 1>
                        <h3 style="margin-bottom: 0px;padding-bottom: 0px;">#lang.contextNames#</h3>
                        <table class="tbl" width="100%">
                        <tr>
                            <td class="tblContent">
                            <cfset top5=top(req[scopeName&"Contextes"],5)>
       
                            <cfset _colors=_listLast(colors.context[qry.name],top5.recordcount-1)&",##f2f2f2">
                            
                            
                             <cfchart showTooltip="#false#"  showlegend="no" 
                                format="png"  show3d="yes"  
                                chartWidth="#350#" chartHeight="#100#" labelFormat="percent" >  
                                <cfchartseries type="pie" colorlist="#_colors#" query="top5"   itemcolumn="label" valuecolumn="percentSize"></cfchartseries> 
                            </cfchart> 
                            
                            </td>
                        </tr>
                        
                        <!--- Contexts --->
                        <cfloop query="appConQry">
                        <cfset _color=appConQry.currentrow GT top5.recordcount?"":getColor(_colors,appConQry.currentrow)>
                        <cfset hashName=hash(appConQry.name)>
                        <cfset showContext=url.contextName EQ hashName>
                        <cfset ankerName=hash(scopeName&"_"&appConQry.name)>
                        <tr>
                            <td class="tblHead" style="background-color:#_color#" width="10"><a name="#ankerName#"></a>
                                <table class="tbl" width="100%">
                                <tr>
                                    <td style="padding-top:6px;" width="10" valign="top">	
                                       <cfif appConQry.size>
                                       <a  href="#action('overview',"totalscopes=#url.totalscopes#&contextName=#showContext?'':hashName####!showContext?ankerName:scopename#")#"><cfmodule template="/railo-context/admin/img.cfm" src="#showContext?'minus':'plus'#.png" hspace="4" border="0"/></a>
                                       <cfelse>
                                            <cfmodule template="/railo-context/admin/img.cfm" src="tp.gif" width="18" height="1" border="0"/>
                                        </cfif>
                                    </td>
                
                                    <td style="background-color:white;padding-top:6px;padding-bottom:6px" class="tblContent"><b>#lang.contextName# "#appConQry.name#"</b><br />
                                        #lang.percentage#: #int(appConQry.percentSize*100)#%<br />
                                        #lang.size#: #appConQry.labelSize#<br />
                                        #lang.counts#: #appConQry.count#<br />
                                        Webroot: #req.sctContext[appConQry.name]#
                            
                                        <!--- Context Detail --->
                                        <cfif showContext>
                                            <cfset getDetail(req,lang,scopeName,appConQry.name)>
                                        <!---<cfscript>   
                                        pc=getPageContext();
                                        factory = pc.getConfig().getFactory();
                                        sc = factory.getScopeContext();
                                        apps = sc.getAllApplicationScopes();
                                        sess=sc.getAllCFSessionScopes();
                                        writedump(sess);
                                            </cfscript>--->
                                        </cfif>
                            </td>
                                </tr>
                                </table>
                            </td>
                            
                        </tr>
                        </cfloop>
                        </table>
                    <cfelse>
                    	<cfset getDetail(req,lang,scopeName,appConQry.name)>
            		</cfif>
                </cfif>
            </cfif>
            
            
            
            
            
            </td>
        </tr>      
		</table>
    </td>
</tr>  
        </cfloop>
</table>



<cfif req.totalContextes.recordcount GT 1>
<h2><a name="byContext">#lang.byContext#</a></h2>
#lang.byContextDesc#
<table class="tbl" width="100%">
<!--- Graph Contextes --->
<tr>
	<td class="tblContent" valign="top">
    <cfset qry=req.totalContextes>
    <cfset top5=top(qry,5)>
    <cfset _colors=_listLast(colorlistContexts,top5.recordcount-1)&",##f2f2f2">
    <cfchart showTooltip="#false#"  showlegend="no" 
        format="png"  show3d="yes"  
        chartWidth="#600#" chartHeight="#180#" labelFormat="percent" >  
        <cfchartseries type="pie" colorlist="#colorlistContexts#" query="top5"   itemcolumn="label" valuecolumn="percentSize"></cfchartseries> 
    </cfchart> 
    </td>
</tr>


<!--- Data Contextes --->
<cfloop query="qry">
	<cfset showDetail=url.totalContextes EQ qry.name>
    <cfset color=qry.currentrow GT top5.recordcount?"":getColor(colorlistContexts,qry.currentrow,'##f2f2f2')>
                    
    <cfset contextName=qry.name>
    <cfset hashName=hash(contextName)>
	<cfset showDetail=url.totalContextes EQ hashName>
<tr>
	<td class="tblHead" valign="top"  style="background-color:#color#;"></a>
		<table class="tbl" width="100%">
        <tr>
        	<td style="padding-top:6px;" width="10" valign="top">	
            	<cfif qry.size><a href="#action('overview',!showDetail?"totalContextes=#hashName#":"totalContextes=none")####showDetail?'byContext':hashName#">
                	<cfmodule template="/railo-context/admin/img.cfm" src="#showDetail?'minus':'plus'#.png" hspace="4" border="0"/></a>
                <cfelse>
                	<cfmodule template="/railo-context/admin/img.cfm" src="tp.gif" width="18" height="1" border="0"/>
                </cfif>
            </td>
        	<td style="background-color:white;padding-top:6px;padding-bottom:6px" class="tblContent">
				<h3 style="margin-bottom: 0px;padding-bottom: 0px;">#qry.name# #lang.contextName#</h3>
            	#lang.percentage#: #int(qry.percentSize*100)#%<br />
            	#lang.size#: #qry.labelSize#<br />
            	#lang.counts#: #qry.count#<br />
            	Webroot: #req.sctContext[contextName]#
            	<cfif showDetail>
                	<h3 style="margin-bottom: 0px;padding-bottom: 0px;">#lang.scopeNames#</h3>
                	<cfset total=qry.sessSize+qry.appSize>
                	<cfset qryScopes=query(
						label:["Session","Application"],
						name:["session","application"],
						size:[qry.sessSize,qry.appSize],
						labelSize:[req.cfc.byteFormat(qry.sessSize),req.cfc.byteFormat(qry.appSize)],
						percentSize:[toPrecent(total,qry.sessSize),toPrecent(total,qry.appSize)],
						count:[qry.sessCount,qry.appCount],
						percentCount:[toPrecent(total,qry.sessCount),toPrecent(total,qry.appCount)]
						)>
                	
                	<table class="tbl" width="100%">
                	<tr>
                    	<td class="tblContent">                    
                         <cfchart showTooltip="#false#"  showlegend="no" 
                            format="png"  show3d="yes"  
                            chartWidth="#350#" chartHeight="#100#" labelFormat="percent" >  
                            <cfchartseries type="pie" colorlist="#colorlistScopes#" query="qryScopes"   itemcolumn="label" valuecolumn="percentSize"></cfchartseries> 
                        </cfchart> 
                    	</td>
                	</tr>
                	<cfset index=0>
                	<cfloop query="qryScopes">
                    	<cfset scopeName=qryScopes.name>
                		<cfset showScope=url.scopeName EQ variables.scopeName>
                    	<cfset ankerName=hash(contextName&":"&scopeName)>
                		<cfset _color=getColor(colorlistScopes,++index)>
                	<tr>
                        <td class="tblHead" style="background-color:#_color#" width="10"><a name="#ankerName#"></a>
                        	<table class="tbl" width="100%">
                            <tr>
                                <td style="padding-top:6px;" width="10" valign="top">	
                                   <a  href="#action('overview',"totalContextes=#url.totalContextes#&scopeName=#showScope?'none':scopeName####showScope?hashName:ankerName#")#"><cfmodule template="/railo-context/admin/img.cfm" src="#showScope?'minus':'plus'#.png" hspace="4" border="0"/></a>
                                </td>
        	
                            	<td style="background-color:white;padding-top:6px;padding-bottom:6px" class="tblContent">
                                	<h3 style="margin-bottom: 0px;padding-bottom: 0px;">#ucFirst(scopeName)# #lang.scopeName#</h3>
                                    #lang.percentage#: #int(qryScopes.percentSize*100)#%<br />
                        			#lang.size#: #qryScopes.labelSize#<br />
                                    #lang.counts#: #qryScopes.count#<br />
                                    <cfif showScope><cfset getDetail(req,lang,scopeName,contextName)></cfif>
                				</td>
                            </tr>
                            </table>
                        </td>
                    </tr>
                	</cfloop>
                	</table>
            	</cfif>
			</td>
        </tr>    
    	</table>
    </td>
</tr>
</cfloop>
</table>
</cfif>



</cfoutput>
