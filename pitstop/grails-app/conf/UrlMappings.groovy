class UrlMappings {
    static mappings = {
      "/$controller/$action?/$id?"{
	      constraints {
			 // apply constraints here
		  }
	  }
      "/"(controller:"index", action:"index")
	  "500"(view:'/500Error')
	  "404"(view:'/404Error')
	  "403"(view:'/403Error')
	}
}
