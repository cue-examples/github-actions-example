package workflows

Workflow2: _#bashWorkflow & {
	on: [
		"push",
		"pull_request",
	]
	name: "Workflow 2"
	jobs: workflow2_job1: {
		"runs-on": "ubuntu-latest"
		steps: [
			_#step & {
				name: "Install CUE"
				uses: "cue-lang/setup-cue@v1.0.0-alpha.2"
				with: version: "v0.4.1-beta.6"
			},
			_#installGo & {
				with: "go-version": "1.17.x"
			},
			_#checkoutCode,
			_#goTest,
			_#run & {
				#arg: "workflow 2"
			},
			_#step & {
				name:                "Regenerate YAML from CUE"
				"working-directory": ".github/workflows"
				run:                 "cue cmd genworkflows"
			},
			_#step & {
				name: "Check commit is clean"
				run:  #"test -z "$(git status --porcelain)" || (git status; git diff; false)"#
			},
		]
	}
}
