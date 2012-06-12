
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>DevBox, from ColdBox</title>
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
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
  </head>

  <body>

    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a class="brand" href="/">My DevBox</a>
          <div class="nav-collapse">
            <ul class="nav">
              <li class="active"><a href="#">Home</a></li>
              <li class="dropdown" id="administrators">
			           <a class="dropdown-toggle" data-toggle="dropdown" href="#administrators">
			             Administrators
			             <b class="caret"></b>
			           </a>
    			    <ul class="dropdown-menu">
    			      <li><a href="/railo-context/admin/index.cfm">Railo Administrator</a></li>
    			      <li><a href="/resin-admin/index.php">Resin Admin</a></li>
                <li class="divider"></li>
                <li>
                    <a rel="tooltip" target="_blank" href="http://getrailo.org">
                      www.getrailo.org
                      <i class="icon-share-alt icon-white"></i>
                    </a>
                </li>
                <li>
                    <a rel="tooltip" target="_blank" href="http://caucho.com">
                      www.caucho.com
                      <i class="icon-share-alt icon-white"></i>
                    </a>
                </li>
    			    </ul>
			       </li>
            </ul>
            <ul class="nav pull-right">
				<li>
					<a rel="tooltip" target="_blank" href="http://coldbox.org">
						coldbox.org
						<i class="icon-share-alt icon-white"></i>
					</a>
				</li>
				<li>
					<a rel="tooltip" target="_blank" href="http://ortussolutions.com">
						ortussolutions.com
						<i class="icon-share-alt icon-white"></i>
					</a>
				</li>
			</ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>

    <div class="container">

    	<div class="hero-unit">
    		<img src="assets/img/ColdBoxLogoSquare_125.png" style="float:left;margin:0px 10px"/>
     	 	<h1>Welcome to your DevBox!</h1>
      		<p>Use this as your ultimate Open Source ColdBox & CFML development server!
          </p>
      </div>

       <h2>ColdBox Dashboard
        <a href="coldbox/dashboard/">
        <button class="btn">
          Open
        </button>
        </a>
      <h2>
      <p>A cool looking application generator and helper app.</p>

      <h2>ColdBox API Docs
        <a href="coldbox-docs/">
        <button class="btn">
          Open
        </button>
        </a>
      <h2>
      <p>The ColdBox Platform API docs.</p>

      <h2>ColdBox Samples Gallery
        <a href="coldbox/samples/">
        <button class="btn">
          Open
        </button>
        </a>
      <h2>
      <p>A nice collection of ColdBox Samples.</p>

      <div class="well">
        
        <h2>Root Location<h2>
        <p>Your current web root is located in the following path:</p>
        <pre>/DEVBOX/webapps/ROOT</pre>

        <h2>ColdBox Application Templates<h2>
        <p>You can use the pre-packaged application templates to kick off your ColdBox Projects:</p>
        <pre>/DEVBOX/webapps/ROOT/coldbox/ApplicationTemplates</pre>

     
        <h2>Railo Administrator</h2>
        <p>The password for the railo administrators is: <pre>coldbox</pre>
        <h2>Resin Administrator</h2>
        <p>The credentials for the Resin Administrator are: <pre>admin/admin</pre>
      </div>

    </div> <!-- /container -->

    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
   	<script src="assets/js/jquery.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script>
    $(function() {
   		 $('.dropdown-toggle').dropdown();
       $("[rel=tooltip]").tooltip();
  	});	
   	</script>

  </body>
</html>
