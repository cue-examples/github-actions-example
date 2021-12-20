package workflows

Workflow1: _#bashWorkflow & {
	on: [
		"push",
		"pull_request",
	]
	name: "Workflow 1"
	jobs: {
		workflow1_job1: {
			strategy: {
				"fail-fast": false
				matrix: {
					"go-version": [
						"1.16.x",
						"1.17.x",
					]
					platform: [
						"ubuntu-latest",
						"macos-latest",
						"windows-latest",
					]
				}
			}
			"runs-on": "${{ matrix.platform }}"
			steps: [
				_#installGo & {
					with: "go-version": "${{ matrix.go-version }}"
				},
				_#checkoutCode,
				_#goTest,
				_#run & {
					#arg: "workflow 1"
				},
			]
		}
		workflow1_job2: {
			needs:     "workflow1_job1"
			"runs-on": "ubuntu-latest"
			steps: [{
				run: "echo Done"
			}]
		}
	}
}
