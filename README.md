# Snyk

Bitrise Snyk Step incorporates Snyk into your Bitrise workflows. By utilizing this step, you will be able to test your dependencies for vulnerabilities during builds and use Snyk to monitor your projects for new vulnerabilities.


## How to use this Step

### Add this step in Bitrise Workflow Editor

This step uses Snyk CLI and `snyk-to-html` to test your code, dependencies, and report results either to Bitrise or Snyk. The following configuration options are avialable:

- Auth Token

  Your Snyk authentication token (see https://app.snyk.io/account). This should be set in Secrets using the `SNYK_AUTH_TOKEN `variable.

- Command (default `test`)

  This is the CLI command to run with Snyk.

- Severity threshold (default `low`)

   Only report vulnerabilities of the provided level or higher (low/medium/high/critical).

- Fail on issues (default `yes`)
   
   Specifies whether to fail the build or not based on the results found by Snyk.

   Snyk by default returns an error code from the test command. This may break your Bitrise workflow. By specifying `no`, the build can continue even if vulnerabilities are found.

- Create HTML Report  (default `no`)

   Specifies whether to create an HTML report.

   If set to `yes`, an HTML report will be created and available as a build artifact

- Monitor (default `no`)

   If enabled, imports the snapshot of dependencies to Snyk for continuous monitoring after a successful test.

   Set this value to `yes` to import the snapshot of dependencies to Snyk after a successful test. Snyk will then start monitoring the dependencies for new vulnerabilities and alert when a new vulnerability is discovered.
      
- Target file
   
   The path to the manifest file to be used by Snyk. Should be provided if non-standard.

- Organization:

   Name of the Snyk organisation name, under which this project should be tested and monitored.

   If omitted the default organization will be used.

- Additional arguments:

   You can provide additional arguments to pass to Snyk CLI. Refer to the Snyk CLI help page for information on additional arguments.

### Testing your project dependencies (`snyk test` command)

Refer to Snyk documentation for the list of supported languages and package managers. You can use the step with default settings. Consider adding `--all-projects` as an additional argument if you want to scan a monorepo.

### Static code analysis (Snyk code test command)

Refer to Snyk documentation for the list of supported languages and package managers. To test using Snyk Code, specify the `command` option as `code test`.

### CLI

Can be run directly with the [bitrise CLI](https://github.com/bitrise-io/bitrise),
just `git clone` this repository, `cd` into it's folder in your Terminal/Command Line
and call `bitrise run test`.

*Check the `bitrise.yml` file for required inputs which have to be
added to your `.bitrise.secrets.yml` file!*

Step by step:

1. Open up your Terminal / Command Line
2. `git clone` the repository
3. `cd` into the directory of the step (the one you just `git clone`d)
5. Create a `.bitrise.secrets.yml` file in the same directory of `bitrise.yml`
   (the `.bitrise.secrets.yml` is a git ignored file, you can store your secrets in it)
6. Check the `bitrise.yml` file for any secret you should set in `.bitrise.secrets.yml`
  * Best practice is to mark these options with something like `# define these in your .bitrise.secrets.yml`, in the `app:envs` section.
7. Once you have all the required secret parameters in your `.bitrise.secrets.yml` you can just run this step with the [bitrise CLI](https://github.com/bitrise-io/bitrise): `bitrise run test`

An example `.bitrise.secrets.yml` file:

```
envs:
- SNYK_AUTH_TOKEN: your_Snyk_authentication_token
```

## How to contribute to this Step

1. Fork this repository
2. `git clone` it
3. Create a branch you'll work on
4. To use/test the step just follow the **How to use this Step** section
5. Do the changes you want to
6. Run/test the step before sending your contribution
  * You can also test the step in your `bitrise` project, either on your Mac or on [bitrise.io](https://www.bitrise.io)
  * You just have to replace the step ID in your project's `bitrise.yml` with either a relative path, or with a git URL format
  * (relative) path format: instead of `- original-step-id:` use `- path::./relative/path/of/script/on/your/Mac:`
  * direct git URL format: instead of `- original-step-id:` use `- git::https://github.com/user/step.git@branch:`
  * You can find more example of alternative step referencing at: https://github.com/bitrise-io/bitrise/blob/master/_examples/tutorials/steps-and-workflows/bitrise.yml
7. Once you're done just commit your changes & create a Pull Request
