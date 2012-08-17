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
			.centered{
				text-align:center;
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
					<!---Responsive Design --->
					<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
			            <span class="icon-bar"></span>
			            <span class="icon-bar"></span>
			            <span class="icon-bar"></span>
			        </a>
					
					<!--- Branding --->
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
										<a href="/coldbox-docs/index.html">
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
									<li class="divider"></li>
									<li>
										<a rel="tooltip" target="_blank" href="http://getrailo.org">
											www.getrailo.org
											<i class="icon-share-alt icon-white">
											</i>
										</a>
									</li>
								</ul>
							</li>
						</ul>
						<!---About --->
						<ul class="nav pull-right">
							<li class="dropdown">
								<a href="##" class="dropdown-toggle" data-toggle="dropdown">
									<i class="icon-info-sign icon-white"></i> About <b class="caret"></b>
								</a>
								<ul id="actions-submenu" class="dropdown-menu">
									<li><a href="http://wiki.coldbox.org"><i class="icon-bullhorn icon-white"></i> Documentation</a></li>
									<li><a href="mailto:info@coldbox.org?subject=DataBoss Feedback"><i class="icon-bullhorn icon-white"></i> Send Us Feedback</a></li>
									<li><a href="http://www.ortussolutions.com/products/coldbox"><i class="icon-home icon-white"></i> Professional Support</a></li>
									<li><a href="http://www.github.com/coldbox/coldbox-platform"><i class="icon-pencil icon-white"></i> Github Repository</a></li>
									<li><a href="https://coldbox.assembla.com/spaces/coldbox/support/tickets"><i class="icon-fire icon-white"></i> Report a Bug</a></li>
									<li class="divider"></li>
									<li class="centered">
										<img src="assets/img/ColdBoxLogoSquare_125.png" alt="logo"/>
									</li>
								</ul>
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
					This is your ultimate Open Source ColdBox & CFML development server!
				</p>
			</div>
			
			<div class="alert alert-success">
				Below you will find a few applications deployed into your DevBox:
			</div>
			
			<table class="table table-striped">
				<thead>
					<th width="200">Application</th>
					<th>Description</th>
					<th>Actions</th>
				</thead>
				<tbody>
					<tr>
						<td>ColdBox Dashboard</td>
						<td>A cool looking application generator and helper application for the ColdBox Platform.</td>
						<td>
							<a href="coldbox/dashboard/">
								<button class="btn btn-info">
									Open
								</button>
							</a>
						</td>
					</tr>
					<tr>
						<td>ColdBox Samples Gallery</td>
						<td>A collection of over 20 sample applications to get you started with ColdBox development.</td>
						<td>
							<a href="coldbox/samples">
								<button class="btn btn-info">
									Open
								</button>
							</a>
						</td>
					</tr>
					<tr>
						<td>ColdBox API Docs</td>
						<td>All the API docs you will ever need.</td>
						<td>
							<a href="coldbox-docs/index.html">
								<button class="btn btn-info">
									Open
								</button>
							</a>
						</td>
					</tr>
					<tr>
						<td>ColdBox Platform Utilities</td>
						<td>This extension helps you when building ColdBox Platform applications using <a href="http://www.adobe.com/products/coldfusion-builder.html">Adobe ColdFusion Builder IDE</a>. 
						It will help you get started with application skeletons, to configuring URL rewriting, security and so much more. <br/><br/>
						
						<pre>#expandPath("/coldbox-utilities")#</pre>
						</td>
						<td>
							<a href="http://www.adobe.com/products/coldfusion-builder.html" title="Download CF Builder">
								<button class="btn btn-info" title="Download CF Builder">
									Download
								</button>
							</a>
						</td>
					</tr>
					
				</tbody>
			</table>

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
				ColdBox Application Templates
				<h2>
				<p>
					You can use the pre-packaged application templates to kick off your ColdBox Projects:
				</p>
				<pre>#expandPath("/coldbox/ApplicationTemplates")#</pre>
				
				<h2>
					Railo Administrator					
				</h2>
				<p>
				The password for the Railo administrators is: <code>coldbox</code><br/>
				<a href="/railo-context/admin/server.cfm">
					<button class="btn">
						Open
					</button>
				</a> 
				
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