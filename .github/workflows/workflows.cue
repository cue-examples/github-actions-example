package workflows

import "json.schemastore.org/github"

workflows: [...{
	filename: string
	workflow: github.#Workflow
}]

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
