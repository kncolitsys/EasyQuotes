<cfcomponent hint="It will handle the Quotes">
	<cffunction name="getQuotes" access="public" returntype="query">
		<cfset counts="">
        <cfset myResult="">
        <cfquery datasource="#request.dsn#" name="counts">
        Select count(*) as recCount from quote
        </cfquery>
        <cfset newrecord = #counts.recCount#>
        <cfset newrandom = Int((newrecord * Rand()))>
        <cfquery name="myResult" datasource="#request.dsn#">
        SELECT quote.ID, quote.quote AS fldQuote FROM quote 
        WHERE quote.ID = <cfqueryparam cfsqltype="cf_sql_numeric" value="#newrandom#">
        </cfquery>
		<cfreturn myResult>
	</cffunction>
</cfcomponent>