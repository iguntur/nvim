return {
	{
		description = "TypeScript compiler configuration file",
		url = "https://json.schemastore.org/tsconfig.json",
		fileMatch = {
			"tsconfig.json",
			"tsconfig.*.json",
		},
	},
	{
		description = "Lerna config",
		url = "https://json.schemastore.org/lerna.json",
		fileMatch = {
			"lerna.json",
		},
	},
	{
		description = "Babel configuration",
		url = "https://json.schemastore.org/babelrc.json",
		fileMatch = {
			".babelrc.json",
			".babelrc",
			"babel.config.json",
		},
	},
	{
		description = "ESLint config",
		fileMatch = {
			".eslintrc.json",
			".eslintrc",
		},
		url = "https://json.schemastore.org/eslintrc.json",
	},
	{
		description = "Bucklescript config",
		url = "https://raw.githubusercontent.com/rescript-lang/rescript-compiler/master/docs/docson/build-schema.json",
		fileMatch = {
			"bsconfig.json",
		},
	},
	{
		description = "Prettier config",
		url = "https://json.schemastore.org/prettierrc.json",
		fileMatch = {
			".prettierrc",
			".prettierrc.json",
			"prettier.config.json",
		},
	},
	{
		description = "Vercel Now config",
		url = "https://json.schemastore.org/now",
		fileMatch = {
			"now.json",
		},
	},
	{
		description = "Stylelint config",
		url = "https://json.schemastore.org/stylelintrc.json",
		fileMatch = {
			".stylelintrc",
			".stylelintrc.json",
			"stylelint.config.json",
		},
	},
	{
		description = "A JSON schema for the ASP.NET LaunchSettings.json files",
		url = "https://json.schemastore.org/launchsettings.json",
		fileMatch = {
			"launchsettings.json",
		},
	},
	{
		description = "Schema for CMake Presets",
		url = "https://raw.githubusercontent.com/Kitware/CMake/master/Help/manual/presets/schema.json",
		fileMatch = {
			"CMakePresets.json",
			"CMakeUserPresets.json",
		},
	},
	{
		description = "Configuration file as an alternative for configuring your repository in the settings page.",
		url = "https://json.schemastore.org/codeclimate.json",
		fileMatch = {
			".codeclimate.json",
		},
	},
	{
		description = "Config file for Command Task Runner",
		url = "https://json.schemastore.org/commands.json",
		fileMatch = {
			"commands.json",
		},
	},
	{
		description = "AWS CloudFormation provides a common language for you to describe and provision all the infrastructure resources in your cloud environment.",
		url = "https://raw.githubusercontent.com/awslabs/goformation/master/schema/cloudformation.schema.json",
		fileMatch = {
			"*.cf.json",
			"cloudformation.json",
		},
	},
	{
		description = "The AWS Serverless Application Model (AWS SAM, previously known as Project Flourish) extends AWS CloudFormation to provide a simplified way of defining the Amazon API Gateway APIs, AWS Lambda functions, and Amazon DynamoDB tables needed by your serverless application.",
		url = "https://raw.githubusercontent.com/awslabs/goformation/master/schema/sam.schema.json",
		fileMatch = {
			"serverless.template",
			"*.sam.json",
			"sam.json",
		},
	},
	{
		description = "Json schema for properties json file for a GitHub Workflow template",
		url = "https://json.schemastore.org/github-workflow-template-properties.json",
		fileMatch = {
			".github/workflow-templates/**.properties.json",
		},
	},
	{
		description = "golangci-lint configuration file",
		url = "https://json.schemastore.org/golangci-lint.json",
		fileMatch = {
			".golangci.toml",
			".golangci.json",
		},
	},
	{
		description = "JSON schema for the JSON Feed format",
		url = "https://json.schemastore.org/feed.json",
		fileMatch = {
			"feed.json",
		},
		versions = {
			["1"] = "https://json.schemastore.org/feed-1.json",
			["1.1"] = "https://json.schemastore.org/feed.json",
		},
	},
	{
		description = "Packer template JSON configuration",
		url = "https://json.schemastore.org/packer.json",
		fileMatch = {
			"packer.json",
		},
	},
	{
		description = "NPM configuration file",
		url = "https://json.schemastore.org/package.json",
		fileMatch = {
			"package.json",
		},
	},
	{
		description = "JSON schema for Visual Studio component configuration files",
		url = "https://json.schemastore.org/vsconfig.json",
		fileMatch = {
			"*.vsconfig",
		},
	},
	{
		description = "Cypress configuration schema",
		url = "https://raw.githubusercontent.com/cypress-io/cypress/develop/cli/schema/cypress.schema.json",
		fileMatch = {
			"cypress.json",
		},
	},
	{
		description = "PHP composer configuration",
		url = "https://raw.githubusercontent.com/composer/composer/main/res/composer-schema.json",
		fileMatch = {
			"composer.json",
		},
	},
}
