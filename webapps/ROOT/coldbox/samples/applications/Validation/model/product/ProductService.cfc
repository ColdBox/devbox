﻿component extends="coldbox.system.orm.hibernate.VirtualEntityService" {
	
	public ProductService function init(){
		super.init(entityName="Product");
		return this;
	}	

}