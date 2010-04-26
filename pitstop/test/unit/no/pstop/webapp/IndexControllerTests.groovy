package no.pstop.webapp

import grails.test.*

class IndexControllerTests extends ControllerUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testSomething() {

    }
	
	void testRanges(){
		println barSize([s:'b',a:1,d:3])
	}
	def barSize = {args ->
		def output = 'chbh='
		output << listToString(args.values())
	}
	def listToString(list){
		replaceSpaces('',list.toString()[1..-2])
	}
	def replaceSpaces(replacement, string){
		string.replaceAll(/\s/){replacement}
	}
}
