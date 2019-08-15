.PHONY: helm-package
helm-package:
	helm package $(CHARTS) -d $(CHART_DIR) --dependency-update
	helm repo index $(CHART_DIR) --merge $(CHART_DIR)/index.yaml

# Checks that kubectl contains the expected CONTEXT
.PHONY: check-for-kube-context-dev
check-for-kube-context-dev:
	@echo "\nChecking for dev kube context: $(K8_DEV_CONTEXT)\n"
	@kubectl config view -o jsonpath='{.contexts[*].name}' | grep -q '$(K8_DEV_CONTEXT)' \
		&& echo "$(OK_COLOR)found...$(NO_COLOR)\n" \
		|| echo "$(ERROR_COLOR)not found...$(NO_COLOR)\n\nPlease login XXX and setup your K8S context.\nSee https://dev Setup K8S Context for more details.\n"
	@kubectl config view -o jsonpath='{.contexts[*].name}' | grep -q '$(K8_DEV_CONTEXT)'

.PHONY: helm-dryrun
helm-dryrun:
	helm upgrade --install $(CHARTS) -d $(CHART_DIR) \
		--dry-run \
		--debug \
		--tiller-namespace $(DEFAULT_TNS) \
		--namespace $(DEFAULT_NS)

.PHONY: helm-deploy
helm-deploy:
	helm upgrade --install $(CHARTS) -d $(CHART_DIR) \
		--dry-run \
		--tiller-namespace $(DEFAULT_TNS) \
		--namespace $(DEFAULT_NS)

.PHONY: helm-upgrade
upgrade: helm-deploy

.PHONY: helm-teardown
helm-teardown:
	helm delete --purge --tiller-namespace $(DEFAULT_TNS) $(DEPLOY_NAME)-appd ; \
	kubectl delete pvc -n $(DEFAULT_NS) -l app=appd,release=$(DEPLOY_NAME)-appd-agent

.PHONY: helm-terminate
helm-terminate: helm-teardown