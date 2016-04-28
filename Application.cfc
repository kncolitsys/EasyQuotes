<cfcomponent>
<cfscript>
       this.name = "EasyQuotes";
       this.applicationTimeout = createTimeSpan(0,1,0,0);
       this.clientmanagement= "yes";
       this.loginstorage = "session";
       this.sessionmanagement = "yes";
       this.sessiontimeout = createTimeSpan(0,0,40,0);
       this.setClientCookies = "yes";
       this.scriptProtect = "all";
   </cfscript>
<cffunction  name="onApplicationStart" output="false">
  <cfset Application.configured = 1>
  <cfset Application.datetimeConfigured = TimeFormat(Now(), "hh:mm tt") & "  " & DateFormat(Now(), "mm.dd.yyyy")>
  <cfset Application.currentSessions = 0>
  <!--- Application Addresses --->
  <cfset setLocale("English (US)")>
  <!--- Set the session page encoding --->
  <cfset setencoding("URL", "utf-8")>
  <cfset setencoding("Form", "utf-8")>
  <cfcontent type="text/html; charset=utf-8">
  <cfreturn True>
</cffunction>
<cffunction  name="onSessionStart" returntype="void">
	<cfset session.email = "">
</cffunction>
<cffunction  name="onSessionEnd" returntype="void">
  <cfargument name="SessionScope" required="true">
  <cflogout>
</cffunction>

<cffunction name="screenformat" output="false" returntype="string"> 
		<cfargument name="s" type="string"> 
		<cfreturn replace(arguments.s,chr(13),"<br/>","all")> 
</cffunction>
    
<cffunction  name="onRequestStart">
  <cfargument name="requestname" required=true/>
  <cfset request.dsn = "quotes">
  <cfset request.user = "admin">
  <cfset request.pass = "">
  <cfif (Not IsDefined("request.siteURL")) OR IsDefined("URL.flush")>
    <cflock scope="request" timeout="#CreateTimeSpan(0,0,20,0)#">
      <cfset request.SiteURL = replace(GetDirectoryFromPath("http://"&cgi.server_name&cgi.path_info),"\","")>
      <cfset request.file_path = GetDirectoryFromPath(GetCurrentTemplatePath())>
    </cflock>
  </cfif>
  <cfset request.relativePath = "EasyQuotes/">
  <cfset request.componentsPath = #Replace(request.relativePath,"/",".",'All')#>
  <cfset request.cfcpath = "#request.componentsPath#com">
  <cfset request.year1 = DateFormat(now(),'yyyy')>
  <cfset request.nextyear = #request.year1#+1>
  <cfset request.defaultLink = "http://localhost/EasyQuotes/">
  <cfset request.absoluteDIR = "c:\inetpub\wwwroot\EasyQuotes\">
  <cfset request.startTimer = getTickCount()>
  <cftry>
    <CFSET SQL_Words="[ ;](insert +into.+values|drop +table|create +table)">
    <CFLOOP COLLECTION="#url#" ITEM="var">
      <CFIF IsSimpleValue(Evaluate(var)) AND REFindNoCase(SQL_Words, Evaluate(var)) NEQ 0>
        <CFTHROW TYPE="SQLAttack" MESSAGE="Invalid URL value passed.">
      </CFIF>
    </CFLOOP>
    <CFLOOP COLLECTION="#form#" ITEM="var">
      <CFIF IsSimpleValue(Evaluate(var)) AND REFindNoCase(SQL_Words, Evaluate(var)) NEQ 0>
        <CFTHROW TYPE="SQLAttack" MESSAGE="Invalid Form value passed.">
      </CFIF>
    </CFLOOP>
    <cfcatch type="any">
      <div align="center">
        <h3><cfoutput>#cfcatch.Detail#</cfoutput></h3>
      </div>
      <cfabort>
    </cfcatch>
  </cftry>
</cffunction>
<cffunction  name="onError" output="true">
  <cfargument name="exception" required=true/>
  <cfargument name="eventName" type="String" required=true/>
  <cfif (trim(arguments.eventName) IS NOT "onSessionEnd") AND (trim(arguments.eventName) IS NOT "onApplicationEnd")>
    <cflog file="#this.name#" type="error"
                text="Event name: #arguments.eventName#" >
    <cflog file="#this.name#" type="error"
                text="Message: #arguments.exception.message#">
    <cfoutput>
      <h2>An unexpected error occurred.</h2>
      <p>Please provide the following information to technical support:</p>
      <p>Error Event:#arguments.eventName#</p>
      <p>Error details:</p>
    </cfoutput>
    <cfdump var=#arguments.exception#>
    <cfelseif (arguments.eventName IS "onApplicationEnd")>
    <cflog file="#this.name#" type="Information"
            text="Application #this.name# Ended" >
  </cfif>
</cffunction>
</cfcomponent>
