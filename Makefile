.PHONY: test

export TF_PATH

test:
	cd tests && go test -v -timeout 60m -run TestApplyNoError/$(TF_PATH) ./nw_test.go

#test_extended:
#	cd tests && go test -v -timeout 60m -run TestNw ./nw_extended_test.go -tags extended
