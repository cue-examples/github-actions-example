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
			_#installGo & {
				with: "go-version": "1.17.x"
			},
			_#checkoutCode,
			_#goTest,
			_#run & {
				#arg: "workflow 2"
			},
		]
	}
}
