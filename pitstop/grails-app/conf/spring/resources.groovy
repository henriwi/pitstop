// Place your Spring DSL code here
beans = {
	localeResolver(org.springframework.web.servlet.i18n.SessionLocaleResolver) {
		defaultLocale = new Locale("nb","NO")
		java.util.Locale.setDefault(defaultLocale)
		}   
}