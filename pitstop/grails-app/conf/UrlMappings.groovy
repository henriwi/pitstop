class UrlMappings {
    static mappings = {
      "/$controller/$action?/$id?"{
	      constraints {
			 // apply constraints here
		  }
	  }
      "/"(controller:"index", action:"index")
	  "403"(view:'/403Error')
	  "404"(view:'/404Error')
	  "405"(view:'/403Error')
	  "500"(view:'/500Error')
	}
}
