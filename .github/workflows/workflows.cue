package workflows

import "json.schemastore.org/github"

workflows: [...{
	filename: string
	workflow: github.#Workflow
}]

// TODO: drop when cuelang.org/issue/390 is fixed.
// Declare definitions for sub-schemas
_#job:  ((github.#Workflow & {}).jobs & {x: _}).x
_#step: ((_#job & {steps:                   _}).steps & [_])[0]

workflows: [
	{
		filename: "workflow1.yml"
		workflow: Workflow1
	},
	{
		filename: "workflow2.yml"
		workflow: Workflow2
	},
]

_#bashWorkflow: github.#Workflow & {
	jobs: [string]: defaults: run: shell: "bash"
}

_#installGo: _#step & {
	name: "Install Go"
	uses: "actions/setup-go@v2"
	with: "go-version": string
}
