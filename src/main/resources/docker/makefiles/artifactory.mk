.PHONY: check-for-artifactory-credentials
check-for-artifactory-credentials:
	# @printf "\nChecking connectivity to Artifactory. Looking for Artifactory credentials on the environment.\n"
	# @printf "   Checking environment for JFROG_USR variable... "
	# @printf $(if $(JFROG_USR),"Found...\n","Not found! Set JFROG_USR environment variable. (e.g. export JFROG_USR=<ssoid>;)\n")
	# @printf "   Checking environment for JFROG_PSW variable... "
	# @printf $(if $(JFROG_PSW),"Found...\n\n","Not found! Set JFROG_PSW environment variable. (e.g. export JFROG_PSW=<sso api key>;)\n\n")
	# @test "$(JFROG_USR)"
	# @test "$(JFROG_PSW)"