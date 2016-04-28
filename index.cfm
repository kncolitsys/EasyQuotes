<html>
<head>
<title>EasyQuotes!</title>
<meta name="keywords" content="EasyQuote!, Coldfusion, Application, CFML, Coldfusion Markup Language, Quote, Application">
<meta name="description" content="EasyQuote! is an easy to set up and easy to use Coldfusion Markup Language random quote generation application that makes it easy for webmasters to add random quote functionality their websites.">
<style type="text/css">
   body {
	   font-family:Verdana, Geneva, sans-serif;
	   font-size:9px;
	   color:#000000;
   }
   .border {
	   border:1px solid #000080;}
   a:link { color: "#000080"; }
   a:visited { color: "#000080"; }
   a:active { color: "#000080"; }
   a:hover { text-decoration: none; color: "#ff0000" }
</style>
</head>
<cfset tools = CreateObject("component","#request.cfcPath#.tools")>
<cfset randomquote = #tools.getQuotes()#>
<body bgcolor="#ffffff" text="#000080" link="#000080" vlink="#000080" alink="#000080">
<table align="center" border="0" cellPadding="2" cellSpacing="0" width="75%" class="border">
<tr>
	<td>
	<a href="http://www.randhawaworld.com" onMouseOver="window.status='Easy Quotes';return true;">
    	<img SRC="images/logo.png" BORDER="0" HSPACE="0" VSPACE="0" ALT="ClickQuote!" WIDTH="664" HEIGHT="114"></a>
	</td>
</tr>
<tr>
	<td>
	<hr noshade size="1" width="100%" color="#000080">
	</td>
</tr>
<tr>
	<td>
	&nbsp;<!--SPACER-->
	</td>
</tr>
<tr>
	<td>
		<cfform action="#cgi.SCRIPT_NAME#?#cgi.QUERY_STRING#" method="POST" id="form1" name="form1">
		<cfoutput>#randomquote.fldQuote#</cfoutput>
		<br><br>
		<input type="submit" value=" New Quote! " name="submit1">
		</cfform>
		</td>
	</tr>
<tr>
	<td>
	&nbsp;<!--SPACER-->
	</td>
</tr>
<tr>
	<td>
	<hr noshade size="1" width="100%" color="#000080">
	</td>
</tr>
<tr>
	<td align="right">
	<font face="Verdana, Arial, Helvetica, sans-serif" size="1" color="#c0c0c0">
	<br>
	Copyright©&nbsp;<cfoutput>#request.year1# - #request.nextyear#</cfoutput>,&nbsp;Randhawaworld.com 
	<br>
	All Rights Reserved Worldwide
	<br>
	<a href="http://www.randhawaworld.com" style="color:#c0c0c0">http://www.randhawaworld.com</a>
	<br>
	<a href="mailto:webmaster@randhawaworld.com" style="color:#c0c0c0">Mail Me</a>
	</td>
</tr>
</table>
</body>
</html>