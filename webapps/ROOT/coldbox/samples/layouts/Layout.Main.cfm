<cfset HTMLHelper = getPlugin("HTMLHelper")>
<cfoutput>
#HTMLHelper.docType()#
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<title>ColdBox: A ColdFusion Framework : #getResource("samplesgallery")#</title>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta name="description" content="Your website description goes here" />
	<meta name="keywords" content="your,keywords,goes,here" />

	<base href="#getSetting("htmlBaseURL")#" />

	<link rel="stylesheet" href="includes/styles/andreas08.css" type="text/css" media="screen,projection" />
	<link rel="stylesheet" href="includes/javascript/Thickbox/ThickBox.css" type="text/css" media="screen,projection" />
	<link rel="stylesheet" href="includes/javascript/tabs/tabs.css" type="text/css" media="screen,projection" />

	<!--- JQUERY CODE --->
	<script language="javascript" src="includes/javascript/jquery-latest.pack.js"></script>
	<script language="javascript" src="includes/javascript/Thickbox/thickbox.js"></script>
	<script language="javascript" src="includes/javascript/tabs/jquery.tabs.pack.js"></script>

	<script language="javascript">
	$(document).ready(function() {
	      $('##mytabs').tabs({fxFade: true, fxSpeed: 'fast'});
	  });
	</script>
</head>

<body>
<div id="container">

	<div id="header" align="center">
		<h1><img src="includes/images/ColdBoxLogoSquare_125.png" /></h1>
	</div>

	<div id="navigation">
		<ul>
			<li class="selected"><a href="index.cfm">#getResource("sampleshome")#</a></li>
			<li><a href="http://www.coldbox.org"  target="_blank">ColdBox Site</a></li>
			<li><a href="http://www.ortussolutions.com"  target="_blank">Ortus Solutions</a></li>
		</ul>

		<div align="right">
		#getResource("changelanguage")#
		<select name="locale" onChange="window.location='#event.buildLink('samples.doChangeLocale')#/locale/' + this.value">
		   	<option value="en_US" <cfif getfwLocale() eq "en_US">selected="selected"</cfif>>English</option>
		   	<option value="es_SV" <cfif getfwLocale() eq "es_SV">selected="selected"</cfif>>Spanish</option>
		</select>
		</div>
	</div>

	<!--- ********************************* --->
	<!--- Render View Here --->
	#renderView()#
	<!--- ********************************* --->

	<div id="subcontent">
		<!--- CCV via render view() --->
		<div class="small box">#renderView("tags/i18n")#</div>

		<div class="small box"><strong>#getResource("note")#:
		<font color="##53231d">#getResource("notemessage")#</font></strong>
		</div>
		<br>
		<h2>#getResource("FavoriteLinks")#</h2>
		<ul class="menublock">
		  <li><a href="https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&business=lmajano%40ortussolutions%2ecom&item_name=ColdBox%20Framework%20Donation&no_shipping=1&no_note=1&cn=Your%20Comments&tax=0&currency_code=USD&lc=US&bn=PP%2dDonationsBF&charset=UTF%2d8">Donate Now!</a></li>
		  <li><a href="http://www.luismajano.com">#getresource("mysite")#</a></li>
		   <li><a href="#getSetting("AmazonURL")#">#getresource("myamazonwishlist")#</a></li>
		  <li><a href="#getSetting("ColdboxURL")#" target="_blank">ColdBox #getresource("home")#</a></li>
		  <li><a href="#getSetting("BlogURL")#" target="_blank">ColdBox Blog</a></li>
		  <li><a href="#getSetting("ColdboxAPIURL")#" target="_blank">ColdBox API</a></li>
		  <li><a href="#getSetting("trackerURL")#" target="_blank">ColdBox Bug Tracker</a></li>
		</ul>
		<br>

	</div>

	<div id="footer">
	<p>&copy; 2005-#dateformat(now(),"YYYY")# <a href="http://www.luismajano.com">ColdBox by Luis Majano </a> | Design by <a href="http://andreasviklund.com">Andreas Viklund</a></p>
	</div>
</div>

</body>
</html>
</cfoutput>