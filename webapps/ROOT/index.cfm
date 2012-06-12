<cfoutput>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>
			DevBox, from ColdBox
		</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="description" content="">
		<meta name="author" content="">
		
		<!-- Le styles -->
		<link href="assets/css/bootstrap.css" rel="stylesheet">
		<style>
			body {
			    padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
			}
		</style>
		<link href="assets/css/bootstrap-responsive.css" rel="stylesheet">
		
		<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
		<!--[if lt IE 9]>
		<script src="http://html5shim.googlecode.com/svn/trunk/html5.js">

		</script>
		<![endif]-->
	</head>
	
	<body>
		<!--- Top NavBar --->
		<div class="navbar navbar-fixed-top">
			<div class="navbar-inner">
				<div class="container">
					<!--- Brand --->
					<a class="brand" href="/">
						DevBox
					</a>
					<!--- NavBar --->
					<div class="nav-collapse">
						<ul class="nav">
							<!--- Home --->
							<li class="active">
								<a href="##">Home</a>
							</li>
							<!--- Main ColdBox Links --->
							<li class="dropdown" id="devbox">
								<a class="dropdown-toggle" data-toggle="dropdown" href="##devbox">
			             			DevBox Apps
			             			<b class="caret"></b>
			          			</a>
								<!--- Drop down --->
								<ul class="dropdown-menu">
									<li>
										<a href="/coldbox/samples">
											ColdBox Samples Gallery
										</a>
									</li>
									<li>
										<a href="/coldbox/dashboard">
											ColdBox Dashboard
										</a>
									</li>
									<li>
										<a href="/coldbox-docs">
											ColdBox API Docs
										</a>
									</li>
								</ul>
							</li>
							<!--- Administrators --->
							<li class="dropdown" id="administrators">
								<a class="dropdown-toggle" data-toggle="dropdown" href="##administrators">
			             			Administrators
			             			<b class="caret"></b>
			          			</a>
								<!--- Drop down --->
								<ul class="dropdown-menu">
									<li>
										<a href="/railo-context/admin/server.cfm">
											Railo Administrator
										</a>
									</li>
									<li>
										<a href="/resin-admin/index.php">
											Resin Admin
										</a>
									</li>
									<li class="divider">
									</li>
									<li>
										<a rel="tooltip" target="_blank" href="http://getrailo.org">
											www.getrailo.org
											<i class="icon-share-alt icon-white">
											</i>
										</a>
									</li>
									<li>
										<a rel="tooltip" target="_blank" href="http://caucho.com">
											www.caucho.com
											<i class="icon-share-alt icon-white">
											</i>
										</a>
									</li>
								</ul>
							</li>
						</ul>
						<ul class="nav pull-right">
							<li>
								<a rel="tooltip" target="_blank" href="http://coldbox.org">
									coldbox.org
									<i class="icon-share-alt icon-white">
									</i>
								</a>
							</li>
							<li>
								<a rel="tooltip" target="_blank" href="http://ortussolutions.com">
									ortussolutions.com
									<i class="icon-share-alt icon-white">
									</i>
								</a>
							</li>
						</ul>
					</div>
					<!--/.nav-collapse -->
				</div>
			</div>
		</div>
		
		<div class="container">
		
			<div class="hero-unit">
				<img src="assets/img/ColdBoxLogoSquare_125.png" style="float:left;margin:0px 10px"/>
				<h1>
					Welcome to your DevBox!
				</h1>
				<p>
					Use this as your ultimate Open Source ColdBox & CFML development server!
				</p>
			</div>
			
			<p>Below you will find a few applications deployed into your DevBox:</p>
			
			<h2>
			ColdBox Dashboard
			<a href="coldbox/dashboard/">
				<button class="btn">
					Open
				</button>
			</a>
			<h2>
			<p>
				A cool looking application generator and helper application for the ColdBox Platform.
			</p>
			
			<h2>
			ColdBox API Docs
			<a href="coldbox-docs/">
				<button class="btn">
					Open
				</button>
			</a>
			<h2>
			<p>
				The ColdBox Platform API docs.
			</p>
			
			<h2>
			ColdBox Samples Gallery
			<a href="coldbox/samples/">
				<button class="btn">
					Open
				</button>
			</a>
			<h2>
			<p>
				A nice collection of ColdBox Samples.
			</p>
			<br/>
			<div class="well">
			
				<h2>
				Webroot Location
				<h2>
				<p>
					Your current web root is located in the following path:
				</p>
				<pre>#expandPath("/")#</pre>
				
				<h2>
				ColdBox Bundle Location
				<h2>
				<p>
					The latest ColdBox bundle has been deployed to
				</p>
				<pre>#expandPath("/coldbox")#</pre>
				
				<h2>
				ColdBox Platform Utilities
				<h2>
				<p>
					This extension helps you when building ColdBox Platform applications using 
					<a href="http://www.adobe.com/products/coldfusion-builder.html">Adobe ColdFusion Builder</a>.
					It will help you get started with application skeletons, to configuring URL rewriting, security and so much more.
				</p>
				<pre>#expandPath("/coldbox-utilities")#</pre>
				
				<h2>
				ColdBox Application Templates
				<h2>
				<p>
					You can use the pre-packaged application templates to kick off your ColdBox Projects:
				</p>
				<pre>#expandPath("/coldbox/ApplicationTemplates")#</pre>
				
				<h2>
					Railo Administrator 
					<a href="/railo-context/admin/server.cfm">
						<button class="btn">
							Open
						</button>
					</a>
				</h2>
				<p>
				The password for the railo administrators is: 
				<pre>coldbox</pre>
				<h2>
					Resin Administrator
					<a href="/resin-admin/index.php">
						<button class="btn">
							Open
						</button>
					</a>
				</h2>
				<p>
				The credentials for the Resin Administrator are: 
				<pre>admin/admin</pre>
			</div>
		</div>
		<!-- /container -->
		<!-- Le javascript
		================================================== -->
		<!-- Placed at the end of the document so the pages load faster -->
		<script src="assets/js/jquery.js">

		</script>
		<script src="assets/js/bootstrap.min.js">

		</script>
		<script>
			$(function(){
			    $('.dropdown-toggle').dropdown();
			    $("[rel=tooltip]").tooltip();
			});
		</script>
	</body>
</html>
</cfoutput>