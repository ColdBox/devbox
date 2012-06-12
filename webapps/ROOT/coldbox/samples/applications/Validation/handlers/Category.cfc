component {	property name="categoryService" inject;	public void function index(event,rc,prc){		setNextEvent("category/list");
	}		public void function list(event,rc){		rc.categories = categoryService.list(asquery=false);		event.setView("category/categories");
	}		public void function edit(event,rc){  		if( !structKeyExists(rc,"category") ){	        rc.category = categoryService.get( event.getValue('category_id','') );
		}        event.setView("category/category");		
	}		public void function save(event,rc){		// populate the model with all the properties				rc.category = populateModel( model=categoryService.get(rc.category_id) );			// validation		var result = validateModel(rc.category);				if( !result.hasErrors() ){			// validation found no errors, persist the data			categoryService.save(rc.category);			getPlugin("messagebox").setMessage("info","Category saved!");				setNextEvent('category/list');			} else {			getPlugin("messagebox").setMessage(type="error",messageArray=result.getAllErrors());			setNextEvent(event='category/edit',persist="category");			
		}		
	}}