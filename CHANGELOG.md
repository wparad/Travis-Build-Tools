# Change log
This is the changelog for [Awesome-Sauce](readme.md).

## 3.2 ##

* [FD-30631](https://jiratrain101.vistaprint.net/jira/browse/FD-30631)
    * Library.config.yaml:
        * Added configuration file to the library template for Awesome Sauce upgrades
    * Service.config.yaml:
        * Mapped `virtual_machine` configuration to the Vagrantfile `vm.box`, for dynamic setup.
    * Puppet:
        * Create `$install_chocolatey` variable in puppet manifest to remove string duplication.
        * service_pacakge_location is now no longer being referenced, and this is set directly in the puppet manifest.
        * Install service in the C:/deployment/service directory
    * chocolatey_setup.ps1
        * now fails on error.
    * Hiera.yaml
        * Add `env/secrets/common` to the list of hiera config files.
    * Moved secrets loading in the `rake deploy` task from the `environment.yaml` files to the `service.config.yaml`.
    * AwesomeSauce Vagrant:
        * Changed interface to include machines and version information.
        * Now assumes that the secrets will live in the env/secrets directory
    * Vagrantfile:
        * Removed Vagrant Orchestrate dependency from Vagrantfile so that it can be run without the plugin installed.
        * Uses machines from environment variable instead of lookup.
        * Add handling for deploying locally, if no virtual machine has yet been created and configured.
        * Moved deployment code into the deployment.cmd
    * Rakefile:
        * Pull deployment.tar.gz from a repository corresponding to the environment in the `rake deploy` task.
        * Reorder rake deploy prompts to ask for environment first and version second.
        * Changed `rake deploy` and `rake status` to pass machine list to `Awesome::Sauce.Vagrant()`
        * Removed reference to default.pp
    * default.pp
        * Removed this file.
    * deployment.cmd
        * Added deployment logic.
    * Environment yaml configuration files
        * Added `package_source` location to pull service source from instead of Chocolatey
    * Chocolatey package
        * Moved into deployment directory
* [FD-30691](https://jiratrain101.vistaprint.net/jira/browse/FD-30691)
    * Awesome Sauce `build.rb`:
        * Add concise logger assembly.