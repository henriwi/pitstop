dataSource {
	pooled = true
	driverClassName = "com.mysql.jdbc.Driver"
	username = "pitstop"
	password = "liva8icon"
}
hibernate {
    cache.use_second_level_cache=true
    cache.use_query_cache=true
    cache.provider_class='net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
	development {
		dataSource {
			dbCreate = "update" // one of 'create', 'create-drop','update'
			url = "jdbc:mysql://localhost/pitstop"
		}
	}
	test {
		dataSource {
			dbCreate = "update"
			driverClassName = "org.hsqldb.jdbcDriver"
			username = "sa"
			password = ""
			url = "jdbc:hsqldb:mem:testDb"
			inactivityTimeout = 200
		}
	}
	production {
		dataSource {
			dbCreate = "create-drop"
			url = "jdbc:mysql://localhost/pitstop"
		}
	}
}