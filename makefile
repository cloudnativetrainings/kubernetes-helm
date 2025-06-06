.PHONY: verify
verify:
	test -f /root/.trainingrc
	grep "source /root/.trainingrc" /root/.bashrc
	docker --version
	kind --version
	kubectl version --client
	kubectx
	kubens
	helm version
	kustomize version
	./pre-checks.sh
	echo "Training Environment successfully verified"
